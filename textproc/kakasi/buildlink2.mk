# $NetBSD: buildlink2.mk,v 1.2 2002/08/25 18:40:06 jlam Exp $

.if !defined(KAKASI_BUILDLINK2_MK)
KAKASI_BUILDLINK2_MK=	# defined

BUILDLINK_PACKAGES+=		kakasi
BUILDLINK_DEPENDS.kakasi?=	kakasi>=2.3.0
BUILDLINK_PKGSRCDIR.kakasi?=	../../textproc/kakasi

EVAL_PREFIX+=				BUILDLINK_PREFIX.kakasi=kakasi
BUILDLINK_PREFIX.kakasi_DEFAULT=	${LOCALBASE}

BUILDLINK_FILES.kakasi=		include/libkakasi.h
BUILDLINK_FILES.kakasi+=	lib/libkakasi.*

BUILDLINK_TARGETS+=	kakasi-buildlink

kakasi-buildlink: _BUILDLINK_USE

.endif	# KAKASI_BUILDLINK2_MK
