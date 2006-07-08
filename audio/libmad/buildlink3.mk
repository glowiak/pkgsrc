# $NetBSD: buildlink3.mk,v 1.9 2006/07/08 23:10:36 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBMAD_BUILDLINK3_MK:=		${LIBMAD_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libmad
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibmad}
BUILDLINK_PACKAGES+=	libmad
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libmad

.if !empty(LIBMAD_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libmad+=	libmad>=0.15.0b
BUILDLINK_ABI_DEPENDS.libmad+=	libmad>=0.15.1bnb1
BUILDLINK_PKGSRCDIR.libmad?=	../../audio/libmad
.endif	# LIBMAD_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
