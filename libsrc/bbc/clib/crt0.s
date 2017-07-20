;
; Startup code for cc65 (BBC CLib ROM linked executable)
;
; This must be the *first* file on the linker command line
;

        .export         _exit

	.import	        _main
        .import         initlib, donelib
        .import         zerobss
	.import		callmain	
	.import		preservezp, restorezp
	.import		_raise
	.import		initclib
	
	.import		disable_cursor_edit
	.import		restore_cursor_edit
	.import		init_stack


	.import		brkret
	.import		trap_brk_clib, release_brk
	
	.export		__Cstart
	.export		_exit_bits

	.import		__BSS_SIZE__, __BSS_RUN__
	.import		__STACKSIZE__
	.import		__initheap
		
	.import		pushax
	.import		printhex

	.include "../../../asminc/zeropage.inc"
	.include "../oslib/os.inc"
	.include "../oslib/osbyte.inc"

	.import print0

	.macro domessage lbl
	lda	#<lbl
	sta	$f2
	lda	#>lbl
	sta	$f3
	jsr	print0
	.endmacro

	.data
startrommsg:	.byte "Calling CLIB rom init", 13, 10, 0
startmsg:	.byte "Starting...", 13, 10, 0
initrommsg:	.byte "Initialise rom", 13, 10, 0
zeromsg:	.byte "Zero bss in executable...", 13, 10, 0
startmainmsg:	.byte "Calling: main", 13, 10, 0
clibcmd:	.byte "CLIB", 13
finished:	.byte "Executable finished normally", 13, 10, 0
initheapmsg:	.byte "Initialising C Heap : ", 0
initstackmsg:	.byte "Initialising C Stack : ", 0
	
	.bss
save_s:	.res	1		; save stack pointer before entering main
				; exit can be called from any level!
save_rom:.res	1		; old rom number

.segment	"STARTUP"

__Cstart:

reset:  ; find the cc65 ROM and switch to it...
	
	lda	#<more
	sta	ptr1
	lda	#>more
	sta	ptr1 + 1

	ldx	#<clibcmd
	ldy	#>clibcmd
	jsr	OSCLI

more:	
	domessage initstackmsg
	jsr	init_stack

	lda	sp + 1
	jsr	printhex
	lda	sp
	jsr	printhex
	jsr	OSNEWL

	

	domessage zeromsg
	jsr	zerobss
	jsr	disable_cursor_edit

	domessage initrommsg
	jsr	initclib

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
	; reenable interrupts
	cli
	
	jsr	trap_brk_clib
	
		
	; enable escape event
	lda	#osbyte_ENABLE_EVENT
	ldx	#EVNTV_ESCAPE
	jsr	OSBYTE
	stx	oldescen
	
	jsr	initlib

	domessage initheapmsg

	lda	#<(__BSS_SIZE__ + __BSS_RUN__)
	ldx	#>(__BSS_SIZE__ + __BSS_RUN__)
	jsr	pushax

	sec
	lda	sp
	sbc	#<__STACKSIZE__
	pha
	lda	sp + 1
	sbc	#>__STACKSIZE__
	tax
	pla
	
	jsr	__initheap

	tsx
	stx	save_s		
	
	domessage startmainmsg

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

	
l1:	jsr	release_brk
		
	; restore event handler
	sei
	lda	oldeventv
	sta	EVNTV
	lda	oldeventv + 1
	sta	EVNTV + 1
	cli
	
	jsr	restore_cursor_edit

	domessage finished

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
