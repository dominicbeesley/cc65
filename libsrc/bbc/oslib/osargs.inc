; Dominic Beesley 27.04.2005


; following called with Y = 0 (i.e. no file)
OSARGS_GET_CURRENT_FS 		= $00
OSARGS_GET_COMMAND_TAIL 	= $01
OSARGS_FLUSH			= $FF

; following called with Y = file handle
OSARGS_READ_PTR			= $00
OSARGS_WRITE_PTR		= $01
OSARGS_READ_EXT			= $02
; NOTE: OSARGS_FLUSH with Y set flushes one file

; return values for OSARGS_GET_CURRENT_FS
OSARGS_FS_NONE			= $00
OSARGS_FS_CAS1200		= $01
OSARGS_FS_CAS300		= $02
OSARGS_FS_ROM			= $03
OSARGS_FS_DFS			= $04
OSARGS_FS_ECONET		= $05
OSARGS_FS_TELESOFT		= $06
OSARGS_FS_IEEE			= $07
OSARGS_FS_ADFS			= $08
OSARGS_FS_VFS			= $09


