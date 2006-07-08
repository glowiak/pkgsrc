# $NetBSD: buildlink3.mk,v 1.10 2006/07/08 23:10:52 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBUNGIF_BUILDLINK3_MK:=	${LIBUNGIF_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libungif
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibungif}
BUILDLINK_PACKAGES+=	libungif
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libungif

.if !empty(LIBUNGIF_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libungif+=	libungif>=4.1.0
BUILDLINK_ABI_DEPENDS.libungif+=	libungif>=4.1.3nb1
BUILDLINK_PKGSRCDIR.libungif?=	../../graphics/libungif
.endif	# LIBUNGIF_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
