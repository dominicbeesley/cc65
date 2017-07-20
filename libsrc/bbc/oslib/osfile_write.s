
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_write
;
;extern os_error *xosfile_write (char const *file_name,
;      bits32 load_addr,
;      bits32 exec_addr,
;      fileswitch_attr attr);
;extern void osfile_write (char const *file_name,	12
;      bits32 load_addr,				8
;      bits32 exec_addr,				4
;      fileswitch_attr attr);				0

		.include "osfile.inc"
		.import osfile_alloc_block
		.import osfile_store_fn
		.import osfile_store_load
		.import osfile_store_exec
		.import osfile_store_attr
		.import	osfile_callosfile
		.import osfile_fndchk
		.import ldeaxysp
		.import ldaxysp
		.import addysp

		.export _osfile_write

		.proc _osfile_write

		jsr	osfile_alloc_block		; room for parameter block

		ldy	#18 + 13		; file_name
		jsr	ldaxysp
		
		jsr	osfile_store_fn
		
		ldy	#18 + 11		; high word of load_addr
		jsr	ldeaxysp
		
		jsr	osfile_store_load

		ldy	#18 + 7			; high word of load_addr
		jsr	ldeaxysp
		
		jsr	osfile_store_exec

		ldy	#18 + 3			; high word of load_addr
		jsr	ldeaxysp
		
		jsr	osfile_store_attr

		lda	#OSFile_Write
		jsr	osfile_callosfile

		ldy	#18 + 14
		jsr	addysp
		rts

		.endproc
