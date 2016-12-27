
libs/EEprom_Write_EEprom:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/EEprom.mbas,41 :: 		error as byte
;libs/EEprom.mbas,43 :: 		hi_=hi(address)
	PUSH       R2
	PUSH       R3
	STD        Y+0, R3
;libs/EEprom.mbas,44 :: 		lo_=lo(address)
	STD        Y+1, R2
;libs/EEprom.mbas,45 :: 		Soft_I2C_Start()                         ' issue start signal
	PUSH       R4
	CALL       _Soft_I2C_Start+0
;libs/EEprom.mbas,46 :: 		Soft_I2C_Write(write_address_bus)                 ' address 160
	LDI        R27, 160
	MOV        R2, R27
	CALL       _Soft_I2C_Write+0
;libs/EEprom.mbas,47 :: 		Soft_I2C_Write(hi_)                        ' start from word at address (REG0)
	LDD        R2, Y+0
	CALL       _Soft_I2C_Write+0
;libs/EEprom.mbas,48 :: 		Soft_I2C_Write(lo_)                     ' write $80 to REG0. (pause counter + 0 sec)   ?? ??????? ????? ????? ?????
	LDD        R2, Y+1
	CALL       _Soft_I2C_Write+0
	POP        R4
;libs/EEprom.mbas,50 :: 		error=Soft_I2C_Write(data1)                ' write 0 to minutes word to (REG1)
	MOV        R2, R4
	CALL       _Soft_I2C_Write+0
;libs/EEprom.mbas,60 :: 		Soft_I2C_Stop()                          ' issue stop signal
	CALL       _Soft_I2C_Stop+0
;libs/EEprom.mbas,61 :: 		delay_ms(15)
	LDI        R17, 156
	LDI        R16, 215
L_libs/EEprom_Write_EEprom1:
	DEC        R16
	BRNE       L_libs/EEprom_Write_EEprom1
	DEC        R17
	BRNE       L_libs/EEprom_Write_EEprom1
	NOP
	NOP
;libs/EEprom.mbas,62 :: 		end sub
L_end_Write_EEprom:
	POP        R3
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of libs/EEprom_Write_EEprom

libs/EEprom_Read_EEprom:

;libs/EEprom.mbas,69 :: 		dim  device_address as char
;libs/EEprom.mbas,71 :: 		Soft_I2C_Start()                    ' Issue start signal
	PUSH       R2
	PUSH       R3
	PUSH       R3
	PUSH       R2
	CALL       _Soft_I2C_Start+0
;libs/EEprom.mbas,72 :: 		Soft_I2C_Write(write_address_bus)            ' Address DS1307, see 160 datasheet
	LDI        R27, 160
	MOV        R2, R27
	CALL       _Soft_I2C_Write+0
	POP        R2
	POP        R3
;libs/EEprom.mbas,75 :: 		lo_=lo(address_1)
; Lo_ start address is: 16 (R16)
	MOV        R16, R2
;libs/EEprom.mbas,76 :: 		Soft_I2C_Write(hi_)                   ' Start from address 0
	PUSH       R16
	MOV        R2, R3
	CALL       _Soft_I2C_Write+0
	POP        R16
;libs/EEprom.mbas,77 :: 		Soft_I2C_Write(lo_)                   ' Start from address 0
	MOV        R2, R16
; Lo_ end address is: 16 (R16)
	CALL       _Soft_I2C_Write+0
;libs/EEprom.mbas,78 :: 		Soft_I2C_Start()                    ' Issue repeated start signal
	CALL       _Soft_I2C_Start+0
;libs/EEprom.mbas,79 :: 		Soft_I2C_Write(read_address_bus)        ' Address 161 for reading R/W=1
	LDI        R27, 161
	MOV        R2, R27
	CALL       _Soft_I2C_Write+0
;libs/EEprom.mbas,81 :: 		EEprom_data_read = Soft_I2C_Read(0)      ' Read seconds byte
	CLR        R2
	CLR        R3
	CALL       _Soft_I2C_Read+0
	STS        _EEprom_data_read+0, R16
;libs/EEprom.mbas,84 :: 		Soft_I2C_Stop()   ' Issue stop signal
	CALL       _Soft_I2C_Stop+0
;libs/EEprom.mbas,85 :: 		delay_ms(15)
	LDI        R17, 156
	LDI        R16, 215
L_libs/EEprom_Read_EEprom4:
	DEC        R16
	BRNE       L_libs/EEprom_Read_EEprom4
	DEC        R17
	BRNE       L_libs/EEprom_Read_EEprom4
	NOP
	NOP
;libs/EEprom.mbas,86 :: 		end sub
L_end_Read_EEprom:
	POP        R3
	POP        R2
	RET
; end of libs/EEprom_Read_EEprom

libs/EEprom_eeprom_call_back_ext:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 4
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/EEprom.mbas,90 :: 		dim on_off22 as integer
;libs/EEprom.mbas,95 :: 		counter_ex=0
	PUSH       R2
	PUSH       R3
	LDI        R27, 0
	STS        _counter_ex+0, R27
	STS        _counter_ex+1, R27
;libs/EEprom.mbas,96 :: 		for week =2 to 2
	LDI        R27, 2
	STS        _week+0, R27
L_libs/EEprom_eeprom_call_back_ext8:
;libs/EEprom.mbas,97 :: 		for Pwm_chanel=1 to 7
	LDI        R27, 1
	STS        _Pwm_chanel+0, R27
L_libs/EEprom_eeprom_call_back_ext13:
;libs/EEprom.mbas,98 :: 		for chanel =1 to 4
	LDI        R27, 1
	STS        _chanel+0, R27
L_libs/EEprom_eeprom_call_back_ext18:
;libs/EEprom.mbas,99 :: 		for on_off22=1 to 2
	LDI        R27, 1
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
L_libs/EEprom_eeprom_call_back_ext23:
;libs/EEprom.mbas,101 :: 		Read_EEprom(1+counter_ex)
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 255
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       libs/EEprom_Read_EEprom+0
;libs/EEprom.mbas,102 :: 		on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][0]=  EEprom_data_read
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+2, R16
	STD        Y+3, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+2
	LDD        R19, Y+3
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LDS        R16, _EEprom_data_read+0
	ST         Z, R16
;libs/EEprom.mbas,103 :: 		Read_EEprom(2 + counter_ex)
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 254
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       libs/EEprom_Read_EEprom+0
;libs/EEprom.mbas,104 :: 		on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][1]=  EEprom_data_read
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+2, R16
	STD        Y+3, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+2
	LDD        R19, Y+3
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 1
	LDS        R16, _EEprom_data_read+0
	ST         Z, R16
;libs/EEprom.mbas,105 :: 		Read_EEprom(3 + counter_ex)
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 253
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       libs/EEprom_Read_EEprom+0
;libs/EEprom.mbas,106 :: 		on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][2]=  EEprom_data_read
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+2, R16
	STD        Y+3, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+2
	LDD        R19, Y+3
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 2
	LDS        R16, _EEprom_data_read+0
	ST         Z, R16
