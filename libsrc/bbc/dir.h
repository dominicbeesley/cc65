
#ifndef _DIR_H
#define _DIR_H


	struct DIR {
		unsigned char 	channel;
		unsigned long	name_ptr;		
		unsigned long	count;
		unsigned long	seq;
		unsigned char	used;
		unsigned char 	name_len;
		char name[20];
	};

#endif