# $NetBSD: buildlink3.mk,v 1.22 2013/02/16 11:18:39 wiz Exp $

BUILDLINK_TREE+=	libsexy

.if !defined(LIBSEXY_BUILDLINK3_MK)
LIBSEXY_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.libsexy+=	libsexy>=0.1.8
BUILDLINK_ABI_DEPENDS.libsexy+=	libsexy>=0.1.11nb15
BUILDLINK_PKGSRCDIR.libsexy?=	../../devel/libsexy

.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/pango/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"
.endif # LIBSEXY_BUILDLINK3_MK

BUILDLINK_TREE+=	-libsexy
