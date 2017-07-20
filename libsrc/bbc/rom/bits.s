		.export _hellow
		.export _hidden
		.export _pie
		.export lang_start
		.import print0
		.import printstr
		.import reset
		.import __Cstart

		.importzp	ptr1, ptr2, ptr3
		.import		__DATA_LOAD__
		.import		__DATA_SIZE__
		.import		__DATA_RUN__

hellowstr:	.byte "Hello World ",0

_hellow:	lda $F3
		pha
		tya
		pha
		lda $F2
		pha
		
		lda #<hellowstr
		sta $F2
		lda #>hellowstr
		sta $F3
		jsr print0

		pla
		sta $F2
		pla 
		clc
		adc $F2
		sta $F2
		pla
		adc #0
		sta $F3
		jsr printstr

		rts

hiddenstring:	.byte "Hidden command executed!", 0

_hidden:	lda	#<hiddenstring
		sta	$F2
		lda	#>hiddenstring
		sta	$F3
		jsr	print0

		lda #0
		rts



piestr:		.byte "Pie mmmmmm",13,10,0
_pie:		lda	#<piestr
		sta	$F2
		lda	#>piestr
		sta	$F3
		jsr	print0
		rts

lang_start:	; set up stack
		ldx	#$FF
		txs			; initialise CPU stack

		lda	#<__DATA_LOAD__
		sta	ptr1
		lda	#>__DATA_LOAD__
		sta	ptr1 + 1

		lda	#<__DATA_RUN__
		sta	ptr2
		lda	#>__DATA_RUN__
		sta	ptr2 + 1

		lda	#<(__DATA_SIZE__ - 1)
		sta	ptr3
		lda	#>(__DATA_SIZE__ - 1)
		sta	ptr3 + 1

		inx
loop1:		lda	#$FF
		cmp	ptr3
		bne	c1
		cmp	ptr3 + 1
		beq	dn
c1:		lda	(ptr1, X)
		sta	(ptr2, X)
		inc	ptr1
		bne	sk1
		inc	ptr1 + 1
sk1:		inc	ptr2
		bne	sk2
		inc	ptr2 + 1
sk2:		dec	ptr3
		bne	loop1
		dec	ptr3 + 1
		bne	loop1
		
dn:		jmp	__Cstart	; call main C initialisation fn
