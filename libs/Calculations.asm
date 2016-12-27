
_strToInt1:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;libs/Calculations.mbas,12 :: 		sub procedure strToInt1()
;libs/Calculations.mbas,15 :: 		output = 0  ex=0
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	PUSH       R8
	PUSH       R9
	LDI        R27, 0
	STS        _output+0, R27
	STS        _output+1, R27
	LDI        R27, 0
	STS        _ex+0, R27
	STS        _ex+1, R27
;libs/Calculations.mbas,16 :: 		i = 1  stringLength = strlen(st)  temp = 0   numberLength = 0
	LDI        R27, 1
	STS        _i+0, R27
	LDI        R27, 0
	STS        _i+1, R27
	LDI        R27, #lo_addr(_st+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_st+0)
	MOV        R3, R27
	CALL       _strlen+0
	STS        _stringLength+0, R16
	STS        _stringLength+1, R17
	LDI        R27, 0
	STS        _temp+0, R27
	STS        _temp+1, R27
	LDI        R27, 0
	STS        _numberLength+0, R27
	STS        _numberLength+1, R27
;libs/Calculations.mbas,18 :: 		for j = 0 to stringLength-1
	LDI        R27, 0
	STS        _j+0, R27
	STS        _j+1, R27
L__strToInt11:
	LDS        R21, _stringLength+0
	LDS        R22, _stringLength+1
	SUBI       R21, 1
	SBCI       R22, 0
	LDS        R16, _j+0
	LDS        R17, _j+1
	CP         R21, R16
	CPC        R22, R17
	BRGE       L__strToInt121
	JMP        L__strToInt15
L__strToInt121:
;libs/Calculations.mbas,20 :: 		tempCh = st[j]
	LDI        R18, #lo_addr(_st+0)
	LDI        R19, hi_addr(_st+0)
	LDS        R16, _j+0
	LDS        R17, _j+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R18, Z
	STS        _tempCh+0, R18
;libs/Calculations.mbas,21 :: 		temp = tempCh - 48
	MOV        R16, R18
	LDI        R17, 0
	SUBI       R16, 48
	SBCI       R17, 0
	STS        _temp+0, R16
	STS        _temp+1, R17
;libs/Calculations.mbas,22 :: 		if   tempCh =46 then
	CPI        R18, 46
	BREQ       L__strToInt122
	JMP        L__strToInt17
L__strToInt122:
;libs/Calculations.mbas,23 :: 		ex=1
	LDI        R27, 1
	STS        _ex+0, R27
	LDI        R27, 0
	STS        _ex+1, R27
L__strToInt17:
;libs/Calculations.mbas,25 :: 		if (temp >= 0) and ( temp <= 9) and (ex=0)  then
	LDS        R19, _temp+0
	LDS        R20, _temp+1
	LDI        R16, 0
	LDI        R17, 0
	CP         R19, R16
	CPC        R20, R17
	LDI        R18, 0
	BRLT       L__strToInt123
	LDI        R18, 255
L__strToInt123:
	LDI        R16, 9
	LDI        R17, 0
	CP         R16, R19
	CPC        R17, R20
	LDI        R27, 0
	BRLT       L__strToInt124
	LDI        R27, 255
L__strToInt124:
	MOV        R16, R27
	AND        R18, R16
	LDS        R16, _ex+0
	LDS        R17, _ex+1
	CPI        R17, 0
	BRNE       L__strToInt125
	CPI        R16, 0
L__strToInt125:
	LDI        R27, 0
	BRNE       L__strToInt126
	LDI        R27, 255
L__strToInt126:
	MOV        R16, R27
	AND        R16, R18
	BRNE       L__strToInt127
	JMP        L__strToInt110
L__strToInt127:
;libs/Calculations.mbas,27 :: 		inc(numberLength)
	LDS        R16, _numberLength+0
	LDS        R17, _numberLength+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _numberLength+0, R16
	STS        _numberLength+1, R17
L__strToInt110:
;libs/Calculations.mbas,29 :: 		next j
	LDS        R16, _j+0
	LDS        R17, _j+1
	CP         R16, R21
	CPC        R17, R22
	BRNE       L__strToInt128
	JMP        L__strToInt15
L__strToInt128:
	LDS        R16, _j+0
	LDS        R17, _j+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _j+0, R16
	STS        _j+1, R17
	JMP        L__strToInt11
