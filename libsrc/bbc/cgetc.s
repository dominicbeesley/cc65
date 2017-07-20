;
; Christian Groessler, November-2002
;
; get a char from the keyboard
; char cgetc(void)
;

	.export _cgetc
	.export setcursor
	.import cursor
	
	.include "oslib/os.inc"
	.include "oslib/osbyte.inc"

_cgetc:	jsr	setcursor
	ldx	#0	; preserved
	jsr	OSRDCH
	bcs	err
	rts
	
err:	cmp	#$1B
	beq	escape
	txa		; return 0 on error
	rts
	
escape:	pha
	lda	#osbyte_ACKNOWLEDGE_ESCAPE
	jsr	OSBYTE
	pla
	rts
	
setcursor:
	; vdu 23,1,x,0*7
	
	lda	#23
	jsr	OSWRCH
	lda	#1
	jsr	OSWRCH
	lda	#0
	cmp	cursor
	beq	nooff
	lda	#1
nooff:	jsr	OSWRCH
	lda	#0
	ldx	#7
loop:	jsr	OSWRCH
	dex
	bne	loop
	
	rts