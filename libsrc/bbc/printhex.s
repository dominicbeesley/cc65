; Dominic Beesley 26.05.2005, print a two digit hex no in A

	.include "oslib/os.inc"
	.export printhex
	
printhex:
	pha
	and	#$F0
	clc
	ror
	ror
	ror
	ror
	cmp	#10
	bcc	xx
	adc	#$6
xx:	adc	#$30
	jsr	OSWRCH
	pla
	and	#$F
	cmp	#10
	bcc	yy
	adc	#$6
yy:	adc	#$30
	jsr	OSWRCH
	rts
