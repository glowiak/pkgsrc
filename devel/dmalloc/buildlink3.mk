# $NetBSD: buildlink3.mk,v 1.5 2006/07/08 23:10:42 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
DMALLOC_BUILDLINK3_MK:=	${DMALLOC_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	dmalloc
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ndmalloc}
BUILDLINK_PACKAGES+=	dmalloc
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}dmalloc

.if !empty(DMALLOC_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.dmalloc+=	dmalloc>=4.8.2nb2
BUILDLINK_PKGSRCDIR.dmalloc?=	../../devel/dmalloc
BUILDLINK_DEPMETHOD.dmalloc?=	build
.endif	# DMALLOC_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
