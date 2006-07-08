# $NetBSD: buildlink3.mk,v 1.3 2006/07/08 23:10:37 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
TWOLAME_BUILDLINK3_MK:=	${TWOLAME_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	twolame
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ntwolame}
BUILDLINK_PACKAGES+=	twolame
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}twolame

.if ${TWOLAME_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.twolame+=	twolame>=0.3.7
BUILDLINK_PKGSRCDIR.twolame?=	../../audio/twolame
.endif	# TWOLAME_BUILDLINK3_MK

.include "../../audio/libsndfile/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
