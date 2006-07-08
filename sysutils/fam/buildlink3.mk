# $NetBSD: buildlink3.mk,v 1.8 2006/07/08 23:11:08 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
FAM_BUILDLINK3_MK:=	${FAM_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	fam
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nfam}
BUILDLINK_PACKAGES+=	fam
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}fam

.if !empty(FAM_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.fam+=		fam>=2.6.10
BUILDLINK_ABI_DEPENDS.fam+=	fam>=2.7.0nb7
BUILDLINK_PKGSRCDIR.fam?=	../../sysutils/fam
.endif	# FAM_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
