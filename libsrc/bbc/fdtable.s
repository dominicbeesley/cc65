; Dominic Beesley 27.04.2005
;
; File descriptor indirection table
; 
; Each file descriptor (as returned by open is an index into these tables
;
; fd_flags is a set of flags for each file descriptor, one for each file
; fd_chan is the OS file handles for each file descriptor but not the first three "special" ones
; fd_seek is the deferred seek calue for each file descriptor but not the first three
;
; NOTE: for speed all fd's are passed around as unsigned chars! $FF == -1!
;
;
; Flags table, for each file fd is an index into this table
;
;	+0	Flags		Bit 0 - can be read
;				Bit 1 - can be written
;				Bit 3 - seek pending (lseek called but seek deferred)
;				Bit 4 - is console (STDIN/OUT/ERR) cannout be closed!
;				All bits are clear for a free location









		.export		__fd_release
		.export		__fd_getflags
		.export		__fd_getchannel
		.export		__fd_getseek
		.export		__fd_setseek
		.export		__fd_clearseek
		
		.import		incsp1, incsp4
		.import		OSFIND
				
		.import		ebadf
		.importzp 	tmp1, tmp2, sreg, sp

		.include	"fdtable.inc"

		.destructor	_closeallfiles, 17
		.export		fd_chan, fd_flags

.data
fd_flags:	.byte	FD_FLAG_READ + FD_FLAG_CON
		.byte	FD_FLAG_WRITE + FD_FLAG_CON
		.byte	FD_FLAG_WRITE + FD_FLAG_CON
		.res	FD_MAX - FD_START, 0
.bss
fd_chan:	.res	FD_MAX - FD_START, 0
fd_seek:	.res	(FD_MAX - FD_START) * 4, 0
.code




;	unsigned char __fastcall _fd_release(unsigned char fd)
;		// release the fd i.e. set all flags to zero (don't bother with rest...)
;		// returns the channel number
		; ??? don't check past end of table as read/write already checked ???
		; ??? don't check whether its already closed
		; ??? don't check for attempt to release a special, close should do that?
__fd_release:	tay
		lda	#0
		sta	fd_flags, y
		lda	fd_chan - FD_START, y ; return the channel
		rts
		
;	unsigned char __fastcall _fd_getflags(unsigned char fd)
;		// get OS channel
;		// may return -1 and set errno to EBADF for bad fd, or closed
;
		; ??? don't check past end of table as read/write already checked ???
__fd_getflags:	cmp	#FD_MAX
		bcc	l1
x1:		jmp	ebadf
l1:		tay
		lda	fd_flags, y
		beq	x1
l3:		rts
		
;	unsigned char __fastcall _fd_getchannel(unsigned char fd)
;		// get OS channel
;		// may return -1 and set errno to EBADF for bad fd, or closed
;
		; ??? don't check past end of table as read/write already checked ???
		; ??? don't check for attempt to read "special" channel
__fd_getchannel:tay
		lda	fd_chan - FD_START, y
		rts

		
;	off_t __fastcall _fd_getseek(unsigned char fd)
;		// get deferred seek value
;
		; ??? don't check ranges and assume caller has checked a seek is pending ???				
__fd_getseek:	sec
		sbc	#FD_START - 1
		asl	A
		asl	A
		tay			; Y = ( fd - FD_START - 1) * 4; i.e. points
					; to entry AFTER ours
		dey			; now points at highest byte of double word
		
		lda	fd_seek, Y
		sta	sreg + 1
		dey
		lda	fd_seek, Y
		sta	sreg
		dey
		ldx	fd_seek, Y
		dey
		lda	fd_seek, Y
		
		rts

;	unsigned char __fastcall _fd_setseek(off_t pos, unsigned char fd) !!!! NOTE param order!
;		// set deferred seek value, return 0
;		??? assumes good parameters, i.e. call to fd_getflags first
__fd_setseek:	sta	tmp1
		jsr	__fd_getflags
		cmp	#$FF
		beq	errss
		
		ora	#FD_FLAG_SEEKPEND
		ldx	tmp1
		sta	fd_flags, x
		
		txa
		sec
		sbc	#FD_START - 1
		asl	A
		asl	A
		tax
		dex			; X points to high byte of seek table entry index (see getseek)
		
		ldy	#3
		
		lda	(sp), y
		sta	fd_seek, x
		dey
		dex
		lda	(sp), y
		sta	fd_seek, x
		dey
		dex
		lda	(sp), y
		sta	fd_seek, x
		dey
		dex
		lda	(sp), y
		sta	fd_seek, x
	
		jsr	incsp4
		lda	#0
		tax
		rts
		
		
errss:		jsr	incsp4
		lda	#$FF
		tax
		rts					

;	unsigned char __fastcall__ _fd_clearseek(unsigned char fd)
;		// clear the seek flag after a deferred seek is performed
;		??? assumes good parameters
		
__fd_clearseek:	sta	tmp1
		jsr	__fd_getflags
		cmp	#$FF
		beq	errcs
		
		ldx	tmp1
		and	#(~FD_FLAG_SEEKPEND) && 255
		sta	fd_flags, x
		
		lda	#0
		tax
				
errcs:		rts
		

;.proc	hexp
;	pha
;	ror
;	ror
;	ror
;	ror
;	jsr 	digit
;	pla
;	pha
;	jsr	digit
;	pla
;	rts
;.endproc
	
	
	
;.proc	digit
;	and	#$0F
;	cmp	#$0A
;	bcc	d
;	clc
;	adc	#$07
;d:	clc
;	adc 	#$30
;	jsr	OSWRCH
;	rts
;.endproc	

.proc	_closeallfiles
	
	ldy	#FD_START
loop:	lda	fd_flags, y
	beq	shut
	
	tya
	pha				; push Y
		
	lda	fd_chan - FD_START, y	
	tay				; Y = channel
	lda	#0			;close	
	jsr	OSFIND
	
	pla				; pop Y
	tay

shut:	iny
	cpy	#FD_MAX
	bne	loop
	rts

.endproc



