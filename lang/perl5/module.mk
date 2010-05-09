# $NetBSD: module.mk,v 1.62 2010/05/09 18:46:34 morr Exp $
#
# This Makefile fragment is intended to be included by packages that build
# and install perl5 modules.
#
# The following targets are provided by this file:
#
# perl5-configure	runs the standard perl configuration in
#			each of the directories specified in
#			${PERL5_CONFIGURE_DIRS}.
#
# do-configure		runs the perl5-configure target; if PERL5_CONFIGURE
#			is set to "YES", then this target overrides the
#			default do-configure provided by bsd.pkg.mk.
#
# The following variables may be set prior to including this file:
#
# PERL5_CONFIGURE	if "YES", then for do-configure, run the standard
#			perl configuration assuming Makefile.PL exists;
#			defaults to "YES".
#
# PERL5_CONFIGURE_DIRS	list of directories in which to run the
#			standard perl configuration; defaults to
#			${CONFIGURE_DIRS}.
#
# PERL5_LDFLAGS		extra linker flags to pass on to the build
#			process.
#
# PERL5_MODULE_TYPE	"MakeMaker", "Module::Build" or "Module::Install"
#			depending on which framework is used to build/install
#			the module.

.include "../../lang/perl5/license.mk"

.if !defined(_PERL5_MODULE_MK)
_PERL5_MODULE_MK=	# defined

.include "../../mk/bsd.prefs.mk"

PERL5_MODULE_TYPE?=		MakeMaker

.if (${PERL5_MODULE_TYPE} != "MakeMaker") && \
    (${PERL5_MODULE_TYPE} != "Module::Build") && \
    (${PERL5_MODULE_TYPE} != "Module::Install") && \
    (${PERL5_MODULE_TYPE} != "Module::Install::Bundled")
PKG_FAIL_REASON+=	"\`\`${PERL5_MODULE_TYPE}'' is not a supported PERL5_MODULE_TYPE."
.endif

# Default test target for Perl modules
TEST_TARGET?=		test

.include "../../mk/compiler.mk"

.if ${PERL5_MODULE_TYPE} == "Module::Build"
_PERL5_MODTYPE=		modbuild
.  if ${_USE_DESTDIR} != "no"
_PERL5_MODBUILD_DESTDIR_OPTION=--destdir ${DESTDIR:Q}
.  else
_PERL5_MODBUILD_DESTDIR_OPTION=
.  endif
.elif ${PERL5_MODULE_TYPE} == "Module::Install"
_PERL5_MODTYPE=		modinst
.elif ${PERL5_MODULE_TYPE} == "Module::Install::Bundled"
_PERL5_MODTYPE=		modinst
.elif ${PERL5_MODULE_TYPE} == "MakeMaker"
_PERL5_MODTYPE=		makemaker
.endif


###########################################################################
###
### Add the proper dependencies for using the specified module build
### system.
###

BUILDLINK_DEPMETHOD.perl+=	full
.include "../../lang/perl5/buildlink3.mk"

.if empty(PKGPATH:Mdevel/p5-Module-Build) && \
    (${PERL5_MODULE_TYPE} == "Module::Build")
BUILD_DEPENDS+=		{perl>=5.10,p5-Module-Build>=0.2608nb1}:../../devel/p5-Module-Build
.endif

.if empty(PKGPATH:Mdevel/p5-Module-Install) && \
    (${PERL5_MODULE_TYPE} == "Module::Install")
BUILD_DEPENDS+=		p5-Module-Install>=0.91:../../devel/p5-Module-Install
.endif


###########################################################################
###
### Target definitions (configure, build, install, etc.)
###

PERL5_CONFIGURE?=	yes
PERL5_CONFIGURE_DIRS?=	${CONFIGURE_DIRS}

MAKE_ENV+=	LC_ALL=C

# All pkgsrc-installed Perl modules are installed into the "vendor"
# directories.
#
MAKE_PARAMS.makemaker+=	INSTALLDIRS=vendor
MAKE_PARAMS.modbuild+=	installdirs=vendor
MAKE_PARAMS.modinst+=	installdirs=vendor

MAKE_PARAMS+=	${MAKE_PARAMS.${_PERL5_MODTYPE}}

.PHONY: do-makemaker-configure
do-makemaker-configure:
	${RUN}								\
	for dir in ${PERL5_CONFIGURE_DIRS}; do				\
		cd ${WRKSRC};						\
		if ${TEST} -f "$$dir"/Makefile.PL; then			\
			cd "$$dir";					\
			${SETENV} ${MAKE_ENV}				\
				${BUILDLINK_PREFIX.perl}/bin/perl Makefile.PL ${MAKE_PARAMS};	\
		fi;							\
	done

