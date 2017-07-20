; Dominic Beesley 14.04.2005
;
; int __fastcall__ read(int fd,void *buf,int count)
;

	.export		_read
	
	.import		rwcommon
	.import		__fd_getflags, __fd_getchannel
	.import		__seekcheck
	.import		_raise
	.import		ldaxysp, pushax, popax
	.import		eio, ebadf, einval, errout2
	.importzp	sp, ptr1, ptr2, ptr3, tmp2, tmp1
	.import		incsp6
	
	.include 	"oslib/os.inc"
	.include 	"fcntl.inc"
	.include 	"errno.inc"
	.include 	"oslib/osbyte.inc"
	.include	"fdtable.inc"
	
	SIGINT		=	3
	
;--------------------------------------------------------------------------
; _read

.proc   _read

	jsr	pushax		; push count;
	ldy	#$05		; get fd
	jsr	ldaxysp		; 
	ldy	#$02
	jsr	__seekcheck	; seek if a seek pending
	cpx	#$FF
	bne	ok
	cmp	#$FF
	bne	ok
        jsr	incsp6		; reset stack
	inx			; return 0 for failed seek, not sure this
	txa			; is right but works for seek past
	rts			; end of file for read only file
	
ok:	jsr	popax
	
	jsr     rwcommon        ; Pop params, check handle
        bcc     l1	        ; Invalid handle, errno already set
	jmp	einval
	
l1:	jsr	__fd_getflags	; get file's flags
	cmp	#$FF		; error ???
	bne	l3
	jmp	errout2		; __fd_getflags already set errno
	
l3:	sta	tmp1
	
	lda	#FD_FLAG_READ
	bit	tmp1
	bne	l2
	jmp	ebadf
	
l2:	lda	#FD_FLAG_CON
	bit	tmp1
	bne	keyin
		
	ldx	#0
	lda	tmp2
	jsr	__fd_getchannel	; not a special so convert fd to
				; channel
	cmp	#$FF
	bne	l4
	jmp	errout2		; errno already set
	
l4:	sta	tmp2
	
	lda	#>dofile
	sta	jumper+1
	lda	#<dofile
	sta	jumper
	jmp 	L2
	
keyin: 	
	lda	#>dokey
	sta	jumper+1
	lda	#<dokey
	sta	jumper
	jmp	L2
	
; Output the next character from the buffer

L0:     jmp	(jumper)
next:	ldy     #0
        sta     (ptr2),y
        inc     ptr2
        bne     L1
        inc     ptr2+1          ; A = *buf++;
L1:     

        
; Count characters written
        inc     ptr3
        bne     L2
        inc     ptr3+1

; Decrement count

L2:     inc     ptr1
        bne     L0
        inc     ptr1+1
        bne     L0

; Return the number of chars written
eof:	
        lda     ptr3
        ldx     ptr3+1
        rts

	

dofile:	lda	#osbyte_READ_EOF_STATUS
	ldx	tmp2
	jsr	OSBYTE
	cpx	#0
	bne	eof
	
	ldy	tmp2
	jsr	OSBGET
	jmp	next
	
dokey:
	jsr	OSRDCH
	bcs	keyerr
	cmp	#13
	beq	return
	cmp 	#10
	beq	newline
	jsr	OSWRCH		; echo character ??? should I do this?
	jmp	next
	
keyerr: cmp	#$1B
	beq	esc
	jmp	eio
	
esc:	lda	#osbyte_ACKNOWLEDGE_ESCAPE
	jsr	OSBYTE
	
	lda	ptr3		; push return value (count of chars up to here)
	pha
	lda	ptr3 + 1
	pha

	lda	ptr2		; push return value (count of chars up to here)
	pha
	lda	ptr2 + 1
	pha

	lda	ptr1		; push return value (count of chars up to here)
	pha
	lda	ptr1 + 1
	pha
	
	lda	#<SIGINT
	ldx	#>SIGINT
	jsr	_raise
	
	pla
	sta	ptr1 + 1
	pla	
	sta	ptr1
	
	pla
	sta	ptr2 + 1
	pla	
	sta	ptr2
	
	pla
	sta	ptr3 + 1
	pla	
	sta	ptr3
	
	jmp	dokey
			
return:	lda	#10
	jmp	next
	
newline:lda	#13
	jmp	next

	
.endproc

.bss
jumper:	.res 	2

