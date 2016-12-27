
_Shamsi_transfer_time:

;libs/milady_shamsi.mbas,50 :: 		sub procedure Shamsi_transfer_time()
;libs/milady_shamsi.mbas,52 :: 		seconds  =  ((seconds and 0x70) >> 4)*10 + (seconds and 0x0F)
	LDS        R16, _seconds+0
	ANDI       R16, 112
	MOV        R17, R16
	LSR        R17
	LSR        R17
	LSR        R17
	LSR        R17
	LDI        R16, 10
	MUL        R17, R16
	MOV        R17, R0
	LDS        R16, _seconds+0
	ANDI       R16, 15
	ADD        R16, R17
	STS        _seconds+0, R16
;libs/milady_shamsi.mbas,53 :: 		minutes  =  ((minutes and 0xF0) >> 4)*10 + (minutes and 0x0F)
	LDS        R16, _minutes+0
	ANDI       R16, 240
	MOV        R17, R16
	LSR        R17
	LSR        R17
	LSR        R17
	LSR        R17
	LDI        R16, 10
	MUL        R17, R16
	MOV        R17, R0
	LDS        R16, _minutes+0
	ANDI       R16, 15
	ADD        R16, R17
	STS        _minutes+0, R16
;libs/milady_shamsi.mbas,54 :: 		hours    =  ((hours and 0x30) >> 4)*10 + (hours and 0x0F)
	LDS        R16, _hours+0
	ANDI       R16, 48
	MOV        R17, R16
	LSR        R17
	LSR        R17
	LSR        R17
	LSR        R17
	LDI        R16, 10
	MUL        R17, R16
	MOV        R17, R0
	LDS        R16, _hours+0
	ANDI       R16, 15
	ADD        R16, R17
	STS        _hours+0, R16
;libs/milady_shamsi.mbas,55 :: 		week     =  (week and 0x07)
	LDS        R16, _week+0
	ANDI       R16, 7
	STS        _week+0, R16
;libs/milady_shamsi.mbas,56 :: 		day      =  ((day and 0xF0) >> 4)*10 + (day and 0x0F)
	LDS        R16, _day+0
	ANDI       R16, 240
	MOV        R17, R16
	LSR        R17
	LSR        R17
	LSR        R17
	LSR        R17
	LDI        R16, 10
	MUL        R17, R16
	MOV        R17, R0
	LDS        R16, _day+0
	ANDI       R16, 15
	ADD        R16, R17
	STS        _day+0, R16
;libs/milady_shamsi.mbas,57 :: 		month    =  ((month and 0x10) >> 4)*10 + (month and 0x0F)
	LDS        R16, _month+0
	ANDI       R16, 16
	MOV        R17, R16
	LSR        R17
	LSR        R17
	LSR        R17
	LSR        R17
	LDI        R16, 10
	MUL        R17, R16
	MOV        R17, R0
	LDS        R16, _month+0
	ANDI       R16, 15
	ADD        R16, R17
	STS        _month+0, R16
;libs/milady_shamsi.mbas,58 :: 		year     =  ((year and 0xF0) >> 4)*10+(year and 0x0F)
	LDS        R16, _year+0
	ANDI       R16, 240
	MOV        R17, R16
	LSR        R17
	LSR        R17
	LSR        R17
	LSR        R17
	LDI        R16, 10
	MUL        R17, R16
	MOV        R17, R0
	LDS        R16, _year+0
	ANDI       R16, 15
	ADD        R16, R17
	STS        _year+0, R16
;libs/milady_shamsi.mbas,59 :: 		end sub
L_end_Shamsi_transfer_time:
	RET
; end of _Shamsi_transfer_time

_Shamsi_show_lcd:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	ADIW       R28, 5

;libs/milady_shamsi.mbas,61 :: 		sub procedure Shamsi_show_lcd(dim jjmonth,jjday,jjyear,jweek,jhours ,jminutes,jseconds as integer)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDD        R16, Y+0
	LDD        R17, Y+1
	STD        Y+0, R16
	STD        Y+1, R17
	LDD        R16, Y+2
	LDD        R17, Y+3
	STD        Y+2, R16
	STD        Y+3, R17
	LDD        R16, Y+4
	LDD        R17, Y+5
	STD        Y+4, R16
	STD        Y+5, R17
;libs/milady_shamsi.mbas,63 :: 		case 2
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__Shamsi_show_lcd105
	LDI        R27, 2
	CP         R8, R27
L__Shamsi_show_lcd105:
	BREQ       L__Shamsi_show_lcd106
	JMP        L__Shamsi_show_lcd5
L__Shamsi_show_lcd106:
;libs/milady_shamsi.mbas,64 :: 		txt = "Sun"
	LDI        R27, 83
	STS        _txt+0, R27
	LDI        R27, 117
	STS        _txt+1, R27
	LDI        R27, 110
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__Shamsi_show_lcd2
L__Shamsi_show_lcd5:
;libs/milady_shamsi.mbas,65 :: 		case 3
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__Shamsi_show_lcd107
	LDI        R27, 3
	CP         R8, R27
L__Shamsi_show_lcd107:
	BREQ       L__Shamsi_show_lcd108
	JMP        L__Shamsi_show_lcd8
L__Shamsi_show_lcd108:
;libs/milady_shamsi.mbas,66 :: 		txt = "Mon"
	LDI        R27, 77
	STS        _txt+0, R27
	LDI        R27, 111
	STS        _txt+1, R27
	LDI        R27, 110
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__Shamsi_show_lcd2
L__Shamsi_show_lcd8:
;libs/milady_shamsi.mbas,67 :: 		case 4
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__Shamsi_show_lcd109
	LDI        R27, 4
	CP         R8, R27
L__Shamsi_show_lcd109:
	BREQ       L__Shamsi_show_lcd110
	JMP        L__Shamsi_show_lcd11
L__Shamsi_show_lcd110:
;libs/milady_shamsi.mbas,68 :: 		txt = "Tue"
	LDI        R27, 84
	STS        _txt+0, R27
	LDI        R27, 117
	STS        _txt+1, R27
	LDI        R27, 101
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__Shamsi_show_lcd2
L__Shamsi_show_lcd11:
;libs/milady_shamsi.mbas,69 :: 		case 5
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__Shamsi_show_lcd111
	LDI        R27, 5
	CP         R8, R27
L__Shamsi_show_lcd111:
	BREQ       L__Shamsi_show_lcd112
	JMP        L__Shamsi_show_lcd14
L__Shamsi_show_lcd112:
;libs/milady_shamsi.mbas,70 :: 		txt = "Wed"
	LDI        R27, 87
	STS        _txt+0, R27
	LDI        R27, 101
	STS        _txt+1, R27
	LDI        R27, 100
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__Shamsi_show_lcd2
L__Shamsi_show_lcd14:
;libs/milady_shamsi.mbas,71 :: 		case 6
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__Shamsi_show_lcd113
	LDI        R27, 6
	CP         R8, R27
L__Shamsi_show_lcd113:
	BREQ       L__Shamsi_show_lcd114
	JMP        L__Shamsi_show_lcd17
L__Shamsi_show_lcd114:
;libs/milady_shamsi.mbas,72 :: 		txt = "Thu"
	LDI        R27, 84
	STS        _txt+0, R27
	LDI        R27, 104
	STS        _txt+1, R27
	LDI        R27, 117
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__Shamsi_show_lcd2
L__Shamsi_show_lcd17:
;libs/milady_shamsi.mbas,73 :: 		case 7
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__Shamsi_show_lcd115
	LDI        R27, 7
	CP         R8, R27
