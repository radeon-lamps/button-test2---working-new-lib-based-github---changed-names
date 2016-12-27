
_write_eeprom_ext_TWI:

;libs/TWI.mbas,33 :: 		sub procedure write_eeprom_ext_TWI(dim address_ as integer,dim  data_ as Byte)
;libs/TWI.mbas,35 :: 		TWI_Init(100000)         ' initialize TWI communication
	PUSH       R2
	PUSH       R3
	LDS        R27, TWPS0_bit+0
	CBR        R27, BitMask(TWPS0_bit+0)
	STS        TWPS0_bit+0, R27
	LDS        R27, TWPS1_bit+0
	CBR        R27, BitMask(TWPS1_bit+0)
	STS        TWPS1_bit+0, R27
	LDI        R27, 32
	STS        TWBR+0, R27
	CALL       _TWI_Init+0
;libs/TWI.mbas,36 :: 		TWI_Start()              ' issue TWI start signal
	CALL       _TWI_Start+0
;libs/TWI.mbas,37 :: 		TWI_Write(write_address_bus)          ' send byte via TWI (device address + W)
	PUSH       R3
	PUSH       R2
	LDS        R2, _write_address_bus+0
	CALL       _TWI_Write+0
	POP        R2
	POP        R3
;libs/TWI.mbas,38 :: 		TWI_Write(address_)             ' send byte (address of EEPROM location)
	CALL       _TWI_Write+0
;libs/TWI.mbas,39 :: 		TWI_Write(data_)          ' send data (data to be written)
	MOV        R2, R4
	CALL       _TWI_Write+0
;libs/TWI.mbas,40 :: 		TWI_Stop()               ' issue TWI stop signal
	CALL       _TWI_Stop+0
;libs/TWI.mbas,42 :: 		Delay_ms(15)
	LDI        R17, 156
	LDI        R16, 215
L__write_eeprom_ext_TWI1:
	DEC        R16
	BRNE       L__write_eeprom_ext_TWI1
	DEC        R17
	BRNE       L__write_eeprom_ext_TWI1
	NOP
	NOP
;libs/TWI.mbas,43 :: 		end sub
L_end_write_eeprom_ext_TWI:
	POP        R3
	POP        R2
	RET
; end of _write_eeprom_ext_TWI

_Read_eeprom_ext_TWI:

;libs/TWI.mbas,48 :: 		sub procedure Read_eeprom_ext_TWI(dim address_ as integer)
;libs/TWI.mbas,50 :: 		TWI_Init(100000)         ' initialize TWI communication
	PUSH       R2
	PUSH       R3
	LDS        R27, TWPS0_bit+0
	CBR        R27, BitMask(TWPS0_bit+0)
	STS        TWPS0_bit+0, R27
	LDS        R27, TWPS1_bit+0
	CBR        R27, BitMask(TWPS1_bit+0)
	STS        TWPS1_bit+0, R27
	LDI        R27, 32
	STS        TWBR+0, R27
	CALL       _TWI_Init+0
;libs/TWI.mbas,51 :: 		TWI_Start()              ' issue TWI start signal
	CALL       _TWI_Start+0
;libs/TWI.mbas,52 :: 		TWI_Write(write_address_bus)          ' send byte via TWI (device address + W)
	PUSH       R3
	PUSH       R2
	LDS        R2, _write_address_bus+0
	CALL       _TWI_Write+0
	POP        R2
	POP        R3
;libs/TWI.mbas,53 :: 		TWI_Write(address_)             ' send byte (data address)
	CALL       _TWI_Write+0
;libs/TWI.mbas,54 :: 		TWI_Start()              ' issue TWI signal repeated start
	CALL       _TWI_Start+0
;libs/TWI.mbas,55 :: 		TWI_Write(read_address_bus)          ' send byte (device address + R)
	LDS        R2, _read_address_bus+0
	CALL       _TWI_Write+0
;libs/TWI.mbas,56 :: 		EEprom_data_read = TWI_Read(0)      ' read data (NO acknowledge)
	CLR        R2
	CALL       _TWI_Read+0
	STS        _EEprom_data_read+0, R16