L__strToInt15:
;libs/Calculations.mbas,32 :: 		for j = 0 to numberLength-1
	LDI        R27, 0
	STS        _j+0, R27
	STS        _j+1, R27
L__strToInt112:
	LDS        R18, _numberLength+0
	LDS        R19, _numberLength+1
	SUBI       R18, 1
	SBCI       R19, 0
	STD        Y+4, R18
	STD        Y+5, R19
	LDS        R16, _j+0
	LDS        R17, _j+1
	CP         R18, R16
	CPC        R19, R17
	BRGE       L__strToInt129
	JMP        L__strToInt116
L__strToInt129:
;libs/Calculations.mbas,34 :: 		tempCh = st[j]
	LDI        R18, #lo_addr(_st+0)
	LDI        R19, hi_addr(_st+0)
	LDS        R16, _j+0
	LDS        R17, _j+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	STS        _tempCh+0, R16
;libs/Calculations.mbas,35 :: 		temp = tempCh - 48
	MOV        R19, R16
	LDI        R20, 0
	SUBI       R19, 48
	SBCI       R20, 0
	STS        _temp+0, R19
	STS        _temp+1, R20
;libs/Calculations.mbas,36 :: 		if (temp >= 0) and (temp <= 9)  then
	LDI        R16, 0
	LDI        R17, 0
	CP         R19, R16
	CPC        R20, R17
	LDI        R18, 0
	BRLT       L__strToInt130
	LDI        R18, 255
L__strToInt130:
	LDI        R16, 9
	LDI        R17, 0
	CP         R16, R19
	CPC        R17, R20
	LDI        R27, 0
	BRLT       L__strToInt131
	LDI        R27, 255
L__strToInt131:
	MOV        R16, R27
	AND        R16, R18
	BRNE       L__strToInt132
	JMP        L__strToInt118
L__strToInt132:
;libs/Calculations.mbas,38 :: 		output =output +  temp * pow(10, (numberLength-i))
	LDS        R0, _i+0
	LDS        R1, _i+1
	LDI        R27, 0
	SBRC       R1, 7
	LDI        R27, 255
	LDS        R16, _numberLength+0
	LDS        R17, _numberLength+1
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	SUB        R16, R0
	SBC        R17, R1
	SBC        R18, R27
	SBC        R19, R27
	CALL       _float_slong2fp+0
	MOVW       R6, R16
	MOVW       R8, R18
	LDI        R27, 0
	MOV        R2, R27
	MOV        R3, R27
	LDI        R27, 32
	MOV        R4, R27
	LDI        R27, 65
	MOV        R5, R27
	CALL       _pow+0
	STD        Y+0, R16
	STD        Y+1, R17
	STD        Y+2, R18
	STD        Y+3, R19
	LDS        R16, _temp+0
	LDS        R17, _temp+1
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CALL       _float_slong2fp+0
	LDD        R20, Y+0
	LDD        R21, Y+1
	LDD        R22, Y+2
	LDD        R23, Y+3
	CALL       _float_fpmul1+0
	STD        Y+0, R16
	STD        Y+1, R17
	STD        Y+2, R18
	STD        Y+3, R19
	LDS        R16, _output+0
	LDS        R17, _output+1
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CALL       _float_slong2fp+0
	LDD        R20, Y+0
	LDD        R21, Y+1
	LDD        R22, Y+2
	LDD        R23, Y+3
	CALL       _float_fpadd1+0
	CALL       _float_fpint+0
	STS        _output+0, R16
	STS        _output+1, R17
;libs/Calculations.mbas,39 :: 		i=i+1
	LDS        R16, _i+0
	LDS        R17, _i+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _i+0, R16
	STS        _i+1, R17
L__strToInt118:
;libs/Calculations.mbas,42 :: 		next j
	LDS        R18, _j+0
	LDS        R19, _j+1
	LDD        R16, Y+4
	LDD        R17, Y+5
	CP         R18, R16
	CPC        R19, R17
	BRNE       L__strToInt133
	JMP        L__strToInt116
L__strToInt133:
	LDS        R16, _j+0
	LDS        R17, _j+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _j+0, R16
	STS        _j+1, R17
	JMP        L__strToInt112
L__strToInt116:
;libs/Calculations.mbas,44 :: 		end sub
L_end_strToInt1:
	POP        R9
	POP        R8
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 5
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _strToInt1

_libs/Calculations_?main:

;libs/Calculations.mbas,45 :: 		end.
L_end_libs/Calculations_?main:
	RET
; end of _libs/Calculations_?main
