# $NetBSD: buildlink3.mk,v 1.7 2006/07/08 23:10:47 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
ODE_BUILDLINK3_MK:=	${ODE_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	ode
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Node}
BUILDLINK_PACKAGES+=	ode
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}ode

.if !empty(ODE_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.ode+=		ode>=0.5nb2
BUILDLINK_ABI_DEPENDS.ode?=	ode>=0.5nb2
BUILDLINK_PKGSRCDIR.ode?=	../../devel/ode
.endif	# ODE_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
