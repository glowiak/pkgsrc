# $NetBSD: buildlink3.mk,v 1.1 2004/03/16 09:48:37 cube Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
INN_BUILDLINK3_MK:=	${INN_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	inn
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ninn}
BUILDLINK_PACKAGES+=	inn

.if !empty(INN_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.inn+=	inn>=2.3.4
BUILDLINK_PKGSRCDIR.inn?=	../../news/inn

.endif	# INN_BUILDLINK3_MK

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}
