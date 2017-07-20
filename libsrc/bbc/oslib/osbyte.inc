; 
; ca65 Assembler include file Dominic Beesley 18 July 2005 is taken from:
; C header file for OSByte
; * written by DefMod (May  4 2004) on Tue May  4 13:27:32 2004
; * Jonathan Coxhead, jonathan@doves.demon.co.uk, 7 Sept 1995
; */

;/*OSLib---efficient, type-safe, transparent, extensible,
;   register-safe A P I coverage of RISC O S*/
;/*Copyright © 1994 Jonathan Coxhead*/

;/* This version for cc65/ca65 (c) Dominic Beesley compiler 18 July 2005
;*/

;/*
;      OSLib is free software; you can redistribute it and/or modify
;   it under the terms of the GNU General Public License as published by
;   the Free Software Foundation; either version 1, or (at your option)
;   any later version.;

;      OSLib is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU General Public License for more details.

;      You should have received a copy of the GNU General Public License
;   along with this programme; if not, write to the Free Software
;   Foundation, Inc, 675 Mass Ave, Cambridge, MA 02139, U S A.
;*/


osbyte_VERSION                          = $0
osbyte_USER_FLAG                        = $1
osbyte_INPUT_STREAM                     = $2
osbyte_OUTPUT_STREAMS                   = $3
osbyte_INTERPRETATION_ARROWS            = $4
osbyte_PRINTER                          = $5
osbyte_IGNORE_CHAR                      = $6
osbyte_SERIAL_RECEIVE_RATE              = $7
osbyte_SERIAL_TRANSMIT_RATE             = $8
osbyte_ON_DURATION                      = $9
osbyte_OFF_DURATION                     = $A
osbyte_KEYBOARD_DELAY                   = $B
osbyte_KEYBOARD_RATE                    = $C
osbyte_DISABLE_EVENT                    = $D
osbyte_ENABLE_EVENT                     = $E
osbyte_FLUSH_BUFFERS                    = $F
osbyte_CHANNEL_COUNT                    = $10
osbyte_CONVERT_CHANNEL                  = $11
osbyte_RESET_FUNCTION_KEYS              = $12
osbyte_AWAIT_VSYNC                      = $13
osbyte_RESET_SYSTEM_FONT                = $14
osbyte_FLUSH_BUFFER                     = $15
; osbyte_INCREMENT_ROM_SEMAPHORE          = $16
; osbyte_DECREMENT_ROM_SEMAPHORE          = $17
; osbyte_RESET_SYSTEM_CHARS               = $19
; osbyte_ECONET_POLL_TRANSMIT             = $32
; osbyte_ECONET_POLL_RECEIVE              = $33
; osbyte_ECONET_ABANDON_RECEIVE           = $34
; osbyte_ECONET_ROFF                      = $35
; osbyte_BANKED_RAM_PRESENCE              = $44
; osbyte_BANKED_RAM_USE                   = $45
; osbyte_COUNTRY_NUMBER                   = $46
; osbyte_ALPHABET_NUMBER                  = $47
; osbyte_SELECT_POINTER                   = $6A
; osbyte_WRITE_BUS_STATE                  = $6B
; osbyte_WRITE_SHADOW_STATE               = $6C
; osbyte_SELECT_TEMPORARY_FS              = $6D
; osbyte_OUTPUT_SCREEN_BANK               = $70
; osbyte_DISPLAY_SCREEN_BANK              = $71
; osbyte_SHADOW_STATE                     = $72
osbyte_VDU_STATE                        = $75
osbyte_UPDATE_KEYBOARD                  = $76
osbyte_CLOSE_SPOOL_AND_EXEC             = $77
osbyte_LOCK_REPEAT                      = $78
osbyte_SCAN_KEYBOARD                    = $79
osbyte_SCAN_KEYBOARD_LIMITED            = $7A
osbyte_PRINTER_DORMANT                  = $7B
osbyte_CLEAR_ESCAPE                     = $7C
osbyte_SET_ESCAPE                       = $7D
osbyte_ACKNOWLEDGE_ESCAPE               = $7E
osbyte_READ_EOF_STATUS                  = $7F
osbyte_BUFFER_OP                        = $80
osbyte_OP_JOYSTICK_STATE                = 0
osbyte_OP_CHANNEL_POSITION1             = 1
osbyte_OP_CHANNEL_POSITION2             = 2
osbyte_OP_CHANNEL_POSITION3             = 3
osbyte_OP_CHANNEL_POSITION4             = 4
osbyte_OP_PRINTER_BUFFER_FREE           = 252
osbyte_OP_SERIAL_OUTPUT_BUFFER_FREE     = 253
osbyte_OP_SERIAL_INPUT_BUFFER_USED      = 254
osbyte_OP_KEYBOARD_BUFFER_USED          = 255
osbyte_IN_KEY                           = $81
osbyte_READ_HIGH_ORDER_ADDRESS          = $82
osbyte_READ_HWM                         = $83
osbyte_READ_TOP                         = $84
osbyte_READ_TOP_FOR_MODE                = $85
osbyte_TEXT_CURSOR_POSITION             = $86
osbyte_SCREEN_CHAR                      = $87
osbyte_RUN                              = $88
osbyte_CASSETTE_MOTOR                   = $89
osbyte_BUFFER_INSERT                    = $8A
osbyte_OPT                              = $8B
osbyte_SELECT_CFS                       = $8C
osbyte_SELECT_ROMFS                     = $8D
osbyte_ROM_ENTER                        = $8E
osbyte_SERVICE_CALL                     = $8F
osbyte_TV                               = $90
osbyte_BUFFER_REMOVE                    = $91
osbyte_READ_FRED                        = $92
osbyte_WRITE_FRED                       = $93
osbyte_READ_JIM                         = $94
osbyte_WRITE_JIM                        = $95
osbyte_READ_SHEILA                      = $96
osbyte_WRITE_SHEILA                     = $97
osbyte_BUFFER_STATUS                    = $98
osbyte_TYPE_CHAR                        = $99
osbyte_WRITE_VDU_CONTROL                = $9A
osbyte_WRITE_VDU_PALETTE                = $9B
osbyte_SERIAL_STATE                     = $9C
osbyte_WRITE_TUBE                       = $9D
osbyte_READ_SPEECH			= $9E	; BBC only
osbyte_WRITE_SPEECH			= $9F	; BBC only
osbyte_READ_VDU_VARIABLE                = $A0
; osbyte_READ_CMOS                        ((osbyte_op) 0xA1u)
; osbyte_WRITE_CMOS                       ((osbyte_op) 0xA2u)
; osbyte_GRAPHICS_INFO                    ((osbyte_op) 0xA3u)
; osbyte_CPU_TYPE                         ((osbyte_op) 0xA4u)
; osbyte_OUTPUT_CURSOR_POSITION           ((osbyte_op) 0xA5u)

