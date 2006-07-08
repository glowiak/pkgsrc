# $NetBSD: buildlink3.mk,v 1.3 2006/07/08 23:11:13 jlam Exp $

BUILDLINK_DEPMETHOD.compositeproto?=	build

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
COMPOSITEPROTO_BUILDLINK3_MK:=	${COMPOSITEPROTO_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	compositeproto
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ncompositeproto}
BUILDLINK_PACKAGES+=	compositeproto
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}compositeproto

.if !empty(COMPOSITEPROTO_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.compositeproto+=	compositeproto>=0.2.1
BUILDLINK_PKGSRCDIR.compositeproto?=	../../x11/compositeproto
.endif	# COMPOSITEPROTO_BUILDLINK3_MK

.include "../../x11/fixesproto/buildlink3.mk"
.include "../../x11/xproto/buildlink3.mk"

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}
