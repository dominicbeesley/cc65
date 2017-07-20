
	.export	brkret
	.export trap_brk
	.export trap_brk_clib
	.export release_brk
	
	.import _exit_bits
	.import BRKV

	.bss
oldbrkv:	.res	2
brkret:		.res	2	; where to jump back to if a BRK is trapped
				; this is set by __set_brk_ret
	.code

trap_brk_clib:
	php
	sei
	
	lda	#<bombmessage
	sta	oldbrkv
	lda	#>bombmessage
	sta	oldbrkv + 1
	
	lda	#<brkhandler
	sta	BRKV
	lda	#>brkhandler
	sta	BRKV + 1

	plp			; restore interrupt status in P	
	rts

trap_brk:
	php
	sei
	
	lda	BRKV
	sta	oldbrkv
	lda	BRKV + 1
	sta	oldbrkv + 1
	
	lda	#<brkhandler
	sta	BRKV
	lda	#>brkhandler
	sta	BRKV + 1

	plp			; restore interrupt status in P	
	rts

release_brk:

	php
	sei

	; restore break handler
	lda	oldbrkv
	sta	BRKV
	lda	oldbrkv + 1
	sta	BRKV + 1

	plp
	rts

brkhandler:
	php
	pha
	txa
	pha
	tya
	pha
	ldy	#0
	lda	($FD), y	;get error code (byte after BRK)
	cmp	#$1B		;escape
	beq	brk_pass
	
		
	lda	brkret
	bne	brk_back
	lda	brkret + 1
	beq	brk_pass
	
brk_back:
	jmp	(brkret)	

brk_pass:	; pass it through...
	jsr	_exit_bits	; OS is going to bomb do clean up
	pla
	tay
	pla
	tax
	pla
	plp
	jmp	(oldbrkv)	

	.import print0
	.import printhex
	.import OSWRCH

	.macro domessage msgaddr
	lda	#<msgaddr
	sta	$F2
	lda	#>msgaddr
	sta	$F3
	jsr	print0
	.endmacro

m0:	.byte "BRK occurred at &", 0
m1:	.byte ", Y=", 0
m2:	.byte ", X=", 0
m3:	.byte ", A=", 0
m4:	.byte ", P=", 0
m5:	.byte 13, 10, "ERR=", 0
m6:	.byte " : ", 0

bombmessage:	; show the error message and then hang
	php
	pha
	txa
	pha
	tya
	pha

	domessage m0

	lda	$FE
	jsr	printhex
	lda	$FD
	jsr	printhex

	domessage m1
	
	pla
	jsr	printhex

	domessage m2

	pla
	jsr	printhex

	domessage m3

	pla
	jsr	printhex

	domessage m4

	pla
	jsr	printhex

	domessage m5

	ldy 	#0
	lda	($FD), y
	jsr	printhex

	domessage m6

	ldy	#0
lp:	iny
	beq	done
	lda	($FD), y
	beq	done
	jsr	OSWRCH
	jmp	lp

done:	jmp	done
