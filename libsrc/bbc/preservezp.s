	.export	preservezp, restorezp
	.import		subysp
	.import		addysp
	.include	"zeropage.inc"
	
	.code
preservezp:
	; make room on the stack
	ldy	#zpspace
	jsr	subysp
	
	ldy	#zpspace-1
preserveloop:
	lda	sp, y		; ??? sp always first in zp?
	sta	(sp), y	

	dey
	bpl	preserveloop
	rts

restorezp:
	ldy	#zpspace-1
restoreloop:
	lda	(sp), y
	sta	sp, y
	dey
	bpl	restoreloop
	
	ldy	#zpspace
	jsr	addysp
	rts
 
	.end