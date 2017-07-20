;
; Dominic Beesley
;
; Screen size variables
;

	.export		screensize

	.include	"oslib/os.inc"
	.include	"oslib/vduvars.inc"
	
		
.proc   screensize

		

	sec
	lda	VDU_WKSP + VDUVAR_TEXT_WINDOW_TR
	sbc	VDU_WKSP + VDUVAR_TEXT_WINDOW_BL
	tax
	inx

	sec
	lda	VDU_WKSP + VDUVAR_TEXT_WINDOW_BL + 1
	sbc	VDU_WKSP + VDUVAR_TEXT_WINDOW_TR + 1
	tay
	iny

	rts

.endproc


