# $NetBSD: buildlink3.mk,v 1.3 2004/01/05 11:05:45 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LIBMM_BUILDLINK3_MK:=	${LIBMM_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libmm
.endif

.if !empty(LIBMM_BUILDLINK3_MK:M+)
BUILDLINK_PACKAGES+=		libmm
BUILDLINK_DEPENDS.libmm?=	libmm>=1.2.1
BUILDLINK_PKGSRCDIR.libmm?=	../../devel/libmm
.endif	# LIBMM_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
