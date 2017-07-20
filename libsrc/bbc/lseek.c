/* Dominic Beesley 27.04.2005
*/

#include "fdtable.h"
#include <errno.h>
#include <unistd.h>
#include "lseek_extra.h"

/*off_t __fastcall__ __ext(int channel) {
		__AX__ = channel;
		__asm__("tay");
		__asm__("ldx	#ptr1");
		__asm__("lda	#2");
		__asm__("jsr	$FFDA");
		__asm__("lda	ptr2");
		__asm__("sta	sreg");
		__asm__("lda	ptr2 + 1");
		__asm__("sta	sreg + 1");
		__asm__("lda	ptr1");
		__asm__("ldx	ptr1 + 1");
		return __EAX__;

}

off_t __fastcall__ __ptr(int channel) {
			printf(" -- channel=%d --", (int) channel);
			
			__AX__ = channel;
			__asm__("tay");
			__asm__("jsr 	$FFEE");
			__asm__("ldx	#ptr1");
			__asm__("lda	#0");
			__asm__("jsr	$FFDA");
			__asm__("lda	ptr1 + 2");
			__asm__("sta	sreg");
			__asm__("lda	ptr1 + 3");
			__asm__("sta	sreg + 1");
			__asm__("lda	ptr1");
			__asm__("ldx	ptr1 + 1");
			return __EAX__;

}

int __fastcall__ __ptr2(unsigned char channel, off_t pos) {
		__EAX__ = pos;
		__asm__("sta ptr1");
		__asm__("stx ptr1 + 1");
		__asm__("lda sreg");
		__asm__("sta ptr1 + 2");
		__asm__("lda sreg + 1");
		__asm__("sta ptr1 + 3");
		__AX__ = channel;
		__asm__("tay");
		__asm__("lda #1");
		__asm__("ldx #ptr1");
		__asm__("jsr $FFDA");
		return 0;
}

int __fastcall__ _seekcheck(int fd) {

	unsigned char channel;
	off_t pos;
		
	if (_fd_getflags(fd) & FD_FLAG_SEEKPEND) {
		
		channel = _fd_getchannel(fd);
		if (channel == -1) 
			return -1;
		
		pos = _fd_getseek(fd);
		if (pos == -1)
			return -1;
		
		if (__ptr2(channel, pos) == -1) {
			printf("Seek failed!\n");
			return -1;
		}
			
			
		_fd_clearseek(fd);
	}	
	
	return 0;
}

*/


off_t __fastcall__ lseek(int fd, off_t offset, int whence) {

	unsigned char channel, flags;

	off_t startpos;
		
	/* check the fd is ok */
	flags = _fd_getflags(fd);
	if (flags == 0xFF) 
		return -1;
	
	if (flags & FD_FLAG_CON)
		goto epipe;
		
	if (whence < 0 || whence >=3)
		goto einval;
		
	if (flags == 0xFF)
		return -1;
		
	channel = _fd_getchannel(fd);
		
	if (whence == SEEK_SET) {
		startpos = 0;
	} else if (whence == SEEK_CUR) {
		if (flags & FD_FLAG_SEEKPEND) {
			/* seek is already pending use that value */
			startpos = _fd_getseek(fd);
		} else {
			startpos = __ptr(channel);
		}
	} else {
		startpos = __ext(channel);
	}
	
	startpos = startpos + offset;

	if (startpos < 0) 
		goto einval;
		
	_fd_setseek(startpos, fd);
		
	return startpos;
	
einval:
	_errno = EINVAL;
	return -1;
		
epipe:
	_errno = ESPIPE;
	return -1;
		

}