;libs/EEprom.mbas,107 :: 		Read_EEprom(4 + counter_ex)
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 252
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       libs/EEprom_Read_EEprom+0
;libs/EEprom.mbas,108 :: 		on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][3]=  EEprom_data_read
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+2, R16
	STD        Y+3, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+2
	LDD        R19, Y+3
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 3
	LDS        R16, _EEprom_data_read+0
	ST         Z, R16
;libs/EEprom.mbas,110 :: 		counter_ex=counter_ex+4
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 252
	SBCI       R17, 255
	STS        _counter_ex+0, R16
	STS        _counter_ex+1, R17
;libs/EEprom.mbas,112 :: 		next on_off22
	LDD        R16, Y+0
	LDD        R17, Y+1
	CPI        R17, 0
	BRNE       L_libs/EEprom_eeprom_call_back_ext186
	CPI        R16, 2
L_libs/EEprom_eeprom_call_back_ext186:
	BRNE       L_libs/EEprom_eeprom_call_back_ext187
	JMP        L_libs/EEprom_eeprom_call_back_ext26
L_libs/EEprom_eeprom_call_back_ext187:
	LDD        R16, Y+0
	LDD        R17, Y+1
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+0, R16
	STD        Y+1, R17
	JMP        L_libs/EEprom_eeprom_call_back_ext23
L_libs/EEprom_eeprom_call_back_ext26:
;libs/EEprom.mbas,113 :: 		next chanel
	LDS        R16, _chanel+0
	CPI        R16, 4
	BRNE       L_libs/EEprom_eeprom_call_back_ext188
	JMP        L_libs/EEprom_eeprom_call_back_ext21
L_libs/EEprom_eeprom_call_back_ext188:
	LDS        R16, _chanel+0
	SUBI       R16, 255
	STS        _chanel+0, R16
	JMP        L_libs/EEprom_eeprom_call_back_ext18
L_libs/EEprom_eeprom_call_back_ext21:
;libs/EEprom.mbas,114 :: 		next pwm_chanel
	LDS        R16, _Pwm_chanel+0
	CPI        R16, 7
	BRNE       L_libs/EEprom_eeprom_call_back_ext189
	JMP        L_libs/EEprom_eeprom_call_back_ext16
L_libs/EEprom_eeprom_call_back_ext189:
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 255
	STS        _Pwm_chanel+0, R16
	JMP        L_libs/EEprom_eeprom_call_back_ext13
L_libs/EEprom_eeprom_call_back_ext16:
;libs/EEprom.mbas,115 :: 		next week
	LDS        R16, _week+0
	CPI        R16, 2
	BRNE       L_libs/EEprom_eeprom_call_back_ext190
	JMP        L_libs/EEprom_eeprom_call_back_ext11
L_libs/EEprom_eeprom_call_back_ext190:
	LDS        R16, _week+0
	SUBI       R16, 255
	STS        _week+0, R16
	JMP        L_libs/EEprom_eeprom_call_back_ext8
L_libs/EEprom_eeprom_call_back_ext11:
;libs/EEprom.mbas,120 :: 		end sub
L_end_eeprom_call_back_ext:
	POP        R3
	POP        R2
	ADIW       R28, 3
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of libs/EEprom_eeprom_call_back_ext

_eeprom_save_ext:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 5
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/EEprom.mbas,124 :: 		dim on_off22 as byte
;libs/EEprom.mbas,129 :: 		counter_ex=0
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R27, 0
	STS        _counter_ex+0, R27
	STS        _counter_ex+1, R27
;libs/EEprom.mbas,130 :: 		for week =2 to 2
	LDI        R27, 2
	STS        _week+0, R27
L__eeprom_save_ext29:
;libs/EEprom.mbas,131 :: 		for Pwm_chanel=1 to 7
	LDI        R27, 1
	STS        _Pwm_chanel+0, R27
L__eeprom_save_ext34:
;libs/EEprom.mbas,132 :: 		for chanel =1 to 4
	LDI        R27, 1
	STS        _chanel+0, R27
L__eeprom_save_ext39:
;libs/EEprom.mbas,133 :: 		for on_off22=1 to 2
	LDI        R27, 1
	STD        Y+0, R27
L__eeprom_save_ext44:
;libs/EEprom.mbas,136 :: 		Write_EEprom(1 + counter_ex,on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][0] )
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+3, R16
	STD        Y+4, R17
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+1, R16
	STD        Y+2, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+1
	LDD        R19, Y+2
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R18, Z
	LDD        R16, Y+3
	LDD        R17, Y+4
	MOV        R4, R18
	MOVW       R2, R16
	CALL       libs/EEprom_Write_EEprom+0
;libs/EEprom.mbas,137 :: 		Write_EEprom(1 + counter_ex+1,on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][1] )
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 255
	SBCI       R17, 255
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+3, R16
	STD        Y+4, R17
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+1, R16
	STD        Y+2, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+1
	LDD        R19, Y+2
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 1
	LD         R18, Z
	LDD        R16, Y+3
	LDD        R17, Y+4
	MOV        R4, R18
	MOVW       R2, R16
	CALL       libs/EEprom_Write_EEprom+0
;libs/EEprom.mbas,138 :: 		Write_EEprom(1 + counter_ex+2,on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][2] )
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 255
	SBCI       R17, 255
	SUBI       R16, 254
	SBCI       R17, 255
	STD        Y+3, R16
	STD        Y+4, R17
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+1, R16
	STD        Y+2, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+1
	LDD        R19, Y+2
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 2
	LD         R18, Z
	LDD        R16, Y+3
	LDD        R17, Y+4
	MOV        R4, R18
	MOVW       R2, R16
	CALL       libs/EEprom_Write_EEprom+0
;libs/EEprom.mbas,139 :: 		Write_EEprom(1 + counter_ex+3,on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][3] )
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 255
	SBCI       R17, 255
	SUBI       R16, 253
	SBCI       R17, 255
	STD        Y+3, R16
	STD        Y+4, R17
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+1, R16
	STD        Y+2, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+1
	LDD        R19, Y+2
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R18, Z
	LDD        R16, Y+3
	LDD        R17, Y+4
	MOV        R4, R18
	MOVW       R2, R16
	CALL       libs/EEprom_Write_EEprom+0
;libs/EEprom.mbas,140 :: 		counter_ex=counter_ex+4
	LDS        R16, _counter_ex+0
	LDS        R17, _counter_ex+1
	SUBI       R16, 252
	SBCI       R17, 255
	STS        _counter_ex+0, R16
	STS        _counter_ex+1, R17
;libs/EEprom.mbas,144 :: 		next on_off22
	LDD        R16, Y+0
	CPI        R16, 2
	BRNE       L__eeprom_save_ext192
	JMP        L__eeprom_save_ext47
