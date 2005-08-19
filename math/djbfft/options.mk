# $NetBSD: options.mk,v 1.1 2005/08/19 05:07:42 schmonz Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.djbfft
PKG_OPTIONS_OPTIONAL_GROUPS=	optimization
PKG_OPTIONS_GROUP.optimization=	djbfft-pentium djbfft-ppro djbfft-sparc
PKG_OPTIONS_LEGACY_VARS+=	WITH_OPT_PENTIUM:djbfft-pentium
PKG_OPTIONS_LEGACY_VARS+=	WITH_OPT_PPRO:djbfft-ppro

.if ${MACHINE_ARCH} == "sparc"
PKG_SUGGESTED_OPTIONS=	djbfft-sparc
.endif

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mdjbfft-pentium)
DJB_CONFIG_CMDS=        ${ECHO} pentium > conf-opt
.endif

.if !empty(PKG_OPTIONS:Mdjbfft-ppro)
DJB_CONFIG_CMDS=        ${ECHO} ppro > conf-opt
.endif

.if !empty(PKG_OPTIONS:Mdjbfft-sparc)
DJB_CONFIG_CMDS=        ${ECHO} sparc > conf-opt
.endif
