# $NetBSD: buildlink3.mk,v 1.1 2004/04/25 00:53:15 xtraeme Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
FREETDS_BUILDLINK3_MK:=	${FREETDS_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	freetds
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nfreetds}
BUILDLINK_PACKAGES+=	freetds

.if !empty(FREETDS_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.freetds+=	freetds>=0.61.2
BUILDLINK_PKGSRCDIR.freetds?=	../../databases/freetds
BUILDLINK_INCDIRS.freetds+=	${BUILDLINK_PREFIX.freetds}/freetds/include
BUILDLINK_LIBDIRS.freetds+=	${BUILDLINK_PREFIX.freetds}/freetds/lib
.endif	# FREETDS_BUILDLINK3_MK

.include "../../converters/libiconv/buildlink3.mk"

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}
