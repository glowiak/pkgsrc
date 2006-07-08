# $NetBSD: buildlink3.mk,v 1.20 2006/07/08 23:10:39 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
DB3_BUILDLINK3_MK:=	${DB3_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	db3
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ndb3}
BUILDLINK_PACKAGES+=	db3
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}db3

.if !empty(DB3_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.db3+=		db3>=2.9.2
BUILDLINK_ABI_DEPENDS.db3+=	db3>=3.11.2nb3
BUILDLINK_PKGSRCDIR.db3?=	../../databases/db3
BUILDLINK_INCDIRS.db3?=		include/db3
BUILDLINK_LDADD.db3=		-ldb3
BUILDLINK_TRANSFORM+=		l:db-3:db3

.  include "../../mk/bsd.prefs.mk"
.  if defined(USE_DB185) && !empty(USE_DB185:M[yY][eE][sS])
BUILDLINK_LIBS.db3=		${BUILDLINK_LDADD.db3}
BUILDLINK_TRANSFORM+=		l:db:db3
.  endif
.endif	# DB3_BUILDLINK3_MK

.include "../../mk/pthread.buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
