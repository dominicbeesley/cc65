;
; Christian Groessler, Apr-2000
;
; void clrscr (void);
;

	.export		_clrscr
	.include	"bbc.inc"
	.importzp	ptr1
	.import		_puts

_clrscr:

	lda	#<cls_vdu
	ldx	#>cls_vdu
	jmp	_puts
	
.rodata
cls_vdu:	.byte 12,0