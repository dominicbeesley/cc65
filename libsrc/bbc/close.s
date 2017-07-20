;
; Ullrich von Bassewitz, 16.11.2002
;
; int __fastcall__ close (int fd);
;
; ??? no error checking
; ??? should be EBADF but not in ../include/errno.h!
; assumes fd<=2 is not real file

        .export         _close
	.import         OSFIND
	.import		__fd_getflags, __fd_getchannel, __fd_release
	.import		ebadf, errout2
	.importzp	tmp1
	.include	"errno.inc"
	.include	"fdtable.inc"
	
	
;--------------------------------------------------------------------------
; _close

.proc   _close
	cpx	#0
	beq	l1
x1:	jmp	ebadf
l1:	sta	tmp1
	jsr	__fd_getflags	; check its a good, open fd
	cmp	#$FF
	bne	l2
x2:	jmp	errout2
	
l2:	and	#FD_FLAG_CON	; check its not a special
	bne	x1

	lda	tmp1
	jsr	__fd_release
	cmp	#$FF
	beq	x2
	
	tay
	lda	#0
	jsr	OSFIND
        
	
	rts
	
.endproc