osbyte_READ_VARIABLE_START              = $A6
osbyte_READ_ROM_POINTER_TABLE           = $A8
osbyte_READ_ROM_INFO_TABLE              = $AA
osbyte_READ_KEYBOARD_TABLE              = $AC
osbyte_READ_VDU_VARIABLE_START          = $AE
osbyte_VAR_VSYNC_TIMER                  = $B0
osbyte_VAR_INPUT_STREAM                 = $B1
osbyte_VAR_KEYBOARD_SEMAPHORE           = $B2
;osbyte_VAR_ROM_SEMAPHORE (RISC OS)	= $B3 
osbyte_VAR_PRIM_HWM                     = $B3
osbyte_VAR_HWM                          = $B4
osbyte_VAR_SERIAL_INTERPRETATION        = $B5
; osbyte_VAR_IGNORE_STATE (RISC OS)                = $B6
osbyte_VAR_CHAR_EXPLODE			= $B6
osbyte_VAR_CASSETTE_ROM_SWITCH          = $B7
osbyte_VAR_VDU_CONTROL                  = $B8
; osbyte_VAR_VDU_PALETTE                  = $B9
osbyte_VAR_ROM_LAST_RESET               = $BA
osbyte_VAR_ROM_BASIC                    = $BB
osbyte_VAR_CURRENT_CHANNEL              = $BC
osbyte_VAR_CHANNEL_COUNT                = $BD
osbyte_VAR_CONVERSION_RESOLUTION        = $BE
osbyte_VAR_SERIAL_BUSY                  = $BF
osbyte_VAR_SERIAL_STATE                 = $C0
osbyte_VAR_FLASH_COUNTER                = $C1
osbyte_VAR_OFF_DURATION                 = $C2
osbyte_VAR_ON_DURATION                  = $C3
osbyte_VAR_KEYBOARD_DELAY               = $C4
osbyte_VAR_KEYBOARD_RATE                = $C5
osbyte_VAR_EXEC_HANDLE                  = $C6
osbyte_VAR_SPOOL_HANDLE                 = $C7
osbyte_VAR_RESET_EFFECTS                = $C8
osbyte_VAR_KEYBOARD_DISABLE             = $C9
osbyte_VAR_KEYBOARD_STATE               = $CA
osbyte_VAR_SERIAL_THRESHOLD             = $CB
osbyte_VAR_SERIAL_BUFFER_STATE          = $CC
osbyte_VAR_SERIAL_DESTINATION           = $CD
osbyte_VAR_ECONET_OS_CALL_STATUS        = $CE
osbyte_VAR_ECONET_INPUT_STATUS          = $CF
osbyte_VAR_ECONET_OUTPUT_STATUS         = $D0
osbyte_VAR_SPEECH_SUPPRESSION		= $D1 ;(BBC Only)
osbyte_VAR_SOUND_SUPPRESSION            = $D2
osbyte_VAR_BELL_CHANNEL                 = $D3
osbyte_VAR_BELL_VOLUME                  = $D4
osbyte_VAR_BELL_FREQUENCY               = $D5
osbyte_VAR_BELL_DURATION                = $D6
osbyte_VAR_BANNER_SUPPRESS              = $D7
osbyte_VAR_PENDING_KEY_LENGTH           = $D8
osbyte_VAR_PAGE_LENGTH                  = $D9
osbyte_VAR_VDU_QUEUE_LENGTH             = $DA
osbyte_VAR_TAB_CHAR                     = $DB
osbyte_VAR_ESCAPE_CHAR                  = $DC
osbyte_VAR_INTERPRETATION_GROUP4        = $DD
osbyte_VAR_INTERPRETATION_GROUP5        = $DE
osbyte_VAR_INTERPRETATION_GROUP6        = $DF
osbyte_VAR_INTERPRETATION_GROUP7        = $E0
 
