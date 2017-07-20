;
; Dominic Beesley 16.04.2005
;
; void cclearxy (unsigned char x, unsigned char y, unsigned char length);
; void cclear (unsigned char length);
;

    	.export		_cclearxy, _cclear
	.import		popa, _gotoxy
	
	.include	"oslib/os.inc"
	

	; ??? Not tested yet
	
_cclearxy:
       	pha	    		; Save the length
	jsr	popa		; Get y
       	jsr    	_gotoxy		; Call this one, will pop params
       	pla			; Restore the length and run into _cclear

_cclear:
       	cmp	#0		; Is the length zero?
       	beq	L9  		; Jump if done
    	tax				     
	lda    	#32		; Blank - screen code
L1:	jsr	OSWRCH		; Direct output
   	dex
	bne	L1
L9:	rts




