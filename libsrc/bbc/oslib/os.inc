; bbc symbols

; os calls
	.import OSCLI
	.import OSBYTE
	.import OSWORD
	.import OSWRCH
	.import OSNEWL
	.import OSASCI
	.import OSRDCH
	.import OSFILE
	.import OSARGS
	.import OSBGET
	.import OSBPUT
	.import OSGBPB
	.import OSFIND
	.import NVRDCH
	.import NVWRCH
	.import GSREAD
	.import GSINIT
	.import OSEVEN
	.import OSRDRM
	
; os vectors
	.import USERV
	.import BRKV
	.import IRQ1V
	.import IRQ2V
	.import CLIV
	.import BYTEV
	.import WORDV
	.import WRCHV
	.import RDCHV
	.import FILEV
	.import ARGSV
	.import BGETV
	.import BPUTV
	.import GBPBV
	.import FINDV
	.import FSCV
	.import EVNTV
	.import UPTV
	.import NETV
	.import VDUV
	.import KEYV
	.import INSV
	.import REMV
	.import CNPV
	.import IND1V
	.import IND2V
	.import IND3V
	
; low memory areas
	.import VDU_WKSP
	
	
; EVENTV event numbers
	EVNTV_OUTPUT_BUFFER_EMPTY	= $00
	EVNTV_INPUT_BUFFER_FULL	= $01
	EVNTV_CHAR_INPUT		= $02
	EVNTV_ADC_COMPLETE		= $03
	EVNTV_VSYNC			= $04
	EVNTV_INT_TIMER_0		= $05
	EVNTV_ESCAPE			= $06
	
OS_VDUNull                      =       $00
OS_VDUCharToPrinter             =       $01
OS_VDUPrinterOn                 =       $02
OS_VDUPrinterOff                =       $03
OS_VDUGraphTextOff              =       $04
OS_VDUSplitCursors              =       $04
OS_VDUGraphTextOn               =       $05
OS_VDUJoinCursors               =       $05
OS_VDUScreenOn                  =       $06
OS_VDUVduOn                     =       $06
OS_VDUBell                      =       $07
OS_VDUBackspace                 =       $08
OS_VDUTab                       =       $09
OS_VDULinefeed                  =       $0A
OS_VDULineFeed                  =       $0A
OS_VDUVerticalTab               =       $0B
OS_VDUClS                       =       $0C
OS_VDUReturn                    =       $0D
OS_VDUPageModeOn                =       $0E
OS_VDUPageModeOff               =       $0F
OS_VDUClG                       =       $10
OS_VDUSetTextColour             =       $11
OS_VDUSetGCOL                   =       $12
OS_VDUSetPalette                =       $13
OS_VDUResetColours              =       $14
OS_VDUScreenOff                 =       $15
OS_VDUVduOff                    =       $15
OS_VDUMode                      =       $16
OS_VDUSetMode                   =       $16
OS_VDUMisc                      =       $17
OS_VDUSetGraphicsWindow         =       $18
OS_VDUPlot                      =       $19
OS_VDUPlotVdu                   =       $19
OS_VDUResetWindows              =       $1A
OS_VDUEscape                    =       $1B
OS_VDUSetTextWindow             =       $1C
OS_VDUSetGraphicsOrigin         =       $1D
OS_VDUHomeTextCursor            =       $1E
OS_VDUSetTextCursor             =       $1F
OS_VDUSpace                     =       $20
OS_VDUDelete                    =       $7F
OS_MiscInterlace                =       $00
OS_MiscCursor                   =       $01
OS_MiscSetECF1                  =       $02
OS_MiscSetECF2                  =       $03
OS_MiscSetECF3                  =       $04
OS_MiscSetECF4                  =       $05
OS_MiscSetDotStyle              =       $06
OS_MiscScroll                   =       $07
OS_MiscClearRegion              =       $08
OS_MiscSetOn                    =       $09
OS_MiscSetOff                   =       $0A
OS_MiscSetBBCECF                =       $0B
OS_MiscSetUnpackedECF1          =       $0C
OS_MiscSetUnpackedECF2          =       $0D
OS_MiscSetUnpackedECF3          =       $0E
OS_MiscSetUnpackedECF4          =       $0F
OS_MiscSetCursorMovement        =       $10
OS_MiscMisc                     =       $11
OS_MiscSetTextFGTint            =       $00
OS_MiscSetTextBGTint            =       $01
OS_MiscSetGraphicsFGTint        =       $02
OS_MiscSetGraphicsBGTint        =       $03
OS_MiscSetECFInterpretation     =       $04
OS_MiscInvertText               =       $05
OS_MiscSetECFOrigin             =       $06
OS_MiscSetCharSize              =       $07
OS_ActionOverwrite              =       $0
OS_ActionDisjoin                =       $1
OS_ActionConjoin                =       $2
OS_ActionExclusiveDisjoin       =       $3
OS_ActionInvert                 =       $4
OS_ActionIdentity               =       $5
OS_ActionConjoinNegation        =       $6
OS_ActionDisjoinNegation        =       $7
OS_ActionUseMask                =       $8
OS_ActionUseECF1                =       $10
OS_ActionUseECF2                =       $20
OS_ActionUseECF3                =       $30
OS_ActionUseECF4                =       $40
OS_ActionUseGiantECF            =       $50
OS_GCOLSetFG                    =       $0
OS_GCOLSetBG                    =       $80
OS_PlotSolid                    =       $0
OS_PlotSolidExEnd               =       $8
OS_PlotDotted                   =       $10
OS_PlotDottedExEnd              =       $18
OS_PlotSolidExStart             =       $20
OS_PlotSolidExBoth              =       $28
OS_PlotDottedExStart            =       $30
OS_PlotDottedExBoth             =       $38
OS_PlotPoint                    =       $40
OS_PlotHorizontalToNonBG        =       $48
OS_PlotTriangle                 =       $50
OS_PlotRightToBG                =       $58
OS_PlotRectangle                =       $60
OS_PlotHorizontalToFG           =       $68
OS_PlotParallelogram            =       $70
OS_PlotRightToNonFG             =       $78
OS_PlotFloodToNonBG             =       $80
OS_PlotFloodToFG                =       $88
OS_PlotCircleOutline            =       $90
OS_PlotCircle                   =       $98
OS_PlotArc                      =       $A0
OS_PlotSegment                  =       $A8
OS_PlotSector                   =       $B0
OS_PlotBlock                    =       $B8
OS_PlotEllipseOutline           =       $C0
OS_PlotEllipse                  =       $C8
OS_MoveBy                       =       $0
OS_PlotBy                       =       $1
OS_PlotInverseBy                =       $2
OS_PlotBGBy                     =       $3
OS_MoveTo                       =       $4
OS_PlotTo                       =       $5
OS_PlotInverseTo                =       $6
OS_PlotBGTo                     =       $7

