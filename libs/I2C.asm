
_Write_Time:

;libs/I2C.mbas,39 :: 		dim c_day as byte, dim c_week as byte, dim c_month as byte, dim c_year as byte)
;libs/I2C.mbas,40 :: 		Soft_I2C_Start()                         ' issue start signal
	PUSH       R2
	PUSH       R8
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _Soft_I2C_Start+0
;libs/I2C.mbas,41 :: 		Soft_I2C_Write(RTC_ADDR)                 ' address DS1307
	LDI        R27, 208
	MOV        R2, R27
	CALL       _Soft_I2C_Write+0
;libs/I2C.mbas,42 :: 		Soft_I2C_Write(0)                        ' start from word at address (REG0)
	CLR        R2
	CALL       _Soft_I2C_Write+0
;libs/I2C.mbas,43 :: 		Soft_I2C_Write(0x80)                     ' write $80 to REG0. (pause counter + 0 sec)   ?? ??????? ????? ????? ?????
	LDI        R27, 128
	MOV        R2, R27
	CALL       _Soft_I2C_Write+0
	POP        R2
	POP        R3
;libs/I2C.mbas,45 :: 		Soft_I2C_Write(c_minutes)                ' write 0 to minutes word to (REG1)
	PUSH       R2
	MOV        R2, R3
	CALL       _Soft_I2C_Write+0
	POP        R2
;libs/I2C.mbas,46 :: 		Soft_I2C_Write(c_hours)                  ' write 17 to hours word (24-hours mode)(REG2)
	CALL       _Soft_I2C_Write+0
	POP        R4
	POP        R5
	POP        R6
;libs/I2C.mbas,47 :: 		Soft_I2C_Write(c_week)                   ' write 2 - Monday (REG3)
	PUSH       R5
	PUSH       R4
	MOV        R2, R6
	CALL       _Soft_I2C_Write+0
	POP        R4
	POP        R5
;libs/I2C.mbas,48 :: 		Soft_I2C_Write(c_day)                    ' write 4 to date word (REG4)
	PUSH       R4
	MOV        R2, R5
	CALL       _Soft_I2C_Write+0
	POP        R4
	POP        R7
;libs/I2C.mbas,49 :: 		Soft_I2C_Write(c_month)                  ' write 5 (May) to month word (REG5)
	PUSH       R4
	MOV        R2, R7
	CALL       _Soft_I2C_Write+0
	POP        R4
	POP        R8
;libs/I2C.mbas,50 :: 		Soft_I2C_Write(c_year)                   ' write 01 to year word (REG6)
	PUSH       R4
	MOV        R2, R8
	CALL       _Soft_I2C_Write+0
;libs/I2C.mbas,51 :: 		Soft_I2C_Stop()                          ' issue stop signal
	CALL       _Soft_I2C_Stop+0
;libs/I2C.mbas,53 :: 		Soft_I2C_Start()                         ' issue start signal
	CALL       _Soft_I2C_Start+0
;libs/I2C.mbas,54 :: 		Soft_I2C_Write(RTC_ADDR)                 ' address DS1307
	LDI        R27, 208
	MOV        R2, R27
	CALL       _Soft_I2C_Write+0
;libs/I2C.mbas,55 :: 		Soft_I2C_Write(0)                        ' start from word at address 0
	CLR        R2
	CALL       _Soft_I2C_Write+0
	POP        R4
;libs/I2C.mbas,56 :: 		Soft_I2C_Write(0 and c_seconds)          ' write 0 to REG0 (enable counting + 0 sec)       ???? ??? ? ?????
	MOV        R16, R4
	ANDI       R16, 0
	MOV        R2, R16
	CALL       _Soft_I2C_Write+0
;libs/I2C.mbas,57 :: 		Soft_I2C_Stop()                          ' issue stop signal
	CALL       _Soft_I2C_Stop+0
;libs/I2C.mbas,58 :: 		end sub
L_end_Write_Time:
	POP        R2
	RET
; end of _Write_Time

_Read_Time:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	ADIW       R28, 5

;libs/I2C.mbas,64 :: 		dim p_day as ^byte, dim p_week as ^byte, dim p_month as ^byte, dim p_year as ^byte)
	PUSH       R2
	PUSH       R3
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
;libs/I2C.mbas,66 :: 		Soft_I2C_Start()                    ' Issue start signal
	PUSH       R9
	PUSH       R8
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _Soft_I2C_Start+0
;libs/I2C.mbas,67 :: 		Soft_I2C_Write(RTC_ADDR)            ' Address DS1307, see DS1307 datasheet
	LDI        R27, 208
	MOV        R2, R27
	CALL       _Soft_I2C_Write+0
;libs/I2C.mbas,68 :: 		Soft_I2C_Write(0)                   ' Start from address 0
	CLR        R2
	CALL       _Soft_I2C_Write+0
;libs/I2C.mbas,69 :: 		Soft_I2C_Start()                    ' Issue repeated start signal
	CALL       _Soft_I2C_Start+0
;libs/I2C.mbas,70 :: 		Soft_I2C_Write(RTC_ADDR + 1)        ' Address DS1307 for reading R/W=1
	LDI        R27, 209
	MOV        R2, R27
	CALL       _Soft_I2C_Write+0
;libs/I2C.mbas,72 :: 		p_seconds^ = Soft_I2C_Read(1)      ' Read seconds byte
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Soft_I2C_Read+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	MOVW       R30, R6
	ST         Z, R16
;libs/I2C.mbas,73 :: 		p_minutes^ = Soft_I2C_Read(1)      ' Read minutes byte
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Soft_I2C_Read+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	MOVW       R30, R4
	ST         Z, R16
;libs/I2C.mbas,74 :: 		p_hours^ = Soft_I2C_Read(1)        ' Read hours byte
	PUSH       R3
	PUSH       R2
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Soft_I2C_Read+0
	POP        R2
	POP        R3
	MOVW       R30, R2
	ST         Z, R16
;libs/I2C.mbas,75 :: 		p_week^ = Soft_I2C_Read(1)
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Soft_I2C_Read+0
	LDD        R30, Y+0
	LDD        R31, Y+1
	ST         Z, R16
;libs/I2C.mbas,76 :: 		p_day^ = Soft_I2C_Read(1)
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Soft_I2C_Read+0
	POP        R8
	POP        R9
	MOVW       R30, R8
	ST         Z, R16
;libs/I2C.mbas,77 :: 		p_month^ = Soft_I2C_Read(1)
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Soft_I2C_Read+0
	LDD        R30, Y+2
	LDD        R31, Y+3
	ST         Z, R16
;libs/I2C.mbas,78 :: 		p_year^ = Soft_I2C_Read(0)
	CLR        R2
	CLR        R3
	CALL       _Soft_I2C_Read+0
	LDD        R30, Y+4
	LDD        R31, Y+5
	ST         Z, R16
;libs/I2C.mbas,80 :: 		Soft_I2C_Stop()   ' Issue stop signal
	CALL       _Soft_I2C_Stop+0
;libs/I2C.mbas,81 :: 		end sub
L_end_Read_Time:
	POP        R3
	POP        R2
	POP        R29
	POP        R28
	RET
; end of _Read_Time

_libs/I2C_?main:

;libs/I2C.mbas,86 :: 		end.
L_end_libs/I2C_?main:
	RET
; end of _libs/I2C_?main