.PHONY: do-modbuild-configure
do-modbuild-configure:
	${RUN}								\
	for dir in ${PERL5_CONFIGURE_DIRS}; do				\
		cd ${WRKSRC};						\
		if ${TEST} -f "$$dir"/Build.PL; then			\
			cd "$$dir";					\
			${SETENV} ${MAKE_ENV}				\
				${BUILDLINK_PREFIX.perl}/bin/perl Build.PL ${MAKE_PARAMS};	\
		fi;							\
	done

.PHONY: do-modinst-configure
do-modinst-configure:
.if ${PERL5_MODULE_TYPE} == "Module::Install"
	${RUN}								\
	for dir in ${PERL5_CONFIGURE_DIRS}; do				\
		cd ${WRKSRC};						\
		if ${TEST} -d "$$dir"/inc/Module; then			\
			${RM} -rf "$$dir"/inc/Module;			\
		fi;							\
		if ${TEST} -f "$$dir"/Makefile.PL; then			\
			cd "$$dir";					\
			${SETENV} ${MAKE_ENV}				\
				${BUILDLINK_PREFIX.perl}/bin/perl Makefile.PL --skipdeps ${MAKE_PARAMS};	\
		fi;							\
	done
.else
	${RUN}								\
	for dir in ${PERL5_CONFIGURE_DIRS}; do				\
		cd ${WRKSRC};						\
		if ${TEST} -f "$$dir"/Makefile.PL; then			\
			cd "$$dir";					\
			${SETENV} ${MAKE_ENV}				\
				${BUILDLINK_PREFIX.perl}/bin/perl Makefile.PL --skipdeps ${MAKE_PARAMS};	\
		fi;							\
	done
.endif

.PHONY: perl5-configure
perl5-configure: do-${_PERL5_MODTYPE}-configure

.if !empty(PERL5_CONFIGURE:M[yY][eE][sS])
do-configure: perl5-configure
.endif

.PHONY: do-modbuild-build
do-modbuild-build:
	@cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ./Build

.PHONY: do-modbuild-test
do-modbuild-test:
	@cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ./Build test

.PHONY: do-modbuild-install
do-modbuild-install:
	@cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ./Build install ${_PERL5_MODBUILD_DESTDIR_OPTION}

.if target(do-${_PERL5_MODTYPE}-build) && !defined(NO_BUILD)
do-build: do-${_PERL5_MODTYPE}-build
do-test: do-${_PERL5_MODTYPE}-test
.endif
.if target(do-${_PERL5_MODTYPE}-install)
do-install: do-${_PERL5_MODTYPE}-install
.endif


###########################################################################
###
### Make variable overrides
###

# MakeMaker provides two hooks, OPTIMIZE and OTHERLDFLAGS, to
# customize the arguments passed to the preprocessor and linker,
# respectively.
#
PERL5_MAKE_FLAGS.makemaker+=	OPTIMIZE=${CFLAGS:Q}" "${CPPFLAGS:Q}
.if ${OBJECT_FMT} == "a.out"
PERL5_MAKE_FLAGS.makemaker+=	OTHERLDFLAGS=${LDFLAGS:S/-Wl,//g:Q}
.else
PERL5_MAKE_FLAGS.makemaker+=	OTHERLDFLAGS=${LDFLAGS:Q}
.endif

# Repoint all of the vendor-specific variables to be under the perl5
# module's ${PREFIX}.
#
.include "../../lang/perl5/vars.mk"
.for _var_ in ${_PERL5_VARS}
PERL5_MAKE_FLAGS.makemaker+=	${_var_}=${PERL5_${_var_}:Q}
.endfor
#
# The PREFIX in the generated Makefile will point to ${_PERL5_PREFIX},
# so override its value to the module's ${PREFIX}.
# Also, set VENDORARCHEXP, so existing .packlist won't be read.
#
PERL5_MAKE_FLAGS.makemaker+=   PREFIX=${PREFIX:Q} VENDORARCHEXP=${DESTDIR}${PERL5_INSTALLVENDORARCH}

PERL5_MAKE_FLAGS+=	${PERL5_MAKE_FLAGS.${_PERL5_MODTYPE}}
MAKE_FLAGS+=		${PERL5_MAKE_FLAGS}

.if defined(PERL5_LDFLAGS) && !empty(PERL5_LDFLAGS)
FIX_RPATH+=	PERL5_LDFLAGS
LDFLAGS+=	${PERL5_LDFLAGS}
.endif

.include "../../lang/perl5/packlist.mk"

.include "../../mk/pthread.buildlink3.mk"

.endif	# _PERL5_MODULE_MK
