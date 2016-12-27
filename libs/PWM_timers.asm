
_pwm_set_1B:

;libs/PWM_timers.mbas,39 :: 		Sub procedure pwm_set_1B(dim pulse_width as  char )
;libs/PWM_timers.mbas,41 :: 		OCR1BL = pulse_width ''  //Load Pulse width
	OUT        OCR1BL+0, R2
;libs/PWM_timers.mbas,42 :: 		OCR1AL = pulse_width ''  //Load Pulse width
	OUT        OCR1AL+0, R2
;libs/PWM_timers.mbas,43 :: 		OCR0 = pulse_width
	OUT        OCR0+0, R2
;libs/PWM_timers.mbas,44 :: 		OCR2 = pulse_width
	OUT        OCR2+0, R2
;libs/PWM_timers.mbas,49 :: 		TCCR0 = (1<<FOC2)or (1<<COM21)or(1<<COM20) or(1<<WGM20) or (1<<CS00)
	LDI        R27, 241
	OUT        TCCR0+0, R27
;libs/PWM_timers.mbas,50 :: 		TCCR1A  = (1<<FOC2)or(1<<COM21)or(1<<COM20)or (1<<WGM20)or(1<<CS00)
	LDI        R27, 241
	OUT        TCCR1A+0, R27
;libs/PWM_timers.mbas,51 :: 		TCCR2 = (1<<FOC2)or(1<<COM21)or(1<<COM20)or(1<<WGM20) or(1<<CS00)
	LDI        R27, 241
	OUT        TCCR2+0, R27
;libs/PWM_timers.mbas,53 :: 		TCCR1B = 1<<CS10
	LDI        R27, 1
	OUT        TCCR1B+0, R27
;libs/PWM_timers.mbas,54 :: 		end sub
L_end_pwm_set_1B:
	RET
; end of _pwm_set_1B

libs/PWM_timers_Timer2_Compare:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;libs/PWM_timers.mbas,56 :: 		Sub procedure Timer2_Compare iv IVT_ADDR_TIMER2_COMP 'L?st aus alle (8Mhz/1024/125) 16ms
;libs/PWM_timers.mbas,57 :: 		inc(_ss)
	LDS        R16, __ss+0
	LDS        R17, __ss+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        __ss+0, R16
	STS        __ss+1, R17
;libs/PWM_timers.mbas,58 :: 		End sub
L_end_Timer2_Compare:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of libs/PWM_timers_Timer2_Compare

libs/PWM_timers_Timer0_overflow:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;libs/PWM_timers.mbas,60 :: 		sub procedure Timer0_overflow iv IVT_ADDR_TIMER0_OVF
;libs/PWM_timers.mbas,61 :: 		inc(_zz)
	LDS        R16, __zz+0
	LDS        R17, __zz+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        __zz+0, R16
	STS        __zz+1, R17
;libs/PWM_timers.mbas,62 :: 		TIFR.TOV0=0
	IN         R27, TIFR+0
	CBR        R27, 1
	OUT        TIFR+0, R27
;libs/PWM_timers.mbas,64 :: 		end sub
L_end_Timer0_overflow:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of libs/PWM_timers_Timer0_overflow

libs/PWM_timers_SetRegister:

;libs/PWM_timers.mbas,66 :: 		sub procedure SetRegister()
;libs/PWM_timers.mbas,76 :: 		TCCR2.WGM21=1 'CTC Mode Aktivierung Timer2
	IN         R27, TCCR2+0
	SBR        R27, 8
	OUT        TCCR2+0, R27
;libs/PWM_timers.mbas,77 :: 		TCCR2.COM20=1 'set OCR Flag bei "Compare Match"
	IN         R27, TCCR2+0
	SBR        R27, 16
	OUT        TCCR2+0, R27
;libs/PWM_timers.mbas,78 :: 		TCCR2.COM21=1 'set OCR Flag bei "Compare Match"
	IN         R27, TCCR2+0
	SBR        R27, 32
	OUT        TCCR2+0, R27
;libs/PWM_timers.mbas,80 :: 		TCCR0.CS02=1 'Ext Flanke Interrupt (T0)
	IN         R27, TCCR0+0
	SBR        R27, 4
	OUT        TCCR0+0, R27
;libs/PWM_timers.mbas,81 :: 		TCCR0.CS01=1
	IN         R27, TCCR0+0
	SBR        R27, 2
	OUT        TCCR0+0, R27
;libs/PWM_timers.mbas,82 :: 		TCCR0.CS00=1
	IN         R27, TCCR0+0
	SBR        R27, 1
	OUT        TCCR0+0, R27
;libs/PWM_timers.mbas,84 :: 		TCCR2.CS22=1 'Set Prescaler Timer2 1024 setzen
	IN         R27, TCCR2+0
	SBR        R27, 4
	OUT        TCCR2+0, R27
