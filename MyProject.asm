
_interrupt_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 26
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;MyProject.mbas,77 :: 		sub procedure interrupt_ISR () org IVT_ADDR_INT2            ''// Interrupt rutine
;MyProject.mbas,80 :: 		if Interupt_first_time=0 then
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	PUSH       R8
	PUSH       R9
	LDS        R16, _Interupt_first_time+0
	CPI        R16, 0
	BREQ       L__interrupt_ISR36
	JMP        L__interrupt_ISR2
L__interrupt_ISR36:
;MyProject.mbas,81 :: 		Interupt_first_time=1
	LDI        R27, 1
	STS        _Interupt_first_time+0, R27
;MyProject.mbas,83 :: 		Lcd_0()
	CALL       _Lcd_0+0
;MyProject.mbas,84 :: 		Lcd_Out(1,1,"Interupt_first_time=0")
	MOVW       R30, R28
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 117
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 102
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 61
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
;MyProject.mbas,85 :: 		Delay_mS(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L__interrupt_ISR4:
	DEC        R16
	BRNE       L__interrupt_ISR4
	DEC        R17
	BRNE       L__interrupt_ISR4
	DEC        R18
	BRNE       L__interrupt_ISR4
	JMP        L__interrupt_ISR3
;MyProject.mbas,86 :: 		else
L__interrupt_ISR2:
;MyProject.mbas,87 :: 		SREG_I_bit = 0                                   '' // Disable Interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;MyProject.mbas,89 :: 		WDT_on()
	CALL       _WDT_on+0
;MyProject.mbas,91 :: 		INT2_bit = 0
	IN         R27, INT2_bit+0
	CBR        R27, BitMask(INT2_bit+0)
	OUT        INT2_bit+0, R27
;MyProject.mbas,93 :: 		while_state_import_main=0
	LDS        R27, _while_state_import_main+0
	CBR        R27, BitMask(_while_state_import_main+0)
	STS        _while_state_import_main+0, R27
;MyProject.mbas,94 :: 		Keypad_set__date_time_import_On_hour_teben(week,hours,minutes,23,0)
	CLR        R6
	LDI        R27, 23
	MOV        R5, R27
	LDS        R4, _minutes+0
	LDS        R3, _hours+0
	LDS        R2, _week+0
	CALL       _Keypad_set__date_time_import_On_hour_teben+0
;MyProject.mbas,95 :: 		Keypad_set__date_time_import_On_minut_teben(week,on_a_0[week-1][chanel-1][Pwm_chanel-1][on_off2-1][1],minutes,59,0)
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
	STD        Y+22, R16
	STD        Y+23, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+22
	LDD        R19, Y+23
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
	ADIW       R30, 1
	LD         R16, Z
	CLR        R6
	LDI        R27, 59
	MOV        R5, R27
	LDS        R4, _minutes+0
	MOV        R3, R16
	LDS        R2, _week+0
	CALL       _Keypad_set__date_time_import_On_minut_teben+0
;MyProject.mbas,96 :: 		Keypad_set__date_time_import_Yes_No_teben( week,chanel,1, 2,1 )
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 2
	MOV        R5, R27
	LDI        R27, 1
	MOV        R4, R27
	LDS        R3, _chanel+0
	LDS        R2, _week+0
	CALL       _Keypad_set__date_time_import_Yes_No_teben+0
;MyProject.mbas,97 :: 		Keypad_set__date_time_import_PWM_Red_teben(1,1,on_a_0[week_new-1][chanel-1][Pwm_chanel-1][on_off2-1][3],100,0,on_a_0[week_new-1][0][Pwm_chanel-1][on_off2-1][3],on_a_0[week_new-1][1][Pwm_chanel-1][on_off2-1][3],on_a_0[week_new-1][2][Pwm_chanel-1][on_off2-1][3],on_a_0[week_new-1][3][Pwm_chanel-1][on_off2-1][3],0,0,0,0,0)''on_a_0[week_new-1][4][Pwm_chanel-1][on_off2-1][3],0,0,0,0) ''on_a_0[week_new-1][5][Pwm_chanel-1][on_off2-1][3],on_a_0[week_new-1][6][Pwm_chanel-1][on_off2-1][3],0,0) ''on_a_0[week_new-1][7][Pwm_chanel-1][on_off2-1][3],on_a_0[week_new-1][8][Pwm_chanel-1][on_off2-1][3]) ''(dim mode_1,Pwm_chanel,var_in as byte, dim p_max as  byte, dim p_min as  byte )
	LDS        R16, _week_new+0
	SUBI       R16, 1
	LDI        R17, 0
	LDI        R20, 224
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	STD        Y+24, R16
	STD        Y+25, R17
	LDI        R18, #lo_addr(_on_a_0+0)
	LDI        R19, hi_addr(_on_a_0+0)
	ADD        R16, R18
	ADC        R17, R19
	LDS        R20, _chanel+0
	SUBI       R20, 1
	STD        Y+22, R16
	STD        Y+23, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+22
	LDD        R19, Y+23
	MOVW       R20, R16
	ADD        R20, R18
	ADC        R21, R19
	LDS        R16, _Pwm_chanel+0
	SUBI       R16, 1
	MOV        R2, R16
	LDI        R27, 0
	MOV        R3, R27
	LSL        R2
	ROL        R3
	LSL        R2
	ROL        R3
	LSL        R2
	ROL        R3
	MOVW       R18, R2
	ADD        R18, R20
	ADC        R19, R21
	LDS        R16, _on_off2+0
	SUBI       R16, 1
	MOV        R24, R16
	LDI        R25, 0
	LSL        R24
	ROL        R25
	LSL        R24
	ROL        R25
	MOVW       R16, R24
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R23, Z
	LDI        R16, #lo_addr(_on_a_0+0)
	LDI        R17, hi_addr(_on_a_0+0)
	LDD        R21, Y+24
	LDD        R22, Y+25
	ADD        R16, R21
	ADC        R17, R22
	ADD        R16, R2
	ADC        R17, R3
	ADD        R16, R24
	ADC        R17, R25
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R20, Z
	LDI        R16, #lo_addr(_on_a_0+0)
	LDI        R17, hi_addr(_on_a_0+0)
	ADD        R16, R21
	ADC        R17, R22
	SUBI       R16, 200
	SBCI       R17, 255
	ADD        R16, R2
	ADC        R17, R3
	ADD        R16, R24
	ADC        R17, R25
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R19, Z
	LDI        R16, #lo_addr(_on_a_0+0)
	LDI        R17, hi_addr(_on_a_0+0)
	ADD        R16, R21
	ADC        R17, R22
	SUBI       R16, 144
	SBCI       R17, 255
	ADD        R16, R2
	ADC        R17, R3
	ADD        R16, R24
	ADC        R17, R25
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R18, Z
	LDI        R16, #lo_addr(_on_a_0+0)
	LDI        R17, hi_addr(_on_a_0+0)
	ADD        R16, R21
	ADC        R17, R22
	SUBI       R16, 88
	SBCI       R17, 255
	ADD        R16, R2
	ADC        R17, R3
	ADD        R16, R24
	ADC        R17, R25
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R16, Z
	MOV        R9, R18
	MOV        R8, R19
	MOV        R7, R20
	CLR        R6
	LDI        R27, 100
	MOV        R5, R27
	MOV        R4, R23
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	PUSH       R27
	LDI        R27, 0
	PUSH       R27
	LDI        R27, 0
	PUSH       R27
	LDI        R27, 0
	PUSH       R27
	LDI        R27, 0
	PUSH       R27
	PUSH       R16
	CALL       _Keypad_set__date_time_import_PWM_Red_teben+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 6
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;MyProject.mbas,98 :: 		Keypad_set__date_time_import_save_exit_teben (week,1,1,0)
	CLR        R5
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDS        R2, _week+0
	CALL       _Keypad_set__date_time_import_save_exit_teben+0