; osbyte_VAR_INTERPRETATION_GROUP0        = $E1
; osbyte_VAR_INTERPRETATION_GROUP1        = $E2
; osbyte_VAR_INTERPRETATION_GROUP2        = $E3
; osbyte_VAR_INTERPRETATION_GROUP3        = $E4

osbyte_VAR_FNKEY_STATUS                 = $E1 ;(BBC Only)
osbyte_VAR_SHIFT_FNKEY_STATUS           = $E2 ;(BBC Only)
osbyte_VAR_CTRL_FNKEY_STATUS            = $E3 ;(BBC Only)
osbyte_VAR_CTRL_SHIFT_FNKEY_STATUS      = $E4 ;(BBC Only)

osbyte_VAR_ESCAPE_STATE                 = $E5
osbyte_VAR_ESCAPE_EFFECTS               = $E6
osbyte_VAR_IRQ_MASK_USER                = $E7
osbyte_VAR_IRQ_MASK_SERIAL              = $E8
osbyte_VAR_IRQ_MASK_SYSTEM              = $E9
osbyte_VAR_TUBE                         = $EA

osbyte_VAR_SPEECH_PRESENCE              = $EB ;(BBC Only)
 
osbyte_VAR_OUTPUT_STREAMS               = $EC
osbyte_VAR_INTERPRETATION_ARROWS        = $ED
osbyte_VAR_INTERPRETATION_KEYPAD        = $EE
osbyte_VAR_SHADOW_STATE                 = $EF
osbyte_VAR_COUNTRY_NUMBER               = $F0
osbyte_VAR_USER_FLAG                    = $F1
osbyte_VAR_SERIAL_RATE                  = $F2
osbyte_VAR_INTERVAL_TIMER_STATE         = $F3
osbyte_VAR_SOFT_KEY_STATE               = $F4
osbyte_VAR_PRINTER                      = $F5
osbyte_VAR_IGNORE_CHAR                  = $F6
osbyte_VAR_INTERPRETATION_BREAK         = $F7
; osbyte_VAR_INTERPRETATION_BREAK1        = $F8
; osbyte_VAR_INTERPRETATION_BREAK2        = $F9
; osbyte_VAR_OUTPUT_SCREEN_BANK           = $FA
; osbyte_VAR_DISPLAY_SCREEN_BANK          = $FB
osbyte_VAR_ROM_CURRENT                  = $FC
osbyte_VAR_LAST_RESET                   = $FD
; osbyte_VAR_INTERPRETATION_SHIFTING      = $FE
osbyte_VAR_RAMSIZE			= $FE ;(BBC Only)
osbyte_VAR_BOOT_OPTION                  = $FF
os_RESET_SOFT                           = 0
os_RESET_POWER_ON                       = 1
os_RESET_HARD                           = 2
 
