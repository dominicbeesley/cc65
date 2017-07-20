
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	return parameters to read/delete/load osfile routines
;	on entry TOS points to OSFILE block
;	y = size of OSFILE BLOCK + callee param size
;	a = OSFILE return code


		.import OSFILE
		.include "os.inc"
		.include "osfile.inc"
		.import osfile_fndchk
		.import osfile_retdword
		.import osfile_retA
		.import addysp
		.import ldaxysp
		.importzp tmp1
		.export osfile_ret_read_delete_load
		.export xosfile_ret_read_delete_load

		.proc xx
		ldy	#18 + 7
		jsr	ldaxysp
		ldy	#2	;load
		jsr	osfile_retdword

		ldy	#18 + 5
		jsr	ldaxysp
		ldy	#6	;exec
		jsr	osfile_retdword

		ldy	#18 + 3
		jsr	ldaxysp
		ldy	#10	;size
		jsr	osfile_retdword

		ldy	#18 + 1
		jsr	ldaxysp
		ldy	#14	;attr
		jsr	osfile_retdword

		ldy	tmp1
		jsr	addysp
		rts
		.endproc

		.proc osfile_ret_read_delete_load
		sty	tmp1			; y - how much stack to
						; give back before returning
						; i.e. size of OSFILE struct
						; plus size of fn. params
		pha

		jsr	xx


		pla
		ldx	#0
		rts
		.endproc

		.proc xosfile_ret_read_delete_load
		sty	tmp1			; y - how much stack to
						; give back before returning
						; i.e. size of OSFILE struct
						; plus size of fn. params
		ldy	#18 + 9
		jsr	ldaxysp
		jsr	osfile_retA

		jsr	xx

		rts
		.endproc
