
#include <dirent.h>
#include <dir.h>
#include <errno.h>

#define MAXOPENDIRS 2

#ifndef NULL
#define NULL 0
#endif

DIR dirs[MAXOPENDIRS];


DIR* __fastcall__ opendir (const char* name) {
	/* ignore name for now and just use current directory! */
	DIR *ret;
	int i;

	// find a free entry

	ret = NULL;
	for (i = 0; i < MAXOPENDIRS; i++) {
		if (dirs[i].used == 0) {
			ret = &dirs[i];
		}
	}

	if (ret == NULL) {
		_errno = EMFILE;
		return NULL;
	}

	ret->channel = 0;
	ret->seq = 0;
	ret->used = 1;
	return ret;
}