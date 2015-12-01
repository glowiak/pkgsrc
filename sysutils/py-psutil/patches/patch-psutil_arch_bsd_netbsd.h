$NetBSD: patch-psutil_arch_bsd_netbsd.h,v 1.1 2015/12/01 14:07:36 ryoon Exp $

--- psutil/arch/bsd/netbsd.h.orig	2015-11-30 15:33:35.000000000 +0000
+++ psutil/arch/bsd/netbsd.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2009, Giampaolo Rodola', Landry Breuil.
+ * All rights reserved.
+ * Use of this source code is governed by a BSD-style license that can be
+ * found in the LICENSE file.
+ */
+
+#include <Python.h>
+
+typedef struct kinfo_proc2 kinfo_proc;
+
+int psutil_kinfo_proc(pid_t pid, kinfo_proc *proc);
+struct kinfo_file * kinfo_getfile(pid_t pid, int* cnt);
+int psutil_get_proc_list(kinfo_proc **procList, size_t *procCount);
+char *psutil_get_cmd_args(pid_t pid, size_t *argsize);
+PyObject * psutil_get_cmdline(pid_t pid);
+int psutil_pid_exists(pid_t pid);
+int psutil_raise_ad_or_nsp(long pid);
+
+//
+PyObject *psutil_proc_threads(PyObject *self, PyObject *args);
+PyObject *psutil_virtual_mem(PyObject *self, PyObject *args);
+PyObject *psutil_swap_mem(PyObject *self, PyObject *args);
+PyObject *psutil_proc_num_fds(PyObject *self, PyObject *args);
+PyObject *psutil_proc_cwd(PyObject *self, PyObject *args);
+PyObject *psutil_proc_connections(PyObject *self, PyObject *args);
+PyObject *psutil_per_cpu_times(PyObject *self, PyObject *args);
+PyObject* psutil_disk_io_counters(PyObject* self, PyObject* args);
+PyObject* psutil_proc_exe(PyObject* self, PyObject* args);
+PyObject* psutil_proc_num_threads(PyObject* self, PyObject* args);
