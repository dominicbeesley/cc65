
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	osfile_* utility functions
;
;	on entry A contains an OSFILE return code,
;	raises an error if "Not found" returned - not sure if this
;	is as behaviour in Risc OS

;	it seems "NOT FOUND" is not an "ERROR" caller must check!

;		.import OSFILE
;		.include "os.inc"
;		.include "osfile.inc"
;		.export osfile_fndchk

;		.proc	osfile_fndchk
;		cmp	#OSFile_NotFound
;		beq	nf
;o:		rts
;nf:		brk
;		.byte	Error_FileNotFound
;		.asciiz	"Not found"
;		.endproc	
