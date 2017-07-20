;
; Dominic Beesley 20.04.2005
;
; void gotox (unsigned char x);
;

	.include	"oslib/os.inc"
	.include	"oslib/vduvars.inc"
	.export		_gotox
	.import		_gotoxy
	.import		_wherey
	
_gotox:
	pha
	lda	#31
	jsr	OSWRCH
	pla
	jsr	OSWRCH
	lda	VDU_WKSP + VDUVAR_TEXT_CURSOR_XY + 1
	jmp	OSWRCH
	