;MyProject.mbas,99 :: 		while_state_import_main=1
	LDS        R27, _while_state_import_main+0
	SBR        R27, BitMask(_while_state_import_main+0)
	STS        _while_state_import_main+0, R27
;MyProject.mbas,103 :: 		Keypad_3()
	CALL       _Keypad_3+0
;MyProject.mbas,104 :: 		txt1 = "<int is selected"
	LDI        R30, #lo_addr(_txt1+0)
	LDI        R31, hi_addr(_txt1+0)
	LDI        R27, 60
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 108
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 99
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
;MyProject.mbas,105 :: 		Lcd_Out(1,1,txt1)
	LDI        R27, #lo_addr(_txt1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt1+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.mbas,106 :: 		if (Button(PIND, 2, 0.1, 1)<> 0) then    ' Detect logical one setting key
	LDI        R27, 1
	MOV        R6, R27
	CLR        R5
	LDI        R27, 2
	MOV        R4, R27
	LDI        R27, #lo_addr(PIND+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PIND+0)
	MOV        R3, R27
	CALL       _Button+0
	CPI        R16, 0
	BRNE       L__interrupt_ISR37
	JMP        L__interrupt_ISR7
L__interrupt_ISR37:
;MyProject.mbas,107 :: 		oldstate = 1
	LDS        R27, _oldstate+0
	SBR        R27, BitMask(_oldstate+0)
	STS        _oldstate+0, R27
