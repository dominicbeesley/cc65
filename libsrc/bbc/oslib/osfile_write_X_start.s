
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	shared startup for all the osfile_write_X functions

		.import ldaxysp
		.import ldeaxysp
		.import osfile_alloc_block	
		.import osfile_store_fn
		.export osfile_write_X_start
		

		.proc osfile_write_X_start

		jsr	osfile_alloc_block	; room for parameter block

		ldy	#18 + 5			; file_name
		jsr	ldaxysp
		
		jsr	osfile_store_fn
		
		ldy	#18 + 3			; high word of exec_addr
		jsr	ldeaxysp
		
		rts

		.endproc
