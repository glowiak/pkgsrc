# $NetBSD: buildlink2.mk,v 1.2 2002/08/25 18:39:57 jlam Exp $

.if !defined(RSAREF_BUILDLINK2_MK)
RSAREF_BUILDLINK2_MK=	# defined

BUILDLINK_PACKAGES+=		rsaref
BUILDLINK_DEPENDS.rsaref?=	rsaref-2.0p3
BUILDLINK_PKGSRCDIR.rsaref?=	../../security/rsaref

EVAL_PREFIX+=	BUILDLINK_PREFIX.rsaref=rsaref
BUILDLINK_PREFIX.rsaref_DEFAULT=	${LOCALBASE}
BUILDLINK_FILES.rsaref=		include/rsaref/*.h
BUILDLINK_FILES.rsaref+=	lib/librsaref.*

BUILDLINK_TARGETS+=	rsaref-buildlink

rsaref-buildlink: _BUILDLINK_USE

.endif	# RSAREF_BUILDLINK2_MK
