# $NetBSD: buildlink3.mk,v 1.8 2006/07/08 23:10:38 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LIBTLEN_BUILDLINK3_MK:=	${LIBTLEN_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libtlen
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibtlen}
BUILDLINK_PACKAGES+=	libtlen
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libtlen

.if !empty(LIBTLEN_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libtlen+=	libtlen>=20040212
BUILDLINK_ABI_DEPENDS.libtlen+=	libtlen>=20040212nb1
BUILDLINK_PKGSRCDIR.libtlen?=	../../chat/libtlen
.endif	# LIBTLEN_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
