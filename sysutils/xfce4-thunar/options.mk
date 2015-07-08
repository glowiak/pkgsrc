# $NetBSD: options.mk,v 1.3 2015/07/08 21:15:21 youri Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.xfce4-thunar
PKG_SUPPORTED_OPTIONS=	gvfs
PKG_SUGGESTED_OPTIONS=  gvfs

.include "../../mk/bsd.options.mk"

# for trash support, and remote filesystems
.if !empty(PKG_OPTIONS:Mgvfs)
DEPENDS+=	gvfs-[0-9]*:../../sysutils/gvfs
.endif
