
#include <dirent.h>
#include <dir.h>


int __fastcall__ closedir (DIR* dir) {
	if (dir)
		dir->used = 0;
}