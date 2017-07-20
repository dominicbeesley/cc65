;
; Ullrich von Bassewitz, 06.08.1998
;
; int kbhit (void);
;

	.export		_kbhit
	.import		return0, return1
	.include	"oslib/os.inc"
	.include	"oslib/osbyte.inc"

.proc	_kbhit
	lda	#osbyte_BUFFER_OP
	ldx	#$FF
	jsr	OSBYTE
	txa	
	bne   	L1
	jmp	return0
L1:	jmp	return1
.endproc






