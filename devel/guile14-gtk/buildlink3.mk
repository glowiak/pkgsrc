# $NetBSD: buildlink3.mk,v 1.6 2006/07/08 23:10:43 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
GUILE_GTK_BUILDLINK3_MK:=	${GUILE_GTK_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	guile-gtk
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nguile-gtk}
BUILDLINK_PACKAGES+=	guile-gtk
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}guile-gtk

.if !empty(GUILE_GTK_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.guile-gtk+=	guile-gtk>=0.19nb4
BUILDLINK_ABI_DEPENDS.guile-gtk+=	guile-gtk>=0.19nb7
BUILDLINK_PKGSRCDIR.guile-gtk?=	../../devel/guile14-gtk
.endif	# GUILE_GTK_BUILDLINK3_MK

.include "../../lang/guile14/buildlink3.mk"
.include "../../x11/gtk/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
