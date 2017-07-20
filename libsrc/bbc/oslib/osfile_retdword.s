
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	Assumes an OSFILE parameter block is at TOS
;	return a dword (32bit) value from the parameter block at TOS
;	to the callee
;
;	On entry sp	->	OSFILE parameter block
;		 ax	->	dword return parameter
;		 y	->	offset on stack of OSFILE parameter
;		
;	if ax is NULL return

		.import OSFILE
		.export osfile_retdword
		.export osfile_retA
		.importzp sp, ptr1, ptr2

		.proc osfile_retdword	
		cpx	#0
		bne	go
		cmp	#0
		beq	no
go:		sta	ptr1
		stx	ptr1 + 1
		tya
		clc
		adc	sp
		sta	ptr2
		lda	sp + 1
		sta	ptr2 + 1
		bcc	noc
		inc	ptr2 + 1
noc:		ldy	#3
lp:		lda	(ptr2), y
		sta	(ptr1), y
		dey
		bpl	lp
no:		rts
		.endproc

		.proc osfile_retA

		.endproc
