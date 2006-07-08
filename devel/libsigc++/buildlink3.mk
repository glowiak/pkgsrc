# $NetBSD: buildlink3.mk,v 1.9 2006/07/08 23:10:45 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBSIGC++_BUILDLINK3_MK:=	${LIBSIGC++_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libsigcxx
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibsigcxx}
BUILDLINK_PACKAGES+=	libsigcxx
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libsigcxx

.if !empty(LIBSIGC++_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libsigcxx+=	libsigc++>=1.2.3nb1
BUILDLINK_ABI_DEPENDS.libsigcxx+=	libsigc++>=1.2.7nb1
BUILDLINK_PKGSRCDIR.libsigcxx?=	../../devel/libsigc++
.endif	# LIBSIGC++_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
