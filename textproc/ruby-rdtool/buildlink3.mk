# $NetBSD: buildlink3.mk,v 1.1 2004/11/27 15:28:30 taca Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+

.include "rdversion.mk"

.if ${RUBY_VER} == ${RUBY_VER_DEFAULT}
RUBY18_RDTOOL_BUILDLINK3_MK:=	${RUBY18_RDTOOL_BUILDLINK3_MK}+
.else
RUBY16_RDTOOL_BUILDLINK3_MK:=	${RUBY16_RDTOOL_BUILDLINK3_MK}+
.endif

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	${RUBY_PKGPREFIX}-rdtool
.endif

.if ${RUBY_VER} == ${RUBY_VER_DEFAULT}
BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nruby18-rdtool}
.else
BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nruby16-rdtool}
.endif
BUILDLINK_PACKAGES+=	${RUBY_PKGPREFIX}-rdtool

.if ${RUBY_VER} == ${RUBY_VER_DEFAULT}
.if !empty(RUBY18_RDTOOL_BUILDLINK3_MK:M+)
BUILDLINK_FILES.ruby18-rdtool+=		bin/rd2
BUILDLINK_DEPMETHOD.ruby18-rdtool?=     build
BUILDLINK_DEPENDS.ruby18-rdtool+=	${RUBY_PKGPREFIX}-rdtool>=0.6.14
BUILDLINK_PKGSRCDIR.ruby18-rdtool?=	../../textproc/ruby-rdtool
.endif	# RUBY18_RDTOOL_BUILDLINK3_MK
.else
.if !empty(RUBY16_RDTOOL_BUILDLINK3_MK:M+)
BUILDLINK_FILES.ruby16-rdtool+=		bin/rd2
BUILDLINK_DEPMETHOD.ruby16-rdtool?=     build
BUILDLINK_DEPENDS.ruby16-rdtool+=	${RUBY_PKGPREFIX}-rdtool>=0.6.14
BUILDLINK_PKGSRCDIR.ruby16-rdtool?=	../../textproc/ruby-rdtool
.endif	# RUBY16_RDTOOL_BUILDLINK3_MK
.endif

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}
