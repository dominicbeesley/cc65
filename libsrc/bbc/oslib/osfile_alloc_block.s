;
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	Create an OSFILE parameter block at TOS

		.import subysp
		.export osfile_alloc_block

		.proc osfile_alloc_block
		ldy	#18
		jsr	subysp
		rts
		.endproc
