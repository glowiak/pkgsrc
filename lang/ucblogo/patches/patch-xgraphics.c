$NetBSD: patch-xgraphics.c,v 1.2 2015/11/06 20:33:21 joerg Exp $

--- xgraphics.c.orig	2007-12-05 21:00:23.000000000 +0000
+++ xgraphics.c
@@ -314,7 +314,7 @@ void check_X11_stop() {
 
 int get_button()
 {
-  checkX;
+  checkX2(-1);
 
   placate_x();
 
@@ -323,7 +323,7 @@ int get_button()
 
 int get_mouse_x()
 {
-  checkX;
+  checkX2(-1);
 
   placate_x();
 
@@ -333,7 +333,7 @@ int get_mouse_x()
 
 int get_mouse_y()
 {
-  checkX;
+  checkX2(-1);
 
   placate_x();
 
