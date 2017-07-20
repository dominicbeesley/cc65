;
; Dominic Beesley 16.04.2005
;
; void cvlinexy (unsigned char x, unsigned char y, unsigned char length);
; void cvline (unsigned char length);
;
	
    	.export		_cvlinexy, _cvline
	.import		popa, _gotoxy, _cputc, setcursor
	.import		_gotoy, _wherey
	.importzp	tmp1

_cvlinexy:
       	pha	    		; Save the length
	jsr	popa	        ; Get y
       	jsr    	_gotoxy		; Call this one, will pop params
   	pla			; Restore the length and run into _cvline

_cvline:
   	cmp	#0		; Is the length zero?
   	beq	L9  		; Jump if done
    	sta	tmp1
L1:	lda	#$7C 		; Vertical bar
   	jsr	_cputc		; Write, no cursor advance
	lda	#8
	jsr	_cputc
	lda	#10
	jsr	_cputc
   	dec	tmp1
	bne	L1
L9:	jmp	setcursor



