/* Dominic Beesley 27.04.2005
	functions for allocating and managing file descriptors - see fdtable.s
*/
	
#ifndef __FDTABLE
#define __FDTABLE

#include <sys/types.h>

#define FD_FLAG_READ		0x01
#define FD_FLAG_WRITE		0x02
#define FD_FLAG_SEEKPEND	0x08
#define FD_FLAG_CON		0x10


unsigned char __fastcall__ _fd_getfree(unsigned char channel, unsigned char flags);
		// get a free fd, if not available returns -1
		// and sets errno to EMFILE
		// sets flags to flags, channel to channel

unsigned char __fastcall__ _fd_release(unsigned char fd);
		// release the fd i.e. set all flags to zero (don't bother with rest...)
		// may return -1 and set errno to EBADF for bad fd, or already closed
		// otherwise returns the channel number

unsigned char __fastcall__ _fd_getchannel(unsigned char fd);
		// get OS channel
		// may return -1 and set errno to EBADF for bad fd, or closed

unsigned char __fastcall__ _fd_getflags(unsigned char fd);
		// get fd flags
		// may return -1 and set errno to EBADF for bad fd, or closed

off_t __fastcall__ _fd_getseek(unsigned char fd);
		// get deferred seek value
		// may return -1 and set errno to EBADF for bad or closed handle
		// will return EBADF if seek flag not set!


unsigned char __fastcall__ _fd_setseek(off_t pos, unsigned char fd); //!!!! NOTE param order!
		// set deferred seek value, return 0
		// may return -1 and set errno to EBADF for bad or closed handle
		// will set seek pending flag for this fd


unsigned char __fastcall__ _fd_clearseek(unsigned char fd);
		// clear the seek flag after a deferred seek is performed
		// may return -1 and set errno to EBADF for bad or closed handle
		// returns flags
 
#endif