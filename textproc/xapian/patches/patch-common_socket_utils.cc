$NetBSD: patch-common_socket_utils.cc,v 1.1 2015/05/26 12:19:38 jaapb Exp $

--- common/socket_utils.cc.orig	2015-05-21 05:57:01.000000000 +0000
+++ common/socket_utils.cc
@@ -28,6 +28,7 @@ using namespace std;
 
 #ifndef __WIN32__
 # include <sys/socket.h>
+# include <sys/time.h>
 #else
 # include "safeerrno.h"
 
