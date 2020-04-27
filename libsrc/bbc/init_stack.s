
	.export init_stack
	.include "oslib/os.inc"
	.include "oslib/osbyte.inc"
	.importzp sp

init_stack:
	; of the two blocks below, one should be selected
	; putting the stack at &400-7FF saves memory but corrupts BASIC
	; so returning from the program can be a problem!

	; put the stack at the top of memory HIMEM before screen
	
;	lda	#osbyte_READ_TOP
;	jsr	OSBYTE
;	tya
;	sta	sp+1   		; Set argument stack ptr
;	txa
 ;    	sta	sp              ; #<(__RAM_START__ + __RAM_SIZE__)

	; put the stack in the BASIC work area &400-7FF
	lda	#$ff
	sta	sp
	lda	#$7
	sta	sp + 1

	rts
