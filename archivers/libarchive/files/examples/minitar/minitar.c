/*-
 * Copyright (c) 2003-2004 Tim Kientzle
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer
 *    in this position and unchanged.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR(S) ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR(S) BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*-
 * This is a compact "tar" program whose primary goal is small size.
 * Statically linked, it can be under 64k.  This serves a number
 * of goals:
 *   o a testbed for libarchive (to check for link pollution),
 *   o a useful tool for space-constrained systems (boot floppies, etc),
 *   o a place to experiment with new implementation ideas for bsdtar,
 *   o a small program to demonstrate libarchive usage.
 *
 * Use the following macros to control what features get incorporated:
 *   NO_BZIP2 - Implies NO_BZIP2_CREATE and NO_BZIP2_EXTRACT
 *   NO_BZIP2_CREATE - Suppress bzip2 compression support.
 *   NO_BZIP2_EXTRACT - Suppress bzip2 auto-detection and decompression.
 *   NO_COMPRESS_EXTRACT - Suppress compress(1) auto-detect and decompression.
 *   NO_COMPRESS - Implies NO_COMPRESS_EXTRACT
 *   NO_CREATE - Suppress all archive creation support.
 *   NO_CPIO_EXTRACT - Suppress auto-detect and dearchiving of cpio archives.
 *   NO_GZIP - Implies NO_GZIP_CREATE and NO_GZIP_EXTRACT
 *   NO_GZIP_CREATE - Suppress gzip compression support.
 *   NO_GZIP_EXTRACT - Suppress gzip auto-detection and decompression.
 *   NO_TAR_EXTRACT - Suppress tar extraction
 *
 * With all of the above options (except NO_TAR_EXTRACT), you get a
 * very small program that can recognize and extract essentially any
 * uncompressed tar archive.  On FreeBSD 5.1, this minimal program is
 * under 64k, statically linked.  Without any of the above options,
 * you get a static executable of about 180k with a lot of very
 * sophisticated modern features.
 *
 * Compare this to over 60k for: main(){printf("hello, world!");}
 */

#include <sys/types.h>
__FBSDID("$FreeBSD$");

#include <sys/stat.h>

#include <archive.h>
#include <archive_entry.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#ifndef NO_CREATE
#include "tree.h"
#endif

/*
 * NO_CREATE implies NO_BZIP2_CREATE and NO_GZIP_CREATE.
 */
#ifdef NO_CREATE
#undef NO_BZIP2_CREATE
#define NO_BZIP2_CREATE
#undef NO_GZIP_CREATE
#define NO_GZIP_CREATE
#endif

/*
 * The combination of NO_GZIP_CREATE and NO_GZIP_EXTRACT is
 * equivalent to NO_GZIP.
 */
#ifdef NO_GZIP_CREATE
#ifdef NO_GZIP_EXTRACT
#undef NO_GZIP
#define NO_GZIP
#endif
#endif

#ifdef NO_GZIP
#undef NO_GZIP_EXTRACT
#define NO_GZIP_EXTRACT
#undef NO_GZIP_CREATE
#define NO_GZIP_CREATE
#endif

/*
 * The combination of NO_BZIP2_CREATE and NO_BZIP2_EXTRACT is
 * equivalent to NO_BZIP2.
 */
#ifdef NO_BZIP2_CREATE
#ifdef NO_BZIP2_EXTRACT
#undef NO_BZIP2
#define NO_BZIP2
#endif
#endif

#ifdef NO_BZIP2
#undef NO_BZIP2_EXTRACT
#define NO_BZIP2_EXTRACT
#undef NO_BZIP2_CREATE
#define NO_BZIP2_CREATE
#endif

/*
 * NO_COMPRESS_EXTRACT and NO_COMPRESS are equivalent.
 */
#ifdef NO_COMPRESS_EXTRACT
#undef NO_COMPRESS
#define NO_COMPRESS
#endif

#ifdef NO_COMPRESS
#undef NO_COMPRESS_EXTRACT
#define NO_COMPRESS_EXTRACT
#endif


#ifndef NO_CREATE
static void	create(const char *filename, int compress, const char **argv);
#endif
static void	errmsg(const char *);
static void	extract(const char *filename, int do_extract, int flags);
static int	copy_data(struct archive *, struct archive *);
static void	msg(const char *);
static void	usage(void);

static int verbose = 0;

int
main(int argc, const char **argv)
{
	const char *filename = NULL;
	int compress, flags, mode, opt;

	(void)argc;
	mode = 'x';
	verbose = 0;
	compress = '\0';
	flags = ARCHIVE_EXTRACT_TIME;

	/* Among other sins, getopt(3) pulls in printf(3). */
	while (*++argv != NULL && **argv == '-') {
		const char *p = *argv + 1;

		while ((opt = *p++) != '\0') {
			switch (opt) {
#ifndef NO_CREATE
			case 'c':
				mode = opt;
				break;
#endif
			case 'f':
				if (*p != '\0')
					filename = p;
				else
					filename = *++argv;
				p += strlen(p);
				break;
#ifndef NO_BZIP2_CREATE
			case 'j':
				compress = opt;
				break;
#endif
			case 'p':
				flags |= ARCHIVE_EXTRACT_PERM;
				flags |= ARCHIVE_EXTRACT_ACL;
				flags |= ARCHIVE_EXTRACT_FFLAGS;
				break;
			case 't':
				mode = opt;
				break;
			case 'v':
				verbose++;
				break;
			case 'x':
				mode = opt;
				break;
#ifndef NO_BZIP2_CREATE
			case 'y':
				compress = opt;
				break;
#endif
#ifndef NO_GZIP_CREATE
			case 'z':
				compress = opt;
				break;
#endif
			default:
				usage();
			}
		}
	}

	switch (mode) {
#ifndef NO_CREATE
	case 'c':
		create(filename, compress, argv);
		break;
#endif
	case 't':
		extract(filename, 0, flags);
		break;
	case 'x':
		extract(filename, 1, flags);
		break;
	}

	return (0);
}


