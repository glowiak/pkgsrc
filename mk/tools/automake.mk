# $NetBSD: automake.mk,v 1.11 2005/05/21 04:46:52 jlam Exp $
#
# Copyright (c) 2005 The NetBSD Foundation, Inc.
# All rights reserved.
#
# This code is derived from software contributed to The NetBSD Foundation
# by Johnny C. Lam
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#        This product includes software developed by the NetBSD
#        Foundation, Inc. and its contributors.
# 4. Neither the name of The NetBSD Foundation nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

#
# This Makefile fragment handles packages that use GNU automake.
#
# By default, all of the automake-related scripts are marked as
# "missing" by running the GNU missing script in place of the utility.
# This hides the automake-related scripts from makefiles that aggressively
# call them when some of the inputs are modified in ways the makefiles
# don't expect.
#
# If a package needs to use GNU automake, then the package Makefile
# should contain one of the following lines:
#
#	USE_TOOLS+=	automake	# use recent GNU automake (>=1.9)
#	USE_TOOLS+=	automake14	# use GNU automake ~1.4
#
# This will allow the package to invoke "aclocal" and "automake" by
# their usual, bare names.
#
# If a particular minimum version of automake is required, then the
# package Makefile can additionally set AUTOMAKE_REQD to the desired
# version, e.g.:
#
#	AUTOMAKE_REQD=	1.8	# use at least automake>=1.8
#
# If a package additionally needs to regenerate configure scripts and
# Makefiles that use gettext, then the package Makefile should contain
# the following line:
#
#	USE_TOOLS+=	gettext-m4	# need gettext.m4 to re-gen files
#
# To globally prevent any GNU automake handling, set the following
# in the package Makefile:
#
#	AUTOMAKE_OVERRIDE=    no
#

# This variable is obsoleted, but continue to allow it until packages
# have been taught to use the new syntax.
#
.if defined(BUILD_USES_GETTEXT_M4)
USE_TOOLS+=	gettext-m4
.endif

# Only allow one of "automake" and "automake14" in USE_TOOLS.
.if !empty(USE_TOOLS:Mautomake) && !empty(USE_TOOLS:Mautomake14)
PKG_FAIL_REASON+=	"\`\`automake'' and \`\`automake14'' conflict in USE_TOOLS."
.endif

# This is an exhaustive list of all of the scripts supplied by GNU
# automake.
#
_TOOLS_AM_NAMES=	aclocal		aclocal-1.4			\
					aclocal-1.5			\
					aclocal-1.6			\
					aclocal-1.7			\
					aclocal-1.8			\
					aclocal-1.9
_TOOLS_AM_NAMES+=	automake	automake-1.4			\
					automake-1.5			\
					automake-1.6			\
					automake-1.7			\
					automake-1.8			\
					automake-1.9

.for _t_ in ${_TOOLS_AM_NAMES}
_TOOLS_AM_TYPE.${_t_}?=	TOOLS_GNU_MISSING
.endfor
.undef _t_

.if !defined(TOOLS_IGNORE.automake) && !empty(USE_TOOLS:Mautomake)
.  if !empty(PKGPATH:Mdevel/automake)
MAKEFLAGS+=		TOOLS_IGNORE.automake=
.  else
AUTOMAKE_REQD?=		1.9
AUTOCONF_REQD?=		2.58

TOOLS_DEPMETHOD.automake?=	BUILD_DEPENDS
TOOLS_DEPENDS.automake?=	automake>=${AUTOMAKE_REQD}:../../devel/automake
.    if empty(${TOOLS_DEPMETHOD.automake}:M${TOOLS_DEPENDS.automake})
${TOOLS_DEPMETHOD.automake}+=	${TOOLS_DEPENDS.automake}
.    endif
EVAL_PREFIX+=			_TOOLS_AM_PREFIX=automake

_TOOLS_AM_TYPE.aclocal=		TOOLS_CREATE
TOOLS_REAL_CMD.aclocal=		${_TOOLS_AM_PREFIX}/bin/aclocal

_TOOLS_AM_TYPE.automake=	TOOLS_CREATE
TOOLS_REAL_CMD.automake=	${_TOOLS_AM_PREFIX}/bin/automake

# Continue to define the following variables until packages have been
# taught to just use "aclocal" and "automake" instead.
#
ACLOCAL=	${TOOLS_CMD.aclocal}
AUTOMAKE=	${TOOLS_CMD.automake}
.  endif
.endif

.if !defined(TOOLS_IGNORE.automake14) && !empty(USE_TOOLS:Mautomake14)
.  if !empty(PKGPATH:Mdevel/automake14)
MAKEFLAGS+=		TOOLS_IGNORE.automake14=
.  else
AUTOMAKE_REQD?=		1.4
AUTOCONF_REQD?=		2.13

TOOLS_DEPMETHOD.automake14?=	BUILD_DEPENDS
TOOLS_DEPENDS.automake14?=	automake14>=${AUTOMAKE_REQD}:../../devel/automake14
.    if empty(${TOOLS_DEPMETHOD.automake14}:M${TOOLS_DEPENDS.automake14})
${TOOLS_DEPMETHOD.automake14}+=	${TOOLS_DEPENDS.automake14}
.    endif
EVAL_PREFIX+=			_TOOLS_AM_PREFIX=automake14

_TOOLS_AM_TYPE.aclocal-1.4=	TOOLS_CREATE
_TOOLS_AM_TYPE.aclocal=		# empty
TOOLS_REAL_CMD.aclocal-1.4=	${_TOOLS_AM_PREFIX}/bin/aclocal-1.4
TOOLS_ALIASES.aclocal-1.4=	aclocal

_TOOLS_AM_TYPE.automake-1.4=	TOOLS_CREATE
_TOOLS_AM_TYPE.automake=	# empty
TOOLS_REAL_CMD.automake-1.4=	${_TOOLS_AM_PREFIX}/bin/automake-1.4
TOOLS_ALIASES.automake-1.4=	automake

# Continue to define the following variables until packages have been
# taught to just use "aclocal" and "automake" instead.
#
ACLOCAL=	${TOOLS_CMD.aclocal-1.4}
AUTOMAKE=	${TOOLS_CMD.automake-1.4}
.  endif
.endif

# Discover which version of autoconf should be used with automake.
.if !empty(USE_TOOLS:Mautomake) || !empty(USE_TOOLS:Mautomake14)
.  if !defined(_TOOLS_AM_AUTOCONF)
_TOOLS_AM_AUTOCONF!=	\
	dep="autoconf>="${AUTOCONF_REQD:Q};				\
	if ${PKG_ADMIN} pmatch "$$dep" autoconf-2.13; then		\
		${ECHO} "autoconf213";					\
	else								\
		${ECHO} "autoconf";					\
	fi
.  endif
MAKEVARS+=	_TOOLS_AM_AUTOCONF
USE_TOOLS+=	${_TOOLS_AM_AUTOCONF}
.endif

# If the package wants to override the GNU auto* tools, then do it.
AUTOMAKE_OVERRIDE?=	yes
.if !empty(AUTOMAKE_OVERRIDE:M[yY][eE][sS])
.  for _t_ in ${_TOOLS_AM_NAMES}
.    if !empty(_TOOLS_AM_TYPE.${_t_})
${_TOOLS_AM_TYPE.${_t_}}+=	${_t_}
.    endif
.  endfor
.  undef _t_
.endif

.if !empty(USE_TOOLS:Mgettext-m4)
BUILD_DEPENDS+=	{gettext-0.10.35nb1,gettext-m4-[0-9]*}:../../devel/gettext-m4
.endif
