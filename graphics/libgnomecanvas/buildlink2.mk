# $NetBSD: buildlink2.mk,v 1.5 2003/02/14 20:14:28 jmmv Exp $

.if !defined(LIBGNOMECANVAS_BUILDLINK2_MK)
LIBGNOMECANVAS_BUILDLINK2_MK=	# defined

BUILDLINK_PACKAGES+=		libgnomecanvas
BUILDLINK_DEPENDS.libgnomecanvas?=	libgnomecanvas>=2.2.0.1
BUILDLINK_PKGSRCDIR.libgnomecanvas?=	../../graphics/libgnomecanvas

EVAL_PREFIX+=	BUILDLINK_PREFIX.libgnomecanvas=libgnomecanvas
BUILDLINK_PREFIX.libgnomecanvas_DEFAULT=	${LOCALBASE}
BUILDLINK_FILES.libgnomecanvas=		include/libgnomecanvas-2.0/libgnomecanvas/*
BUILDLINK_FILES.libgnomecanvas+=	lib/libglade/2.0/libcanvas.*
BUILDLINK_FILES.libgnomecanvas+=	lib/libgnomecanvas-2.*
BUILDLINK_FILES.libgnomecanvas+=	lib/pkgconfig/libgnomecanvas-2.0.pc

.include "../../devel/gettext-lib/buildlink2.mk"
.include "../../devel/libglade2/buildlink2.mk"
.include "../../graphics/libart2/buildlink2.mk"
.include "../../x11/gtk2/buildlink2.mk"

BUILDLINK_TARGETS+=	libgnomecanvas-buildlink

libgnomecanvas-buildlink: _BUILDLINK_USE

.endif	# LIBGNOMECANVAS_BUILDLINK2_MK
