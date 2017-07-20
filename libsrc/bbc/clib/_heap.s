;
; Ullrich von Bassewitz, 03.06.1998
;
; Heap variables and initialization.
;

;
; Changed for CLIB, is called during executable init to take
; account of prevailing circumstances


; void __fastcall__ _initheap(__BSS_RUN__ + __BSS_SIZE__, sp - __STACK_SIZE);


;       	.constructor	__initheap, 24
;       	.import	       	__BSS_RUN__, __BSS_SIZE__, __STACKSIZE__
	.importzp	sp
	.import		popax
	.import		printhex
	.import		OSNEWL, OSASCI

	.include        "../../../asminc/_heap.inc"


.data

;__heaporg:
;       	.word  		0;__BSS_RUN__+__BSS_SIZE__	
;__heapptr:
;      	.word		0;__BSS_RUN__+__BSS_SIZE__
;__heapend:
;       	.word		0;__BSS_RUN__+__BSS_SIZE__
;__heapfirst:
;      	.word	0
;__heaplast:
;      	.word	00


; Initialization. Will be called from startup!

.code

__initheap:

	stx	__heapend + 1
	sta	__heapend
	jsr	popax
	stx	__heaporg + 1
	stx	__heapptr + 1
	sta	__heaporg
	sta	__heapptr


	lda	#>__heaporg
	jsr	printhex
	lda	#<__heaporg
	jsr	printhex
	
	lda	#$20
	jsr	OSASCI

	lda	__heaporg + 1
	jsr	printhex
	lda	__heaporg
	jsr	printhex
	
	lda	#$2d
	jsr	OSASCI

	lda	__heapend + 1
	jsr	printhex
	lda	__heapend
	jsr	printhex

	jsr	OSNEWL
	

	rts

;      	sec
;      	lda	sp
;      	sbc	#<__STACKSIZE__
;      	sta	__heapend
;      	lda	sp+1
;	sbc	#>__STACKSIZE__
;	sta	__heapend+1
;	rts

                      
