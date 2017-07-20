;
; Dominic Beesley 13.04.2005
;
; int write (int fd, const void* buf, unsigned count);
;
; ??? No error cheking yet

        .export         _write

        .import         rwcommon
	.import		__fd_getflags, __fd_getchannel
        .import		pushax, popax, ldaxysp
	.import		__seekcheck
	.import		eio, ebadf, einval, errout2
	.importzp       sp, ptr1, ptr2, ptr3, tmp2, tmp1
	
        .include	"bbc.inc"
	.include	"oslib/os.inc"
	.include        "fcntl.inc"
	.include	"errno.inc"
	.include	"fdtable.inc"


;--------------------------------------------------------------------------
; _write

.proc   _write

	jsr	pushax		; push count;
	ldy	#$05		; get fd
	jsr	ldaxysp		; 
	ldy	#$02
	jsr	__seekcheck	; seek if a seek pending
	cpx	#$FF
	bne	ok
	cmp	#$FF
	bne	ok
	jsr	popax
	jmp	errout2
	
ok:	jsr	popax
        
	jsr     rwcommon        ; Pop params, check handle
        bcc     l1          ; Invalid handle, errno already set
	jmp	einval
	
l1:	jsr	__fd_getflags	; get file's flags
	cmp	#$FF
	bne	l3
	jmp	errout2
	
l3:	sta	tmp1
	
	lda	#FD_FLAG_WRITE
	bit	tmp1
	bne	l2
	jmp	ebadf
	
l2:	lda	#FD_FLAG_CON
	bit	tmp1
	bne	scrout
		
	ldx	#0
	lda	tmp2
	jsr	__fd_getchannel	; not a special so convert fd to
				; channel
	cmp	#$FF
	bne	l4
	jmp	errout2
	
l4:	sta	tmp2
				
	lda	#>dofile
	sta	jumper+1
	lda	#<dofile
	sta	jumper
	jmp 	L2
	
scrout: 	
	lda	#>doscreen
	sta	jumper+1
	lda	#<doscreen
	sta	jumper
	jmp	L2
	
; Output the next character from the buffer

L0:     ldy     #0
        lda     (ptr2),y
        inc     ptr2
        bne     L1
        inc     ptr2+1          ; A = *buf++;
L1:     jmp	(jumper)

next:        
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
	
        lda     ptr3
        ldx     ptr3+1
        rts

dofile:
	ldy	tmp2
	jsr	OSBPUT
	jmp	next
	
doscreen:
	cmp	#$0a
	beq	newl
	jsr     OSWRCH
	jmp	next
newl:
	jsr	OSNEWL
	jmp	next
	
.endproc

.bss
jumper:	.res 	2

