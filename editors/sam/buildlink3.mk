# $NetBSD: buildlink3.mk,v 1.6 2006/07/08 23:10:49 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
SAM_BUILDLINK3_MK:=	${SAM_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	sam
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nsam}
BUILDLINK_PACKAGES+=	sam
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}sam

.if !empty(SAM_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.sam+=	sam>=4.3nb1
BUILDLINK_ABI_DEPENDS.sam?=	sam>=4.3nb3
BUILDLINK_PKGSRCDIR.sam?=	../../editors/sam
BUILDLINK_DEPMETHOD.sam?=	build
.endif	# SAM_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
