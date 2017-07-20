; Dominic Beesley 27.04.2005

		.export		__fd_getfree
		.importzp	sp, tmp1
		.import		fd_chan, fd_flags, emfile
		.import		incsp1
		.include	"fdtable.inc"

;	unsigned char __fastcall _fd_getfree(unsigned char channel, unsigned char flags)	
;		// get a free fd, if not available returns -1
;		// and sets errno to EMFILE
;		// sets flags to flags, channel to channel

__fd_getfree:
		ldy	#FD_START
next:		ldx	fd_flags, y
		beq	gotfreefd
		iny
		cpy	FD_MAX
		bcs	next
		
		jsr	incsp1
		
		jmp	emfile	
		
gotfreefd:	sta	fd_flags, y
		
		tya
		pha
		tax
				
		ldy	#0
		lda	(sp), y
		sta	fd_chan - FD_START, x
		
		jsr	incsp1
		
		pla
		ldx	#0
		rts
