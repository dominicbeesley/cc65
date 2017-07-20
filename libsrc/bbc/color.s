;
; Dominic Beesley	16.04.2005
;
;	unsigned char __fastcall__ xxxcolor (unsigned char color);
;	return old colour

 	.export		_textcolor, _bgcolor, _bordercolor, setcolors

	.include	"oslib/os.inc"
	.include	"oslib/vduvars.inc"
	.import		return1
	.importzp	tmp1
	.import		_revflag
	
;	??? Does not work in MODE 7
;	??? No bounds checking
	
	.bss
oldbg:	.res 1
oldfg:	.res 1
	.code
	
_bgcolor:
	tax
	lda	oldbg
	pha
	stx	oldbg
	jsr	setcolors
	pla
	rts
_textcolor:
	tax
	lda	oldfg
	pha
	stx	oldfg
	jsr	setcolors
	pla
	rts

setcolors:
	lda	_revflag
	bne	rev
	lda	#17
	jsr	OSWRCH
	lda	oldfg
	jsr	OSWRCH
	lda	#17
	jsr	OSWRCH
	lda	oldbg
	ora	#$80
	jsr	OSWRCH
	rts

rev:
	lda	#17
	jsr	OSWRCH
	lda	oldbg
	jsr	OSWRCH
	lda	#17
	jsr	OSWRCH
	lda	oldfg
	ora	#$80
	jsr	OSWRCH
	rts

_bordercolor:
	jsr return1;
