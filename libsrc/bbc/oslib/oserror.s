;
; Ullrich von Bassewitz, 17.05.2000
;
; int __fastcall__ _osmaperrno (unsigned char oserror);
; /* Map a system specific error into a system independent code */
;

	.export		__osmaperrno
	.include	"errno.inc"

.code

__osmaperrno:

	lda	#<EINVAL
	ldx	#>EINVAL
	rts
