; Dominic Beesley 23.05.2005
; Assembler support functions for lseek etc

	.importzp ptr1, sreg, sp
	.export ___ext, ___ptr, ___ptr2
	.export __seekcheck
	.import OSARGS
	.import incsp1, pusha, popa
	.import __fd_clearseek
	.import __fd_getseek
	.import __fd_getchannel
	.import __fd_getflags
	.import	_clear_brk_ret, _set_brk_ret	
	.import	errout2
	.include "oslib/osargs.inc"
	.include "fdtable.inc"
		
retblock:	lda ptr1 + 3
		sta sreg + 1
		lda ptr1 + 2
		sta sreg
		lda ptr1
		ldx ptr1 + 1
		rts
		
; off_t __fastcall__ __ext(unsigned char channel)
___ext:		tay
		lda	#OSARGS_READ_EXT
callosargs:	ldx	#ptr1
		jsr	OSARGS
		jmp	retblock
		
; off_t __fastcall__ __ptr(unsigned char channel)
___ptr:		tay
		lda	#OSARGS_READ_PTR
		jmp	callosargs
		
; int __fastcall__ __ptr2(unsigned char channel, off_t pos)
___ptr2:	sta	ptr1
		stx	ptr1 + 1
		lda	sreg
		sta	ptr1 + 2
		lda	sreg + 1
		sta	ptr1 + 3
		
		jsr	_set_brk_ret
		bne	__ptr2err
		
		ldy	#0
		lda	(sp), y
		tay
		lda	#OSARGS_WRITE_PTR
		ldx	#ptr1
		jsr	OSARGS
		
		jsr	_clear_brk_ret
		
		jsr	incsp1
		lda	#0
		tax
		rts
		
__ptr2err:	jsr	incsp1
		lda	sp
		lda	sp + 1
		lda	#$FF
		tax
		rts
		
;int __fastcall__ _seekcheck(int fd) {
__seekcheck:
	jsr	pusha
	
;	if (_fd_getflags(fd) & FD_FLAG_SEEKPEND) {
	jsr	__fd_getflags	; get flags
	cmp	#$FF
	bne	l1
	jmp	errout2	
l1:	and	#FD_FLAG_SEEKPEND
	beq	out0
		
;		channel = _fd_getchannel(fd);
	ldy	#0
	lda	(sp), y
	jsr	__fd_getchannel
		
;		if (channel == -1) 
;			return -1;
	cmp	#$FF
	beq	outerr
	
	jsr	pusha
		
;		pos = _fd_getseek(fd);
	ldy	#1
	lda	(sp), y
	jsr	__fd_getseek
	
;		if (pos == -1)
;			return -1;
	
	cmp	#$FF
	bne	getseekok
	cpx	#$FF
	bne	getseekok
	cmp	sreg
	bne	getseekok
	cmp	sreg + 1
	bne	getseekok
	jmp	outerr2
	
getseekok:
;		if (__ptr2(channel, pos) == -1) {
;			return -1;
;		}

	jsr	___ptr2
	cmp	#$FF
	beq	outerr	

;	_fd_clearseek(fd);
	jsr	popa
	jmp	__fd_clearseek	; note JMP!
	
;	return 0;
out0:	jsr	incsp1
	lda	#0
	tax
	rts
	
outerr2:jsr	incsp1
outerr: jsr	incsp1
	lda	#$FF
	tax
	rts
;}
		
		
	.end
	
		