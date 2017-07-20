
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	Assumes an OSFILE parameter block is at TOS
;	call OSFILE A contains reason code, sp points to parameter block

		.import OSFILE
		.export osfile_callosfile
		.importzp sp

		.proc osfile_callosfile
		ldx	sp
		ldy	sp + 1
		jsr	OSFILE
		rts
		.endproc
