# $NetBSD: buildlink3.mk,v 1.6 2006/07/08 23:11:01 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBDVDCSS_BUILDLINK3_MK:=	${LIBDVDCSS_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libdvdcss
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibdvdcss}
BUILDLINK_PACKAGES+=	libdvdcss
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libdvdcss

.if !empty(LIBDVDCSS_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libdvdcss+=	libdvdcss>=1.2.4
BUILDLINK_ABI_DEPENDS.libdvdcss+=	libdvdcss>=1.2.8nb1
BUILDLINK_PKGSRCDIR.libdvdcss?=	../../multimedia/libdvdcss
.endif	# LIBDVDCSS_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
