
_Lcd_Port_Init:

;libs/LCD.mbas,62 :: 		sub procedure Lcd_Port_Init()
;libs/LCD.mbas,65 :: 		DDC2_bit =1   DDC3_bit =1
	IN         R27, DDC2_bit+0
	SBR        R27, BitMask(DDC2_bit+0)
	OUT        DDC2_bit+0, R27
	IN         R27, DDC3_bit+0
	SBR        R27, BitMask(DDC3_bit+0)
	OUT        DDC3_bit+0, R27
;libs/LCD.mbas,66 :: 		DDC4_bit =1   DDC5_bit =1  ' configure PORTD as output
	IN         R27, DDC4_bit+0
	SBR        R27, BitMask(DDC4_bit+0)
	OUT        DDC4_bit+0, R27
	IN         R27, DDC5_bit+0
	SBR        R27, BitMask(DDC5_bit+0)
	OUT        DDC5_bit+0, R27
;libs/LCD.mbas,67 :: 		DDC6_bit =1   DDC7_bit =1
	IN         R27, DDC6_bit+0
	SBR        R27, BitMask(DDC6_bit+0)
	OUT        DDC6_bit+0, R27
	IN         R27, DDC7_bit+0
	SBR        R27, BitMask(DDC7_bit+0)
	OUT        DDC7_bit+0, R27
;libs/LCD.mbas,77 :: 		end sub
L_end_Lcd_Port_Init:
	RET
; end of _Lcd_Port_Init

_Lcd_0:

;libs/LCD.mbas,78 :: 		sub procedure Lcd_0()
;libs/LCD.mbas,79 :: 		Lcd_Init()
	PUSH       R2
	CALL       _Lcd_Init+0
;libs/LCD.mbas,80 :: 		Lcd_Cmd(_LCD_CLEAR)               ' Clear display
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;libs/LCD.mbas,81 :: 		Lcd_Cmd(_LCD_CURSOR_OFF)          ' Cursor off
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;libs/LCD.mbas,83 :: 		end sub
L_end_Lcd_0:
	POP        R2
	RET
; end of _Lcd_0

_LCD_Load:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/LCD.mbas,87 :: 		dim i, dchar as byte
;libs/LCD.mbas,88 :: 		for dchar = 0 to 4
	PUSH       R2
	LDI        R27, 0
	STD        Y+1, R27
L__LCD_Load4:
;libs/LCD.mbas,89 :: 		LCD_Cmd(64 + (dchar * 8))               ' Select 2x16 memory location for custom character
	LDD        R16, Y+1
	LSL        R16
	LSL        R16
	LSL        R16
	SUBI       R16, 192
	MOV        R2, R16
	CALL       _Lcd_Cmd+0
;libs/LCD.mbas,90 :: 		for i = 0 to 7
	LDI        R27, 0
	STD        Y+0, R27
L__LCD_Load9:
;libs/LCD.mbas,92 :: 		case 0
	LDD        R16, Y+1
	CPI        R16, 0
	BREQ       L__LCD_Load38
	JMP        L__LCD_Load16
