;
; Dominic Beesley 14.04.2005
;
; void cputcxy (unsigned char x, unsigned char y, char c);
; void cputc (char c);
;

    	.export	       	_cputcxy, _cputc, putchar
	.import		popa, _gotoxy
	.include	"oslib/os.inc"
	
_cputcxy:
	pha	    		; Save C
	jsr	popa		; Get Y
	jsr	_gotoxy		; Set cursor, drop x
	pla			; Restore C

_cputc:
	jmp	OSWRCH		; ??? probably wrong???

putchar:
	cmp	#$a
	beq	nl
	jmp	OSWRCH		; ??? probably wrong???
nl:	jmp	OSNEWL

