
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_delete
;

		.include "osfile.inc"
		.import osfile_alloc_block
		.import osfile_store_fn
		.import	osfile_callosfile
		.import osfile_ret_read_delete_load
		.import ldaxysp
		.export _osfile_delete
			

;;extern os_error *xosfile_delete (char const *file_name,
;      fileswitch_object_type *obj_type,
;      bits32 *load_addr,
;      bits32 *exec_addr,
;      long *size,
;      fileswitch_attr *attr);
;extern fileswitch_object_type osfile_delete (char const *file_name,
;      bits32 *load_addr,
;      bits32 *exec_addr,
;      long *size,
;      fileswitch_attr *attr);

		.proc _osfile_delete
		
		jsr	osfile_alloc_block
		
		ldy	#18 + 9
		jsr	ldaxysp
		jsr	osfile_store_fn

		lda	#OSFile_Delete
		jsr	osfile_callosfile

		ldy	#18 + 10
		jmp	osfile_ret_read_delete_load

		.endproc