L__LCD_Load38:
;libs/LCD.mbas,93 :: 		LCD_Chr_Cp(heart[i])
	LDI        R17, #lo_addr(_heart+0)
	LDI        R18, hi_addr(_heart+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L__LCD_Load13
L__LCD_Load16:
;libs/LCD.mbas,94 :: 		case 1
	LDD        R16, Y+1
	CPI        R16, 1
	BREQ       L__LCD_Load39
	JMP        L__LCD_Load19
L__LCD_Load39:
;libs/LCD.mbas,95 :: 		LCD_Chr_Cp(co[i])
	LDI        R17, #lo_addr(_co+0)
	LDI        R18, hi_addr(_co+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L__LCD_Load13
L__LCD_Load19:
;libs/LCD.mbas,96 :: 		case 2
	LDD        R16, Y+1
	CPI        R16, 2
	BREQ       L__LCD_Load40
	JMP        L__LCD_Load22
L__LCD_Load40:
;libs/LCD.mbas,97 :: 		LCD_Chr_Cp(cn[i])
	LDI        R17, #lo_addr(_cn+0)
	LDI        R18, hi_addr(_cn+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L__LCD_Load13
L__LCD_Load22:
;libs/LCD.mbas,98 :: 		case 3
	LDD        R16, Y+1
	CPI        R16, 3
	BREQ       L__LCD_Load41
	JMP        L__LCD_Load25
L__LCD_Load41:
;libs/LCD.mbas,99 :: 		LCD_Chr_Cp(cf[i])
	LDI        R17, #lo_addr(_cf+0)
	LDI        R18, hi_addr(_cf+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L__LCD_Load13
L__LCD_Load25:
;libs/LCD.mbas,100 :: 		case 4
	LDD        R16, Y+1
	CPI        R16, 4
	BREQ       L__LCD_Load42
	JMP        L__LCD_Load28
L__LCD_Load42:
;libs/LCD.mbas,101 :: 		LCD_Chr_Cp(character_b[i])
	LDI        R17, #lo_addr(_character_b+0)
	LDI        R18, hi_addr(_character_b+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L__LCD_Load13
L__LCD_Load28:
L__LCD_Load13:
;libs/LCD.mbas,103 :: 		next i
	LDD        R16, Y+0
	CPI        R16, 7
	BRNE       L__LCD_Load43
	JMP        L__LCD_Load12
L__LCD_Load43:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L__LCD_Load9
L__LCD_Load12:
;libs/LCD.mbas,104 :: 		next dchar
	LDD        R16, Y+1
	CPI        R16, 4
	BRNE       L__LCD_Load44
	JMP        L__LCD_Load7
L__LCD_Load44:
	LDD        R16, Y+1
	SUBI       R16, 255
	STD        Y+1, R16
	JMP        L__LCD_Load4
L__LCD_Load7:
;libs/LCD.mbas,105 :: 		end sub
L_end_LCD_Load:
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _LCD_Load

_CustomChar:

;libs/LCD.mbas,108 :: 		dim i as byte
;libs/LCD.mbas,109 :: 		Lcd_Cmd(120)
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 120
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
	POP        R2
	POP        R3
;libs/LCD.mbas,110 :: 		for i = 0 to 7
; i start address is: 18 (R18)
	LDI        R18, 0
; i end address is: 18 (R18)
L__CustomChar31:
;libs/LCD.mbas,111 :: 		Lcd_Chr_CP(character[i])
; i start address is: 18 (R18)
	LDI        R16, #lo_addr(_character+0)
	LDI        R17, hi_addr(_character+0)
	MOV        R30, R18
	LDI        R31, 0
	ADD        R30, R16
	ADC        R31, R17
	LPM        R16, Z
	PUSH       R18
	PUSH       R3
	PUSH       R2
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R2
	POP        R3
	POP        R18
;libs/LCD.mbas,112 :: 		next i
	CPI        R18, 7
	BRNE       L__CustomChar46
	JMP        L__CustomChar34
L__CustomChar46:
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
; i end address is: 18 (R18)
	JMP        L__CustomChar31
L__CustomChar34:
;libs/LCD.mbas,113 :: 		Lcd_Cmd(_LCD_RETURN_HOME)
	PUSH       R3
	PUSH       R2
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
	POP        R2
	POP        R3
;libs/LCD.mbas,114 :: 		Lcd_Chr(pos_row, pos_char, 7)
	PUSH       R3
	PUSH       R2
	LDI        R27, 7
	MOV        R4, R27
	CALL       _Lcd_Chr+0
	POP        R2
	POP        R3
;libs/LCD.mbas,115 :: 		end sub
L_end_CustomChar:
	POP        R4
	RET
; end of _CustomChar

_libs/LCD_?main:

;libs/LCD.mbas,118 :: 		end.
L_end_libs/LCD_?main:
	RET
; end of _libs/LCD_?main
