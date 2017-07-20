
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	Assumes an OSFILE parameter block is at TOS
;	Store length / start address

		.import steaxysp
		.export osfile_store_len

		.proc osfile_store_len
		ldy	#$A
		jsr	steaxysp
		rts
		.endproc