;libs/PWM_timers.mbas,85 :: 		TCCR2.CS21=1
	IN         R27, TCCR2+0
	SBR        R27, 2
	OUT        TCCR2+0, R27
;libs/PWM_timers.mbas,86 :: 		TCCR2.CS20=1
	IN         R27, TCCR2+0
	SBR        R27, 1
	OUT        TCCR2+0, R27
;libs/PWM_timers.mbas,88 :: 		OCR2=124 'Set Output Compare register Timer2 to 124 (for Loop 0-124 => 125)
	LDI        R27, 124
	OUT        OCR2+0, R27
;libs/PWM_timers.mbas,89 :: 		TIMSK.OCIE2=1 ' Enable comp match flag interrupt Timer 2
	IN         R27, TIMSK+0
	SBR        R27, 128
	OUT        TIMSK+0, R27
;libs/PWM_timers.mbas,90 :: 		TIMSK.TOIE0=1 ' Enable OV flag interrupt Timer 0
	IN         R27, TIMSK+0
	SBR        R27, 1
	OUT        TIMSK+0, R27
;libs/PWM_timers.mbas,91 :: 		SREG.SREG_I=1
	IN         R27, SREG+0
	SBR        R27, 128
	OUT        SREG+0, R27
;libs/PWM_timers.mbas,92 :: 		End Sub
L_end_SetRegister:
	RET
; end of libs/PWM_timers_SetRegister

_SetPWM0:

;libs/PWM_timers.mbas,95 :: 		sub procedure SetPWM0(dim duty as integer)
;libs/PWM_timers.mbas,98 :: 		OCR0=duty
	OUT        OCR0+0, R2
;libs/PWM_timers.mbas,99 :: 		end sub
L_end_SetPWM0:
	RET
; end of _SetPWM0

libs/PWM_timers_PWM_MAKE_as_max:

;libs/PWM_timers.mbas,103 :: 		jjyear as float
;libs/PWM_timers.mbas,105 :: 		jjyear=ceil((jj*max_duty)/100)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	MOV        R16, R2
	LDI        R17, 0
	MOV        R18, R17
	MOV        R19, R17
	MOV        R20, R3
	MOV        R21, R4
	LDI        R22, 0
	SBRC       R4, 7
	LDI        R22, 255
	MOV        R23, R22
	CALL       _HWMul_32x32+0
	CALL       _float_slong2fp+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 200
	LDI        R23, 66
	CALL       _float_fpdiv1+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _ceil+0
;libs/PWM_timers.mbas,106 :: 		FloatToStr(jjyear, st)
	LDI        R27, #lo_addr(_st+0)
	MOV        R6, R27
	LDI        R27, hi_addr(_st+0)
	MOV        R7, R27
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _FloatToStr+0
;libs/PWM_timers.mbas,111 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/PWM_timers.mbas,113 :: 		strToInt1()
	CALL       _strToInt1+0
