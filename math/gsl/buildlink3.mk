# $NetBSD: buildlink3.mk,v 1.7 2006/07/08 23:10:59 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GSL_BUILDLINK3_MK:=	${GSL_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	gsl
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngsl}
BUILDLINK_PACKAGES+=	gsl
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}gsl

.if !empty(GSL_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.gsl+=		gsl>=1.4
BUILDLINK_ABI_DEPENDS.gsl+=	gsl>=1.5nb1
BUILDLINK_PKGSRCDIR.gsl?=	../../math/gsl
.endif	# GSL_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
