# $NetBSD: buildlink3.mk,v 1.10 2006/07/08 23:10:50 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
FNLIB_BUILDLINK3_MK:=	${FNLIB_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	fnlib
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nfnlib}
BUILDLINK_PACKAGES+=	fnlib
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}fnlib

.if !empty(FNLIB_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.fnlib+=	fnlib>=0.5nb6
BUILDLINK_ABI_DEPENDS.fnlib+=	fnlib>=0.5nb10
BUILDLINK_PKGSRCDIR.fnlib?=	../../graphics/fnlib
.endif	# FNLIB_BUILDLINK3_MK

.include "../../graphics/imlib/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