;libs/PWM_timers.mbas,115 :: 		IntToStr(ii, txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _output+0
	LDS        R3, _output+1
	CALL       _IntToStr+0
;libs/PWM_timers.mbas,116 :: 		Lcd_Out(1,1,st)
	LDI        R27, #lo_addr(_st+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_st+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/PWM_timers.mbas,117 :: 		Lcd_Out(2,1,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/PWM_timers.mbas,118 :: 		Delay_mS(1000)
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_libs/PWM_timers_PWM_MAKE_as_max6:
	DEC        R16
	BRNE       L_libs/PWM_timers_PWM_MAKE_as_max6
	DEC        R17
	BRNE       L_libs/PWM_timers_PWM_MAKE_as_max6
	DEC        R18
	BRNE       L_libs/PWM_timers_PWM_MAKE_as_max6
;libs/PWM_timers.mbas,119 :: 		end sub
L_end_PWM_MAKE_as_max:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of libs/PWM_timers_PWM_MAKE_as_max

_PWM_MAKE:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/PWM_timers.mbas,123 :: 		jjyear as float
;libs/PWM_timers.mbas,125 :: 		jjyear=ceil((jj*max_duty)/100)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R6
	PUSH       R7
	MOV        R16, R2
	LDI        R17, 0
	MOV        R18, R17
	MOV        R19, R17
	MOV        R20, R3
	MOV        R21, R4
	LDI        R22, 0
	SBRC       R4, 7
	LDI        R22, 255
	MOV        R23, R22
	CALL       _HWMul_32x32+0
	CALL       _float_slong2fp+0
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 200
	LDI        R23, 66
	CALL       _float_fpdiv1+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _ceil+0
	STD        Y+2, R16
	STD        Y+3, R17
	STD        Y+4, R18
	STD        Y+5, R19
;libs/PWM_timers.mbas,126 :: 		FloatToStr(jjyear, st)
	LDI        R27, #lo_addr(_st+0)
	MOV        R6, R27
	LDI        R27, hi_addr(_st+0)
	MOV        R7, R27
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _FloatToStr+0
;libs/PWM_timers.mbas,131 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/PWM_timers.mbas,135 :: 		ii = integer (jjyear)
	LDD        R16, Y+2
	LDD        R17, Y+3
	LDD        R18, Y+4
	LDD        R19, Y+5
	CALL       _float_fpint+0
	STD        Y+0, R16
	STD        Y+1, R17
;libs/PWM_timers.mbas,136 :: 		IntToStr(ii, txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _IntToStr+0
;libs/PWM_timers.mbas,137 :: 		Lcd_Out(1,1,st)
	LDI        R27, #lo_addr(_st+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_st+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/PWM_timers.mbas,138 :: 		Lcd_Out(2,6,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	POP        R2
;libs/PWM_timers.mbas,139 :: 		IntToStr(jj, txt)
	PUSH       R2
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _IntToStr+0
;libs/PWM_timers.mbas,140 :: 		Lcd_Out(2,1,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;libs/PWM_timers.mbas,144 :: 		case 1
	LDI        R27, 1
	CP         R5, R27
	BREQ       L__PWM_MAKE123
	JMP        L__PWM_MAKE12
L__PWM_MAKE123:
;libs/PWM_timers.mbas,147 :: 		PWM16bit_Change_Duty(ii, _TIMER1_CH_A )
	LDI        R27, 17
	MOV        R4, R27
	LDD        R2, Y+0
	LDD        R3, Y+1
	CALL       _PWM16bit_Change_Duty+0
	JMP        L__PWM_MAKE9
L__PWM_MAKE12:
;libs/PWM_timers.mbas,148 :: 		case 2
	LDI        R27, 2
	CP         R5, R27
	BREQ       L__PWM_MAKE124
	JMP        L__PWM_MAKE15
L__PWM_MAKE124:
;libs/PWM_timers.mbas,151 :: 		PWM16bit_Change_Duty(ii,_TIMER1_CH_B )
	LDI        R27, 18
	MOV        R4, R27
	LDD        R2, Y+0
	LDD        R3, Y+1
	CALL       _PWM16bit_Change_Duty+0
	JMP        L__PWM_MAKE9
L__PWM_MAKE15:
;libs/PWM_timers.mbas,152 :: 		case 3
	LDI        R27, 3
	CP         R5, R27
	BREQ       L__PWM_MAKE125
	JMP        L__PWM_MAKE18
L__PWM_MAKE125:
;libs/PWM_timers.mbas,156 :: 		PWM16bit_Change_Duty(ii,2 )
	LDI        R27, 2
	MOV        R4, R27
	LDD        R2, Y+0
	LDD        R3, Y+1
	CALL       _PWM16bit_Change_Duty+0
	JMP        L__PWM_MAKE9
L__PWM_MAKE18:
;libs/PWM_timers.mbas,157 :: 		case 4
	LDI        R27, 4
	CP         R5, R27
	BREQ       L__PWM_MAKE126
	JMP        L__PWM_MAKE21
L__PWM_MAKE126:
;libs/PWM_timers.mbas,160 :: 		if jj=0 then
	LDI        R27, 0
	CP         R2, R27
	BREQ       L__PWM_MAKE127
	JMP        L__PWM_MAKE23
L__PWM_MAKE127:
;libs/PWM_timers.mbas,161 :: 		SetPWM0(max_duty-ii)
	LDD        R0, Y+0
	LDD        R1, Y+1
	MOV        R16, R3
	MOV        R17, R4
	SUB        R16, R0
	SBC        R17, R1
	MOVW       R2, R16
	CALL       _SetPWM0+0
	JMP        L__PWM_MAKE24
;libs/PWM_timers.mbas,162 :: 		else
L__PWM_MAKE23:
;libs/PWM_timers.mbas,163 :: 		SetPWM0(max_duty-ii)
	LDD        R0, Y+0
	LDD        R1, Y+1
	MOV        R16, R3
	MOV        R17, R4
	SUB        R16, R0
	SBC        R17, R1
	MOVW       R2, R16
	CALL       _SetPWM0+0
;libs/PWM_timers.mbas,165 :: 		end if
L__PWM_MAKE24:
	JMP        L__PWM_MAKE9
L__PWM_MAKE21:
;libs/PWM_timers.mbas,168 :: 		case 5
	LDI        R27, 5
	CP         R5, R27
	BREQ       L__PWM_MAKE128
	JMP        L__PWM_MAKE27
L__PWM_MAKE128:
	JMP        L__PWM_MAKE9
L__PWM_MAKE27:
;libs/PWM_timers.mbas,172 :: 		case 6
	LDI        R27, 6
	CP         R5, R27
	BREQ       L__PWM_MAKE129
	JMP        L__PWM_MAKE30
L__PWM_MAKE129:
	JMP        L__PWM_MAKE9
L__PWM_MAKE30:
;libs/PWM_timers.mbas,176 :: 		case 7
	LDI        R27, 7
	CP         R5, R27
	BREQ       L__PWM_MAKE130
	JMP        L__PWM_MAKE33
L__PWM_MAKE130:
	JMP        L__PWM_MAKE9
L__PWM_MAKE33:
L__PWM_MAKE9:
;libs/PWM_timers.mbas,181 :: 		end sub
L_end_PWM_MAKE:
	POP        R7
	POP        R6
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 5
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _PWM_MAKE

libs/PWM_timers_PWM_MAKE_Stop:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/PWM_timers.mbas,185 :: 		jjyear as float
;libs/PWM_timers.mbas,187 :: 		jjyear=ceil((jj*max_duty)/100)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R6
	PUSH       R7
	MOV        R16, R2
	LDI        R17, 0
	MOV        R18, R17
	MOV        R19, R17
	MOV        R20, R3
	MOV        R21, R4
	LDI        R22, 0
	SBRC       R4, 7
	LDI        R22, 255
	MOV        R23, R22
	CALL       _HWMul_32x32+0
	CALL       _float_slong2fp+0
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 200
	LDI        R23, 66
	CALL       _float_fpdiv1+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _ceil+0
	STD        Y+2, R16
	STD        Y+3, R17
	STD        Y+4, R18
	STD        Y+5, R19
;libs/PWM_timers.mbas,188 :: 		FloatToStr(jjyear, st)
	LDI        R27, #lo_addr(_st+0)
	MOV        R6, R27
	LDI        R27, hi_addr(_st+0)
	MOV        R7, R27
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _FloatToStr+0
;libs/PWM_timers.mbas,193 :: 		Lcd_0()
	CALL       _Lcd_0+0
;libs/PWM_timers.mbas,197 :: 		ii = integer (jjyear)
	LDD        R16, Y+2
	LDD        R17, Y+3
	LDD        R18, Y+4
	LDD        R19, Y+5
	CALL       _float_fpint+0
	STD        Y+0, R16
	STD        Y+1, R17
;libs/PWM_timers.mbas,198 :: 		IntToStr(ii, txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _IntToStr+0
;libs/PWM_timers.mbas,199 :: 		Lcd_Out(1,1,st)
	LDI        R27, #lo_addr(_st+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_st+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/PWM_timers.mbas,200 :: 		Lcd_Out(2,6,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	POP        R2
;libs/PWM_timers.mbas,201 :: 		IntToStr(jj, txt)
	PUSH       R2
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _IntToStr+0
;libs/PWM_timers.mbas,202 :: 		Lcd_Out(2,1,txt)
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;libs/PWM_timers.mbas,206 :: 		case 2
	LDI        R27, 2
	CP         R5, R27
	BREQ       L_libs/PWM_timers_PWM_MAKE_Stop132
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop38
L_libs/PWM_timers_PWM_MAKE_Stop132:
;libs/PWM_timers.mbas,209 :: 		PWM16bit_Stop( _TIMER1_CH_A ) 'PWM16bit_Change_Duty(ii, _TIMER1_CH_A )
	LDI        R27, 17
	MOV        R2, R27
	CALL       _PWM16bit_Stop+0
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop35
L_libs/PWM_timers_PWM_MAKE_Stop38:
;libs/PWM_timers.mbas,210 :: 		case 3
	LDI        R27, 3
	CP         R5, R27
	BREQ       L_libs/PWM_timers_PWM_MAKE_Stop133
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop41
L_libs/PWM_timers_PWM_MAKE_Stop133:
;libs/PWM_timers.mbas,213 :: 		PWM16bit_Stop( _TIMER1_CH_B ) 'PWM16bit_Change_Duty(ii,_TIMER1_CH_B )
	LDI        R27, 18
	MOV        R2, R27
	CALL       _PWM16bit_Stop+0
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop35
L_libs/PWM_timers_PWM_MAKE_Stop41:
;libs/PWM_timers.mbas,214 :: 		case 4
	LDI        R27, 4
	CP         R5, R27
	BREQ       L_libs/PWM_timers_PWM_MAKE_Stop134
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop44
L_libs/PWM_timers_PWM_MAKE_Stop134:
;libs/PWM_timers.mbas,218 :: 		PWM16bit_Stop( 2 ) 'PWM16bit_Change_Duty(ii,2 )
	LDI        R27, 2
	MOV        R2, R27
	CALL       _PWM16bit_Stop+0
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop35
L_libs/PWM_timers_PWM_MAKE_Stop44:
;libs/PWM_timers.mbas,219 :: 		case 1
	LDI        R27, 1
	CP         R5, R27
	BREQ       L_libs/PWM_timers_PWM_MAKE_Stop135
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop47
L_libs/PWM_timers_PWM_MAKE_Stop135:
;libs/PWM_timers.mbas,222 :: 		if jj=0 then
	LDI        R27, 0
	CP         R2, R27
	BREQ       L_libs/PWM_timers_PWM_MAKE_Stop136
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop49
L_libs/PWM_timers_PWM_MAKE_Stop136:
;libs/PWM_timers.mbas,223 :: 		SetPWM0(max_duty-ii)
	LDD        R0, Y+0
	LDD        R1, Y+1
	MOV        R16, R3
	MOV        R17, R4
	SUB        R16, R0
	SBC        R17, R1
	MOVW       R2, R16
	CALL       _SetPWM0+0
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop50
;libs/PWM_timers.mbas,224 :: 		else
L_libs/PWM_timers_PWM_MAKE_Stop49:
;libs/PWM_timers.mbas,225 :: 		SetPWM0(max_duty-ii)
	LDD        R0, Y+0
	LDD        R1, Y+1
	MOV        R16, R3
	MOV        R17, R4
	SUB        R16, R0
	SBC        R17, R1
	MOVW       R2, R16
	CALL       _SetPWM0+0
;libs/PWM_timers.mbas,227 :: 		end if
L_libs/PWM_timers_PWM_MAKE_Stop50:
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop35
L_libs/PWM_timers_PWM_MAKE_Stop47:
;libs/PWM_timers.mbas,230 :: 		case 5
	LDI        R27, 5
	CP         R5, R27
	BREQ       L_libs/PWM_timers_PWM_MAKE_Stop137
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop53
L_libs/PWM_timers_PWM_MAKE_Stop137:
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop35
L_libs/PWM_timers_PWM_MAKE_Stop53:
;libs/PWM_timers.mbas,234 :: 		case 6
	LDI        R27, 6
	CP         R5, R27
	BREQ       L_libs/PWM_timers_PWM_MAKE_Stop138
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop56
L_libs/PWM_timers_PWM_MAKE_Stop138:
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop35
L_libs/PWM_timers_PWM_MAKE_Stop56:
;libs/PWM_timers.mbas,238 :: 		case 7
	LDI        R27, 7
	CP         R5, R27
	BREQ       L_libs/PWM_timers_PWM_MAKE_Stop139
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop59
L_libs/PWM_timers_PWM_MAKE_Stop139:
	JMP        L_libs/PWM_timers_PWM_MAKE_Stop35
L_libs/PWM_timers_PWM_MAKE_Stop59:
L_libs/PWM_timers_PWM_MAKE_Stop35:
;libs/PWM_timers.mbas,243 :: 		end sub
L_end_PWM_MAKE_Stop:
	POP        R7
	POP        R6
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 5
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of libs/PWM_timers_PWM_MAKE_Stop

_PWM_Port_Initialize:

;libs/PWM_timers.mbas,245 :: 		sub procedure PWM_Port_Initialize ()
;libs/PWM_timers.mbas,248 :: 		DDB4_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB4_bit+0
	SBR        R27, BitMask(DDB4_bit+0)
	OUT        DDB4_bit+0, R27
;libs/PWM_timers.mbas,249 :: 		DDB5_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB5_bit+0
	SBR        R27, BitMask(DDB5_bit+0)
	OUT        DDB5_bit+0, R27
;libs/PWM_timers.mbas,250 :: 		DDB6_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB6_bit+0
	SBR        R27, BitMask(DDB6_bit+0)
	OUT        DDB6_bit+0, R27
;libs/PWM_timers.mbas,251 :: 		DDB7_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB7_bit+0
	SBR        R27, BitMask(DDB7_bit+0)
	OUT        DDB7_bit+0, R27
;libs/PWM_timers.mbas,261 :: 		end  sub
L_end_PWM_Port_Initialize:
	RET
; end of _PWM_Port_Initialize

_PWM_Initialize:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 3
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/PWM_timers.mbas,266 :: 		k as integer
;libs/PWM_timers.mbas,267 :: 		J=0
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 0
	STD        Y+0, R27
;libs/PWM_timers.mbas,278 :: 		TCCR0=(1<<WGM00) or (1<<COM01) or (1<<COM00) or (1<<WGM01) or (1<<CS02) or (0<<CS01) or (1<<CS00)
	LDI        R27, 125
	OUT        TCCR0+0, R27
;libs/PWM_timers.mbas,279 :: 		TCNT0=0x00
	LDI        R27, 0
	OUT        TCNT0+0, R27
;libs/PWM_timers.mbas,282 :: 		PWM16bit_Init(_PWM16_PHASE_CORRECT_MODE_8BIT, _PWM16_PRESCALER_16bit_8, _PWM16_NON_INVERTED, j , _TIMER1)
	LDI        R27, 1
	MOV        R7, R27
	CLR        R5
	CLR        R6
	LDI        R27, 168
	MOV        R4, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 11
	MOV        R2, R27
	CALL       _PWM16bit_Init+0
;libs/PWM_timers.mbas,283 :: 		PWM16bit_Init(_PWM16_PHASE_CORRECT_MODE_8BIT, _PWM16_PRESCALER_16bit_8, _PWM16_NON_INVERTED, j , 2)
	LDI        R27, 2
	MOV        R7, R27
	LDD        R5, Y+0
	LDI        R27, 0
	MOV        R6, R27
	LDI        R27, 168
	MOV        R4, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 11
	MOV        R2, R27
	CALL       _PWM16bit_Init+0
;libs/PWM_timers.mbas,286 :: 		PWM1_Set_Duty(j)
	LDD        R2, Y+0
	CALL       _PWM1_Set_Duty+0
;libs/PWM_timers.mbas,287 :: 		PWM2_Set_Duty(j)
	LDD        R2, Y+0
	CALL       _PWM2_Set_Duty+0
;libs/PWM_timers.mbas,289 :: 		ocr0=0 ocr2=0
	LDI        R27, 0
	OUT        OCR0+0, R27
	LDI        R27, 0
	OUT        OCR2+0, R27
;libs/PWM_timers.mbas,291 :: 		for k=10 to 0  step -5
	LDI        R27, 10
	STD        Y+1, R27
	LDI        R27, 0
	STD        Y+2, R27
L__PWM_Initialize62:
	LDD        R18, Y+1
	LDD        R19, Y+2
	LDI        R16, 0
	LDI        R17, 0
	CP         R18, R16
	CPC        R19, R17
	BRGE       L__PWM_Initialize142
	JMP        L__PWM_Initialize66
L__PWM_Initialize142:
;libs/PWM_timers.mbas,292 :: 		PWM_MAKE (k*10,255,1)''(dim jj as byte,dim max_duty,Pwm_chanel as integer)
	LDD        R20, Y+1
	LDD        R21, Y+2
	LDI        R16, 10
	MUL        R20, R16
	MOV        R16, R0
	LDI        R27, 1
	MOV        R5, R27
	LDI        R27, 255
	MOV        R3, R27
	LDI        R27, 0
	MOV        R4, R27
	MOV        R2, R16
	CALL       _PWM_MAKE+0
;libs/PWM_timers.mbas,293 :: 		PWM_MAKE (k*10,255,2)''(dim jj as byte,dim max_duty,Pwm_chanel as integer)
	LDD        R20, Y+1
	LDD        R21, Y+2
	LDI        R16, 10
	MUL        R20, R16
	MOV        R16, R0
	LDI        R27, 2
	MOV        R5, R27
	LDI        R27, 255
	MOV        R3, R27
	LDI        R27, 0
	MOV        R4, R27
	MOV        R2, R16
	CALL       _PWM_MAKE+0
;libs/PWM_timers.mbas,294 :: 		PWM_MAKE (k*10,255,3)''(dim jj as byte,dim max_duty,Pwm_chanel as integer)
	LDD        R20, Y+1
	LDD        R21, Y+2
	LDI        R16, 10
	MUL        R20, R16
	MOV        R16, R0
	LDI        R27, 3
	MOV        R5, R27
	LDI        R27, 255
	MOV        R3, R27
	LDI        R27, 0
	MOV        R4, R27
	MOV        R2, R16
	CALL       _PWM_MAKE+0
;libs/PWM_timers.mbas,295 :: 		PWM_MAKE (k*10,255,4)''(dim jj as byte,dim max_duty,Pwm_chanel as integer)
	LDD        R20, Y+1
	LDD        R21, Y+2
	LDI        R16, 10
	MUL        R20, R16
	MOV        R16, R0
	LDI        R27, 4
	MOV        R5, R27
	LDI        R27, 255
	MOV        R3, R27
	LDI        R27, 0
	MOV        R4, R27
	MOV        R2, R16
	CALL       _PWM_MAKE+0
;libs/PWM_timers.mbas,296 :: 		delay_ms(50)
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L__PWM_Initialize67:
	DEC        R16
	BRNE       L__PWM_Initialize67
	DEC        R17
	BRNE       L__PWM_Initialize67
	DEC        R18
	BRNE       L__PWM_Initialize67
;libs/PWM_timers.mbas,297 :: 		next k
	LDD        R16, Y+1
	LDD        R17, Y+2
	CPI        R17, 0
	BRNE       L__PWM_Initialize143
	CPI        R16, 0
L__PWM_Initialize143:
	BRNE       L__PWM_Initialize144
	JMP        L__PWM_Initialize66
L__PWM_Initialize144:
	LDD        R16, Y+1
	LDD        R17, Y+2
	SUBI       R16, 5
	SBCI       R17, 0
	STD        Y+1, R16
	STD        Y+2, R17
	JMP        L__PWM_Initialize62
L__PWM_Initialize66:
;libs/PWM_timers.mbas,298 :: 		PWM_MAKE (0,255,4)''(dim jj as byte,dim max_duty,Pwm_chanel as integer)
	LDI        R27, 4
	MOV        R5, R27
	LDI        R27, 255
	MOV        R3, R27
	LDI        R27, 0
	MOV        R4, R27
	CLR        R2
	CALL       _PWM_MAKE+0
;libs/PWM_timers.mbas,316 :: 		end sub
L_end_PWM_Initialize:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _PWM_Initialize

libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 27
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/PWM_timers.mbas,319 :: 		dim Pwm_chanel_ini,chanel_ini,week_ini as byte
;libs/PWM_timers.mbas,320 :: 		Lcd_0() lcd_out(1,1,"Initialsiing on_a_0")
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _Lcd_0+0
	MOVW       R30, R28
	ADIW       R30, 3
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 108
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
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
	SUBI       R16, 253
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
;libs/PWM_timers.mbas,321 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond70:
	DEC        R16
	BRNE       L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond70
	DEC        R17
	BRNE       L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond70
	DEC        R18
	BRNE       L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond70
	NOP
;libs/PWM_timers.mbas,322 :: 		for week_ini =1 to 7
	LDI        R27, 1
	STD        Y+2, R27
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond73:
;libs/PWM_timers.mbas,323 :: 		for Pwm_chanel_ini=1 to 7
	LDI        R27, 1
	STD        Y+0, R27
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond78:
;libs/PWM_timers.mbas,324 :: 		for chanel_ini =1 to 1
	LDI        R27, 1
	STD        Y+1, R27
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond83:
;libs/PWM_timers.mbas,325 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][0] =en
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	ST         Z, R3
;libs/PWM_timers.mbas,326 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][1]=hr
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R4
;libs/PWM_timers.mbas,327 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][2] =mint
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R5
;libs/PWM_timers.mbas,328 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][3]=prc
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R6
;libs/PWM_timers.mbas,331 :: 		next chanel_ini
	LDD        R16, Y+1
	CPI        R16, 1
	BRNE       L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond146
	JMP        L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond86
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond146:
	LDD        R16, Y+1
	SUBI       R16, 255
	STD        Y+1, R16
	JMP        L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond83
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond86:
;libs/PWM_timers.mbas,332 :: 		for chanel_ini =2 to 4
	LDI        R27, 2
	STD        Y+1, R27
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond88:
;libs/PWM_timers.mbas,333 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][0] =0
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LDI        R27, 0
	ST         Z, R27
