
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_write_load
;

		.include "osfile.inc"
		.import osfile_write_X_start
		.import osfile_store_attr
		.import	osfile_callosfile
		.import osfile_fndchk
		.import ldeaxysp
		.import ldaxysp
		.import addysp
		.export _osfile_write_attr

;extern os_error *xosfile_write_attr (char const *file_name,
;      fileswitch_attr attr);
;extern void osfile_write_attr (char const *file_name,
;      fileswitch_attr attr);

		.proc _osfile_write_attr

		jsr	osfile_write_X_start
		
		jsr	osfile_store_attr

		lda	#OSFile_WriteAttr
		jsr	osfile_callosfile

		ldy	#18 + 6
		jsr	addysp
		rts

		.endproc
