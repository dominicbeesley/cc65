
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_delete
;

		.include "osfile.inc"
		.import osfile_alloc_block
		.import osfile_store_fn
		.import osfile_store_load
		.import osfile_store_exec
		.import osfile_store_len
		.import osfile_store_attr
		.import	osfile_callosfile
		.import ldeaxysp
		.import ldaxysp
		.import addysp
		.importzp sp, sreg
		.export _osfile_save

;extern os_error *xosfile_save (char const *file_name,
;      bits32 load_addr,
;      bits32 exec_addr,
;      byte const *data,
;      byte const *end);
;extern void osfile_save (char const *file_name,		12
;      bits32 load_addr,					8
;      bits32 exec_addr,					4
;      byte const *data,					2
;      byte const *end);					0

		.proc _osfile_save

		jsr	osfile_alloc_block

		ldy	#18 + 13
		jsr	ldaxysp
		jsr	osfile_store_fn

		ldy	#18 + 11
		jsr	ldeaxysp
		jsr	osfile_store_load

		ldy	#18 + 7
		jsr	ldeaxysp
		jsr	osfile_store_exec

		ldy	#18 + 3
		jsr	ldaxysp
		ldy	#0
		sty	sreg
		sty	sreg + 1
		jsr	osfile_store_len; start address in memory

		ldy	#18 + 1
		jsr	ldaxysp
		ldy	#0
		sty	sreg
		sty	sreg + 1
		jsr	osfile_store_attr; end address in memory

		lda	#OSFile_Save
		jsr	osfile_callosfile

		ldy	#18 + 14
		jsr	addysp

		rts

		.endproc