;libs/PWM_timers.mbas,334 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][1]=hr
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R4
;libs/PWM_timers.mbas,335 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][2] =mint
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R5
;libs/PWM_timers.mbas,336 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][3]=0
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	LDI        R27, 0
	ST         Z, R27
;libs/PWM_timers.mbas,339 :: 		next chanel_ini
	LDD        R16, Y+1
	CPI        R16, 4
	BRNE       L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond147
	JMP        L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond91
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond147:
	LDD        R16, Y+1
	SUBI       R16, 255
	STD        Y+1, R16
	JMP        L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond88
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond91:
;libs/PWM_timers.mbas,340 :: 		next Pwm_chanel_ini
	LDD        R16, Y+0
	CPI        R16, 7
	BRNE       L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond148
	JMP        L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond81
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond148:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond78
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond81:
;libs/PWM_timers.mbas,341 :: 		next week_ini
	LDD        R16, Y+2
	CPI        R16, 7
	BRNE       L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond149
	JMP        L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond76
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond149:
	LDD        R16, Y+2
	SUBI       R16, 255
	STD        Y+2, R16
	JMP        L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond73
L_libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond76:
;libs/PWM_timers.mbas,343 :: 		end sub
L_end_on_off_initial_old_chnged_newxt_hourtosecond:
	ADIW       R28, 26
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of libs/PWM_timers_on_off_initial_old_chnged_newxt_hourtosecond

