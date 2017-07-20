; Dominic Beesley 26.05.2005
; Functions for trapping the BRKV vector.
; These functions should be used to "protect" calls to os functions
; They work a bit like setjmp, execept that only one may be active at a
; time

	.export		_set_brk_ret, _clear_brk_ret
	.import		brkret
	.importzp	sp
	
	.import		OSWRCH
	.import		printhex

.code
;	call this function to make break vector call back into
;	a function. S, sp will be restored
;	will return with A=0 for first call A=1 for subsequent
;	corrupts A, X, Y
;	cf setjmp, longjmp
_set_brk_ret:
	
	pla			; save return address
	tay
	pla
	tsx			; sp in X (+2)
	sta	rtsto + 1	; high byte first
	pha
	tya
	sta	rtsto
	pha
		
	stx	olds
	
	lda	sp
	sta	oldsp
	
	lda	sp + 1
	sta	oldsp + 1
	
	sei
	lda	#<trapbrk
	sta	brkret
	lda	#>trapbrk
	sta	brkret + 1
	cli
		
	lda	#0
	rts
	
trapbrk:		; This is called if a BRK occurs
	lda	#0		; reset this (ignore further errors)
	sta	brkret
	sta	brkret + 1
	
	lda	oldsp
	sta	sp
	
	lda	oldsp + 1	; put sp back as it was
	sta	sp + 1
	
	ldx	olds
	txs
	
	lda	rtsto + 1
	pha
	lda	rtsto
	pha
	
	cli
	lda	#1
	rts
	
;	call this function to reset the above. You MUST reset this
;	before exiting the procedure that called it unless a break
;	actually occurs (calling this too much does not hurt)
	
_clear_brk_ret: 
	sei 
	lda #0 
	sta brkret 
	sta brkret + 1 
	cli
	rts
	
.bss
rtsto:	.res 2		; address to jump back to
olds:	.res 1		; old processor S (before this function was called)
oldsp:	.res 2		; old C sp