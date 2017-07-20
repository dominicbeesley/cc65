#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include "fdtable.h"
#include <errno.h>

//??? doesnt work for all flags yet! danger will overwrite when it shouldnt!

unsigned char osfind(unsigned char mode, const char *name) {
	__AX__ = mode;
	__asm__("pha");
	
	__AX__ = (unsigned int) name;
	__asm__("pha");
	__asm__("txa");
	__asm__("tay");
	__asm__("pla");
	__asm__("tax");
	
	__asm__("pla");
	__asm__("jsr $FFCE");		//??? bad boy
	return __AX__ & 0XFF;
}

int open(const char *name, int flags, ...) {
	char *p;
	unsigned char channel;
	unsigned char fd_flags;
	int fd;
		
	//bbc requires $0D as filename terminator
	p = strchr(name,'\0');
	*p = '\x0D';
	

	if ( (flags & O_RDWR) == O_RDONLY ) {
		channel = osfind(0x40, name);
		fd_flags = FD_FLAG_READ;
	} else if ( (flags & O_RDWR) == O_WRONLY) {
		channel = osfind(0x80, name);
		fd_flags = FD_FLAG_WRITE;
	} else if ( (flags & O_RDWR) == O_RDWR) {
		channel = osfind(0xc0, name);
		fd_flags = FD_FLAG_READ | FD_FLAG_WRITE;
	} else
		channel = 0; //error;
		
	if (!channel) {
		_errno = EIO;	// ??? more work needed here!
		*p = 0;
		return -1;
	}
	
	fd = _fd_getfree(channel, fd_flags);
	
	if (fd == -1) {
		__AX__ = channel;
		__asm__("tay");
		__asm__("lda #0");
		__asm__("jsr $FFCE");
	}

	*p = 0;
		
	return fd;
}