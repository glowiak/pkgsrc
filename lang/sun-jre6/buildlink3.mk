# $NetBSD: buildlink3.mk,v 1.4 2008/01/20 09:21:35 tnn Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
SUN_JRE6_BUILDLINK3_MK:=	${SUN_JRE6_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	sun-jre6
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nsun-jre6}
BUILDLINK_PACKAGES+=	sun-jre6
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}sun-jre6

.if !empty(SUN_JRE6_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.sun-jre6+=		sun-jre6-[0-9]*
BUILDLINK_ABI_DEPENDS.sun-jre6?=		sun-jre6>=6.0.4
BUILDLINK_PKGSRCDIR.sun-jre6?=		../../lang/sun-jre6
BUILDLINK_JAVA_PREFIX.sun-jre6=	${PREFIX}/java/sun-6

UNLIMIT_RESOURCES+=	datasize	# Must be at least 131204
.endif	# SUN_JRE6_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