OS_ErrorNumberShift             =       0
OS_ErrorNumber                  =       $FF
OS_ErrorSourceShift             =       8
OS_ErrorSource                  =       $FFFF00
OS_ErrorCategoryShift           =       24
OS_ErrorCategory                =       $7000000
OS_CategoryUnclassified         =       0
OS_CategoryInformation          =       1
OS_CategoryWarning              =       2
OS_CategorySystem               =       3
OS_GlobalEscape                 =       1
OS_GlobalFatal                  =       2
OS_GlobalIsAFil                 =       3
OS_GlobalIsntFil                =       4
OS_GlobalIsADir                 =       5
OS_GlobalIsntDir                =       6
OS_GlobalNoFile                 =       7
OS_GlobalNoDir                  =       8
OS_GlobalNoAny                  =       9
OS_GlobalTypsBad                =       10
OS_GlobalBadRen                 =       11
OS_GlobalBadAcc                 =       12
OS_GlobalOpnFils                =       13
OS_GlobalBadName                =       14
OS_GlobalLongNam                =       15
OS_GlobalChannel                =       16
OS_GlobalBadSWI                 =       17
OS_GlobalModInUs                =       18
OS_GlobalStrOFlo                =       19
OS_GlobalNumOFlo                =       20
OS_GlobalBufOFlo                =       21
OS_GlobalBadStn                 =       22
OS_GlobalBadNet                 =       23
OS_GlobalFullNet                =       24
OS_GlobalNoEco                  =       25
OS_GlobalBadRead                =       26
OS_GlobalBadWrt                 =       27
OS_GlobalDataLst                =       28
OS_GlobalBadFSOp                =       29
OS_GlobalFSNoRd                 =       30
OS_GlobalFSNoWrt                =       31
OS_GlobalFSInUse                =       32
OS_GlobalBadAddress             =       33
OS_GlobalNoStore                =       34
OS_GlobalRAMLoadC               =       35
OS_GlobalDDS0                   =       36
OS_GlobalDDS1                   =       37
OS_GlobalDDS2                   =       38
OS_GlobalDDS3                   =       39
OS_GlobalCSDS                   =       40
OS_GlobalLDS                    =       41
OS_GlobalURDS                   =       42
OS_GlobalDr                     =       43
OS_GlobalApp                    =       44
OS_GlobalExDt                   =       45
OS_GlobalExLdEx                 =       46
OS_GlobalUseDesk                =       47
OS_GlobalAppQuit                =       48
OS_GlobalNoMem                  =       49
OS_GlobalBadHard                =       50
OS_GlobalBadParm                =       51
OS_GlobalNoWimp                 =       52
Error_Escape                    =       $11
Error_BadMode                   =       $19
Error_IsADir                    =       $A8
Error_TypesDontMatch            =       $AF
Error_BadRename                 =       $B0
Error_BadCopy                   =       $B1
Error_OutsideFile               =       $B7
Error_AccessViolation           =       $BD
Error_TooManyOpenFiles          =       $C0
Error_NotOpenForUpdate          =       $C1
Error_FileOpen                  =       $C2
Error_ObjectLocked              =       $C3
Error_AlreadyExists             =       $C4
Error_BadFileName               =       $CC
Error_FileNotFound              =       $D6
Error_Syntax                    =       $DC
Error_BadNoParms                =       $DC
Error_TooManyParms              =       $DC
Error_Channel                   =       $DE
Error_EndOfFile                 =       $DF
Error_BadFilingSystemName       =       $F8
Error_UnknownFilingSystem       =       $F8
Error_BadKey                    =       $FB
Error_BadAddress                =       $FC
Error_BadString                 =       $FD
Error_BadAliasString            =       $FD
Error_BadParmString             =       $FD
Error_WildCards                 =       $FD
Error_BadCommand                =       $FE
Error_BadMacVal                 =       $120
Error_BadVarNam                 =       $121
Error_BadVarType                =       $122
Error_VarNoRoom                 =       $123
Error_VarCantFind               =       $124
Error_VarTooLong                =       $125
Error_RedirectFail              =       $140
Error_StackFull                 =       $141
Error_BadHex                    =       $160
Error_BadExpr                   =       $161
Error_BadBra                    =       $162
Error_StkOFlo                   =       $163
Error_MissOpn                   =       $164
Error_MissOpr                   =       $165
Error_BadBits                   =       $166
Error_StrOFlo                   =       $167
Error_BadItm                    =       $168
Error_DivZero                   =       $169
Error_BadBase                   =       $16A
Error_BadNumb                   =       $16B
Error_NumbTooBig                =       $16C
Error_BadClaimNum               =       $1A1
Error_BadRelease                =       $1A2
Error_BadDevNo                  =       $1A3
Error_BadDevVecRel              =       $1A4
Error_BadEnvNumber              =       $1B0
Error_CantCancelQuit            =       $1B1
Error_ChDynamCAO                =       $1C0
Error_ChDynamNotAllMoved        =       $1C1
Error_AplWSpaceInUse            =       $1C2
Error_RAMFsUnchangeable         =       $1C3
Error_OSCLILongLine             =       $1E0
Error_OSCLITooHard              =       $1E1
Error_RCExc                     =       $1E2
Error_RCNegative                =       $1E2
Error_SysHeapFull               =       $1E3
Error_BuffOverflow              =       $1E4
Error_BadTime                   =       $1E5
Error_NoSuchSWI                 =       $1E6
Error_Unimplemented             =       $1E7
Error_OutOfRange                =       $1E8
Error_NoOSCLISpecials           =       $1E9
Error_BadParameters             =       $1EA
Error_ArgRepeated               =       $1EB
Error_BadReadSysInfo            =       $1EC
Error_CDATStackOverflow         =       $2C0
Error_CDATBufferOverflow        =       $2C1
Error_CDATBadField              =       $2C2
Error_CantStartApplication      =       $600
Error_BadCommandOption          =       $601
Error_UnknownSerialOp           =       $602
Error_BadHard                   =       $603