L__Shamsi_show_lcd115:
	BREQ       L__Shamsi_show_lcd116
	JMP        L__Shamsi_show_lcd20
L__Shamsi_show_lcd116:
;libs/milady_shamsi.mbas,74 :: 		txt = "Fri"
	LDI        R27, 70
	STS        _txt+0, R27
	LDI        R27, 114
	STS        _txt+1, R27
	LDI        R27, 105
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__Shamsi_show_lcd2
L__Shamsi_show_lcd20:
;libs/milady_shamsi.mbas,75 :: 		case 1
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__Shamsi_show_lcd117
	LDI        R27, 1
	CP         R8, R27
L__Shamsi_show_lcd117:
	BREQ       L__Shamsi_show_lcd118
	JMP        L__Shamsi_show_lcd23
L__Shamsi_show_lcd118:
;libs/milady_shamsi.mbas,76 :: 		txt = "Sat"
	LDI        R27, 83
	STS        _txt+0, R27
	LDI        R27, 97
	STS        _txt+1, R27
	LDI        R27, 116
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__Shamsi_show_lcd2
L__Shamsi_show_lcd23:
L__Shamsi_show_lcd2:
;libs/milady_shamsi.mbas,79 :: 		LCD_Out(1,1, txt)
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;libs/milady_shamsi.mbas,80 :: 		Lcd_Chr(1, 6, (jjday div 10)   + 48)    ' Print tens digit of day variable
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;libs/milady_shamsi.mbas,81 :: 		Lcd_Chr(1, 7, (jjday mod 10)   + 48)    ' Print oness digit of day variable
	PUSH       R3
	PUSH       R2
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
	POP        R2
	POP        R3
;libs/milady_shamsi.mbas,82 :: 		Lcd_Chr(1, 9, (jjmonth div 10) + 48)
	PUSH       R3
	PUSH       R2
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R2
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
	POP        R2
	POP        R3
