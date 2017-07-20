
	.export	_main
	.export _lang_start
	.export initclib
	.import OSWRCH
	.import print0
	.import zerobss
	.importzp ptr1

	.import pushax
	.import _memcpy
	.import __DATA_SIZE__, __DATA_RUN__, __DATA_LOAD__

mainmessage:	.byte "ROM main function entered!", 13, 10, 0;;

_main:	lda	#<mainmessage
	sta	$F2
	lda	#>mainmessage
	sta	$F3
	jsr	print0
	rts

langmessage:	.byte "LANGUAGE started", 13, 10, 0;
retmessage:	.byte "PROGRAM finished", 13, 10, 0;

_lang_start:
	ldx	#$ff		; set up the CPU stack
	txs

	lda	$fd		; print copyright message
	sta	$f2
	lda	$fe
	sta	$f3

	inc	$f2
	bne	s1
	inc	$f3
s1:

	jsr	print0

	lda	#<langmessage
	sta	$F2
	lda	#>langmessage
	sta	$F3
	jsr	print0

	lda	#>fin
	pha
	lda	#<fin
	pha

	jmp	(ptr1)		; this will have been set by caller (HOPEFULLY)

fin:	nop
	lda	#<retmessage
	sta	$F2
	lda	#>retmessage
	sta	$F3
	jsr	print0

here:	jmp here
	
initclib:
	; copy DATA segment from ROM to RAM

	lda	#<__DATA_RUN__
	ldx	#>__DATA_RUN__

	jsr	pushax

	lda	#<__DATA_LOAD__
	ldx	#>__DATA_LOAD__

	jsr	pushax

	lda	#<__DATA_SIZE__
	ldx	#>__DATA_SIZE__

	jsr	_memcpy

	jmp	zerobss		; zero (ROM) bss area
	