;MyProject.mbas,108 :: 		Lcd_0()
	CALL       _Lcd_0+0
;MyProject.mbas,111 :: 		Delay_mS(400)                      ' Update flag
	LDI        R18, 17
	LDI        R17, 60
	LDI        R16, 204
L__interrupt_ISR9:
	DEC        R16
	BRNE       L__interrupt_ISR9
	DEC        R17
	BRNE       L__interrupt_ISR9
	DEC        R18
	BRNE       L__interrupt_ISR9
L__interrupt_ISR7:
;MyProject.mbas,113 :: 		if (oldstate and Button(PIND, 2, 0.1, 0)) then    ' Detect one-to-zero transition
	CLR        R6
	CLR        R5
	LDI        R27, 2
	MOV        R4, R27
	LDI        R27, #lo_addr(PIND+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PIND+0)
	MOV        R3, R27
	CALL       _Button+0
	LDS        R0, _oldstate+0
	CLR        R17
	SBRC       R0, BitPos(_oldstate+0)
	INC        R17
	AND        R16, R17
	BRNE       L__interrupt_ISR38
	JMP        L__interrupt_ISR12
L__interrupt_ISR38:
;MyProject.mbas,114 :: 		oldstate = 0
	LDS        R27, _oldstate+0
	CBR        R27, BitMask(_oldstate+0)
	STS        _oldstate+0, R27
;MyProject.mbas,115 :: 		txt1 = "<good>"
	LDI        R30, #lo_addr(_txt1+0)
	LDI        R31, hi_addr(_txt1+0)
	LDI        R27, 60
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 111
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 62
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
;MyProject.mbas,116 :: 		Lcd_Out(1,1,txt1)
	LDI        R27, #lo_addr(_txt1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt1+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.mbas,117 :: 		Delay_mS(400)
	LDI        R18, 17
	LDI        R17, 60
	LDI        R16, 204
L__interrupt_ISR14:
	DEC        R16
	BRNE       L__interrupt_ISR14
	DEC        R17
	BRNE       L__interrupt_ISR14
	DEC        R18
	BRNE       L__interrupt_ISR14
L__interrupt_ISR12:
;MyProject.mbas,121 :: 		WDTCR = 0x00
	LDI        R27, 0
	OUT        WDTCR+0, R27
;MyProject.mbas,122 :: 		INT2_bit = 1
	IN         R27, INT2_bit+0
	SBR        R27, BitMask(INT2_bit+0)
	OUT        INT2_bit+0, R27
;MyProject.mbas,124 :: 		SREG_I_bit = 1                                  ''  // Enable Interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;MyProject.mbas,132 :: 		end if
L__interrupt_ISR3:
;MyProject.mbas,133 :: 		end sub
L_end_interrupt_ISR:
	POP        R9
	POP        R8
	POP        R7
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
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _interrupt_ISR

_interrupt_ISR_6:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 22
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;MyProject.mbas,135 :: 		sub procedure interrupt_ISR_6 () org IVT_ADDR_INT6            ''// Interrupt rutine
;MyProject.mbas,138 :: 		if Interupt_first_time2=0 then
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _Interupt_first_time2+0
	CPI        R16, 0
	BREQ       L__interrupt_ISR_640
	JMP        L__interrupt_ISR_618
