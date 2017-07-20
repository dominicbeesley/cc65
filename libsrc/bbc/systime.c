#include <time.h>

time_t _systime(void) { 

	unsigned char block[7];
	struct tm t;	
	int i;
	
	block[0] = 1;
	
	__asm__("clc");
	__asm__("lda sp");
	__asm__("adc #%o", block);
	__asm__("tax");
	__asm__("lda sp+1");
	__asm__("adc #0");
	__asm__("tay");
	
	__asm__("lda #$0E");
	__asm__("jsr $FFF1");
	
	
	for (i=0; i<6; i++) {
		block[i] = (block[i] & 0xF) + 10 * (block[i] >> 4);
	}
	
	t.tm_sec = block[6];
	t.tm_min = block[5];
	t.tm_hour = block[4];
	t.tm_mday = block[2];
	t.tm_mon = block[1] - 1;
	t.tm_year = (block[0]<70)?block[0]+100:block[0];
	
	t.tm_wday = 0;
	t.tm_yday = 0;
	t.tm_isdst = 0;
		
	return mktime(&t);

}
