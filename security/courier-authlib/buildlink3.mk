# $NetBSD: buildlink3.mk,v 1.1 2005/02/10 03:47:12 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
COURIER_AUTHLIB_BUILDLINK3_MK:=	${COURIER_AUTHLIB_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	courier-authlib
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ncourier-authlib}
BUILDLINK_PACKAGES+=	courier-authlib

.if !empty(COURIER_AUTHLIB_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.courier-authlib+=	courier-authlib>=0.53
BUILDLINK_PKGSRCDIR.courier-authlib?=	../../security/courier-authlib
.endif	# COURIER_AUTHLIB_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
