# $NetBSD: buildlink3.mk,v 1.9 2014/10/07 16:47:14 adam Exp $

BUILDLINK_TREE+=	softhsm

.if !defined(SOFTHSM_BUILDLINK3_MK)
SOFTHSM_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.softhsm+=	softhsm>=1.1.3
BUILDLINK_ABI_DEPENDS.softhsm+=	softhsm>=1.3.7nb1
BUILDLINK_PKGSRCDIR.softhsm?=	../../security/softhsm

.include "../../databases/sqlite3/buildlink3.mk"
.include "../../security/botan/buildlink3.mk"
.endif	# SOFTHSM_BUILDLINK3_MK

BUILDLINK_TREE+=	-softhsm
