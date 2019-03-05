# $NetBSD: buildlink3.mk,v 1.6 2019/03/05 17:43:19 jaapb Exp $

BUILDLINK_TREE+=	ocaml-lwt_react

.if !defined(OCAML_LWT_REACT_BUILDLINK3_MK)
OCAML_LWT_REACT_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.ocaml-lwt_react+=	ocaml-lwt_react>=1.1.0
BUILDLINK_ABI_DEPENDS.ocaml-lwt_react+=	ocaml-lwt_react>=1.1.1nb4
BUILDLINK_PKGSRCDIR.ocaml-lwt_react?=	../../devel/ocaml-lwt_react

.include "../../devel/ocaml-lwt/buildlink3.mk"
.include "../../devel/ocaml-react/buildlink3.mk"
.endif	# OCAML_LWT_REACT_BUILDLINK3_MK

BUILDLINK_TREE+=	-ocaml-lwt_react
