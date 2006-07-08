# $NetBSD: buildlink3.mk,v 1.6 2006/07/08 23:11:09 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
PCIUTILS_BUILDLINK3_MK:=	${PCIUTILS_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	pciutils
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Npciutils}
BUILDLINK_PACKAGES+=	pciutils
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}pciutils

.if !empty(PCIUTILS_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.pciutils+=	pciutils>=2.1.11
BUILDLINK_ABI_DEPENDS.pciutils?=	pciutils>=2.1.11nb1
BUILDLINK_PKGSRCDIR.pciutils?=	../../sysutils/pciutils
BUILDLINK_DEPMETHOD.pciutils?=	build
.endif	# PCIUTILS_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