#ifndef NO_CREATE
static char buff[16384];

static void
create(const char *filename, int compress, const char **argv)
{
	struct archive *a;
	struct archive_entry *entry;
	ssize_t len;
	int fd;

	a = archive_write_new();
	switch (compress) {
#ifndef NO_BZIP2_CREATE
	case 'j': case 'y':
		archive_write_set_compression_bzip2(a);
		break;
#endif
#ifndef NO_GZIP_CREATE
	case 'z':
		archive_write_set_compression_gzip(a);
		break;
#endif
	default:
		archive_write_set_compression_none(a);
		break;
	}
	archive_write_set_format_ustar(a);
	if (strcmp(filename, "-") == 0)
		filename = NULL;
	archive_write_open_file(a, filename);
	while (*argv != NULL) {
		struct tree *t = tree_open(*argv);
		while (tree_next(t)) {
			entry = archive_entry_new();
			archive_entry_copy_stat(entry, tree_current_stat(t));
			archive_entry_set_pathname(entry, tree_current_path(t));
			if (verbose) {
				msg("a ");
				msg(tree_current_path(t));
			}
			archive_write_header(a, entry);
			fd = open(tree_current_access_path(t), O_RDONLY);
			len = read(fd, buff, sizeof(buff));
			while (len > 0) {
				archive_write_data(a, buff, len);
				len = read(fd, buff, sizeof(buff));
			}
			close(fd);
			archive_entry_free(entry);
			if (verbose)
				msg("\n");
		}
		argv++;
	}
	archive_write_close(a);
	archive_write_finish(a);
}
#endif

static void
extract(const char *filename, int do_extract, int flags)
{
	struct archive *a;
	struct archive *ext;
	struct archive_entry *entry;
	int r;

	a = archive_read_new();
	ext = archive_write_disk_new();
	archive_write_disk_set_options(ext, flags);
#ifndef NO_BZIP2_EXTRACT
	archive_read_support_compression_bzip2(a);
#endif
#ifndef NO_GZIP_EXTRACT
	archive_read_support_compression_gzip(a);
#endif
#ifndef NO_COMPRESS_EXTRACT
	archive_read_support_compression_compress(a);
#endif
#ifndef NO_TAR_EXTRACT
	archive_read_support_format_tar(a);
#endif
#ifndef NO_CPIO_EXTRACT
	archive_read_support_format_cpio(a);
#endif
	if (filename != NULL && strcmp(filename, "-") == 0)
		filename = NULL;
	if ((r = archive_read_open_file(a, filename, 10240))) {
		errmsg(archive_error_string(a));
		errmsg("\n");
		exit(r);
	}
	for (;;) {
		r = archive_read_next_header(a, &entry);
		if (r == ARCHIVE_EOF)
			break;
		if (r != ARCHIVE_OK) {
			errmsg(archive_error_string(a));
			errmsg("\n");
			exit(1);
		}
		if (verbose && do_extract)
			msg("x ");
		if (verbose || !do_extract)
			msg(archive_entry_pathname(entry));
		if (do_extract) {
			r = archive_write_header(ext, entry);
			if (r != ARCHIVE_OK)
				errmsg(archive_error_string(a));
			else
				copy_data(a, ext);
		}
		if (verbose || !do_extract)
			msg("\n");
	}
	archive_read_close(a);
	archive_read_finish(a);
	exit(0);
}

static int
copy_data(struct archive *ar, struct archive *aw)
{
	int r;
	const void *buff;
	size_t size;
	off_t offset;

	for (;;) {
		r = archive_read_data_block(ar, &buff, &size, &offset);
		if (r == ARCHIVE_EOF) {
			errmsg(archive_error_string(ar));
			return (ARCHIVE_OK);
		}
		if (r != ARCHIVE_OK)
			return (r);
		r = archive_write_data_block(aw, buff, size, offset);
		if (r != ARCHIVE_OK) {
			errmsg(archive_error_string(ar));
			return (r);
		}
	}
}

static void
msg(const char *m)
{
	write(1, m, strlen(m));
}

static void
errmsg(const char *m)
{
	write(2, m, strlen(m));
}

static void
usage(void)
{
/* Many program options depend on compile options. */
	const char *m = "Usage: minitar [-"
#ifndef NO_CREATE
	    "c"
#endif
#ifndef	NO_BZIP2
	    "j"
#endif
	    "tvx"
#ifndef NO_BZIP2
	    "y"
#endif
#ifndef NO_GZIP
	    "z"
#endif
	    "] [-f file] [file]\n";

	errmsg(m);
	exit(1);
}

#if 0
/*
 * These override functions in libc (which are called by libarchive).
 * The libc functions are pretty large; this bit of subterfuge
 * reduces the size of the executable by about 70%.
 */
struct passwd *getpwnam(const char *);
struct group *getgrnam(const char *);

struct passwd *
getpwnam(const char *login)
{
        (void)login;
        return (NULL);
}

struct group *
getgrnam(const char *name)
{
        (void)name;
        return (NULL);
}
#endif