;libs/TWI.mbas,62 :: 		TWI_Stop()
	CALL       _TWI_Stop+0
;libs/TWI.mbas,63 :: 		Delay_ms(15)
	LDI        R17, 156
	LDI        R16, 215
L__Read_eeprom_ext_TWI4:
	DEC        R16
	BRNE       L__Read_eeprom_ext_TWI4
	DEC        R17
	BRNE       L__Read_eeprom_ext_TWI4
	NOP
	NOP
;libs/TWI.mbas,64 :: 		end sub
L_end_Read_eeprom_ext_TWI:
	POP        R3
	POP        R2
	RET
; end of _Read_eeprom_ext_TWI

_eeprom_call_back_ext_twi:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 23
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/TWI.mbas,69 :: 		Pwm_chanel_ini,chanel_ini as byte
;libs/TWI.mbas,74 :: 		counter=5
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 5
	STS        _counter+0, R27
	LDI        R27, 0
	STS        _counter+1, R27
;libs/TWI.mbas,75 :: 		for week_twi =1 to 7
	LDI        R27, 1
	STD        Y+1, R27
L__eeprom_call_back_ext_twi8:
;libs/TWI.mbas,76 :: 		for Pwm_chanel_ini=1 to 7
	LDI        R27, 1
	STD        Y+2, R27
L__eeprom_call_back_ext_twi13:
;libs/TWI.mbas,77 :: 		for chanel_ini =1 to 4
	LDI        R27, 1
	STD        Y+3, R27
L__eeprom_call_back_ext_twi18:
;libs/TWI.mbas,78 :: 		for on_off22_twi=1 to 2
	LDI        R27, 1
	STD        Y+0, R27
L__eeprom_call_back_ext_twi23:
;libs/TWI.mbas,85 :: 		Read_eeprom_ext_TWI(inc(counter))
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _counter+0, R16
	STS        _counter+1, R17
	MOVW       R2, R16
	CALL       _Read_eeprom_ext_TWI+0
;libs/TWI.mbas,86 :: 		on_a_0 [week_twi-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22_twi-1][0]=  EEprom_data_read
	LDD        R16, Y+1
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDD        R20, Y+3
	SUBI       R20, 1
	STD        Y+21, R16
	STD        Y+22, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+21
	LDD        R19, Y+22
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+2
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
;libs/TWI.mbas,88 :: 		Read_eeprom_ext_TWI(inc(counter))
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _counter+0, R16
	STS        _counter+1, R17
	MOVW       R2, R16
	CALL       _Read_eeprom_ext_TWI+0
;libs/TWI.mbas,89 :: 		on_a_0 [week_twi-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22_twi-1][1]=  EEprom_data_read
	LDD        R16, Y+1
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDD        R20, Y+3
	SUBI       R20, 1
	STD        Y+21, R16
	STD        Y+22, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+21
	LDD        R19, Y+22
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+2
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
;libs/TWI.mbas,91 :: 		Read_eeprom_ext_TWI(inc(counter))
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _counter+0, R16
	STS        _counter+1, R17
	MOVW       R2, R16
	CALL       _Read_eeprom_ext_TWI+0
;libs/TWI.mbas,92 :: 		on_a_0 [week_twi-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22_twi-1][2]=  EEprom_data_read
	LDD        R16, Y+1
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDD        R20, Y+3
	SUBI       R20, 1
	STD        Y+21, R16
	STD        Y+22, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+21
	LDD        R19, Y+22
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+2
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
;libs/TWI.mbas,94 :: 		Read_eeprom_ext_TWI(inc(counter))
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _counter+0, R16
	STS        _counter+1, R17
	MOVW       R2, R16
	CALL       _Read_eeprom_ext_TWI+0