L__eeprom_save_ext192:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L__eeprom_save_ext44
L__eeprom_save_ext47:
;libs/EEprom.mbas,145 :: 		next chanel
	LDS        R16, _chanel+0
	CPI        R16, 4
	BRNE       L__eeprom_save_ext193
	JMP        L__eeprom_save_ext42
L__eeprom_save_ext193:
	LDS        R16, _chanel+0
	SUBI       R16, 255
	STS        _chanel+0, R16
	JMP        L__eeprom_save_ext39
L__eeprom_save_ext42:
;libs/EEprom.mbas,146 :: 		next pwm_chanel
	LDS        R16, _Pwm_chanel+0
	CPI        R16, 7
	BRNE       L__eeprom_save_ext194
	JMP        L__eeprom_save_ext37
L__eeprom_save_ext194:
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 255
	STS        _Pwm_chanel+0, R16
	JMP        L__eeprom_save_ext34
L__eeprom_save_ext37:
;libs/EEprom.mbas,147 :: 		next week
	LDS        R16, _week+0
	CPI        R16, 2
	BRNE       L__eeprom_save_ext195
	JMP        L__eeprom_save_ext32
L__eeprom_save_ext195:
	LDS        R16, _week+0
	SUBI       R16, 255
	STS        _week+0, R16
	JMP        L__eeprom_save_ext29
L__eeprom_save_ext32:
;libs/EEprom.mbas,152 :: 		end sub
L_end_eeprom_save_ext:
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 4
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _eeprom_save_ext

libs/EEprom_eeprom_call_back:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 7
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/EEprom.mbas,162 :: 		week_int as byte
;libs/EEprom.mbas,166 :: 		counter=0
	PUSH       R2
	PUSH       R3
	LDI        R27, 0
	STS        _counter+0, R27
	STS        _counter+1, R27
;libs/EEprom.mbas,167 :: 		for week_int =1 to 7
	LDI        R27, 1
	STD        Y+2, R27
L_libs/EEprom_eeprom_call_back50:
;libs/EEprom.mbas,168 :: 		for Pwm_chanel=1 to 7
	LDI        R27, 1
	STS        _Pwm_chanel+0, R27
L_libs/EEprom_eeprom_call_back55:
;libs/EEprom.mbas,169 :: 		for chanel =1 to 4
	LDI        R27, 1
	STS        _chanel+0, R27
L_libs/EEprom_eeprom_call_back60:
;libs/EEprom.mbas,170 :: 		for on_off22=1 to 2
	LDI        R27, 1
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
L_libs/EEprom_eeprom_call_back65:
;libs/EEprom.mbas,172 :: 		on_a_0 [week_int-1][chanel-1][pwm_chanel-1][on_off22-1][0]=  EEPROM_read(0x01 + counter)
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+5, R16
	STD        Y+6, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+5
	LDD        R19, Y+6
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	STD        Y+5, R16
	STD        Y+6, R17
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 255
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       _EEPROM_Read+0
	LDD        R17, Y+5
	LDD        R18, Y+6
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;libs/EEprom.mbas,173 :: 		on_a_0 [week_int-1][chanel-1][pwm_chanel-1][on_off22-1][1]=  EEPROM_read(0x02 + counter)
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+5, R16
	STD        Y+6, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+5
	LDD        R19, Y+6
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+5, R16
	STD        Y+6, R17
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 254
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       _EEPROM_Read+0
	LDD        R17, Y+5
	LDD        R18, Y+6
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;libs/EEprom.mbas,174 :: 		on_a_0 [week_int-1][chanel-1][pwm_chanel-1][on_off22-1][2]=  EEPROM_read(0x03 + counter)
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+5, R16
	STD        Y+6, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+5
	LDD        R19, Y+6
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	SUBI       R16, 254
	SBCI       R17, 255
	STD        Y+5, R16
	STD        Y+6, R17
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 253
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       _EEPROM_Read+0
	LDD        R17, Y+5
	LDD        R18, Y+6
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;libs/EEprom.mbas,175 :: 		on_a_0 [week_int-1][chanel-1][pwm_chanel-1][on_off22-1][3]=  EEPROM_read(0x04 + counter)
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+5, R16
	STD        Y+6, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+5
	LDD        R19, Y+6
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	SUBI       R16, 253
	SBCI       R17, 255
	STD        Y+5, R16
	STD        Y+6, R17
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 252
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       _EEPROM_Read+0
	LDD        R17, Y+5
	LDD        R18, Y+6
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;libs/EEprom.mbas,177 :: 		counter=counter+4
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 252
	SBCI       R17, 255
	STS        _counter+0, R16
	STS        _counter+1, R17
;libs/EEprom.mbas,179 :: 		next on_off2
	LDD        R16, Y+0
	LDD        R17, Y+1
	CPI        R17, 0
	BRNE       L_libs/EEprom_eeprom_call_back197
	CPI        R16, 2
L_libs/EEprom_eeprom_call_back197:
	BRNE       L_libs/EEprom_eeprom_call_back198
	JMP        L_libs/EEprom_eeprom_call_back68
L_libs/EEprom_eeprom_call_back198:
	LDD        R16, Y+0
	LDD        R17, Y+1
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+0, R16
	STD        Y+1, R17
	JMP        L_libs/EEprom_eeprom_call_back65
L_libs/EEprom_eeprom_call_back68:
;libs/EEprom.mbas,180 :: 		next chanel
	LDS        R16, _chanel+0
	CPI        R16, 4
	BRNE       L_libs/EEprom_eeprom_call_back199
	JMP        L_libs/EEprom_eeprom_call_back63
L_libs/EEprom_eeprom_call_back199:
	LDS        R16, _chanel+0
	SUBI       R16, 255
	STS        _chanel+0, R16
	JMP        L_libs/EEprom_eeprom_call_back60
L_libs/EEprom_eeprom_call_back63:
;libs/EEprom.mbas,181 :: 		next pwm_chanel
	LDS        R16, _Pwm_chanel+0
	CPI        R16, 7
	BRNE       L_libs/EEprom_eeprom_call_back200
	JMP        L_libs/EEprom_eeprom_call_back58
L_libs/EEprom_eeprom_call_back200:
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 255
	STS        _Pwm_chanel+0, R16
	JMP        L_libs/EEprom_eeprom_call_back55
L_libs/EEprom_eeprom_call_back58:
;libs/EEprom.mbas,182 :: 		next week_int
	LDD        R16, Y+2
	CPI        R16, 7
	BRNE       L_libs/EEprom_eeprom_call_back201
	JMP        L_libs/EEprom_eeprom_call_back53
L_libs/EEprom_eeprom_call_back201:
	LDD        R16, Y+2
	SUBI       R16, 255
	STD        Y+2, R16
	JMP        L_libs/EEprom_eeprom_call_back50
L_libs/EEprom_eeprom_call_back53:
;libs/EEprom.mbas,187 :: 		end sub
L_end_eeprom_call_back:
	POP        R3
	POP        R2
	ADIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of libs/EEprom_eeprom_call_back

