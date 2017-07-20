;Assembler header file for OSFile
;written by DefMod (May  4 2004) on Tue May  4 13:24:38 2004
;Jonathan Coxhead, jonathan@doves.demon.co.uk, 21 Aug 1995

;ca65 version Dominic Beesley 2005


;Symbols for constants
OSFile_NotFound                 =       $0
OSFile_IsFile                   =       $1
OSFile_IsDir                    =       $2
OSFile_IsImage                  =       $3
OSFile_FileType                 =       $FFF00
OSFile_FileTypeShift            =       8
OSFile_TypeDraw                 =       $AFF
OSFile_TypeBBCROM               =       $BBC
OSFile_TypeCode                 =       $F95
OSFile_TypeResource             =       $FAE
OSFile_TypeDOSDisc              =       $FC8
OSFile_TypeDevice               =       $FCC
OSFile_TypeCache                =       $FCF
OSFile_TypeTaskExec             =       $FD6
OSFile_TypeTaskObey             =       $FD7
OSFile_TypeDOS                  =       $FE4
OSFile_TypeDesktop              =       $FEA
OSFile_TypeObey                 =       $FEB
OSFile_TypeTemplate             =       $FEC
OSFile_TypePalette              =       $FED
OSFile_TypeConfig               =       $FF2
OSFile_TypePrintout             =       $FF4
OSFile_TypePostscript           =       $FF5
OSFile_TypeFont                 =       $FF6
OSFile_TypeBBCFont              =       $FF7
OSFile_TypeAbsolute             =       $FF8
OSFile_TypeSprite               =       $FF9
OSFile_TypeModule               =       $FFA
OSFile_TypeBASIC                =       $FFB
OSFile_TypeUtility              =       $FFC
OSFile_TypeData                 =       $FFD
OSFile_TypeCommand              =       $FFE
OSFile_TypeText                 =       $FFF
OSFile_TypeDir                  =       $1000
OSFile_TypeApplication          =       $2000
OSFile_TypeUntyped              =       $FFFFFFFF



OSFile_Write                    =       $1

OSFile_WriteLoad                =       $2

OSFile_WriteExec                =       $3

OSFile_WriteAttr                =       $4

OSFile_Delete                   =       $6

OSFile_Load                     =       $FF

OSFile_Save                     =       $0

OSFile_Read                     =       $5

OSFile_Create                   =       $7