;libs/TWI.mbas,95 :: 		on_a_0 [week_twi-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22_twi-1][3]=  EEprom_data_read
	LDD        R16, Y+1
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDD        R20, Y+3
	SUBI       R20, 1
	STD        Y+21, R16
	STD        Y+22, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+21
	LDD        R19, Y+22
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+2
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
;libs/TWI.mbas,97 :: 		Lcd_0() byteToStr(EEprom_data_read, txt)
	CALL       _Lcd_0+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/TWI.mbas,98 :: 		Lcd_Out(1,1,"date read is: " )
	MOVW       R30, R28
	ADIW       R30, 4
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 58
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	SUBI       R16, 252
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/TWI.mbas,99 :: 		Lcd_Out(2,1,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/TWI.mbas,102 :: 		intToStr(integer (ceil((counter*100)/1573)), txt)
	LDS        R16, _counter+0
	LDS        R17, _counter+1
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	LDI        R20, 100
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	CALL       _HWMul_32x32+0
	CALL       _float_slong2fp+0
	LDI        R20, 0
	LDI        R21, 160
	LDI        R22, 196
	LDI        R23, 68
	CALL       _float_fpdiv1+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _ceil+0
	CALL       _float_fpint+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _IntToStr+0
;libs/TWI.mbas,103 :: 		Lcd_Out(1,1,"read counter: " )
	MOVW       R30, R28
	ADIW       R30, 4
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 99
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 117
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 58
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	SUBI       R16, 252
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/TWI.mbas,104 :: 		Lcd_Chr (2,5,137) Lcd_Out(2,7,txt )
	LDI        R27, 137
	MOV        R4, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/TWI.mbas,108 :: 		next on_off22_twi
	LDD        R16, Y+0
	CPI        R16, 2
	BRNE       L__eeprom_call_back_ext_twi70
	JMP        L__eeprom_call_back_ext_twi26
L__eeprom_call_back_ext_twi70:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L__eeprom_call_back_ext_twi23
L__eeprom_call_back_ext_twi26:
;libs/TWI.mbas,109 :: 		next chanel_ini
	LDD        R16, Y+3
	CPI        R16, 4
	BRNE       L__eeprom_call_back_ext_twi71
	JMP        L__eeprom_call_back_ext_twi21
L__eeprom_call_back_ext_twi71:
	LDD        R16, Y+3
	SUBI       R16, 255
	STD        Y+3, R16
	JMP        L__eeprom_call_back_ext_twi18
L__eeprom_call_back_ext_twi21:
;libs/TWI.mbas,110 :: 		next Pwm_chanel_ini
	LDD        R16, Y+2
	CPI        R16, 7
	BRNE       L__eeprom_call_back_ext_twi72
	JMP        L__eeprom_call_back_ext_twi16
L__eeprom_call_back_ext_twi72:
	LDD        R16, Y+2
	SUBI       R16, 255
	STD        Y+2, R16
	JMP        L__eeprom_call_back_ext_twi13
L__eeprom_call_back_ext_twi16:
;libs/TWI.mbas,111 :: 		next week_twi
	LDD        R16, Y+1
	CPI        R16, 7
	BRNE       L__eeprom_call_back_ext_twi73
	JMP        L__eeprom_call_back_ext_twi11
L__eeprom_call_back_ext_twi73:
	LDD        R16, Y+1
	SUBI       R16, 255
	STD        Y+1, R16
	JMP        L__eeprom_call_back_ext_twi8
L__eeprom_call_back_ext_twi11:
;libs/TWI.mbas,116 :: 		end sub
L_end_eeprom_call_back_ext_twi:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 22
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _eeprom_call_back_ext_twi

_eeprom_save_ext_twi:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 39
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/TWI.mbas,122 :: 		Pwm_chanel_ini,chanel_ini as byte
;libs/TWI.mbas,126 :: 		counter=5
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 5
	STD        Y+2, R27
	LDI        R27, 0
	STD        Y+3, R27
;libs/TWI.mbas,127 :: 		for week_twi =1 to 7
	LDI        R27, 1
	STD        Y+1, R27
L__eeprom_save_ext_twi29:
;libs/TWI.mbas,128 :: 		for Pwm_chanel_ini=1 to 7
	LDI        R27, 1
	STD        Y+4, R27
L__eeprom_save_ext_twi34:
;libs/TWI.mbas,129 :: 		for chanel_ini =1 to 4
	LDI        R27, 1
	STD        Y+5, R27
L__eeprom_save_ext_twi39:
;libs/TWI.mbas,130 :: 		for on_off22_twi=1 to 2
	LDI        R27, 1
	STD        Y+0, R27
L__eeprom_save_ext_twi44:
;libs/TWI.mbas,133 :: 		write_eeprom_ext_TWI(inc(counter),on_a_0 [week_twi-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22_twi-1][0] )
	LDD        R16, Y+2
	LDD        R17, Y+3
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+2, R16
	STD        Y+3, R17
	LDD        R16, Y+1
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDD        R20, Y+5
	SUBI       R20, 1
	STD        Y+37, R16
	STD        Y+38, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+37
	LDD        R19, Y+38
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+4
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
	LD         R16, Z
	MOV        R4, R16
	LDD        R2, Y+2
	LDD        R3, Y+3
	CALL       _write_eeprom_ext_TWI+0
;libs/TWI.mbas,141 :: 		write_eeprom_ext_TWI(inc(counter),on_a_0 [week_twi-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22_twi-1][1] )
	LDD        R16, Y+2
	LDD        R17, Y+3
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+2, R16
	STD        Y+3, R17
	LDD        R16, Y+1
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDD        R20, Y+5
	SUBI       R20, 1
	STD        Y+37, R16
	STD        Y+38, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+37
	LDD        R19, Y+38
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+4
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
	LD         R16, Z
	MOV        R4, R16
	LDD        R2, Y+2
	LDD        R3, Y+3
	CALL       _write_eeprom_ext_TWI+0
;libs/TWI.mbas,142 :: 		write_eeprom_ext_TWI(inc(counter),on_a_0 [week_twi-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22_twi-1][2] )
	LDD        R16, Y+2
	LDD        R17, Y+3
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+2, R16
	STD        Y+3, R17
	LDD        R16, Y+1
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDD        R20, Y+5
	SUBI       R20, 1
	STD        Y+37, R16
	STD        Y+38, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+37
	LDD        R19, Y+38
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+4
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
	LD         R16, Z
	MOV        R4, R16
	LDD        R2, Y+2
	LDD        R3, Y+3
	CALL       _write_eeprom_ext_TWI+0
;libs/TWI.mbas,143 :: 		write_eeprom_ext_TWI(inc(counter),on_a_0 [week_twi-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22_twi-1][3] )
	LDD        R16, Y+2
	LDD        R17, Y+3
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+2, R16
	STD        Y+3, R17
	LDD        R16, Y+1
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDD        R20, Y+5
	SUBI       R20, 1
	STD        Y+37, R16
	STD        Y+38, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+37
	LDD        R19, Y+38
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+4
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
	LD         R16, Z
	MOV        R4, R16
	LDD        R2, Y+2
	LDD        R3, Y+3
	CALL       _write_eeprom_ext_TWI+0
;libs/TWI.mbas,145 :: 		Read_eeprom_ext_TWI(counter)
	LDD        R2, Y+2
	LDD        R3, Y+3
	CALL       _Read_eeprom_ext_TWI+0
;libs/TWI.mbas,146 :: 		Lcd_0() byteToStr(EEprom_data_read, txt)
	CALL       _Lcd_0+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/TWI.mbas,147 :: 		Lcd_Out(1,1,"EEprom_data_read writen is: " )
	MOVW       R30, R28
	ADIW       R30, 6
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
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 100
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
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 58
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	SUBI       R16, 250
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/TWI.mbas,148 :: 		Lcd_Out(2,1,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/TWI.mbas,152 :: 		intToStr(integer (ceil(counter*100/1573)), txt)
	LDD        R16, Y+2
	LDD        R17, Y+3
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	LDI        R20, 100
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	CALL       _HWMul_32x32+0
	CALL       _float_slong2fp+0
	LDI        R20, 0
	LDI        R21, 160
	LDI        R22, 196
	LDI        R23, 68
	CALL       _float_fpdiv1+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _ceil+0
	CALL       _float_fpint+0
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _IntToStr+0
;libs/TWI.mbas,153 :: 		Lcd_Out(1,1,"Write counter: " )
	MOVW       R30, R28
	ADIW       R30, 6
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 99
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 117
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 58
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	SUBI       R16, 250
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/TWI.mbas,154 :: 		Lcd_Out(2,7,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/TWI.mbas,157 :: 		next on_off22_twi
	LDD        R16, Y+0
	CPI        R16, 2
	BRNE       L__eeprom_save_ext_twi75
	JMP        L__eeprom_save_ext_twi47
L__eeprom_save_ext_twi75:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L__eeprom_save_ext_twi44
L__eeprom_save_ext_twi47:
;libs/TWI.mbas,158 :: 		next chanel_ini
	LDD        R16, Y+5
	CPI        R16, 4
	BRNE       L__eeprom_save_ext_twi76
	JMP        L__eeprom_save_ext_twi42
L__eeprom_save_ext_twi76:
	LDD        R16, Y+5
	SUBI       R16, 255
	STD        Y+5, R16
	JMP        L__eeprom_save_ext_twi39
L__eeprom_save_ext_twi42:
;libs/TWI.mbas,159 :: 		next Pwm_chanel_ini
	LDD        R16, Y+4
	CPI        R16, 7
	BRNE       L__eeprom_save_ext_twi77
	JMP        L__eeprom_save_ext_twi37
L__eeprom_save_ext_twi77:
	LDD        R16, Y+4
	SUBI       R16, 255
	STD        Y+4, R16
	JMP        L__eeprom_save_ext_twi34
L__eeprom_save_ext_twi37:
;libs/TWI.mbas,160 :: 		next week_twi
	LDD        R16, Y+1
	CPI        R16, 7
	BRNE       L__eeprom_save_ext_twi78
	JMP        L__eeprom_save_ext_twi32
L__eeprom_save_ext_twi78:
	LDD        R16, Y+1
	SUBI       R16, 255
	STD        Y+1, R16
	JMP        L__eeprom_save_ext_twi29
L__eeprom_save_ext_twi32:
;libs/TWI.mbas,164 :: 		delay_ms(111)
	LDI        R18, 5
	LDI        R17, 130
	LDI        R16, 58
L__eeprom_save_ext_twi48:
	DEC        R16
	BRNE       L__eeprom_save_ext_twi48
	DEC        R17
	BRNE       L__eeprom_save_ext_twi48
	DEC        R18
	BRNE       L__eeprom_save_ext_twi48
	NOP
	NOP
;libs/TWI.mbas,165 :: 		end sub
L_end_eeprom_save_ext_twi:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 38
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _eeprom_save_ext_twi

_eeprom_ext_TWI_ini:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 22
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/TWI.mbas,169 :: 		sub procedure eeprom_ext_TWI_ini()
;libs/TWI.mbas,170 :: 		EEprom_data_read=0  Lcd_0()
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 0
	STS        _EEprom_data_read+0, R27
	CALL       _Lcd_0+0
;libs/TWI.mbas,171 :: 		Read_eeprom_ext_TWI(0x00)
	CLR        R2
	CLR        R3
	CALL       _Read_eeprom_ext_TWI+0
;libs/TWI.mbas,172 :: 		if  EEprom_data_read=111 then
	LDS        R16, _EEprom_data_read+0
	CPI        R16, 111
	BREQ       L__eeprom_ext_TWI_ini80
	JMP        L__eeprom_ext_TWI_ini52
L__eeprom_ext_TWI_ini80:
;libs/TWI.mbas,173 :: 		lcd_out(1,1,"Ext TWI EEp wr beffor")
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
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
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 98
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 102
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
;libs/TWI.mbas,174 :: 		delay_ms(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L__eeprom_ext_TWI_ini54:
	DEC        R16
	BRNE       L__eeprom_ext_TWI_ini54
	DEC        R17
	BRNE       L__eeprom_ext_TWI_ini54
	DEC        R18
	BRNE       L__eeprom_ext_TWI_ini54
	JMP        L__eeprom_ext_TWI_ini53
;libs/TWI.mbas,175 :: 		else
L__eeprom_ext_TWI_ini52:
;libs/TWI.mbas,176 :: 		write_eeprom_ext_TWI(0x00,111)
	LDI        R27, 111
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _write_eeprom_ext_TWI+0
;libs/TWI.mbas,177 :: 		lcd_out(1,1,"Ext TWI EEp not wrted")
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
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
	LDI        R27, 112
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
;libs/TWI.mbas,178 :: 		lcd_out(2,1,"Wrtting ext twi eep")
	MOVW       R30, R28
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 116
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
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 119
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 112
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
;libs/TWI.mbas,179 :: 		delay_ms(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L__eeprom_ext_TWI_ini56:
	DEC        R16
	BRNE       L__eeprom_ext_TWI_ini56
	DEC        R17
	BRNE       L__eeprom_ext_TWI_ini56
	DEC        R18
	BRNE       L__eeprom_ext_TWI_ini56
;libs/TWI.mbas,180 :: 		end if
L__eeprom_ext_TWI_ini53:
;libs/TWI.mbas,181 :: 		EEprom_data_read=0 Lcd_0()
	LDI        R27, 0
	STS        _EEprom_data_read+0, R27
	CALL       _Lcd_0+0
;libs/TWI.mbas,182 :: 		Read_eeprom_ext_TWI(0x00)
	CLR        R2
	CLR        R3
	CALL       _Read_eeprom_ext_TWI+0
;libs/TWI.mbas,183 :: 		if  EEprom_data_read=111 then
	LDS        R16, _EEprom_data_read+0
	CPI        R16, 111
	BREQ       L__eeprom_ext_TWI_ini81
	JMP        L__eeprom_ext_TWI_ini59
L__eeprom_ext_TWI_ini81:
;libs/TWI.mbas,184 :: 		lcd_out(1,1,"Ext TWI EEp working")
	MOVW       R30, R28
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 120
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
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
	LDI        R27, 112
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
;libs/TWI.mbas,185 :: 		delay_ms(100)
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L__eeprom_ext_TWI_ini61:
	DEC        R16
	BRNE       L__eeprom_ext_TWI_ini61
	DEC        R17
	BRNE       L__eeprom_ext_TWI_ini61
	DEC        R18
	BRNE       L__eeprom_ext_TWI_ini61
;libs/TWI.mbas,186 :: 		byteToStr(EEprom_data_read, txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _EEprom_data_read+0
	CALL       _ByteToStr+0
;libs/TWI.mbas,187 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/TWI.mbas,188 :: 		Lcd_Out(1,1,"EEprom TWI o " )
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
	LDI        R27, 84
	ST         Z+, R27
	LDI        R27, 87
	ST         Z+, R27
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 111
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
;libs/TWI.mbas,189 :: 		Lcd_Out(2,1,txt )
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/TWI.mbas,190 :: 		delay_ms(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L__eeprom_ext_TWI_ini63:
	DEC        R16
	BRNE       L__eeprom_ext_TWI_ini63
	DEC        R17
	BRNE       L__eeprom_ext_TWI_ini63
	DEC        R18
	BRNE       L__eeprom_ext_TWI_ini63
	JMP        L__eeprom_ext_TWI_ini60
;libs/TWI.mbas,191 :: 		else
L__eeprom_ext_TWI_ini59:
;libs/TWI.mbas,193 :: 		lcd_out(1,1,"TWI EEp not working")
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
	LDI        R27, 112
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
;libs/TWI.mbas,195 :: 		delay_ms(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L__eeprom_ext_TWI_ini65:
	DEC        R16
	BRNE       L__eeprom_ext_TWI_ini65
	DEC        R17
	BRNE       L__eeprom_ext_TWI_ini65
	DEC        R18
	BRNE       L__eeprom_ext_TWI_ini65
;libs/TWI.mbas,196 :: 		end if
L__eeprom_ext_TWI_ini60:
;libs/TWI.mbas,197 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/TWI.mbas,198 :: 		end sub
L_end_eeprom_ext_TWI_ini:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 21
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _eeprom_ext_TWI_ini

_libs/TWI_?main:

;libs/TWI.mbas,201 :: 		end.
L_end_libs/TWI_?main:
	RET
; end of _libs/TWI_?main
