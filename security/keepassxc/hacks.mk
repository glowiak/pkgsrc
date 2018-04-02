# $NetBSD: hacks.mk,v 1.1 2018/04/02 08:45:24 wiz Exp $

# linking -lQt5Widgets on NetBSD with gcc produces
# ld: BFD (NetBSD Binutils nb1) 2.27 assertion fail
# /usr/src/external/gpl3/binutils/lib/libbfd/../../dist/bfd/elflink.c:2694
# unless -lexecinfo preceeds -lQt5Widgets
BUILDLINK_TRANSFORM.NetBSD+=	l:Qt5Widgets:execinfo:Qt5Widgets