_on_off_initial:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 27
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/PWM_timers.mbas,347 :: 		dim Pwm_chanel_ini,chanel_ini,week_ini as byte
;libs/PWM_timers.mbas,348 :: 		Lcd_0() lcd_out(1,1,"Initialsiing on_a_0")
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _Lcd_0+0
	MOVW       R30, R28
	ADIW       R30, 3
	LDI        R27, 73
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 108
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 105
	ST         Z+, R27
	LDI        R27, 110
	ST         Z+, R27
	LDI        R27, 103
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
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
	SUBI       R16, 253
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
;libs/PWM_timers.mbas,349 :: 		delay_ms(500)
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L__on_off_initial93:
	DEC        R16
	BRNE       L__on_off_initial93
	DEC        R17
	BRNE       L__on_off_initial93
	DEC        R18
	BRNE       L__on_off_initial93
	NOP
;libs/PWM_timers.mbas,350 :: 		for week_ini =1 to 7
	LDI        R27, 1
	STD        Y+2, R27
L__on_off_initial96:
;libs/PWM_timers.mbas,351 :: 		for Pwm_chanel_ini=1 to 7
	LDI        R27, 1
	STD        Y+0, R27
L__on_off_initial101:
;libs/PWM_timers.mbas,352 :: 		for chanel_ini =1 to 1
	LDI        R27, 1
	STD        Y+1, R27
