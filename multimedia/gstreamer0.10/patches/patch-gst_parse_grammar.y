$NetBSD: patch-gst_parse_grammar.y,v 1.1 2013/08/01 22:08:16 wiz Exp $

Fix build with bison-3.0.

--- gst/parse/grammar.y.orig	2011-12-30 01:14:35.000000000 +0000
+++ gst/parse/grammar.y
@@ -650,6 +650,7 @@ static int yyerror (void *scanner, graph
 
 %parse-param { void *scanner }
 %parse-param { graph_t *graph }
+%lex-param {void *scanner}
 %pure-parser
 
 %start graph