L__interrupt_ISR_640:
;MyProject.mbas,139 :: 		Interupt_first_time2=1
	LDI        R27, 1
	STS        _Interupt_first_time2+0, R27
;MyProject.mbas,141 :: 		Lcd_0()
	CALL       _Lcd_0+0
;MyProject.mbas,142 :: 		Lcd_Out(1,1,"Interupt_first_time=0")
	MOVW       R30, R28
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 117
	ST         Z+, R27
	LDI        R27, 112
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 102
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 95
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 61
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
;MyProject.mbas,143 :: 		Delay_mS(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L__interrupt_ISR_620:
	DEC        R16
	BRNE       L__interrupt_ISR_620
	DEC        R17
	BRNE       L__interrupt_ISR_620
	DEC        R18
	BRNE       L__interrupt_ISR_620
	JMP        L__interrupt_ISR_619
;MyProject.mbas,144 :: 		else
L__interrupt_ISR_618:
;MyProject.mbas,145 :: 		SREG_I_bit = 0                                   '' // Disable Interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;MyProject.mbas,147 :: 		WDT_on()
	CALL       _WDT_on+0
;MyProject.mbas,149 :: 		INT6_bit = 0
	IN         R27, INT6_bit+0
	CBR        R27, BitMask(INT6_bit+0)
	OUT        INT6_bit+0, R27
;MyProject.mbas,160 :: 		Easy_vacuum_95_10_4_simple(chanel,1)
	LDI        R27, 1
	MOV        R3, R27
	LDS        R2, _chanel+0
	CALL       _Easy_vacuum_95_10_4_simple+0
;MyProject.mbas,162 :: 		Lcd_Out(1,1,txt1)
	LDI        R27, #lo_addr(_txt1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt1+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.mbas,166 :: 		WDTCR = 0x00
	LDI        R27, 0
	OUT        WDTCR+0, R27
;MyProject.mbas,167 :: 		INT6_bit = 1   ''simulating pressed  INT6 button by 1 in this bit
	IN         R27, INT6_bit+0
	SBR        R27, BitMask(INT6_bit+0)
	OUT        INT6_bit+0, R27
;MyProject.mbas,169 :: 		SREG_I_bit = 1                                  ''  // Enable Interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;MyProject.mbas,170 :: 		end if
L__interrupt_ISR_619:
;MyProject.mbas,172 :: 		end sub
L_end_interrupt_ISR_6:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 21
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _interrupt_ISR_6

_interrupt_ISR_0:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 5
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;MyProject.mbas,175 :: 		sub procedure interrupt_ISR_0 () org IVT_ADDR_INT0            ''// Interrupt rutine
;MyProject.mbas,178 :: 		SREG_I_bit = 0                                   '' // Disable Interrupts
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;MyProject.mbas,179 :: 		LCD_Out(2,1, "INT0")
	MOVW       R30, R28
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 78
	ST         Z+, R27
	LDI        R27, 84
	ST         Z+, R27
	LDI        R27, 48
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
;MyProject.mbas,180 :: 		Delay_mS(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L__interrupt_ISR_023:
	DEC        R16
	BRNE       L__interrupt_ISR_023
	DEC        R17
	BRNE       L__interrupt_ISR_023
	DEC        R18
	BRNE       L__interrupt_ISR_023
;MyProject.mbas,181 :: 		WDT_on()
	CALL       _WDT_on+0
;MyProject.mbas,182 :: 		INTF0_bit=0                                                  '  // Clear interrupt flag
	IN         R27, INTF0_bit+0
	CBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;MyProject.mbas,183 :: 		INT0_bit = 0
	IN         R27, INT0_bit+0
	CBR        R27, BitMask(INT0_bit+0)
	OUT        INT0_bit+0, R27
;MyProject.mbas,184 :: 		Keypad_3()
	CALL       _Keypad_3+0
;MyProject.mbas,187 :: 		WDTCR = 0x00
	LDI        R27, 0
	OUT        WDTCR+0, R27
;MyProject.mbas,188 :: 		INT0_bit = 1
	IN         R27, INT0_bit+0
	SBR        R27, BitMask(INT0_bit+0)
	OUT        INT0_bit+0, R27
;MyProject.mbas,190 :: 		SREG_I_bit = 1                                  ''  // Enable Interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;MyProject.mbas,198 :: 		end sub
L_end_interrupt_ISR_0:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 4
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _interrupt_ISR_0

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;MyProject.mbas,202 :: 		main:
;MyProject.mbas,205 :: 		DDB0_bit = 1                                       ' set Button pin as input
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	PUSH       R8
	PUSH       R9
	IN         R27, DDB0_bit+0
	SBR        R27, BitMask(DDB0_bit+0)
	OUT        DDB0_bit+0, R27
;MyProject.mbas,206 :: 		DDA2_bit = 1                                        ' set Button pin as input
	IN         R27, DDA2_bit+0
	SBR        R27, BitMask(DDA2_bit+0)
	OUT        DDA2_bit+0, R27
;MyProject.mbas,207 :: 		DDA5_bit = 1                                        ' set Button pin as input
	IN         R27, DDA5_bit+0
	SBR        R27, BitMask(DDA5_bit+0)
	OUT        DDA5_bit+0, R27
;MyProject.mbas,208 :: 		DDA4_bit = 1                                        ' set Button pin as input
	IN         R27, DDA4_bit+0
	SBR        R27, BitMask(DDA4_bit+0)
	OUT        DDA4_bit+0, R27
;MyProject.mbas,209 :: 		DDA3_bit = 1                                        ' set Button pin as input
	IN         R27, DDA3_bit+0
	SBR        R27, BitMask(DDA3_bit+0)
	OUT        DDA3_bit+0, R27
;MyProject.mbas,210 :: 		DDC2_bit =1   DDC3_bit =1
	IN         R27, DDC2_bit+0
	SBR        R27, BitMask(DDC2_bit+0)
	OUT        DDC2_bit+0, R27
	IN         R27, DDC3_bit+0
	SBR        R27, BitMask(DDC3_bit+0)
	OUT        DDC3_bit+0, R27
;MyProject.mbas,211 :: 		DDC4_bit =1   DDC5_bit =1  ' configure PORTD as output
	IN         R27, DDC4_bit+0
	SBR        R27, BitMask(DDC4_bit+0)
	OUT        DDC4_bit+0, R27
	IN         R27, DDC5_bit+0
	SBR        R27, BitMask(DDC5_bit+0)
	OUT        DDC5_bit+0, R27
;MyProject.mbas,212 :: 		DDC6_bit =1
	IN         R27, DDC6_bit+0
	SBR        R27, BitMask(DDC6_bit+0)
	OUT        DDC6_bit+0, R27
;MyProject.mbas,213 :: 		DDC7_bit =1
	IN         R27, DDC7_bit+0
	SBR        R27, BitMask(DDC7_bit+0)
	OUT        DDC7_bit+0, R27
;MyProject.mbas,216 :: 		DDD2_bit =0 DDD3_bit =0   DDD4_bit =0  ' configure PORTD as output
	IN         R27, DDD2_bit+0
	CBR        R27, BitMask(DDD2_bit+0)
	OUT        DDD2_bit+0, R27
	IN         R27, DDD3_bit+0
	CBR        R27, BitMask(DDD3_bit+0)
	OUT        DDD3_bit+0, R27
	IN         R27, DDD4_bit+0
	CBR        R27, BitMask(DDD4_bit+0)
	OUT        DDD4_bit+0, R27
;MyProject.mbas,217 :: 		DDD5_bit =0 DDD6_bit =0     DDD7_bit =0
	IN         R27, DDD5_bit+0
	CBR        R27, BitMask(DDD5_bit+0)
	OUT        DDD5_bit+0, R27
	IN         R27, DDD6_bit+0
	CBR        R27, BitMask(DDD6_bit+0)
	OUT        DDD6_bit+0, R27
	IN         R27, DDD7_bit+0
	CBR        R27, BitMask(DDD7_bit+0)
	OUT        DDD7_bit+0, R27
;MyProject.mbas,218 :: 		DDE6_bit = 0                    ' Set PORTE pin 7 as input pin for the Heater switches
	IN         R27, DDE6_bit+0
	CBR        R27, BitMask(DDE6_bit+0)
	OUT        DDE6_bit+0, R27
;MyProject.mbas,221 :: 		DDB1_bit =1      DDB3_bit =1
	IN         R27, DDB1_bit+0
	SBR        R27, BitMask(DDB1_bit+0)
	OUT        DDB1_bit+0, R27
	IN         R27, DDB3_bit+0
	SBR        R27, BitMask(DDB3_bit+0)
	OUT        DDB3_bit+0, R27
;MyProject.mbas,222 :: 		DDA0_bit =1 DDA1_bit =1      DDA2_bit =1  DDA3_bit =1
	IN         R27, DDA0_bit+0
	SBR        R27, BitMask(DDA0_bit+0)
	OUT        DDA0_bit+0, R27
	IN         R27, DDA1_bit+0
	SBR        R27, BitMask(DDA1_bit+0)
	OUT        DDA1_bit+0, R27
	IN         R27, DDA2_bit+0
	SBR        R27, BitMask(DDA2_bit+0)
	OUT        DDA2_bit+0, R27
	IN         R27, DDA3_bit+0
	SBR        R27, BitMask(DDA3_bit+0)
	OUT        DDA3_bit+0, R27
;MyProject.mbas,227 :: 		DDB4_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB4_bit+0
	SBR        R27, BitMask(DDB4_bit+0)
	OUT        DDB4_bit+0, R27
;MyProject.mbas,228 :: 		DDB5_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB5_bit+0
	SBR        R27, BitMask(DDB5_bit+0)
	OUT        DDB5_bit+0, R27
;MyProject.mbas,229 :: 		DDB6_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB6_bit+0
	SBR        R27, BitMask(DDB6_bit+0)
	OUT        DDB6_bit+0, R27
;MyProject.mbas,230 :: 		DDB7_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB7_bit+0
	SBR        R27, BitMask(DDB7_bit+0)
	OUT        DDB7_bit+0, R27
;MyProject.mbas,231 :: 		DDE3_bit = 1                    ' Set PORTD pin 7 as output pin for the PWM1 (according to datasheet)
	IN         R27, DDE3_bit+0
	SBR        R27, BitMask(DDE3_bit+0)
	OUT        DDE3_bit+0, R27
;MyProject.mbas,232 :: 		DDE4_bit = 1                    ' Set PORTD pin 7 as output pin for the PWM1 (according to datasheet)
	IN         R27, DDE4_bit+0
	SBR        R27, BitMask(DDE4_bit+0)
	OUT        DDE4_bit+0, R27
;MyProject.mbas,233 :: 		DDE5_bit = 1                    ' Set PORTD pin 7 as output pin for the PWM1 (according to datasheet)
	IN         R27, DDE5_bit+0
	SBR        R27, BitMask(DDE5_bit+0)
	OUT        DDE5_bit+0, R27
;MyProject.mbas,260 :: 		Lcd_Port_Init()
	CALL       _Lcd_Port_Init+0
;MyProject.mbas,261 :: 		Key_Port_Init()
	CALL       _Key_Port_Init+0
;MyProject.mbas,262 :: 		PWM_Port_Initialize ()
	CALL       _PWM_Port_Initialize+0
;MyProject.mbas,264 :: 		LCD_Init() ' Initialize LCD
	CALL       _Lcd_Init+0
;MyProject.mbas,265 :: 		LCD_cmd(_LCD_CLEAR) ' Clear LCD
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;MyProject.mbas,266 :: 		LCD_cmd(_LCD_CURSOR_OFF)
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;MyProject.mbas,267 :: 		LCD_Out(2,1,"TEST")
	MOVW       R30, R28
	LDI        R27, 84
	ST         Z+, R27
	LDI        R27, 69
	ST         Z+, R27
	LDI        R27, 83
	ST         Z+, R27
	LDI        R27, 84
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
;MyProject.mbas,268 :: 		hours=0x0  minutes=0x0   seconds=0x00 day= 0x2 week=2   month=0x11  year=0x15
	LDI        R27, 0
	STS        _hours+0, R27
	LDI        R27, 0
	STS        _minutes+0, R27
	LDI        R27, 0
	STS        _seconds+0, R27
	LDI        R27, 2
	STS        _day+0, R27
	LDI        R27, 2
	STS        _week+0, R27
	LDI        R27, 17
	STS        _month+0, R27
	LDI        R27, 21
	STS        _year+0, R27
;MyProject.mbas,271 :: 		Write_Time(hours, minutes, seconds, 0x13, 0x02,   0x11,year)'
	LDI        R27, 21
	MOV        R8, R27
	LDI        R27, 17
	MOV        R7, R27
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 19
	MOV        R5, R27
	CLR        R4
	CLR        R3
	CLR        R2
	CALL       _Write_Time+0
;MyProject.mbas,277 :: 		while_state_import=1
	LDS        R27, _while_state_import+0
	SBR        R27, BitMask(_while_state_import+0)
	STS        _while_state_import+0, R27
;MyProject.mbas,278 :: 		oldstate_2=0
	LDS        R27, _oldstate_2+0
	CBR        R27, BitMask(_oldstate_2+0)
	STS        _oldstate_2+0, R27
;MyProject.mbas,280 :: 		chanel=1  Pwm_chanel=1  on_off2=1   week_new=week    chanel_active=1
	LDI        R27, 1
	STS        _chanel+0, R27
	LDI        R27, 1
	STS        _Pwm_chanel+0, R27
	LDI        R27, 1
	STS        _on_off2+0, R27
	LDS        R16, _week+0
	STS        _week_new+0, R16
	LDI        R27, 1
	STS        _chanel_active+0, R27
;MyProject.mbas,339 :: 		Lcd_0()
	CALL       _Lcd_0+0
;MyProject.mbas,340 :: 		LCD_Load()
	CALL       _LCD_Load+0
;MyProject.mbas,341 :: 		CustomChar(1,1)
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _CustomChar+0
;MyProject.mbas,342 :: 		LCD_Chr(1,5,3)
	LDI        R27, 3
	MOV        R4, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;MyProject.mbas,343 :: 		LCD_Chr(2,2,0)    ' Display custom char 0 (heart)
	CLR        R4
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;MyProject.mbas,344 :: 		LCD_Chr(2,4,4)    ' Display custom char B
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;MyProject.mbas,345 :: 		Delay_ms(1500)
	LDI        R18, 61
	LDI        R17, 225
	LDI        R16, 64
L__main26:
	DEC        R16
	BRNE       L__main26
	DEC        R17
	BRNE       L__main26
	DEC        R18
	BRNE       L__main26
	NOP
	NOP
;MyProject.mbas,347 :: 		on_off_initial (1,1,0,20,18)    '' off mode on_off initial (dim on_off22,en,hr,mint,prc as integer)
	LDI        R27, 18
	MOV        R6, R27
	LDI        R27, 20
	MOV        R5, R27
	CLR        R4
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _on_off_initial+0
;MyProject.mbas,348 :: 		on_off_initial (2,1,0,0,18)    '''on mode
	LDI        R27, 18
	MOV        R6, R27
	CLR        R5
	CLR        R4
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _on_off_initial+0
;MyProject.mbas,357 :: 		Read_Time(@hours, @minutes, @seconds, @day, @week, @month, @year)
	LDI        R27, #lo_addr(_day+0)
	MOV        R8, R27
	LDI        R27, hi_addr(_day+0)
	MOV        R9, R27
	LDI        R27, #lo_addr(_seconds+0)
	MOV        R6, R27
	LDI        R27, hi_addr(_seconds+0)
	MOV        R7, R27
	LDI        R27, #lo_addr(_minutes+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_minutes+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_hours+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_hours+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_year+0)
	PUSH       R27
	LDI        R27, #lo_addr(_year+0)
	PUSH       R27
	LDI        R27, hi_addr(_month+0)
	PUSH       R27
	LDI        R27, #lo_addr(_month+0)
	PUSH       R27
	LDI        R27, hi_addr(_week+0)
	PUSH       R27
	LDI        R27, #lo_addr(_week+0)
	PUSH       R27
	CALL       _Read_Time+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 6
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;MyProject.mbas,358 :: 		Shamsi_call()
	CALL       _Shamsi_call+0
;MyProject.mbas,359 :: 		Shamsi_show_lcd( jmonth,jday,jyear,week,hours ,minutes,seconds )
	LDS        R8, _week+0
	LDI        R27, 0
	MOV        R9, R27
	LDS        R6, _Jyear+0
	LDS        R7, _Jyear+1
	LDS        R4, _Jday+0
	LDS        R5, _Jday+1
	LDS        R2, _Jmonth+0
	LDS        R3, _Jmonth+1
	LDS        R16, _seconds+0
	LDI        R27, 0
	PUSH       R27
	PUSH       R16
	LDS        R16, _minutes+0
	LDI        R27, 0
	PUSH       R27
	PUSH       R16
	LDS        R16, _hours+0
	LDI        R27, 0
	PUSH       R27
	PUSH       R16
	CALL       _Shamsi_show_lcd+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 6
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;MyProject.mbas,362 :: 		miladi_call(jmonth,jday,jyear,week,hours ,minutes,seconds )
	LDS        R8, _week+0
	LDI        R27, 0
	MOV        R9, R27
	LDS        R6, _Jyear+0
	LDS        R7, _Jyear+1
	LDS        R4, _Jday+0
	LDS        R5, _Jday+1
	LDS        R2, _Jmonth+0
	LDS        R3, _Jmonth+1
	LDS        R16, _seconds+0
	LDI        R27, 0
	PUSH       R27
	PUSH       R16
	LDS        R16, _minutes+0
	LDI        R27, 0
	PUSH       R27
	PUSH       R16
	LDS        R16, _hours+0
	LDI        R27, 0
	PUSH       R27
	PUSH       R16
	CALL       _miladi_call+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 6
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;MyProject.mbas,377 :: 		PWM_Initialize ()
	CALL       _PWM_Initialize+0
;MyProject.mbas,381 :: 		Interupt_first_time=0 Interupt_first_time2=0
	LDI        R27, 0
	STS        _Interupt_first_time+0, R27
	LDI        R27, 0
	STS        _Interupt_first_time2+0, R27
;MyProject.mbas,382 :: 		ISC20_Bit = 1                                    '' // Set interrupts to be detected on rising edge
	LDS        R27, ISC20_bit+0
	SBR        R27, BitMask(ISC20_bit+0)
	STS        ISC20_bit+0, R27
;MyProject.mbas,383 :: 		ISC00_bit = 1
	LDS        R27, ISC00_bit+0
	SBR        R27, BitMask(ISC00_bit+0)
	STS        ISC00_bit+0, R27
;MyProject.mbas,384 :: 		INTF2_bit = 0
	IN         R27, INTF2_bit+0
	CBR        R27, BitMask(INTF2_bit+0)
	OUT        INTF2_bit+0, R27
;MyProject.mbas,385 :: 		SREG_I_bit = 0
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;MyProject.mbas,386 :: 		Delay_ms(100)                                  ''  // Enable Interrupts
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L__main28:
	DEC        R16
	BRNE       L__main28
	DEC        R17
	BRNE       L__main28
	DEC        R18
	BRNE       L__main28
;MyProject.mbas,389 :: 		INT2_bit =1
	IN         R27, INT2_bit+0
	SBR        R27, BitMask(INT2_bit+0)
	OUT        INT2_bit+0, R27
;MyProject.mbas,390 :: 		INT6_bit =1
	IN         R27, INT6_bit+0
	SBR        R27, BitMask(INT6_bit+0)
	OUT        INT6_bit+0, R27
;MyProject.mbas,391 :: 		SREG_I_bit = 1
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;MyProject.mbas,396 :: 		chanel=1
	LDI        R27, 1
	STS        _chanel+0, R27
;MyProject.mbas,397 :: 		Lcd_0()
	CALL       _Lcd_0+0
;MyProject.mbas,398 :: 		while TRUE
L__main31:
;MyProject.mbas,401 :: 		Lcd_Out(1,1,"main ")
	MOVW       R30, R28
	LDI        R27, 109
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
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
;MyProject.mbas,407 :: 		wend
	JMP        L__main31
L_end_main:
	POP        R9
	POP        R8
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