_eeprom_save:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 11
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/EEprom.mbas,192 :: 		week_int as byte
;libs/EEprom.mbas,196 :: 		counter=0
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R27, 0
	STS        _counter+0, R27
	STS        _counter+1, R27
;libs/EEprom.mbas,197 :: 		for week_int =1 to 7
	LDI        R27, 1
	STD        Y+2, R27
L__eeprom_save71:
;libs/EEprom.mbas,198 :: 		for Pwm_chanel=1 to 7
	LDI        R27, 1
	STS        _Pwm_chanel+0, R27
L__eeprom_save76:
;libs/EEprom.mbas,199 :: 		for chanel =1 to 4
	LDI        R27, 1
	STS        _chanel+0, R27
L__eeprom_save81:
;libs/EEprom.mbas,200 :: 		for on_off22=1 to 2
	LDI        R27, 1
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
L__eeprom_save86:
;libs/EEprom.mbas,203 :: 		EEPROM_Write(0x01 + counter,on_a_0 [week_int-1][chanel-1][pwm_chanel-1][on_off22-1][0] )
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+9, R16
	STD        Y+10, R17
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+7, R16
	STD        Y+8, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+7
	LDD        R19, Y+8
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R18, Z
	LDD        R16, Y+9
	LDD        R17, Y+10
	MOV        R4, R18
	MOVW       R2, R16
	CALL       _EEPROM_Write+0
;libs/EEprom.mbas,204 :: 		EEPROM_Write(0x01 + counter+1,on_a_0 [week_int-1][chanel-1][pwm_chanel-1][on_off22-1][1] )
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 255
	SBCI       R17, 255
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+9, R16
	STD        Y+10, R17
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+7, R16
	STD        Y+8, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+7
	LDD        R19, Y+8
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 1
	LD         R18, Z
	LDD        R16, Y+9
	LDD        R17, Y+10
	MOV        R4, R18
	MOVW       R2, R16
	CALL       _EEPROM_Write+0
;libs/EEprom.mbas,205 :: 		EEPROM_Write(0x01 + counter+2,on_a_0 [week_int-1][chanel-1][pwm_chanel-1][on_off22-1][2] )
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 255
	SBCI       R17, 255
	SUBI       R16, 254
	SBCI       R17, 255
	STD        Y+9, R16
	STD        Y+10, R17
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+7, R16
	STD        Y+8, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+7
	LDD        R19, Y+8
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 2
	LD         R18, Z
	LDD        R16, Y+9
	LDD        R17, Y+10
	MOV        R4, R18
	MOVW       R2, R16
	CALL       _EEPROM_Write+0
;libs/EEprom.mbas,206 :: 		EEPROM_Write(0x01 + counter+3,on_a_0 [week_int-1][chanel-1][pwm_chanel-1][on_off22-1][3] )
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 255
	SBCI       R17, 255
	SUBI       R16, 253
	SBCI       R17, 255
	STD        Y+9, R16
	STD        Y+10, R17
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+7, R16
	STD        Y+8, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+7
	LDD        R19, Y+8
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R18, Z
	LDD        R16, Y+9
	LDD        R17, Y+10
	MOV        R4, R18
	MOVW       R2, R16
	CALL       _EEPROM_Write+0
;libs/EEprom.mbas,207 :: 		counter=counter+4
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 252
	SBCI       R17, 255
	STS        _counter+0, R16
	STS        _counter+1, R17
;libs/EEprom.mbas,209 :: 		next on_off2
	LDD        R16, Y+0
	LDD        R17, Y+1
	CPI        R17, 0
	BRNE       L__eeprom_save203
	CPI        R16, 2
L__eeprom_save203:
	BRNE       L__eeprom_save204
	JMP        L__eeprom_save89
L__eeprom_save204:
	LDD        R16, Y+0
	LDD        R17, Y+1
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+0, R16
	STD        Y+1, R17
	JMP        L__eeprom_save86
L__eeprom_save89:
;libs/EEprom.mbas,210 :: 		next chanel
	LDS        R16, _chanel+0
	CPI        R16, 4
	BRNE       L__eeprom_save205
	JMP        L__eeprom_save84
L__eeprom_save205:
	LDS        R16, _chanel+0
	SUBI       R16, 255
	STS        _chanel+0, R16
	JMP        L__eeprom_save81
L__eeprom_save84:
;libs/EEprom.mbas,211 :: 		next pwm_chanel
	LDS        R16, _Pwm_chanel+0
	CPI        R16, 7
	BRNE       L__eeprom_save206
	JMP        L__eeprom_save79
L__eeprom_save206:
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 255
	STS        _Pwm_chanel+0, R16
	JMP        L__eeprom_save76
L__eeprom_save79:
;libs/EEprom.mbas,212 :: 		next week_int
	LDD        R16, Y+2
	CPI        R16, 7
	BRNE       L__eeprom_save207
	JMP        L__eeprom_save74
L__eeprom_save207:
	LDD        R16, Y+2
	SUBI       R16, 255
	STD        Y+2, R16
	JMP        L__eeprom_save71
L__eeprom_save74:
;libs/EEprom.mbas,217 :: 		end sub
L_end_eeprom_save:
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 10
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _eeprom_save

libs/EEprom_eeprom:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 28
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/EEprom.mbas,221 :: 		txt_sub as string[4]
;libs/EEprom.mbas,222 :: 		Lcd_0()
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	CALL       _Lcd_0+0
;libs/EEprom.mbas,225 :: 		ByteToStr(EEPROM_Read(0x00), txt)
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	MOV        R2, R16
	CALL       _ByteToStr+0
