;
;
;	Dominic Beesley 2005
;	OSLib implementation for BBC/Master Target	
;
;	Used by various functions for string manipulations
		.export bbc_string_buf

		.bss
bbc_string_buf:	.res 255, 0
