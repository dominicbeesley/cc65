;
; Dominic Beesley 20.04.2005
;
; void __fastcall__ gotoy (unsigned char x);
;

	.include	"oslib/os.inc"
	.include	"oslib/vduvars.inc"
	.export		_gotoy
	.import		_gotoxy
	.import		_wherey
	
_gotoy:
	pha
	lda	#31
	jsr	OSWRCH
	lda	VDU_WKSP + VDUVAR_TEXT_CURSOR_XY + 0
	jsr	OSWRCH
	pla
	jmp	OSWRCH
