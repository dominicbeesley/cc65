;
; Ullrich von Bassewitz, 17.11.2002
; Dominic Beesley 13.04.2005
;
; Common stuff for the read/write routines
;
; ??? all file stuff assumes fd<3 is stdin..stderr

        .export         rwcommon

        .import         popax
        .importzp       ptr1, ptr2, ptr3, tmp2

        .include        "errno.inc"
        .include        "fdtable.inc"


;--------------------------------------------------------------------------
; rwcommon: Pop the parameters from stack, preprocess them and place them
; into zero page locations. Return carry set if the handle is invalid,
; return carry clear if it is ok. If the carry is clear, the handle is
; returned in A.

.proc   rwcommon

        eor     #$FF
        sta     ptr1
        txa
        eor     #$FF
        sta     ptr1+1          ; Remember -count-1

        jsr     popax           ; Get buf
        sta     ptr2
        stx     ptr2+1

        lda     #$00
        sta     ptr3
        sta     ptr3+1          ; Clear ptr3

        jsr     popax           ; Get the handle
        cpx     #$01
        bcs     out
        cmp     #FD_MAX - 1
        bcs     out
        sta     tmp2
out:    rts                     ; Return with carry clear


.endproc