L__on_off_initial106:
;libs/PWM_timers.mbas,353 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][0] =en
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	ST         Z, R3
;libs/PWM_timers.mbas,354 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][1]=hr
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R4
;libs/PWM_timers.mbas,355 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][2] =mint
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R5
;libs/PWM_timers.mbas,356 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][3]=prc
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R6
;libs/PWM_timers.mbas,359 :: 		next chanel_ini
	LDD        R16, Y+1
	CPI        R16, 1
	BRNE       L__on_off_initial151
	JMP        L__on_off_initial109
L__on_off_initial151:
	LDD        R16, Y+1
	SUBI       R16, 255
	STD        Y+1, R16
	JMP        L__on_off_initial106
L__on_off_initial109:
;libs/PWM_timers.mbas,360 :: 		for chanel_ini =2 to 4
	LDI        R27, 2
	STD        Y+1, R27
L__on_off_initial111:
;libs/PWM_timers.mbas,361 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][0] =0
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
	SUBI       R16, 1
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LDI        R27, 0
	ST         Z, R27
;libs/PWM_timers.mbas,362 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][1]=hr
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R4
;libs/PWM_timers.mbas,363 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][2] =mint
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	ST         Z, R5
;libs/PWM_timers.mbas,364 :: 		on_a_0 [week_ini-1][chanel_ini-1][Pwm_chanel_ini-1][on_off22-1][3]=0
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
	LDD        R20, Y+1
	SUBI       R20, 1
	STD        Y+25, R16
	STD        Y+26, R17
	LDI        R16, 56
	LDI        R17, 0
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDD        R18, Y+25
	LDD        R19, Y+26
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+0
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
	MOV        R16, R2
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
	LDI        R27, 0
	ST         Z, R27
