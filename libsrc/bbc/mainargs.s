;
; Dominic Beesley 15.04.2005
;
; Setup arguments for main
;


	.constructor    initmainargs, 25
       	.import         __argc, __argv
	
MAXARGS = 8


;---------------------------------------------------------------------------
; Setup arguments for main

.proc   initmainargs

	lda	#<argtab	; argv points at table below
	sta	__argv
	lda	#>argtab
	sta	__argv + 1
	
	ldy	#0		; y - index into string
	ldx	#0		; x - index into argtab
	
loop0:	lda	($F2), y	; skip whitespace
	cmp	#32
	bcc	alldone
	bne	start
	iny
	jmp	loop0

start:
	clc
	tya
	adc	$F2
	sta	argtab, x
	inx
	lda	#0
	adc	$F3
	sta	argtab, x
	inx
	cpx	#MAXARGS*2
	bcs	alldone
		
loop1:	cpy	#255		; loop here searching for end of params
	beq	alldone
	lda	($F2), y
	cmp	#32
	beq	doneone
	bcc	alldone
	iny
	jmp	loop1
	
doneone:lda	#0		;zero terminate argument
	sta	($F2), y
	iny
	jmp	loop0
	
alldone:lda	#0		;zero terminate whole string
	sta	($F2), y

	
bail:
	stx	__argc		; x = number of arguments * 2
	clc
	ror	__argc
	lda	#0
	sta	__argc + 1
	
        rts

.endproc

.bss
argtab:	.res	MAXARGS * 2