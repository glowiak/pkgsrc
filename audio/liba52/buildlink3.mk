# $NetBSD: buildlink3.mk,v 1.7 2006/07/08 23:10:36 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LIBA52_BUILDLINK3_MK:=	${LIBA52_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	liba52
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nliba52}
BUILDLINK_PACKAGES+=	liba52
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}liba52

.if !empty(LIBA52_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.liba52+=	liba52>=0.7.4
BUILDLINK_ABI_DEPENDS.liba52+=	liba52>=0.7.4nb3
BUILDLINK_PKGSRCDIR.liba52?=	../../audio/liba52
.endif	# LIBA52_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
