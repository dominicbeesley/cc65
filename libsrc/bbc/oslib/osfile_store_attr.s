
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	Assumes an OSFILE parameter block is at TOS
;	Store attributes / end address

		.import steaxysp
		.export osfile_store_attr

		.proc osfile_store_attr
		ldy	#$E
		jsr	steaxysp
		rts
		.endproc
