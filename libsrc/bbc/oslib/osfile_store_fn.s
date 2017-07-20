;
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	Assumes an OSFILE parameter block is at TOS
;	Store filename pointer

		.import steaxysp
		.export osfile_store_fn
		.importzp ptr1, ptr2
		.import bbc_string_buf

		.proc osfile_store_fn
		; copy to buffer and replace 0 terminator with \x0d
		
		sta	ptr1
		stx	ptr1 + 1

		lda	#<bbc_string_buf
		sta	ptr2
		ldx	#>bbc_string_buf
		stx	ptr2 + 1

		ldy	#0
lp:		lda	(ptr1), y
		beq	dn
		sta	(ptr2), y
		iny
		bne	lp
		dey
dn:		lda	#$d
		sta	(ptr2), y

		ldy	#0			; store in block
		lda	#<bbc_string_buf
		ldx	#>bbc_string_buf
		jsr	steaxysp
		rts
		.endproc
