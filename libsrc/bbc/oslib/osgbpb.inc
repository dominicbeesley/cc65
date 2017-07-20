;Assembler header file for OSGBPB
;written by DefMod (May  4 2004) on Tue May  4 13:24:38 2004
;Jonathan Coxhead, jonathan@doves.demon.co.uk, 21 Aug 1995

;Modified by Dominic Beesley for cc65


;Symbols for constants
OSGBPB_PrivilegeOwner           =       $0
OSGBPB_PrivilegePublic          =       $FF
OSGBPB_NoMore                   =       -1

OSGBPB_WriteAt                  =       $1
OSGBPB_Write                    =       $2
OSGBPB_ReadAt                   =       $3
OSGBPB_Read                     =       $4
OSGBPB_ReadDiscName             =       $5
OSGBPB_ReadCSDName              =       $6
OSGBPB_ReadLibName              =       $7
OSGBPB_CSDEntries               =       $8
