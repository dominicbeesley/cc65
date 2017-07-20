
#ifndef __LSEEK_EXTRA__
#define __LSEEK_EXTRA__
#include <unistd.h>

off_t __fastcall__ __ext(unsigned char channel);
off_t __fastcall__ __ptr(unsigned char channel);
int __fastcall__ __ptr2(unsigned char channel, off_t pos);
		
#endif