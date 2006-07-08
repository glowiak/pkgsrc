# $NetBSD: buildlink3.mk,v 1.8 2006/07/08 23:11:15 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
PY_XLIB_BUILDLINK3_MK:=	${PY_XLIB_BUILDLINK3_MK}+

.include "../../lang/python/pyversion.mk"

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	py-Xlib
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Npy-Xlib}
BUILDLINK_PACKAGES+=	py-Xlib
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}py-Xlib

.if !empty(PY_XLIB_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.py-Xlib+=	${PYPKGPREFIX}-Xlib>=0.12
BUILDLINK_ABI_DEPENDS.py-Xlib?=	${PYPKGPREFIX}-Xlib>=0.12nb1
BUILDLINK_PKGSRCDIR.py-Xlib?=	../../x11/py-Xlib
.endif	# PY_XLIB_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
