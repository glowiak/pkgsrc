# $NetBSD: buildlink3.mk,v 1.98 2023/12/30 12:56:24 wiz Exp $

BUILDLINK_TREE+=	poppler

.if !defined(POPPLER_BUILDLINK3_MK)
POPPLER_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.poppler+=	poppler>=0.5.1
BUILDLINK_ABI_DEPENDS.poppler+=	poppler>=23.12.0
BUILDLINK_PKGSRCDIR.poppler?=	../../print/poppler

GCC_REQD+=	7

.include "../../devel/nss/buildlink3.mk"
.include "../../graphics/cairo/buildlink3.mk"
.include "../../graphics/lcms2/buildlink3.mk"
.include "../../fonts/fontconfig/buildlink3.mk"
.include "../../mk/jpeg.buildlink3.mk"
.include "../../graphics/openjpeg/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../graphics/tiff/buildlink3.mk"
.endif # POPPLER_BUILDLINK3_MK

BUILDLINK_TREE+=	-poppler
