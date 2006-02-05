# $NetBSD: buildlink3.mk,v 1.9 2006/02/05 21:03:33 ghen Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
FIREFOX_BUILDLINK3_MK:=	${FIREFOX_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	firefox
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nfirefox}
BUILDLINK_PACKAGES+=	firefox

.if !empty(FIREFOX_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.firefox+=	firefox>=1.5
BUILDLINK_RECOMMENDED.firefox+=	firefox>=1.5.0.1
BUILDLINK_PKGSRCDIR.firefox?=	../../www/firefox
.endif	# FIREFOX_BUILDLINK3_MK

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}