;libs/PWM_timers.mbas,367 :: 		next chanel_ini
	LDD        R16, Y+1
	CPI        R16, 4
	BRNE       L__on_off_initial152
	JMP        L__on_off_initial114
L__on_off_initial152:
	LDD        R16, Y+1
	SUBI       R16, 255
	STD        Y+1, R16
	JMP        L__on_off_initial111
L__on_off_initial114:
;libs/PWM_timers.mbas,368 :: 		next Pwm_chanel_ini
	LDD        R16, Y+0
	CPI        R16, 7
	BRNE       L__on_off_initial153
	JMP        L__on_off_initial104
L__on_off_initial153:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L__on_off_initial101
L__on_off_initial104:
;libs/PWM_timers.mbas,369 :: 		next week_ini
	LDD        R16, Y+2
	CPI        R16, 7
	BRNE       L__on_off_initial154
	JMP        L__on_off_initial99
L__on_off_initial154:
	LDD        R16, Y+2
	SUBI       R16, 255
	STD        Y+2, R16
	JMP        L__on_off_initial96
L__on_off_initial99:
;libs/PWM_timers.mbas,371 :: 		end sub
L_end_on_off_initial:
	ADIW       R28, 26
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _on_off_initial

_WDT_on:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 7
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/PWM_timers.mbas,373 :: 		sub procedure  WDT_on()
;libs/PWM_timers.mbas,405 :: 		WDTCR =(1<<WDP2) or (1<<WDP1)  or (1<<WDP0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 7
	OUT        WDTCR+0, R27
;libs/PWM_timers.mbas,411 :: 		Lcd_Cmd(_LCD_CLEAR)
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;libs/PWM_timers.mbas,412 :: 		Lcd_Out(2,2,"Reset.")
	MOVW       R30, R28
	LDI        R27, 82
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 116
	ST         Z+, R27
	LDI        R27, 46
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;libs/PWM_timers.mbas,418 :: 		end sub
L_end_WDT_on:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _WDT_on

_libs/PWM_timers_?main:

;libs/PWM_timers.mbas,421 :: 		end.
L_end_libs/PWM_timers_?main:
	RET
; end of _libs/PWM_timers_?main
