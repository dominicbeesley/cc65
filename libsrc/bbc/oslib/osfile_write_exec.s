
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_write_load
;

		.include "osfile.inc"
		.import osfile_write_X_start
		.import osfile_store_exec
		.import	osfile_callosfile
		.import osfile_fndchk
		.import ldeaxysp
		.import ldaxysp
		.import addysp
		.export _osfile_write_exec

;extern os_error *xosfile_write_load (char const *file_name,
;      bits32 load_addr);
;extern void osfile_write_load (char const *file_name,
;      bits32 load_addr);

		.proc _osfile_write_exec

		jsr	osfile_write_X_start
		
		jsr	osfile_store_exec

		lda	#OSFile_WriteExec
		jsr	osfile_callosfile

		ldy	#18 + 6
		jsr	addysp
		rts

		.endproc
