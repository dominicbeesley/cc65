
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	Assumes an OSFILE parameter block is at TOS
;	Store exec address

		.import steaxysp
		.export osfile_store_exec

		.proc osfile_store_exec
		ldy	#6
		jsr	steaxysp
		rts
		.endproc
