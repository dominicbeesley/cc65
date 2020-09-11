;
; File generated by cc65 v 2.11.0
;
	.fopt		compiler,"cc65 v 2.11.0"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	on
	.importzp	sp, sreg, regsave, regbank, tmp1, ptr1, ptr2
	.macpack	longbranch
	.dbg		file, "lseek.c", 2446, 1142154975
	.dbg		file, "./fdtable.h", 1678, 1142154975
	.dbg		file, "/home/dominic/Documents/programming/6502/mysources/cc65-2.11.0/include/sys/types.h", 3147, 1142154913
	.dbg		file, "/home/dominic/Documents/programming/6502/mysources/cc65-2.11.0/include/errno.h", 3690, 1142154975
	.dbg		file, "/home/dominic/Documents/programming/6502/mysources/cc65-2.11.0/include/unistd.h", 3996, 1142154975
	.dbg		file, "./lseek_extra.h", 236, 1142154975
	.import		__fd_getchannel
	.import		__fd_getflags
	.import		__fd_getseek
	.import		__fd_setseek
	.import		__errno
	.export		_lseek
	.import		___ext
	.import		___ptr

; ---------------------------------------------------------------
; long __fastcall__ lseek (int, long, int)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_lseek

.segment	"CODE"

;
; off_t __fastcall__ lseek(int fd, off_t offset, int whence) {
;
	.dbg	line, "lseek.c", 90
	jsr     pushax
;
; flags = _fd_getflags(fd);
;
	.dbg	line, "lseek.c", 97
	jsr     decsp6
	ldy     #$0C
	lda     (sp),y
	jsr     __fd_getflags
	ldy     #$04
	sta     (sp),y
;
; if (flags == 0xFF) 
;
	.dbg	line, "lseek.c", 98
	cmp     #$FF
	bne     L0006
;
; return -1;
;
	.dbg	line, "lseek.c", 99
	tax
	sta     sreg
	sta     sreg+1
	jmp     L003A
;
; if (flags & FD_FLAG_CON)
;
	.dbg	line, "lseek.c", 101
L0006:	lda     (sp),y
	and     #$10
;
; goto epipe;
;
	.dbg	line, "lseek.c", 102
	jne     L000B
;
; if (whence < 0 || whence >=3)
;
	.dbg	line, "lseek.c", 104
	ldy     #$07
	jsr     ldaxysp
	txa
	jmi     L000F
	ldy     #$07
	jsr     ldaxysp
	jsr     pushax
	lda     #$03
	jsr     tosgea0
	jne     L000F
;
; if (flags == 0xFF)
;
	.dbg	line, "lseek.c", 107
	ldy     #$04
	lda     (sp),y
	cmp     #$FF
	bne     L0010
;
; return -1;
;
	.dbg	line, "lseek.c", 108
	tax
	sta     sreg
	sta     sreg+1
	jmp     L003A
;
; channel = _fd_getchannel(fd);
;
	.dbg	line, "lseek.c", 110
L0010:	ldy     #$0C
	lda     (sp),y
	jsr     __fd_getchannel
	ldy     #$05
	sta     (sp),y
;
; if (whence == SEEK_SET) {
;
	.dbg	line, "lseek.c", 112
	ldy     #$07
	lda     (sp),y
	bne     L0016
	dey
	lda     (sp),y
	cmp     #$02
	bne     L0016
;
; startpos = 0;
;
	.dbg	line, "lseek.c", 113
	ldy     #$00
	tya
	sta     (sp),y
	iny
	sta     (sp),y
	iny
	sta     (sp),y
	iny
	sta     (sp),y
;
; } else if (whence == SEEK_CUR) {
;
	.dbg	line, "lseek.c", 114
	jmp     L0028
L0016:	ldy     #$06
	lda     (sp),y
	iny
	ora     (sp),y
	bne     L001C
;
; if (flags & FD_FLAG_SEEKPEND) {
;
	.dbg	line, "lseek.c", 115
	ldy     #$04
	lda     (sp),y
	and     #$08
	beq     L001F
;
; startpos = _fd_getseek(fd);
;
	.dbg	line, "lseek.c", 117
	ldy     #$0C
	lda     (sp),y
	jsr     __fd_getseek
;
; } else {
;
	.dbg	line, "lseek.c", 118
	jmp     L003C
;
; startpos = __ptr(channel);
;
	.dbg	line, "lseek.c", 119
L001F:	iny
	lda     (sp),y
	jsr     ___ptr
;
; } else {
;
	.dbg	line, "lseek.c", 121
	jmp     L003C
;
; startpos = __ext(channel);
;
	.dbg	line, "lseek.c", 122
L001C:	ldy     #$05
	lda     (sp),y
	jsr     ___ext
L003C:	ldy     #$00
	jsr     steaxysp
;
; startpos = startpos + offset;
;
	.dbg	line, "lseek.c", 125
L0028:	ldy     #$03
	jsr     ldeaxysp
	jsr     pusheax
	ldy     #$0F
	jsr     ldeaxysp
	jsr     tosaddeax
	ldy     #$00
	jsr     steaxysp
;
; if (startpos < 0) 
;
	.dbg	line, "lseek.c", 127
	ldy     #$03
	jsr     ldeaxysp
	lda     sreg+1
;
; goto einval;
;
	.dbg	line, "lseek.c", 128
	bmi     L000F
;
; _fd_setseek(startpos, fd);
;
	.dbg	line, "lseek.c", 130
	ldy     #$03
	jsr     ldeaxysp
	jsr     pusheax
	ldy     #$10
	lda     (sp),y
	jsr     __fd_setseek
;
; return startpos;
;
	.dbg	line, "lseek.c", 132
	ldy     #$03
	jsr     ldeaxysp
	jmp     L0002
;
; _errno = EINVAL;
;
	.dbg	line, "lseek.c", 135
L000F:	ldx     #$00
	lda     #$07
;
; return -1;
;
	.dbg	line, "lseek.c", 136
	jmp     L0041
;
; _errno = ESPIPE;
;
	.dbg	line, "lseek.c", 139
L000B:	ldx     #$00
	lda     #$0E
L0041:	sta     __errno
	stx     __errno+1
;
; return -1;
;
	.dbg	line, "lseek.c", 140
	dex
	stx     sreg
	stx     sreg+1
L003A:	txa
;
; }
;
	.dbg	line, "lseek.c", 0
L0002:	ldy     #$0E
	jmp     addysp
	.dbg	line

.endproc