;libs/milady_shamsi.mbas,83 :: 		Lcd_Chr(1,10, (jjmonth mod 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R2
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 10
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
	POP        R6
	POP        R7
;libs/milady_shamsi.mbas,85 :: 		Lcd_Chr(1,12, (jjyear div 1000)  + 48)
	PUSH       R7
	PUSH       R6
	LDI        R20, 232
	LDI        R21, 3
	MOVW       R16, R6
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
	POP        R6
	POP        R7
;libs/milady_shamsi.mbas,86 :: 		Lcd_Chr(1,13, ((jjyear mod 1000)div 100)  + 48)
	PUSH       R7
	PUSH       R6
	LDI        R20, 232
	LDI        R21, 3
	MOVW       R16, R6
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 100
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
	POP        R6
	POP        R7
;libs/milady_shamsi.mbas,87 :: 		Lcd_Chr(1,14, (((jjyear mod 1000)mod 100) div 10)  + 48)
	PUSH       R7
	PUSH       R6
	LDI        R20, 232
	LDI        R21, 3
	MOVW       R16, R6
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 100
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 14
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
	POP        R6
	POP        R7
;libs/milady_shamsi.mbas,88 :: 		Lcd_Chr(1,15, (((jjyear mod 1000)mod 100) mod 10)  + 48)
	LDI        R20, 232
	LDI        R21, 3
	MOVW       R16, R6
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 100
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 15
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,90 :: 		Lcd_Chr(2, 6, (jhours div 10)   + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+0
	LDD        R17, Y+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,91 :: 		Lcd_Chr(2, 7, (jhours mod 10)   + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+0
	LDD        R17, Y+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,92 :: 		Lcd_Chr(2, 9, (jminutes div 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+2
	LDD        R17, Y+3
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,93 :: 		Lcd_Chr(2,10, (jminutes mod 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+2
	LDD        R17, Y+3
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 10
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,94 :: 		Lcd_Chr(2,12, (jseconds div 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+4
	LDD        R17, Y+5
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,95 :: 		Lcd_Chr(2,13, (jseconds mod 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+4
	LDD        R17, Y+5
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,97 :: 		end sub
L_end_Shamsi_show_lcd:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	POP        R29
	POP        R28
	RET
; end of _Shamsi_show_lcd

libs/milady_shamsi_shamsi_to_milady:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 20
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/milady_shamsi.mbas,110 :: 		end structure
;libs/milady_shamsi.mbas,112 :: 		Mmonth_a[0] = 30
	LDI        R27, 30
	STD        Y+8, R27
;libs/milady_shamsi.mbas,113 :: 		Mmonth_a[1] = 31
	LDI        R27, 31
	STD        Y+9, R27
;libs/milady_shamsi.mbas,114 :: 		Mmonth_a[2] = 30
	LDI        R27, 30
	STD        Y+10, R27
;libs/milady_shamsi.mbas,115 :: 		Mmonth_a[3] = 31
	LDI        R27, 31
	STD        Y+11, R27
;libs/milady_shamsi.mbas,116 :: 		Mmonth_a[4] = 31
	LDI        R27, 31
	STD        Y+12, R27
;libs/milady_shamsi.mbas,117 :: 		Mmonth_a[5] = 30
	LDI        R27, 30
	STD        Y+13, R27
;libs/milady_shamsi.mbas,118 :: 		Mmonth_a[6] = 31
	LDI        R27, 31
	STD        Y+14, R27
;libs/milady_shamsi.mbas,119 :: 		Mmonth_a[7] = 30
	LDI        R27, 30
	STD        Y+15, R27
;libs/milady_shamsi.mbas,120 :: 		Mmonth_a[8] = 31
	LDI        R27, 31
	STD        Y+16, R27
;libs/milady_shamsi.mbas,121 :: 		Mmonth_a[9] = 31
	LDI        R27, 31
	STD        Y+17, R27
;libs/milady_shamsi.mbas,122 :: 		Mmonth_a[10] = 28
	LDI        R27, 28
	STD        Y+18, R27
;libs/milady_shamsi.mbas,123 :: 		Mmonth_a[11] = 31
	LDI        R27, 31
	STD        Y+19, R27
;libs/milady_shamsi.mbas,125 :: 		miladiYear = ShamsiYear + 621
	MOVW       R16, R6
	SUBI       R16, 147
	SBCI       R17, 253
	STD        Y+2, R16
	STD        Y+3, R17
;libs/milady_shamsi.mbas,126 :: 		miladiYear2=miladiYear
	STD        Y+0, R16
	STD        Y+1, R17
;libs/milady_shamsi.mbas,127 :: 		Temp1 = miladiYear2 Mod 4
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R20, 4
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp1+0, R16
	STS        _Temp1+1, R17
;libs/milady_shamsi.mbas,128 :: 		Temp2 = miladiYear2 Mod 100
	LDI        R20, 100
	LDI        R21, 0
	LDD        R16, Y+0
	LDD        R17, Y+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp2+0, R16
	STS        _Temp2+1, R17
;libs/milady_shamsi.mbas,129 :: 		Temp3 = miladiYear2 Mod 400
	LDI        R20, 144
	LDI        R21, 1
	LDD        R16, Y+0
	LDD        R17, Y+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	STS        _Temp3+0, R16
	STS        _Temp3+1, R17
;libs/milady_shamsi.mbas,130 :: 		Temp4 = (( Temp2 <> 0) and ( Temp1 = 0) )
	LDS        R21, _Temp2+0
	LDS        R22, _Temp2+1
	CPI        R22, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady120
	CPI        R21, 0
L_libs/milady_shamsi_shamsi_to_milady120:
	LDI        R20, 0
	BREQ       L_libs/milady_shamsi_shamsi_to_milady121
	LDI        R20, 255
L_libs/milady_shamsi_shamsi_to_milady121:
	LDS        R18, _Temp1+0
	LDS        R19, _Temp1+1
	CPI        R19, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady122
	CPI        R18, 0
L_libs/milady_shamsi_shamsi_to_milady122:
	LDI        R27, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady123
	LDI        R27, 255
L_libs/milady_shamsi_shamsi_to_milady123:
	MOV        R18, R27
	AND        R18, R20
	STS        _Temp4+0, R18
	LDI        R27, 0
	STS        _Temp4+1, R27
;libs/milady_shamsi.mbas,131 :: 		Temp5=((Temp2 = 0) and (Temp3 = 0) )
	CPI        R22, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady124
	CPI        R21, 0
L_libs/milady_shamsi_shamsi_to_milady124:
	LDI        R18, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady125
	LDI        R18, 255
L_libs/milady_shamsi_shamsi_to_milady125:
	CPI        R17, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady126
	CPI        R16, 0
L_libs/milady_shamsi_shamsi_to_milady126:
	LDI        R27, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady127
	LDI        R27, 255
L_libs/milady_shamsi_shamsi_to_milady127:
	MOV        R16, R27
	AND        R16, R18
; Temp5 start address is: 18 (R18)
	MOV        R18, R16
	LDI        R19, 0
;libs/milady_shamsi.mbas,133 :: 		if(Temp4 or temp5) then
	LDS        R16, _Temp4+0
	LDS        R17, _Temp4+1
	OR         R16, R18
	OR         R17, R19
; Temp5 end address is: 18 (R18)
	MOV        R27, R16
	OR         R27, R17
	BRNE       L_libs/milady_shamsi_shamsi_to_milady128
	JMP        L_libs/milady_shamsi_shamsi_to_milady26
L_libs/milady_shamsi_shamsi_to_milady128:
;libs/milady_shamsi.mbas,138 :: 		marchDayDiff = 12
	LDI        R27, 12
	STD        Y+4, R27
	LDI        R27, 0
	STD        Y+5, R27
	JMP        L_libs/milady_shamsi_shamsi_to_milady27
;libs/milady_shamsi.mbas,139 :: 		Else
L_libs/milady_shamsi_shamsi_to_milady26:
;libs/milady_shamsi.mbas,142 :: 		marchDayDiff = 11
	LDI        R27, 11
	STD        Y+4, R27
	LDI        R27, 0
	STD        Y+5, R27
;libs/milady_shamsi.mbas,143 :: 		End If
L_libs/milady_shamsi_shamsi_to_milady27:
;libs/milady_shamsi.mbas,144 :: 		if(((((miladiYear+1 mod  100)<> 0) and ((miladiYear+1 mod 4) = 0))) or ((((miladiYear+1 mod 100)= 0) and (miladiYear+1 mod 400) = 0))) then
	LDD        R16, Y+2
	LDD        R17, Y+3
	MOV        R19, R16
	MOV        R20, R17
	SUBI       R19, 255
	SBCI       R20, 255
	CPI        R20, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady129
	CPI        R19, 0
L_libs/milady_shamsi_shamsi_to_milady129:
	LDI        R17, 0
	BREQ       L_libs/milady_shamsi_shamsi_to_milady130
	LDI        R17, 255
L_libs/milady_shamsi_shamsi_to_milady130:
	CPI        R20, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady131
	CPI        R19, 0
L_libs/milady_shamsi_shamsi_to_milady131:
	LDI        R16, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady132
	LDI        R16, 255
L_libs/milady_shamsi_shamsi_to_milady132:
	MOV        R18, R17
	AND        R18, R16
	LDI        R17, 0
	AND        R16, R19
	AND        R17, R20
	CPI        R17, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady133
	CPI        R16, 0
L_libs/milady_shamsi_shamsi_to_milady133:
	LDI        R27, 0
	BRNE       L_libs/milady_shamsi_shamsi_to_milady134
	LDI        R27, 255
L_libs/milady_shamsi_shamsi_to_milady134:
	MOV        R16, R27
	OR         R16, R18
	BRNE       L_libs/milady_shamsi_shamsi_to_milady135
	JMP        L_libs/milady_shamsi_shamsi_to_milady29
L_libs/milady_shamsi_shamsi_to_milady135:
;libs/milady_shamsi.mbas,146 :: 		Mmonth_a[10] = Mmonth_a[10] + 1 '//Adding one day to Feb
	LDD        R16, Y+18
	SUBI       R16, 255
	STD        Y+18, R16
L_libs/milady_shamsi_shamsi_to_milady29:
;libs/milady_shamsi.mbas,149 :: 		if((ShamsiMonth>=1)and( ShamsiMonth<=6))   then
	LDI        R16, 1
	LDI        R17, 0
	CP         R2, R16
	CPC        R3, R17
	LDI        R18, 0
	BRLT       L_libs/milady_shamsi_shamsi_to_milady136
	LDI        R18, 255
L_libs/milady_shamsi_shamsi_to_milady136:
	LDI        R16, 6
	LDI        R17, 0
	CP         R16, R2
	CPC        R17, R3
	LDI        R27, 0
	BRLT       L_libs/milady_shamsi_shamsi_to_milady137
	LDI        R27, 255
L_libs/milady_shamsi_shamsi_to_milady137:
	MOV        R16, R27
	AND        R16, R18
	BRNE       L_libs/milady_shamsi_shamsi_to_milady138
	JMP        L_libs/milady_shamsi_shamsi_to_milady32
L_libs/milady_shamsi_shamsi_to_milady138:
;libs/milady_shamsi.mbas,150 :: 		dayCount = ((ShamsiMonth-1) * 31) + ShamsiDay
	MOVW       R16, R2
	SUBI       R16, 1
	SBCI       R17, 0
	LDI        R20, 31
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	ADD        R16, R4
	ADC        R17, R5
; dayCount start address is: 18 (R18)
	MOVW       R18, R16
; dayCount end address is: 18 (R18)
	JMP        L_libs/milady_shamsi_shamsi_to_milady33
;libs/milady_shamsi.mbas,151 :: 		else
L_libs/milady_shamsi_shamsi_to_milady32:
;libs/milady_shamsi.mbas,152 :: 		dayCount =(6 * 31) + ((ShamsiMonth - 7) * 30) + ShamsiDay
	MOVW       R16, R2
	SUBI       R16, 7
	SBCI       R17, 0
	LDI        R20, 30
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	SUBI       R16, 70
	SBCI       R17, 255
	ADD        R16, R4
	ADC        R17, R5
; dayCount start address is: 18 (R18)
	MOVW       R18, R16
; dayCount end address is: 18 (R18)
;libs/milady_shamsi.mbas,153 :: 		end if
L_libs/milady_shamsi_shamsi_to_milady33:
;libs/milady_shamsi.mbas,154 :: 		if (dayCount <= marchDayDiff) then '//So we are in 20(for leap year) or 21for none leap year) to 31 march
; dayCount start address is: 18 (R18)
	LDD        R16, Y+4
	LDD        R17, Y+5
	CP         R16, R18
	CPC        R17, R19
	BRGE       L_libs/milady_shamsi_shamsi_to_milady139
	JMP        L_libs/milady_shamsi_shamsi_to_milady35
L_libs/milady_shamsi_shamsi_to_milady139:
;libs/milady_shamsi.mbas,156 :: 		miladiDate_iDay = dayCount + (31 - marchDayDiff)
	LDD        R0, Y+4
	LDD        R1, Y+5
	LDI        R16, 31
	LDI        R17, 0
	SUB        R16, R0
	SBC        R17, R1
	ADD        R16, R18
	ADC        R17, R19
; dayCount end address is: 18 (R18)
	STS        _miladiDate_iDay+0, R16
	STS        _miladiDate_iDay+1, R17
;libs/milady_shamsi.mbas,157 :: 		miladiDate_iMonth = 3
	LDI        R27, 3
	STS        _miladiDate_iMonth+0, R27
	LDI        R27, 0
	STS        _miladiDate_iMonth+1, R27
;libs/milady_shamsi.mbas,158 :: 		miladiDate_iYear=miladiYear
	LDD        R16, Y+2
	LDD        R17, Y+3
	STS        _miladiDate_iYear+0, R16
	STS        _miladiDate_iYear+1, R17
	JMP        L_libs/milady_shamsi_shamsi_to_milady36
;libs/milady_shamsi.mbas,160 :: 		else
L_libs/milady_shamsi_shamsi_to_milady35:
;libs/milady_shamsi.mbas,161 :: 		remainDay = dayCount - marchDayDiff
; dayCount start address is: 18 (R18)
	LDD        R0, Y+4
	LDD        R1, Y+5
	MOVW       R16, R18
	SUB        R16, R0
	SBC        R17, R1
; dayCount end address is: 18 (R18)
	STD        Y+6, R16
	STD        Y+7, R17
;libs/milady_shamsi.mbas,162 :: 		end if
L_libs/milady_shamsi_shamsi_to_milady36:
;libs/milady_shamsi.mbas,163 :: 		i = 0  ' //starting from April
; i start address is: 20 (R20)
	LDI        R20, 0
	LDI        R21, 0
; i end address is: 20 (R20)
;libs/milady_shamsi.mbas,165 :: 		while ((remainDay > Mmonth_a[i]))
L_libs/milady_shamsi_shamsi_to_milady38:
; i start address is: 20 (R20)
	MOVW       R16, R28
	SUBI       R16, 248
	SBCI       R17, 255
	MOVW       R30, R20
	ADD        R30, R16
	ADC        R31, R17
	LD         R16, Z
	LDD        R18, Y+6
	LDD        R19, Y+7
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L_libs/milady_shamsi_shamsi_to_milady140
	JMP        L_libs/milady_shamsi_shamsi_to_milady39
L_libs/milady_shamsi_shamsi_to_milady140:
;libs/milady_shamsi.mbas,167 :: 		remainDay = remainDay - Mmonth_a[i]
	MOVW       R16, R28
	SUBI       R16, 248
	SBCI       R17, 255
	MOVW       R30, R20
	ADD        R30, R16
	ADC        R31, R17
	LD         R16, Z
	MOV        R0, R16
	LDI        R27, 0
	MOV        R1, R27
	LDD        R16, Y+6
	LDD        R17, Y+7
	SUB        R16, R0
	SBC        R17, R1
	STD        Y+6, R16
	STD        Y+7, R17
;libs/milady_shamsi.mbas,168 :: 		i=i+1
	MOVW       R16, R20
	SUBI       R16, 255
	SBCI       R17, 255
; i end address is: 20 (R20)
; i start address is: 22 (R22)
	MOVW       R22, R16
;libs/milady_shamsi.mbas,170 :: 		wend
	MOVW       R20, R22
; i end address is: 22 (R22)
	JMP        L_libs/milady_shamsi_shamsi_to_milady38
L_libs/milady_shamsi_shamsi_to_milady39:
;libs/milady_shamsi.mbas,171 :: 		miladiDate_iDay = remainDay
; i start address is: 20 (R20)
	LDD        R16, Y+6
	LDD        R17, Y+7
	STS        _miladiDate_iDay+0, R16
	STS        _miladiDate_iDay+1, R17
;libs/milady_shamsi.mbas,173 :: 		if (i > 8)  then '// We are in the next Miladi Year
	LDI        R16, 8
	LDI        R17, 0
	CP         R16, R20
	CPC        R17, R21
	BRLT       L_libs/milady_shamsi_shamsi_to_milady141
	JMP        L_libs/milady_shamsi_shamsi_to_milady43
L_libs/milady_shamsi_shamsi_to_milady141:
;libs/milady_shamsi.mbas,175 :: 		miladiDate_iMonth = i - 8
	MOVW       R16, R20
	SUBI       R16, 8
	SBCI       R17, 0
; i end address is: 20 (R20)
	STS        _miladiDate_iMonth+0, R16
	STS        _miladiDate_iMonth+1, R17
;libs/milady_shamsi.mbas,176 :: 		miladiDate_iYear =  miladiYear + 1
	LDD        R16, Y+2
	LDD        R17, Y+3
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _miladiDate_iYear+0, R16
	STS        _miladiDate_iYear+1, R17
	JMP        L_libs/milady_shamsi_shamsi_to_milady44
;libs/milady_shamsi.mbas,178 :: 		else
L_libs/milady_shamsi_shamsi_to_milady43:
;libs/milady_shamsi.mbas,180 :: 		miladiDate_iMonth = i + 4
; i start address is: 20 (R20)
	MOVW       R16, R20
	SUBI       R16, 252
	SBCI       R17, 255
; i end address is: 20 (R20)
	STS        _miladiDate_iMonth+0, R16
	STS        _miladiDate_iMonth+1, R17
;libs/milady_shamsi.mbas,181 :: 		miladiDate_iYear =  miladiYear
	LDD        R16, Y+2
	LDD        R17, Y+3
	STS        _miladiDate_iYear+0, R16
	STS        _miladiDate_iYear+1, R17
;libs/milady_shamsi.mbas,182 :: 		end if
L_libs/milady_shamsi_shamsi_to_milady44:
;libs/milady_shamsi.mbas,185 :: 		end sub
L_end_shamsi_to_milady:
	ADIW       R28, 19
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of libs/milady_shamsi_shamsi_to_milady

libs/milady_shamsi_shamsi:

;libs/milady_shamsi.mbas,189 :: 		sub procedure shamsi()
;libs/milady_shamsi.mbas,193 :: 		Gmonth_a[0] = 31
	LDI        R27, 31
	STS        _Gmonth_a+0, R27
;libs/milady_shamsi.mbas,194 :: 		Gmonth_a[1] = 28
	LDI        R27, 28
	STS        _Gmonth_a+1, R27
;libs/milady_shamsi.mbas,195 :: 		Gmonth_a[2] = 31
	LDI        R27, 31
	STS        _Gmonth_a+2, R27
;libs/milady_shamsi.mbas,196 :: 		Gmonth_a[3] = 30
	LDI        R27, 30
	STS        _Gmonth_a+3, R27
;libs/milady_shamsi.mbas,197 :: 		Gmonth_a[4] = 31
	LDI        R27, 31
	STS        _Gmonth_a+4, R27
;libs/milady_shamsi.mbas,198 :: 		Gmonth_a[5] = 30
	LDI        R27, 30
	STS        _Gmonth_a+5, R27
;libs/milady_shamsi.mbas,199 :: 		Gmonth_a[6] = 31
	LDI        R27, 31
	STS        _Gmonth_a+6, R27
;libs/milady_shamsi.mbas,200 :: 		Gmonth_a[7] = 31
	LDI        R27, 31
	STS        _Gmonth_a+7, R27
;libs/milady_shamsi.mbas,201 :: 		Gmonth_a[8] = 30
	LDI        R27, 30
	STS        _Gmonth_a+8, R27
;libs/milady_shamsi.mbas,202 :: 		Gmonth_a[9] = 31
	LDI        R27, 31
	STS        _Gmonth_a+9, R27
;libs/milady_shamsi.mbas,203 :: 		Gmonth_a[10] = 30
	LDI        R27, 30
	STS        _Gmonth_a+10, R27
;libs/milady_shamsi.mbas,204 :: 		Gmonth_a[11] = 31
	LDI        R27, 31
	STS        _Gmonth_a+11, R27
;libs/milady_shamsi.mbas,205 :: 		Gnumdayofyear = 365
	LDI        R27, 109
	STS        _Gnumdayofyear+0, R27
	LDI        R27, 1
	STS        _Gnumdayofyear+1, R27
;libs/milady_shamsi.mbas,206 :: 		Gdayofyear = 0
	LDI        R27, 0
	STS        _Gdayofyear+0, R27
	STS        _Gdayofyear+1, R27
;libs/milady_shamsi.mbas,207 :: 		Temp1 = Gyear Mod 4
	LDI        R20, 4
	LDI        R21, 0
	LDS        R16, _Gyear+0
	LDS        R17, _Gyear+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp1+0, R16
	STS        _Temp1+1, R17
;libs/milady_shamsi.mbas,208 :: 		Temp2 = Gyear Mod 100
	LDI        R20, 100
	LDI        R21, 0
	LDS        R16, _Gyear+0
	LDS        R17, _Gyear+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp2+0, R16
	STS        _Temp2+1, R17
;libs/milady_shamsi.mbas,209 :: 		Temp3 = Gyear Mod 400
	LDI        R20, 144
	LDI        R21, 1
	LDS        R16, _Gyear+0
	LDS        R17, _Gyear+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp3+0, R16
	STS        _Temp3+1, R17
;libs/milady_shamsi.mbas,210 :: 		Temp4 = Temp1 And Temp2
	LDS        R20, _Temp1+0
	LDS        R21, _Temp1+1
	LDS        R18, _Temp2+0
	LDS        R19, _Temp2+1
	AND        R18, R20
	AND        R19, R21
	STS        _Temp4+0, R18
	STS        _Temp4+1, R19
;libs/milady_shamsi.mbas,211 :: 		If (Temp4 <> 0) Or (Temp3 = 0) Then
	CPI        R19, 0
	BRNE       L_libs/milady_shamsi_shamsi143
	CPI        R18, 0
L_libs/milady_shamsi_shamsi143:
	LDI        R27, 0
	BREQ       L_libs/milady_shamsi_shamsi144
	LDI        R27, 255
L_libs/milady_shamsi_shamsi144:
	MOV        R18, R27
	CPI        R17, 0
	BRNE       L_libs/milady_shamsi_shamsi145
	CPI        R16, 0
L_libs/milady_shamsi_shamsi145:
	LDI        R27, 0
	BRNE       L_libs/milady_shamsi_shamsi146
	LDI        R27, 255
L_libs/milady_shamsi_shamsi146:
	MOV        R16, R27
	OR         R16, R18
	BRNE       L_libs/milady_shamsi_shamsi147
	JMP        L_libs/milady_shamsi_shamsi47
L_libs/milady_shamsi_shamsi147:
;libs/milady_shamsi.mbas,213 :: 		Gmonth_a[1] = 28
	LDI        R27, 28
	STS        _Gmonth_a+1, R27
	JMP        L_libs/milady_shamsi_shamsi48
;libs/milady_shamsi.mbas,214 :: 		Else
L_libs/milady_shamsi_shamsi47:
;libs/milady_shamsi.mbas,215 :: 		Gmonth_a[1] = 29
	LDI        R27, 29
	STS        _Gmonth_a+1, R27
;libs/milady_shamsi.mbas,216 :: 		End If
L_libs/milady_shamsi_shamsi48:
;libs/milady_shamsi.mbas,219 :: 		Gyear_ = Gyear - 1
	LDS        R16, _Gyear+0
	LDS        R17, _Gyear+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _Gyear_+0, R16
	STS        _Gyear_+1, R17
;libs/milady_shamsi.mbas,220 :: 		Temp1 = Gyear_ Mod 4
	LDI        R20, 4
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp1+0, R16
	STS        _Temp1+1, R17
;libs/milady_shamsi.mbas,221 :: 		Temp2 = Gyear_ Mod 100
	LDI        R20, 100
	LDI        R21, 0
	LDS        R16, _Gyear_+0
	LDS        R17, _Gyear_+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp2+0, R16
	STS        _Temp2+1, R17
;libs/milady_shamsi.mbas,222 :: 		Temp3 = Gyear_ Mod 400
	LDI        R20, 144
	LDI        R21, 1
	LDS        R16, _Gyear_+0
	LDS        R17, _Gyear_+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp3+0, R16
	STS        _Temp3+1, R17
;libs/milady_shamsi.mbas,223 :: 		Temp4 = Temp1 And Temp2
	LDS        R20, _Temp1+0
	LDS        R21, _Temp1+1
	LDS        R18, _Temp2+0
	LDS        R19, _Temp2+1
	AND        R18, R20
	AND        R19, R21
	STS        _Temp4+0, R18
	STS        _Temp4+1, R19
;libs/milady_shamsi.mbas,224 :: 		If (Temp4 <> 0) Or (Temp3 = 0) Then
	CPI        R19, 0
	BRNE       L_libs/milady_shamsi_shamsi148
	CPI        R18, 0
L_libs/milady_shamsi_shamsi148:
	LDI        R27, 0
	BREQ       L_libs/milady_shamsi_shamsi149
	LDI        R27, 255
L_libs/milady_shamsi_shamsi149:
	MOV        R18, R27
	CPI        R17, 0
	BRNE       L_libs/milady_shamsi_shamsi150
	CPI        R16, 0
L_libs/milady_shamsi_shamsi150:
	LDI        R27, 0
	BRNE       L_libs/milady_shamsi_shamsi151
	LDI        R27, 255
L_libs/milady_shamsi_shamsi151:
	MOV        R16, R27
	OR         R16, R18
	BRNE       L_libs/milady_shamsi_shamsi152
	JMP        L_libs/milady_shamsi_shamsi50
L_libs/milady_shamsi_shamsi152:
;libs/milady_shamsi.mbas,225 :: 		Isleapyearp =0
	LDS        R27, _Isleapyearp+0
	CBR        R27, BitMask(_Isleapyearp+0)
	STS        _Isleapyearp+0, R27
	JMP        L_libs/milady_shamsi_shamsi51
;libs/milady_shamsi.mbas,226 :: 		Else
L_libs/milady_shamsi_shamsi50:
;libs/milady_shamsi.mbas,227 :: 		Isleapyearp=1
	LDS        R27, _Isleapyearp+0
	SBR        R27, BitMask(_Isleapyearp+0)
	STS        _Isleapyearp+0, R27
;libs/milady_shamsi.mbas,228 :: 		End If
L_libs/milady_shamsi_shamsi51:
;libs/milady_shamsi.mbas,229 :: 		Temp1 = Gmonth - 1
	LDS        R16, _Gmonth+0
	LDS        R17, _Gmonth+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _Temp1+0, R16
	STS        _Temp1+1, R17
;libs/milady_shamsi.mbas,230 :: 		For Iloop = 1 To Temp1
	LDI        R27, 1
	STS        _Iloop+0, R27
L_libs/milady_shamsi_shamsi52:
	LDS        R18, _Iloop+0
	LDS        R16, _Temp1+0
	LDS        R17, _Temp1+1
	CP         R16, R18
	LDI        R27, 0
	CPC        R17, R27
	BRGE       L_libs/milady_shamsi_shamsi153
	JMP        L_libs/milady_shamsi_shamsi56
L_libs/milady_shamsi_shamsi153:
;libs/milady_shamsi.mbas,231 :: 		Gdayofyear = Gmonth_a[iloop-1] + Gdayofyear
	LDS        R18, _Iloop+0
	SUBI       R18, 1
	LDI        R16, #lo_addr(_Gmonth_a+0)
	LDI        R17, hi_addr(_Gmonth_a+0)
	MOV        R30, R18
	LDI        R31, 0
	ADD        R30, R16
	ADC        R31, R17
	LD         R18, Z
	LDS        R16, _Gdayofyear+0
	LDS        R17, _Gdayofyear+1
	ADD        R16, R18
	LDI        R27, 0
	ADC        R17, R27
	STS        _Gdayofyear+0, R16
	STS        _Gdayofyear+1, R17
;libs/milady_shamsi.mbas,232 :: 		Next   Iloop
	LDS        R16, _Iloop+0
	LDS        R18, _Temp1+0
	LDS        R19, _Temp1+1
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRNE       L_libs/milady_shamsi_shamsi154
	JMP        L_libs/milady_shamsi_shamsi56
L_libs/milady_shamsi_shamsi154:
	LDS        R16, _Iloop+0
	SUBI       R16, 255
	STS        _Iloop+0, R16
	JMP        L_libs/milady_shamsi_shamsi52
L_libs/milady_shamsi_shamsi56:
;libs/milady_shamsi.mbas,233 :: 		Gdayofyear = Gday + Gdayofyear
	LDS        R18, _Gday+0
	LDS        R19, _Gday+1
	LDS        R16, _Gdayofyear+0
	LDS        R17, _Gdayofyear+1
	ADD        R18, R16
	ADC        R19, R17
	STS        _Gdayofyear+0, R18
	STS        _Gdayofyear+1, R19
;libs/milady_shamsi.mbas,234 :: 		If Gdayofyear > 79 Then
	LDI        R16, 79
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L_libs/milady_shamsi_shamsi155
	JMP        L_libs/milady_shamsi_shamsi58
L_libs/milady_shamsi_shamsi155:
;libs/milady_shamsi.mbas,235 :: 		Temp1 = Gdayofyear - 79
	LDS        R18, _Gdayofyear+0
	LDS        R19, _Gdayofyear+1
	SUBI       R18, 79
	SBCI       R19, 0
	STS        _Temp1+0, R18
	STS        _Temp1+1, R19
;libs/milady_shamsi.mbas,236 :: 		Jyear = Gyear - 621
	LDS        R16, _Gyear+0
	LDS        R17, _Gyear+1
	SUBI       R16, 109
	SBCI       R17, 2
	STS        _Jyear+0, R16
	STS        _Jyear+1, R17
;libs/milady_shamsi.mbas,237 :: 		If Temp1 < 186 Then
	LDI        R16, 186
	LDI        R17, 0
	CP         R18, R16
	CPC        R19, R17
	BRLT       L_libs/milady_shamsi_shamsi156
	JMP        L_libs/milady_shamsi_shamsi61
L_libs/milady_shamsi_shamsi156:
;libs/milady_shamsi.mbas,238 :: 		Temp2 = Temp1 Mod 31
	LDI        R20, 31
	LDI        R21, 0
	LDS        R16, _Temp1+0
	LDS        R17, _Temp1+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp2+0, R16
	STS        _Temp2+1, R17
;libs/milady_shamsi.mbas,239 :: 		Temp3 = Temp1 / 31
	LDI        R20, 31
	LDI        R21, 0
	LDS        R16, _Temp1+0
	LDS        R17, _Temp1+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _Temp3+0, R16
	STS        _Temp3+1, R17
;libs/milady_shamsi.mbas,240 :: 		If Temp2 = 0 Then
	LDS        R16, _Temp2+0
	LDS        R17, _Temp2+1
	CPI        R17, 0
	BRNE       L_libs/milady_shamsi_shamsi157
	CPI        R16, 0
L_libs/milady_shamsi_shamsi157:
	BREQ       L_libs/milady_shamsi_shamsi158
	JMP        L_libs/milady_shamsi_shamsi64
L_libs/milady_shamsi_shamsi158:
;libs/milady_shamsi.mbas,241 :: 		Jmonth = Temp3
	LDS        R16, _Temp3+0
	LDS        R17, _Temp3+1
	STS        _Jmonth+0, R16
	STS        _Jmonth+1, R17
;libs/milady_shamsi.mbas,242 :: 		Jday = 31
	LDI        R27, 31
	STS        _Jday+0, R27
	LDI        R27, 0
	STS        _Jday+1, R27
	JMP        L_libs/milady_shamsi_shamsi65
;libs/milady_shamsi.mbas,243 :: 		Else
L_libs/milady_shamsi_shamsi64:
;libs/milady_shamsi.mbas,244 :: 		Jmonth = Temp3 + 1
	LDS        R16, _Temp3+0
	LDS        R17, _Temp3+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Jmonth+0, R16
	STS        _Jmonth+1, R17
;libs/milady_shamsi.mbas,245 :: 		Jday = Temp2
	LDS        R16, _Temp2+0
	LDS        R17, _Temp2+1
	STS        _Jday+0, R16
	STS        _Jday+1, R17
;libs/milady_shamsi.mbas,246 :: 		End If
L_libs/milady_shamsi_shamsi65:
	JMP        L_libs/milady_shamsi_shamsi62
;libs/milady_shamsi.mbas,247 :: 		Else
L_libs/milady_shamsi_shamsi61:
;libs/milady_shamsi.mbas,248 :: 		Temp2 = Temp1 - 186
	LDS        R16, _Temp1+0
	LDS        R17, _Temp1+1
	SUBI       R16, 186
	SBCI       R17, 0
	STS        _Temp2+0, R16
	STS        _Temp2+1, R17
;libs/milady_shamsi.mbas,249 :: 		Temp3 = Temp2 Mod 30
	LDI        R20, 30
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp3+0, R16
	STS        _Temp3+1, R17
;libs/milady_shamsi.mbas,250 :: 		Temp4 = Temp2 / 30
	LDI        R20, 30
	LDI        R21, 0
	LDS        R16, _Temp2+0
	LDS        R17, _Temp2+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _Temp4+0, R16
	STS        _Temp4+1, R17
;libs/milady_shamsi.mbas,251 :: 		If Temp3 = 0 Then
	LDS        R16, _Temp3+0
	LDS        R17, _Temp3+1
	CPI        R17, 0
	BRNE       L_libs/milady_shamsi_shamsi159
	CPI        R16, 0
L_libs/milady_shamsi_shamsi159:
	BREQ       L_libs/milady_shamsi_shamsi160
	JMP        L_libs/milady_shamsi_shamsi67
L_libs/milady_shamsi_shamsi160:
;libs/milady_shamsi.mbas,252 :: 		Jmonth = Temp4 + 6
	LDS        R16, _Temp4+0
	LDS        R17, _Temp4+1
	SUBI       R16, 250
	SBCI       R17, 255
	STS        _Jmonth+0, R16
	STS        _Jmonth+1, R17
;libs/milady_shamsi.mbas,253 :: 		Jday = 30
	LDI        R27, 30
	STS        _Jday+0, R27
	LDI        R27, 0
	STS        _Jday+1, R27
	JMP        L_libs/milady_shamsi_shamsi68
;libs/milady_shamsi.mbas,254 :: 		Else
L_libs/milady_shamsi_shamsi67:
;libs/milady_shamsi.mbas,255 :: 		Jmonth = Temp4 + 7
	LDS        R16, _Temp4+0
	LDS        R17, _Temp4+1
	SUBI       R16, 249
	SBCI       R17, 255
	STS        _Jmonth+0, R16
	STS        _Jmonth+1, R17
;libs/milady_shamsi.mbas,256 :: 		Jday = Temp3
	LDS        R16, _Temp3+0
	LDS        R17, _Temp3+1
	STS        _Jday+0, R16
	STS        _Jday+1, R17
;libs/milady_shamsi.mbas,257 :: 		End If
L_libs/milady_shamsi_shamsi68:
;libs/milady_shamsi.mbas,258 :: 		End If
L_libs/milady_shamsi_shamsi62:
	JMP        L_libs/milady_shamsi_shamsi59
;libs/milady_shamsi.mbas,259 :: 		Else
L_libs/milady_shamsi_shamsi58:
;libs/milady_shamsi.mbas,260 :: 		Jyear = Gyear - 622
	LDS        R16, _Gyear+0
	LDS        R17, _Gyear+1
	SUBI       R16, 110
	SBCI       R17, 2
	STS        _Jyear+0, R16
	STS        _Jyear+1, R17
;libs/milady_shamsi.mbas,261 :: 		If Isleapyearp  Then
	LDS        R27, _Isleapyearp+0
	SBRS       R27, BitPos(_Isleapyearp+0)
	JMP        L_libs/milady_shamsi_shamsi70
;libs/milady_shamsi.mbas,262 :: 		Gdayofyear = Gdayofyear + 11
	LDS        R16, _Gdayofyear+0
	LDS        R17, _Gdayofyear+1
	SUBI       R16, 245
	SBCI       R17, 255
	STS        _Gdayofyear+0, R16
	STS        _Gdayofyear+1, R17
	JMP        L_libs/milady_shamsi_shamsi71
;libs/milady_shamsi.mbas,263 :: 		Else
L_libs/milady_shamsi_shamsi70:
;libs/milady_shamsi.mbas,264 :: 		Gdayofyear = Gdayofyear + 10
	LDS        R16, _Gdayofyear+0
	LDS        R17, _Gdayofyear+1
	SUBI       R16, 246
	SBCI       R17, 255
	STS        _Gdayofyear+0, R16
	STS        _Gdayofyear+1, R17
;libs/milady_shamsi.mbas,265 :: 		End If
L_libs/milady_shamsi_shamsi71:
;libs/milady_shamsi.mbas,266 :: 		Temp2 = Gdayofyear Mod 30
	LDI        R20, 30
	LDI        R21, 0
	LDS        R16, _Gdayofyear+0
	LDS        R17, _Gdayofyear+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _Temp2+0, R16
	STS        _Temp2+1, R17
;libs/milady_shamsi.mbas,267 :: 		Temp3 = Gdayofyear / 30
	LDI        R20, 30
	LDI        R21, 0
	LDS        R16, _Gdayofyear+0
	LDS        R17, _Gdayofyear+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _Temp3+0, R16
	STS        _Temp3+1, R17
;libs/milady_shamsi.mbas,268 :: 		If Temp2 = 0 Then
	LDS        R16, _Temp2+0
	LDS        R17, _Temp2+1
	CPI        R17, 0
	BRNE       L_libs/milady_shamsi_shamsi161
	CPI        R16, 0
L_libs/milady_shamsi_shamsi161:
	BREQ       L_libs/milady_shamsi_shamsi162
	JMP        L_libs/milady_shamsi_shamsi73
L_libs/milady_shamsi_shamsi162:
;libs/milady_shamsi.mbas,269 :: 		Jmonth = Temp3 + 9
	LDS        R16, _Temp3+0
	LDS        R17, _Temp3+1
	SUBI       R16, 247
	SBCI       R17, 255
	STS        _Jmonth+0, R16
	STS        _Jmonth+1, R17
;libs/milady_shamsi.mbas,270 :: 		Jday = 30
	LDI        R27, 30
	STS        _Jday+0, R27
	LDI        R27, 0
	STS        _Jday+1, R27
	JMP        L_libs/milady_shamsi_shamsi74
;libs/milady_shamsi.mbas,271 :: 		Else
L_libs/milady_shamsi_shamsi73:
;libs/milady_shamsi.mbas,272 :: 		Jmonth = Temp3 + 10
	LDS        R16, _Temp3+0
	LDS        R17, _Temp3+1
	SUBI       R16, 246
	SBCI       R17, 255
	STS        _Jmonth+0, R16
	STS        _Jmonth+1, R17
;libs/milady_shamsi.mbas,273 :: 		Jday = Temp2
	LDS        R16, _Temp2+0
	LDS        R17, _Temp2+1
	STS        _Jday+0, R16
	STS        _Jday+1, R17
;libs/milady_shamsi.mbas,274 :: 		End If
L_libs/milady_shamsi_shamsi74:
;libs/milady_shamsi.mbas,275 :: 		Delay_ms(1)
	LDI        R17, 11
	LDI        R16, 99
L_libs/milady_shamsi_shamsi75:
	DEC        R16
	BRNE       L_libs/milady_shamsi_shamsi75
	DEC        R17
	BRNE       L_libs/milady_shamsi_shamsi75
;libs/milady_shamsi.mbas,276 :: 		End If
L_libs/milady_shamsi_shamsi59:
;libs/milady_shamsi.mbas,278 :: 		end sub
L_end_shamsi:
	RET
; end of libs/milady_shamsi_shamsi

_miladi_call:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	ADIW       R28, 5

;libs/milady_shamsi.mbas,279 :: 		sub procedure miladi_call(dim jjmonth,jjday,jjyear,jweek,jhours ,jminutes,jseconds as integer)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDD        R16, Y+0
	LDD        R17, Y+1
	STD        Y+0, R16
	STD        Y+1, R17
	LDD        R16, Y+2
	LDD        R17, Y+3
	STD        Y+2, R16
	STD        Y+3, R17
	LDD        R16, Y+4
	LDD        R17, Y+5
	STD        Y+4, R16
	STD        Y+5, R17
;libs/milady_shamsi.mbas,282 :: 		Lcd_0()
	PUSH       R9
	PUSH       R8
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _Lcd_0+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
;libs/milady_shamsi.mbas,283 :: 		shamsi_to_milady( jjmonth, jjday, jJyear )
	CALL       libs/milady_shamsi_shamsi_to_milady+0
	POP        R8
	POP        R9
;libs/milady_shamsi.mbas,285 :: 		case 2
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__miladi_call164
	LDI        R27, 2
	CP         R8, R27
L__miladi_call164:
	BREQ       L__miladi_call165
	JMP        L__miladi_call81
L__miladi_call165:
;libs/milady_shamsi.mbas,286 :: 		txt = "Sun"
	LDI        R27, 83
	STS        _txt+0, R27
	LDI        R27, 117
	STS        _txt+1, R27
	LDI        R27, 110
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__miladi_call78
L__miladi_call81:
;libs/milady_shamsi.mbas,287 :: 		case 3
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__miladi_call166
	LDI        R27, 3
	CP         R8, R27
L__miladi_call166:
	BREQ       L__miladi_call167
	JMP        L__miladi_call84
L__miladi_call167:
;libs/milady_shamsi.mbas,288 :: 		txt = "Mon"
	LDI        R27, 77
	STS        _txt+0, R27
	LDI        R27, 111
	STS        _txt+1, R27
	LDI        R27, 110
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__miladi_call78
L__miladi_call84:
;libs/milady_shamsi.mbas,289 :: 		case 4
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__miladi_call168
	LDI        R27, 4
	CP         R8, R27
L__miladi_call168:
	BREQ       L__miladi_call169
	JMP        L__miladi_call87
L__miladi_call169:
;libs/milady_shamsi.mbas,290 :: 		txt = "Tue"
	LDI        R27, 84
	STS        _txt+0, R27
	LDI        R27, 117
	STS        _txt+1, R27
	LDI        R27, 101
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__miladi_call78
L__miladi_call87:
;libs/milady_shamsi.mbas,291 :: 		case 5
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__miladi_call170
	LDI        R27, 5
	CP         R8, R27
L__miladi_call170:
	BREQ       L__miladi_call171
	JMP        L__miladi_call90
L__miladi_call171:
;libs/milady_shamsi.mbas,292 :: 		txt = "Wed"
	LDI        R27, 87
	STS        _txt+0, R27
	LDI        R27, 101
	STS        _txt+1, R27
	LDI        R27, 100
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__miladi_call78
L__miladi_call90:
;libs/milady_shamsi.mbas,293 :: 		case 6
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__miladi_call172
	LDI        R27, 6
	CP         R8, R27
L__miladi_call172:
	BREQ       L__miladi_call173
	JMP        L__miladi_call93
L__miladi_call173:
;libs/milady_shamsi.mbas,294 :: 		txt = "Thu"
	LDI        R27, 84
	STS        _txt+0, R27
	LDI        R27, 104
	STS        _txt+1, R27
	LDI        R27, 117
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__miladi_call78
L__miladi_call93:
;libs/milady_shamsi.mbas,295 :: 		case 7
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__miladi_call174
	LDI        R27, 7
	CP         R8, R27
L__miladi_call174:
	BREQ       L__miladi_call175
	JMP        L__miladi_call96
L__miladi_call175:
;libs/milady_shamsi.mbas,296 :: 		txt = "Fri"
	LDI        R27, 70
	STS        _txt+0, R27
	LDI        R27, 114
	STS        _txt+1, R27
	LDI        R27, 105
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__miladi_call78
L__miladi_call96:
;libs/milady_shamsi.mbas,297 :: 		case 1
	LDI        R27, 0
	CP         R9, R27
	BRNE       L__miladi_call176
	LDI        R27, 1
	CP         R8, R27
L__miladi_call176:
	BREQ       L__miladi_call177
	JMP        L__miladi_call99
L__miladi_call177:
;libs/milady_shamsi.mbas,298 :: 		txt = "Sat"
	LDI        R27, 83
	STS        _txt+0, R27
	LDI        R27, 97
	STS        _txt+1, R27
	LDI        R27, 116
	STS        _txt+2, R27
	LDI        R27, 0
	STS        _txt+3, R27
	JMP        L__miladi_call78
L__miladi_call99:
L__miladi_call78:
;libs/milady_shamsi.mbas,301 :: 		LCD_Out(1,1, txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/milady_shamsi.mbas,302 :: 		Lcd_Chr(1, 6, (miladiDate_iDay div 10)   + 48)    ' Print tens digit of day variable
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _miladiDate_iDay+0
	LDS        R17, _miladiDate_iDay+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,303 :: 		Lcd_Chr(1, 7, (miladiDate_iDay mod 10)   + 48)    ' Print oness digit of day variable
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _miladiDate_iDay+0
	LDS        R17, _miladiDate_iDay+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,304 :: 		Lcd_Chr(1, 9, (miladiDate_iMonth div 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _miladiDate_iMonth+0
	LDS        R17, _miladiDate_iMonth+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,305 :: 		Lcd_Chr(1,10, (miladiDate_iMonth mod 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _miladiDate_iMonth+0
	LDS        R17, _miladiDate_iMonth+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 10
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,306 :: 		Lcd_Chr(1,12, (miladiDate_iYear div 1000)  + 48)
	LDI        R20, 232
	LDI        R21, 3
	LDS        R16, _miladiDate_iYear+0
	LDS        R17, _miladiDate_iYear+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,307 :: 		Lcd_Chr(1,13, ((miladiDate_iYear mod 1000)div 100)  + 48)
	LDI        R20, 232
	LDI        R21, 3
	LDS        R16, _miladiDate_iYear+0
	LDS        R17, _miladiDate_iYear+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 100
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,308 :: 		Lcd_Chr(1,14, (((miladiDate_iYear mod 1000)mod 100) div 10)  + 48)
	LDI        R20, 232
	LDI        R21, 3
	LDS        R16, _miladiDate_iYear+0
	LDS        R17, _miladiDate_iYear+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 100
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 14
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,309 :: 		Lcd_Chr(1,15, (((miladiDate_iYear mod 1000)mod 100) mod 10)  + 48)
	LDI        R20, 232
	LDI        R21, 3
	LDS        R16, _miladiDate_iYear+0
	LDS        R17, _miladiDate_iYear+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 100
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 15
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,311 :: 		Lcd_Chr(2, 6, (jhours div 10)   + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+0
	LDD        R17, Y+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,312 :: 		Lcd_Chr(2, 7, (jhours mod 10)   + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+0
	LDD        R17, Y+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,313 :: 		Lcd_Chr(2, 9, (jminutes div 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+2
	LDD        R17, Y+3
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,314 :: 		Lcd_Chr(2,10, (jminutes mod 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+2
	LDD        R17, Y+3
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 10
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,315 :: 		Lcd_Chr(2,12, (jseconds div 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+4
	LDD        R17, Y+5
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,316 :: 		Lcd_Chr(2,13, (jseconds mod 10) + 48)
	LDI        R20, 10
	LDI        R21, 0
	LDD        R16, Y+4
	LDD        R17, Y+5
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;libs/milady_shamsi.mbas,318 :: 		Delay_mS(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L__miladi_call100:
	DEC        R16
	BRNE       L__miladi_call100
	DEC        R17
	BRNE       L__miladi_call100
	DEC        R18
	BRNE       L__miladi_call100
;libs/milady_shamsi.mbas,319 :: 		end sub
L_end_miladi_call:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	POP        R29
	POP        R28
	RET
; end of _miladi_call

_Shamsi_call:

;libs/milady_shamsi.mbas,323 :: 		sub procedure Shamsi_call()
;libs/milady_shamsi.mbas,326 :: 		Shamsi_transfer_time()
	PUSH       R2
	CALL       _Shamsi_transfer_time+0
;libs/milady_shamsi.mbas,328 :: 		Gyear =  Year+2000
	LDS        R16, _year+0
	LDI        R17, 0
	SUBI       R16, 48
	SBCI       R17, 248
	STS        _Gyear+0, R16
	STS        _Gyear+1, R17
;libs/milady_shamsi.mbas,329 :: 		Gday = Day
	LDS        R16, _day+0
	STS        _Gday+0, R16
	LDI        R27, 0
	STS        _Gday+1, R27
;libs/milady_shamsi.mbas,330 :: 		Gmonth = Month
	LDS        R16, _month+0
	STS        _Gmonth+0, R16
	LDI        R27, 0
	STS        _Gmonth+1, R27
;libs/milady_shamsi.mbas,332 :: 		shamsi()
	CALL       libs/milady_shamsi_shamsi+0
;libs/milady_shamsi.mbas,338 :: 		Lcd_Cmd(_LCD_CLEAR)               ' Prepare and output static text on LCD
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;libs/milady_shamsi.mbas,347 :: 		end sub
L_end_Shamsi_call:
	POP        R2
	RET
; end of _Shamsi_call

_libs/milady_shamsi_?main:

;libs/milady_shamsi.mbas,349 :: 		end.
L_end_libs/milady_shamsi_?main:
	RET
; end of _libs/milady_shamsi_?main
