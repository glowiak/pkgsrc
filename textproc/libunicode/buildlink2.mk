# $NetBSD: buildlink2.mk,v 1.2 2002/08/25 18:40:09 jlam Exp $

.if !defined(LIBUNICODE_BUILDLINK2_MK)
LIBUNICODE_BUILDLINK2_MK=	# defined

BUILDLINK_PACKAGES+=			libunicode
BUILDLINK_DEPENDS.libunicode?=		libunicode>=0.4
BUILDLINK_PKGSRCDIR.libunicode?=	../../textproc/libunicode

EVAL_PREFIX+=			BUILDLINK_PREFIX.libunicode=libunicode
BUILDLINK_PREFIX.libunicode_DEFAULT=	${LOCALBASE}
BUILDLINK_FILES.libunicode=	include/unicode.h
BUILDLINK_FILES.libunicode+=	lib/libunicode.*

BUILDLINK_TARGETS+=	libunicode-buildlink

libunicode-buildlink: _BUILDLINK_USE

.endif	# LIBUNICODE_BUILDLINK2_MK
