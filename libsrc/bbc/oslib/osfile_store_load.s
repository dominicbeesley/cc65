;
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	Assumes an OSFILE parameter block is at TOS
;	Store load address

		.import steaxysp
		.export osfile_store_load

		.proc osfile_store_load
		ldy	#2
		jsr	steaxysp
		rts
		.endproc
