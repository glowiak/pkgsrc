# $NetBSD: buildlink3.mk,v 1.47 2015/04/21 08:56:44 jperkin Exp $

BUILDLINK_TREE+=	xfce4-panel

.if !defined(XFCE4_PANEL_BUILDLINK3_MK)
XFCE4_PANEL_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.xfce4-panel+=	xfce4-panel>=4.12.0
BUILDLINK_ABI_DEPENDS.xfce4-panel+=	xfce4-panel>=4.12.0
BUILDLINK_PKGSRCDIR.xfce4-panel?=	../../x11/xfce4-panel

.include "../../x11/libxfce4ui/buildlink3.mk"
.endif # XFCE4_PANEL_BUILDLINK3_MK

BUILDLINK_TREE+=	-xfce4-panel
