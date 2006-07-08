# $NetBSD: buildlink3.mk,v 1.6 2006/07/08 23:11:02 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBMPEG3_BUILDLINK3_MK:=	${LIBMPEG3_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libmpeg3
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibmpeg3}
BUILDLINK_PACKAGES+=	libmpeg3
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libmpeg3

.if !empty(LIBMPEG3_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libmpeg3+=	libmpeg3>=1.3nb4
BUILDLINK_ABI_DEPENDS.libmpeg3?=	libmpeg3>=1.3nb6
BUILDLINK_PKGSRCDIR.libmpeg3?=	../../multimedia/libmpeg3
.endif	# LIBMPEG3_BUILDLINK3_MK

.include "../../mk/pthread.buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