;libs/EEprom.mbas,227 :: 		Lcd_Out(2,1,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,228 :: 		Delay_ms(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_libs/EEprom_eeprom91:
	DEC        R16
	BRNE       L_libs/EEprom_eeprom91
	DEC        R17
	BRNE       L_libs/EEprom_eeprom91
	DEC        R18
	BRNE       L_libs/EEprom_eeprom91
;libs/EEprom.mbas,229 :: 		if  (EEPROM_Read(0x00)=122)   then
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	CPI        R16, 122
	BREQ       L_libs/EEprom_eeprom209
	JMP        L_libs/EEprom_eeprom94
L_libs/EEprom_eeprom209:
;libs/EEprom.mbas,230 :: 		Lcd_Out(1,1,"EEprom  writed befor" )
	MOVW       R30, R28
	ADIW       R30, 3
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 98
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 102
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	SUBI       R16, 253
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,231 :: 		ByteToStr(EEPROM_Read(0x00), txt)
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	MOV        R2, R16
	CALL       _ByteToStr+0
;libs/EEprom.mbas,233 :: 		Lcd_Out(2,1,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_libs/EEprom_eeprom95
;libs/EEprom.mbas,234 :: 		else
L_libs/EEprom_eeprom94:
;libs/EEprom.mbas,237 :: 		Lcd_Out(1,1,"not writed" )
	MOVW       R30, R28
	ADIW       R30, 3
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	SUBI       R16, 253
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,239 :: 		end if
L_libs/EEprom_eeprom95:
;libs/EEprom.mbas,240 :: 		Delay_ms(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_libs/EEprom_eeprom96:
	DEC        R16
	BRNE       L_libs/EEprom_eeprom96
	DEC        R17
	BRNE       L_libs/EEprom_eeprom96
	DEC        R18
	BRNE       L_libs/EEprom_eeprom96
;libs/EEprom.mbas,243 :: 		on_off22=1
	LDI        R27, 1
	STD        Y+2, R27
;libs/EEprom.mbas,244 :: 		for chanel =1 to 4
	LDI        R27, 1
	STS        _chanel+0, R27
L_libs/EEprom_eeprom99:
;libs/EEprom.mbas,245 :: 		on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][0] =chanel
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+26, R16
	STD        Y+27, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+26
	LDD        R19, Y+27
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LDS        R16, _chanel+0
	ST         Z, R16
;libs/EEprom.mbas,247 :: 		tt=on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off22-1][0]
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+26, R16
	STD        Y+27, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+26
	LDD        R19, Y+27
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+2
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	STD        Y+1, R16
;libs/EEprom.mbas,254 :: 		for counter = 1 to 4                          ' Fill data buffer
	LDI        R27, 1
	STD        Y+0, R27
L_libs/EEprom_eeprom104:
;libs/EEprom.mbas,255 :: 		EEPROM_Write(0x00 + counter,tt )        ' Write data to address 0x100+counter
	LDD        R16, Y+0
	LDI        R17, 0
	LDD        R4, Y+1
	MOVW       R2, R16
	CALL       _EEPROM_Write+0
;libs/EEprom.mbas,256 :: 		next counter
	LDD        R16, Y+0
	CPI        R16, 4
	BRNE       L_libs/EEprom_eeprom210
	JMP        L_libs/EEprom_eeprom107
L_libs/EEprom_eeprom210:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L_libs/EEprom_eeprom104
L_libs/EEprom_eeprom107:
;libs/EEprom.mbas,257 :: 		Delay_ms(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_libs/EEprom_eeprom108:
	DEC        R16
	BRNE       L_libs/EEprom_eeprom108
	DEC        R17
	BRNE       L_libs/EEprom_eeprom108
	DEC        R18
	BRNE       L_libs/EEprom_eeprom108
;libs/EEprom.mbas,260 :: 		if (EEPROM_Read(0x00) ) then
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	TST        R16
	BRNE       L_libs/EEprom_eeprom211
	JMP        L_libs/EEprom_eeprom111
L_libs/EEprom_eeprom211:
;libs/EEprom.mbas,262 :: 		for counter = 1 to  4
	LDI        R27, 1
	STD        Y+0, R27
L_libs/EEprom_eeprom114:
;libs/EEprom.mbas,264 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,265 :: 		ByteToStr(EEPROM_Read(0x100+counter), txt)
	LDD        R16, Y+0
	LDI        R17, 0
	SUBI       R16, 0
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       _EEPROM_Read+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	MOV        R2, R16
	CALL       _ByteToStr+0
;libs/EEprom.mbas,266 :: 		Lcd_Out(1,1,"EEprom" )
	MOVW       R30, R28
	ADIW       R30, 3
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	SUBI       R16, 253
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,267 :: 		Lcd_Out(2,1,txt )                 ' Write text in first row
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,271 :: 		Delay_ms(50)
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_libs/EEprom_eeprom118:
	DEC        R16
	BRNE       L_libs/EEprom_eeprom118
	DEC        R17
	BRNE       L_libs/EEprom_eeprom118
	DEC        R18
	BRNE       L_libs/EEprom_eeprom118
;libs/EEprom.mbas,272 :: 		next counter
	LDD        R16, Y+0
	CPI        R16, 4
	BRNE       L_libs/EEprom_eeprom212
	JMP        L_libs/EEprom_eeprom117
L_libs/EEprom_eeprom212:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L_libs/EEprom_eeprom114
L_libs/EEprom_eeprom117:
L_libs/EEprom_eeprom111:
;libs/EEprom.mbas,274 :: 		next  chanel
	LDS        R16, _chanel+0
	CPI        R16, 4
	BRNE       L_libs/EEprom_eeprom213
	JMP        L_libs/EEprom_eeprom102
L_libs/EEprom_eeprom213:
	LDS        R16, _chanel+0
	SUBI       R16, 255
	STS        _chanel+0, R16
	JMP        L_libs/EEprom_eeprom99
L_libs/EEprom_eeprom102:
;libs/EEprom.mbas,276 :: 		end sub
L_end_eeprom:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 27
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of libs/EEprom_eeprom

_ext_twi_eeprom_ini:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 26
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/EEprom.mbas,281 :: 		sub procedure ext_twi_eeprom_ini()
;libs/EEprom.mbas,284 :: 		EEprom_data_read=0
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	LDI        R27, 0
	STS        _EEprom_data_read+0, R27
;libs/EEprom.mbas,285 :: 		Read_eeprom_ext_TWI(1)
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Read_eeprom_ext_TWI+0
;libs/EEprom.mbas,288 :: 		if  (EEprom_data_read=10)   then
	LDS        R16, _EEprom_data_read+0
	CPI        R16, 10
	BREQ       L__ext_twi_eeprom_ini215
	JMP        L__ext_twi_eeprom_ini122
L__ext_twi_eeprom_ini215:
;libs/EEprom.mbas,289 :: 		Lcd_0() Lcd_Out(1,1,"TWI EEPROM" ) Lcd_Out(2,1,"is working" )
	CALL       _Lcd_0+0
	MOVW       R30, R28
	LDI        R27, 84
	ST         Z+, R27
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	MOVW       R30, R28
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 107
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,290 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini124:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini124
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini124
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini124
	NOP
;libs/EEprom.mbas,291 :: 		ByteToStr(EEprom_data_read,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/EEprom.mbas,292 :: 		Lcd_Out(1,1,"EEprommmmmmmmmm" )
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,293 :: 		Lcd_Out(2,1,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L__ext_twi_eeprom_ini123
;libs/EEprom.mbas,294 :: 		else
L__ext_twi_eeprom_ini122:
;libs/EEprom.mbas,295 :: 		Lcd_0() Lcd_Out(1,1,"TWI EEPROM" ) Lcd_Out(2,1,"is Not working")
	CALL       _Lcd_0+0
	MOVW       R30, R28
	LDI        R27, 84
	ST         Z+, R27
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	MOVW       R30, R28
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 78
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 107
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,296 :: 		bytetostr(EEprom_data_read,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/EEprom.mbas,297 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,298 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini126:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini126
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini126
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini126
	NOP
;libs/EEprom.mbas,299 :: 		Lcd_Out(1,1,"0 EEPROM is:" )Lcd_Out(2,1,txt )
	MOVW       R30, R28
	LDI        R27, 48
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 58
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,300 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini128:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini128
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini128
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini128
	NOP
;libs/EEprom.mbas,301 :: 		end if
L__ext_twi_eeprom_ini123:
;libs/EEprom.mbas,302 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,304 :: 		EEprom_data_read=0
	LDI        R27, 0
	STS        _EEprom_data_read+0, R27
;libs/EEprom.mbas,305 :: 		Read_eeprom_ext_TWI(1)
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Read_eeprom_ext_TWI+0
;libs/EEprom.mbas,308 :: 		if  (EEprom_data_read =10)   then
	LDS        R16, _EEprom_data_read+0
	CPI        R16, 10
	BREQ       L__ext_twi_eeprom_ini216
	JMP        L__ext_twi_eeprom_ini131
L__ext_twi_eeprom_ini216:
;libs/EEprom.mbas,309 :: 		Lcd_Out(1,1,"ext EEp writed befor" )
	MOVW       R30, R28
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 98
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 102
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,310 :: 		ByteToStr(EEprom_data_read, txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/EEprom.mbas,312 :: 		Lcd_Out(2,1,txt )   delay_ms(500)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini133:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini133
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini133
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini133
	NOP
;libs/EEprom.mbas,313 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,314 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,315 :: 		Lcd_Out(1,1,"Reading EEPROM " )
	MOVW       R30, R28
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,316 :: 		Lcd_Out(2,1," ..." )
	MOVW       R30, R28
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,317 :: 		eeprom_call_back_ext_twi()
	CALL       _eeprom_call_back_ext_twi+0
;libs/EEprom.mbas,326 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini135:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini135
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini135
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini135
	NOP
	JMP        L__ext_twi_eeprom_ini132
;libs/EEprom.mbas,329 :: 		else
L__ext_twi_eeprom_ini131:
;libs/EEprom.mbas,331 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,332 :: 		Lcd_Out(1,1,"ext not writed111111111" )
	MOVW       R30, R28
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,333 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini137:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini137
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini137
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini137
	NOP
;libs/EEprom.mbas,334 :: 		on_off_initial (1,1,0,0,17)    '' On mode on_off initial (dim on_off22,en,hr,mint,prc as integer)
	LDI        R27, 17
	MOV        R6, R27
	CLR        R5
	CLR        R4
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _on_off_initial+0
;libs/EEprom.mbas,335 :: 		on_off_initial (2,1,0,0,17)    '''OFF mode
	LDI        R27, 17
	MOV        R6, R27
	CLR        R5
	CLR        R4
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _on_off_initial+0
;libs/EEprom.mbas,337 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,338 :: 		Lcd_Out(1,1,"Wrting to EEPROM ..." )
	MOVW       R30, R28
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,340 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,341 :: 		Lcd_Out(1,1,"Wrting to EEPROM " ) Lcd_Out(2,1,"..." )
	MOVW       R30, R28
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	LDI        R27, 46
	STD        Y+0, R27
	LDI        R27, 46
	STD        Y+1, R27
	LDI        R27, 46
	STD        Y+2, R27
	LDI        R27, 0
	STD        Y+3, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,344 :: 		write_eeprom_ext_TWI(1 ,10 )
	LDI        R27, 10
	MOV        R4, R27
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _write_eeprom_ext_TWI+0
;libs/EEprom.mbas,345 :: 		eeprom_save_ext_twi()
	CALL       _eeprom_save_ext_twi+0
;libs/EEprom.mbas,348 :: 		Lcd_Out(1,1,"writing ext eeprom" )
	MOVW       R30, R28
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,349 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,350 :: 		Pwm_chanel=1   chanel=1        on_off2=1
	LDI        R27, 1
	STS        _Pwm_chanel+0, R27
	LDI        R27, 1
	STS        _chanel+0, R27
	LDI        R27, 1
	STS        _on_off2+0, R27
;libs/EEprom.mbas,351 :: 		week=7
	LDI        R27, 7
	STS        _week+0, R27
;libs/EEprom.mbas,352 :: 		ByteToStr(on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off2-1][3],txt)
	LDI        R18, 64
	LDI        R19, 5
	LDI        R16, #lo_addr(_on_a_0+0)
	LDI        R17, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R16, Z
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	MOV        R2, R16
	CALL       _ByteToStr+0
;libs/EEprom.mbas,353 :: 		Lcd_Out(1,1,"on_a_0" )
	MOVW       R30, R28
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 48
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,354 :: 		Lcd_Out(2,1,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,355 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini139:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini139
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini139
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini139
	NOP
;libs/EEprom.mbas,357 :: 		end if
L__ext_twi_eeprom_ini132:
;libs/EEprom.mbas,358 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini141:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini141
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini141
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini141
	NOP
;libs/EEprom.mbas,359 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,360 :: 		Pwm_chanel=1   chanel=1      on_off2=1
	LDI        R27, 1
	STS        _Pwm_chanel+0, R27
	LDI        R27, 1
	STS        _chanel+0, R27
	LDI        R27, 1
	STS        _on_off2+0, R27
;libs/EEprom.mbas,361 :: 		week=7
	LDI        R27, 7
	STS        _week+0, R27
;libs/EEprom.mbas,362 :: 		ByteToStr(on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off2-1][0],txt)
	LDI        R18, 64
	LDI        R19, 5
	LDI        R16, #lo_addr(_on_a_0+0)
	LDI        R17, hi_addr(_on_a_0+0)
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LD         R16, Z
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	MOV        R2, R16
	CALL       _ByteToStr+0
;libs/EEprom.mbas,363 :: 		Lcd_Out(1,1,"on_a_0" )
	MOVW       R30, R28
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 48
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,364 :: 		Lcd_Out(2,1,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,365 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini143:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini143
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini143
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini143
	NOP
;libs/EEprom.mbas,366 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,368 :: 		ByteToStr(on_a_0 [week-1][chanel-1][pwm_chanel-1][on_off2-1][3],txt)
	LDS        R16, _week+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+24, R16
	STD        Y+25, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+24
	LDD        R19, Y+25
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R18, R16
	ADC        R19, R17
	LDS        R16, _on_off2+0
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R16, Z
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	MOV        R2, R16
	CALL       _ByteToStr+0
;libs/EEprom.mbas,369 :: 		Lcd_Out(1,1,"precrntage" )
	MOVW       R30, R28
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 99
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,370 :: 		Lcd_Out(2,1,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,371 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini145:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini145
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini145
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini145
	NOP
;libs/EEprom.mbas,372 :: 		EEprom_data_read=0
	LDI        R27, 0
	STS        _EEprom_data_read+0, R27
;libs/EEprom.mbas,373 :: 		Read_eeprom_ext_TWI(1)
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Read_eeprom_ext_TWI+0
;libs/EEprom.mbas,376 :: 		if  (EEprom_data_read=10)   then
	LDS        R16, _EEprom_data_read+0
	CPI        R16, 10
	BREQ       L__ext_twi_eeprom_ini217
	JMP        L__ext_twi_eeprom_ini148
L__ext_twi_eeprom_ini217:
;libs/EEprom.mbas,377 :: 		Lcd_0() Lcd_Out(1,1,"TWI EEPROM" ) Lcd_Out(2,1,"is working" )
	CALL       _Lcd_0+0
	MOVW       R30, R28
	LDI        R27, 84
	ST         Z+, R27
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	MOVW       R30, R28
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 107
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,378 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini150:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini150
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini150
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini150
	NOP
;libs/EEprom.mbas,379 :: 		ByteToStr(EEprom_data_read,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/EEprom.mbas,380 :: 		Lcd_Out(1,1,"EEprommmmmmmmmm" )
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,381 :: 		Lcd_Out(2,1,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L__ext_twi_eeprom_ini149
;libs/EEprom.mbas,382 :: 		else
L__ext_twi_eeprom_ini148:
;libs/EEprom.mbas,383 :: 		Lcd_0() Lcd_Out(1,1,"TWI EEPROM" ) Lcd_Out(2,1,"is Not working")
	CALL       _Lcd_0+0
	MOVW       R30, R28
	LDI        R27, 84
	ST         Z+, R27
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	MOVW       R30, R28
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 78
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 107
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,384 :: 		bytetostr(EEprom_data_read,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/EEprom.mbas,385 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,386 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini152:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini152
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini152
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini152
	NOP
;libs/EEprom.mbas,387 :: 		Lcd_Out(1,1,"0 EEPROM is:" )Lcd_Out(2,1,txt )
	MOVW       R30, R28
	LDI        R27, 48
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 58
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,388 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini154:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini154
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini154
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini154
	NOP
;libs/EEprom.mbas,390 :: 		end if
L__ext_twi_eeprom_ini149:
;libs/EEprom.mbas,391 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__ext_twi_eeprom_ini156:
	DEC        R16
	BRNE       L__ext_twi_eeprom_ini156
	DEC        R17
	BRNE       L__ext_twi_eeprom_ini156
	DEC        R18
	BRNE       L__ext_twi_eeprom_ini156
	NOP
;libs/EEprom.mbas,392 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,393 :: 		end sub
L_end_ext_twi_eeprom_ini:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 25
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _ext_twi_eeprom_ini

_int_eeprom_ini:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 21
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/EEprom.mbas,398 :: 		sub procedure int_eeprom_ini()     ''internal eeprm of avr
;libs/EEprom.mbas,400 :: 		Lcd_0()
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	CALL       _Lcd_0+0
;libs/EEprom.mbas,401 :: 		Lcd_Out(1,1,"EEprom  :" )
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 58
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,405 :: 		if  (EEPROM_Read(0x00)=12)   then
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	CPI        R16, 12
	BREQ       L__int_eeprom_ini219
	JMP        L__int_eeprom_ini160
L__int_eeprom_ini219:
;libs/EEprom.mbas,406 :: 		Lcd_0() Lcd_Out(1,1,"Reading from " ) Lcd_Out(2,1,"EEprom ..." )
	CALL       _Lcd_0+0
	MOVW       R30, R28
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 102
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,407 :: 		eeprom_call_back()
	CALL       libs/EEprom_eeprom_call_back+0
;libs/EEprom.mbas,408 :: 		Lcd_Out(1,1,"EEprom  writed befor" )
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 98
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 102
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,409 :: 		ByteToStr(EEPROM_Read(0x00), txt)
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	MOV        R2, R16
	CALL       _ByteToStr+0
;libs/EEprom.mbas,411 :: 		Lcd_Out(2,1,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L__int_eeprom_ini161
;libs/EEprom.mbas,412 :: 		else
L__int_eeprom_ini160:
;libs/EEprom.mbas,413 :: 		EEPROM_Write(0x00 ,12 )
	LDI        R27, 12
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;libs/EEprom.mbas,414 :: 		on_off_initial (1,1,0,0,14)    '' off mode on_off initial (dim on_off22,en,hr,mint,prc as integer)
	LDI        R27, 14
	MOV        R6, R27
	CLR        R5
	CLR        R4
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _on_off_initial+0
;libs/EEprom.mbas,415 :: 		on_off_initial (2,1,0,0,14)    '''on mode
	LDI        R27, 14
	MOV        R6, R27
	CLR        R5
	CLR        R4
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _on_off_initial+0
;libs/EEprom.mbas,416 :: 		Lcd_0() Lcd_Out(1,1,"Writing to  " ) Lcd_Out(2,1,"EEprom ..." )
	CALL       _Lcd_0+0
	MOVW       R30, R28
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,417 :: 		eeprom_save()
	CALL       _eeprom_save+0
;libs/EEprom.mbas,419 :: 		Lcd_Out(1,1,"not writed" )
	MOVW       R30, R28
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,422 :: 		end if
L__int_eeprom_ini161:
;libs/EEprom.mbas,423 :: 		Delay_mS(1500)
	LDI        R18, 61
	LDI        R17, 225
	LDI        R16, 64
L__int_eeprom_ini162:
	DEC        R16
	BRNE       L__int_eeprom_ini162
	DEC        R17
	BRNE       L__int_eeprom_ini162
	DEC        R18
	BRNE       L__int_eeprom_ini162
	NOP
	NOP
;libs/EEprom.mbas,424 :: 		end sub
L_end_int_eeprom_ini:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 20
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _int_eeprom_ini

libs/EEprom_ext_eeprom_ini:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 24
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/EEprom.mbas,427 :: 		sub procedure ext_eeprom_ini()
;libs/EEprom.mbas,430 :: 		Lcd_0()
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	CALL       _Lcd_0+0
;libs/EEprom.mbas,432 :: 		EEprom_data_read=0
	LDI        R27, 0
	STS        _EEprom_data_read+0, R27
;libs/EEprom.mbas,433 :: 		Read_EEprom(0)
	CLR        R2
	CLR        R3
	CALL       libs/EEprom_Read_EEprom+0
;libs/EEprom.mbas,434 :: 		if  (EEprom_data_read =12)   then
	LDS        R16, _EEprom_data_read+0
	CPI        R16, 12
	BREQ       L_libs/EEprom_ext_eeprom_ini221
	JMP        L_libs/EEprom_ext_eeprom_ini166
L_libs/EEprom_ext_eeprom_ini221:
;libs/EEprom.mbas,435 :: 		Lcd_Out(1,1,"ext EEprom writed befor" )
	MOVW       R30, R28
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 98
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 102
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,436 :: 		ByteToStr(EEprom_data_read, txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/EEprom.mbas,438 :: 		Lcd_Out(2,1,txt )   delay_ms(1500)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	LDI        R18, 61
	LDI        R17, 225
	LDI        R16, 64
L_libs/EEprom_ext_eeprom_ini168:
	DEC        R16
	BRNE       L_libs/EEprom_ext_eeprom_ini168
	DEC        R17
	BRNE       L_libs/EEprom_ext_eeprom_ini168
	DEC        R18
	BRNE       L_libs/EEprom_ext_eeprom_ini168
	NOP
	NOP
;libs/EEprom.mbas,439 :: 		Lcd_0()    Lcd_Out(1,1,"Reading from " )    Lcd_Out(2,1,"EEPROM ... " )
	CALL       _Lcd_0+0
	MOVW       R30, R28
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 102
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,440 :: 		eeprom_call_back_ext()
	CALL       libs/EEprom_eeprom_call_back_ext+0
;libs/EEprom.mbas,441 :: 		EEprom_data_read=0
	LDI        R27, 0
	STS        _EEprom_data_read+0, R27
;libs/EEprom.mbas,442 :: 		Read_EEprom(0x04)
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       libs/EEprom_Read_EEprom+0
;libs/EEprom.mbas,443 :: 		ByteToStr(EEprom_data_read, txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/EEprom.mbas,445 :: 		Lcd_Out(1,1,"EEprom-ext 04" )
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 45
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 48
	ST         Z+, R27
	LDI        R27, 52
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,446 :: 		Lcd_Out(2,1,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,447 :: 		delay_ms(1500)
	LDI        R18, 61
	LDI        R17, 225
	LDI        R16, 64
L_libs/EEprom_ext_eeprom_ini170:
	DEC        R16
	BRNE       L_libs/EEprom_ext_eeprom_ini170
	DEC        R17
	BRNE       L_libs/EEprom_ext_eeprom_ini170
	DEC        R18
	BRNE       L_libs/EEprom_ext_eeprom_ini170
	NOP
	NOP
	JMP        L_libs/EEprom_ext_eeprom_ini167
;libs/EEprom.mbas,449 :: 		else
L_libs/EEprom_ext_eeprom_ini166:
;libs/EEprom.mbas,451 :: 		Lcd_Out(1,1,"ext not writed111111111" )
	MOVW       R30, R28
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,452 :: 		delay_ms(1500)
	LDI        R18, 61
	LDI        R17, 225
	LDI        R16, 64
L_libs/EEprom_ext_eeprom_ini172:
	DEC        R16
	BRNE       L_libs/EEprom_ext_eeprom_ini172
	DEC        R17
	BRNE       L_libs/EEprom_ext_eeprom_ini172
	DEC        R18
	BRNE       L_libs/EEprom_ext_eeprom_ini172
	NOP
	NOP
;libs/EEprom.mbas,453 :: 		Write_EEprom(0 ,12 )
	LDI        R27, 12
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       libs/EEprom_Write_EEprom+0
;libs/EEprom.mbas,454 :: 		on_off_initial (1,1,0,0,18)    '' off mode on_off initial (dim on_off22,en,hr,mint,prc as integer)
	LDI        R27, 18
	MOV        R6, R27
	CLR        R5
	CLR        R4
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _on_off_initial+0
;libs/EEprom.mbas,455 :: 		on_off_initial (2,1,0,0,18)    '''on mode
	LDI        R27, 18
	MOV        R6, R27
	CLR        R5
	CLR        R4
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _on_off_initial+0
;libs/EEprom.mbas,456 :: 		Lcd_0()    Lcd_Out(1,1,"Writing to  " )    Lcd_Out(2,1,"EEPROM ... " )
	CALL       _Lcd_0+0
	MOVW       R30, R28
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 80
	ST         Z+, R27
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 79
	ST         Z+, R27
	LDI        R27, 77
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,457 :: 		eeprom_save_ext()
	CALL       _eeprom_save_ext+0
;libs/EEprom.mbas,458 :: 		Lcd_Out(1,1,"writing ext eeprom" )
	MOVW       R30, R28
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,460 :: 		end if
L_libs/EEprom_ext_eeprom_ini167:
;libs/EEprom.mbas,461 :: 		delay_ms(1500)
	LDI        R18, 61
	LDI        R17, 225
	LDI        R16, 64
L_libs/EEprom_ext_eeprom_ini174:
	DEC        R16
	BRNE       L_libs/EEprom_ext_eeprom_ini174
	DEC        R17
	BRNE       L_libs/EEprom_ext_eeprom_ini174
	DEC        R18
	BRNE       L_libs/EEprom_ext_eeprom_ini174
	NOP
	NOP
;libs/EEprom.mbas,462 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,463 :: 		EEprom_data_read=0
	LDI        R27, 0
	STS        _EEprom_data_read+0, R27
;libs/EEprom.mbas,464 :: 		Read_EEprom(0)
	CLR        R2
	CLR        R3
	CALL       libs/EEprom_Read_EEprom+0
;libs/EEprom.mbas,465 :: 		if  (EEprom_data_read=12)   then
	LDS        R16, _EEprom_data_read+0
	CPI        R16, 12
	BREQ       L_libs/EEprom_ext_eeprom_ini222
	JMP        L_libs/EEprom_ext_eeprom_ini177
L_libs/EEprom_ext_eeprom_ini222:
;libs/EEprom.mbas,466 :: 		Lcd_Out(1,1,"12 is good" )
	MOVW       R30, R28
	LDI        R27, 49
	ST         Z+, R27
	LDI        R27, 50
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,467 :: 		ByteToStr(EEprom_data_read,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/EEprom.mbas,469 :: 		Lcd_Out(2,1,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_libs/EEprom_ext_eeprom_ini178
;libs/EEprom.mbas,470 :: 		else
L_libs/EEprom_ext_eeprom_ini177:
;libs/EEprom.mbas,472 :: 		Lcd_Out(1,1,"ext not working" )
	MOVW       R30, R28
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 107
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/EEprom.mbas,473 :: 		delay_ms(1500)
	LDI        R18, 61
	LDI        R17, 225
	LDI        R16, 64
L_libs/EEprom_ext_eeprom_ini179:
	DEC        R16
	BRNE       L_libs/EEprom_ext_eeprom_ini179
	DEC        R17
	BRNE       L_libs/EEprom_ext_eeprom_ini179
	DEC        R18
	BRNE       L_libs/EEprom_ext_eeprom_ini179
	NOP
	NOP
;libs/EEprom.mbas,477 :: 		end if
L_libs/EEprom_ext_eeprom_ini178:
;libs/EEprom.mbas,478 :: 		delay_ms(1500)
	LDI        R18, 61
	LDI        R17, 225
	LDI        R16, 64
L_libs/EEprom_ext_eeprom_ini181:
	DEC        R16
	BRNE       L_libs/EEprom_ext_eeprom_ini181
	DEC        R17
	BRNE       L_libs/EEprom_ext_eeprom_ini181
	DEC        R18
	BRNE       L_libs/EEprom_ext_eeprom_ini181
	NOP
	NOP
;libs/EEprom.mbas,479 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/EEprom.mbas,480 :: 		end sub
L_end_ext_eeprom_ini:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 23
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of libs/EEprom_ext_eeprom_ini

_libs/EEprom_?main:

;libs/EEprom.mbas,483 :: 		end.
L_end_libs/EEprom_?main:
	RET
; end of _libs/EEprom_?main
