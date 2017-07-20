;
; Dominic Beesley 14.04.2005
;
; unsigned char wherey (void);
;

	.export	 _wherey
	.include "oslib/os.inc"
	.include "oslib/vduvars.inc"

_wherey:
	lda	VDU_WKSP + VDUVAR_TEXT_CURSOR_XY + 1
	ldx	#0
	rts
