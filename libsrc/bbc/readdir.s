;
;
;	struct dirent* __fastcall__ readdir (DIR* dir);
;
;

		.export 	_readdir
		.importzp	ptr1, ptr2
		.import		pushax
		.import		incsp2
		.import		_set_brk_ret
		.import		_clear_brk_ret

		.include	"oslib/os.inc"
		.include	"oslib/osgbpb.inc"

; This uses a DIR entry as below:
;

.struct 	DIR
		channel		.byte
		name_ptr	.dword
		count		.dword
		seq		.dword
		used		.byte
		name_len	.byte
		name		.res 20
.endstruct	


_readdir:	sta	ptr1		;	ptr1 points to DIR entry
		stx	ptr1 + 1	;	which is as above
					
		clc			;	Calculate address of
		lda	ptr1		;	ptr1.name_len
		adc	#DIR::name_len	;
		ldy	#DIR::name_ptr	;	store in ptr.name_buf
		sta	(ptr1), y	;
		sta	ptr2		;	and ptr2
		lda	ptr1 + 1
		adc	#$0
		iny
		sta	(ptr1), y
		sta	ptr2 + 1

		lda	#$1		;	set count to 1
		ldy	#DIR::count	;	assume high bytes are 0
		sta	(ptr1), y	;	already (should be set
					;	up by opendir

		jsr	_set_brk_ret	;	return here with carry
		bne	_er		;	Z = OK
		

		ldy	ptr1 + 1		; call os function
		ldx	ptr1			;
		lda	#OSGBPB_CSDEntries
		jsr	OSGBPB

		bcs	_er2		; 	no error but no more 
					;	entries

		jsr	_clear_brk_ret	;	remove error handler


		ldy	#0
		lda	(ptr2),y	;	y = name_len
		tay

		inc	ptr2		;	move ptr2 to point
		bne	sk1		;	at start of name
		inc	ptr2 + 1
sk1:
		
loopZ:		dey
		bmi	doneZ
		lda	(ptr2), y	;	Change all <= ' '
		cmp	#$21
		bcs	doneZ
		lda	#$0
		sta	(ptr2), y
		jmp	loopZ
			
doneZ:		ldx	ptr2 + 1
		lda	ptr2	
		rts

_er2:		jsr	_clear_brk_ret	;	remove error handler

_er:		lda	#0
		tax
		rts	

