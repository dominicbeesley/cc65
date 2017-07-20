; Dominic Beesley 26.05.2005
; Routines for setting errorno and returning -1L
 
; ??? Assumes all error numbers < 256 and >0

	.include	"errno.inc"
	.export		einval
	.export		emfile
	.export		ebadf
	.export		eio
	
	.export		errout
	.export		errout2
	
	.importzp	sreg


	
	
einval:
        lda     #<EINVAL
	bne	errout

emfile:	lda	#<EMFILE
	bne	errout

ebadf:	lda	#<EBADF
	bne	errout

eio:	lda	#<EIO
	bne	eio
			
errout:	sta	__errno
errout2:ldx	#0
	stx	__errno + 1
	dex
	txa
	sta	sreg
	sta	sreg + 1
	rts
