;
; Startup code for cc65 (bbc normal library - not ROM)
;
; This must be the *first* file on the linker command line
;

        .export         _exit
        .export         __STARTUP__ : absolute = 1      ; Mark as startup
        .import         initlib, donelib
        .import         zerobss
	.import		callmain	
	.import		preservezp, restorezp
	.import		_raise

	.import		disable_cursor_edit
	.import		restore_cursor_edit
	.import		init_stack
	
	.import		brkret
	.import		trap_brk, release_brk
	
	.export		__Cstart
	.export		_exit_bits
		
	.include "zeropage.inc"
	.include "oslib/os.inc"
	.include "oslib/osbyte.inc"
	
	.bss
save_s:	.res	1		; save stack pointer before entering main
				; exit can be called from any level!

.segment	"STARTUP"

__Cstart:

reset:
	jsr	zerobss
	jsr	disable_cursor_edit
	jsr	init_stack
	
	; disable interrupts while we setup the vectors
	sei
		
	; set up escape handler
	lda	EVNTV
	sta	oldeventv
	lda	EVNTV + 1
	sta	oldeventv + 1
	
	lda	#<eschandler
	sta	EVNTV
	lda	#>eschandler
	sta	EVNTV + 1
	
	jsr	trap_brk
	
	; reenable interrupts
	cli
		
	; enable escape event
	lda	#osbyte_ENABLE_EVENT
	ldx	#EVNTV_ESCAPE
	jsr	OSBYTE
	stx	oldescen
	
	jsr	initlib

	tsx
	stx	save_s		
	
	jsr	callmain

_exit_bits:	; AX contains exit code, store LSB in user flag
	

	tax
	ldy	#0
	lda	#osbyte_USER_FLAG
	jsr	OSBYTE

	jsr     donelib
	
	; reset escape event state
	lda	oldescen
	bne	l1
	lda	#osbyte_DISABLE_EVENT
	ldx	#EVNTV_ESCAPE
	jsr	OSBYTE

	
l1:	sei

	jsr	release_brk

		
	; restore event handler
	lda	oldeventv
	sta	EVNTV
	lda	oldeventv + 1
	sta	EVNTV + 1
	cli
	
	jsr	restore_cursor_edit

exit:   rts

_exit:	ldx	save_s		; force return to OS
	txs
	jmp	_exit_bits

eschandler:
	php	;push flags
	cmp	#EVNTV_ESCAPE
	bne	nohandle
	
	
	
	pha	; push regs
	txa
	pha
	tya
	pha
	
	
	; preserve zp
	jsr	preservezp
	
	cli			; reenable interrupts
	

	ldx	#0
	lda	#3		;SIGINT ???
	jsr	_raise

	
	sei			; disable interrupts, as we pass it on...
	
	; restore zp
	jsr	restorezp
	
	pla
	tay
	pla
	tax
	pla
	plp
	rts
	
nohandle:
	plp
	jmp	(oldeventv)
	

	.bss
oldeventv:	.res	2
oldescen:	.res	1	; was escape event enabled before?
