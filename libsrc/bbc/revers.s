;
; Ullrich von Bassewitz, 07.08.1998
;
; unsigned char __fastcall__ revers (unsigned char onoff);
;
	.include "bbc.inc"
	
      	.export		_revers
	.export		_revflag
	.import		_textcolor
	.import		_bgcolor
	.import		setcolors

;	??? Not quite sure if this is right
;	??? should probably interact with _textcolor, _bgcolor
;	??? Try it anyway
	
_revers:
	cmp	#0
	beq	zero
	lda	#255
zero:
	ldx	_revflag
	sta	_revflag

	jsr	setcolors
	
	txa
	rts

	.data

_revflag:
	.byte	0
