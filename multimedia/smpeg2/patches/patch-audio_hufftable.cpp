$NetBSD: patch-audio_hufftable.cpp,v 1.1 2018/02/08 07:28:58 mrg Exp $

don't initialise unsigned with "0-1".

--- audio/hufftable.cpp.orig	2013-06-01 15:19:04.000000000 +0000
+++ audio/hufftable.cpp	2018-02-07 11:40:46.545617490 +0000
@@ -550,11 +550,11 @@
 
 const HUFFMANCODETABLE MPEGaudio::ht[HTN]=
 {
-  { 0, 0-1, 0-1, 0,  0, htd33},
+  { 0, (unsigned)(0-1), (unsigned)(0-1), 0,  0, htd33},
   { 1, 2-1, 2-1, 0,  7,htd01},
   { 2, 3-1, 3-1, 0, 17,htd02},
   { 3, 3-1, 3-1, 0, 17,htd03},
-  { 4, 0-1, 0-1, 0,  0, htd33},
+  { 4, (unsigned)(0-1), (unsigned)(0-1), 0,  0, htd33},
   { 5, 4-1, 4-1, 0, 31,htd05},
   { 6, 4-1, 4-1, 0, 31,htd06},
   { 7, 6-1, 6-1, 0, 71,htd07},
@@ -564,7 +564,7 @@
   {11, 8-1, 8-1, 0,127,htd11},
   {12, 8-1, 8-1, 0,127,htd12},
   {13,16-1,16-1, 0,511,htd13},
-  {14, 0-1, 0-1, 0,  0, htd33},
+  {14, (unsigned)(0-1), (unsigned)(0-1), 0,  0, htd33},
   {15,16-1,16-1, 0,511,htd15},
   {16,16-1,16-1, 1,511,htd16},
   {17,16-1,16-1, 2,511,htd16},
