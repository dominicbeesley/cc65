		.import OSASCI
		.export printstr

		.proc printstr
		ldy	#0
l0:		lda	($F2), Y
		cmp	#32
		bcc	out
		jsr	OSASCI
		iny
		bne	l0
out:		rts
		.endproc

