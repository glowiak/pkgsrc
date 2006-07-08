# $NetBSD: buildlink3.mk,v 1.6 2006/07/08 23:10:38 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LIBIRC_BUILDLINK3_MK:=	${LIBIRC_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libirc
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibirc}
BUILDLINK_PACKAGES+=	libirc
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libirc

.if !empty(LIBIRC_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libirc+=	libirc>=0.2nb1
BUILDLINK_ABI_DEPENDS.libirc+=	libirc>=0.2nb2
BUILDLINK_PKGSRCDIR.libirc?=	../../chat/libirc
.endif	# LIBIRC_BUILDLINK3_MK

.include "../../devel/glib/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
