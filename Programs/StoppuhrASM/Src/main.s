;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Franz Korf	
;* Version            : V1.0
;* Date               : 11.05.2022
;* Description        : Rahmen zur Loesung von GTP Woche 7-9 (Stoppuhr).
;
;*******************************************************************************

; Define address of selected GPIO and Timer registers
PERIPH_BASE     	equ	0x40000000                 ;Peripheral base address
AHB1PERIPH_BASE 	equ	(PERIPH_BASE + 0x00020000)
APB1PERIPH_BASE     equ PERIPH_BASE

GPIOD_BASE			equ	(AHB1PERIPH_BASE + 0x0C00)
GPIOF_BASE			equ	(AHB1PERIPH_BASE + 0x1400)
TIM2_BASE           equ (APB1PERIPH_BASE + 0x0000)
	
GPIO_F_PIN        	equ	(GPIOF_BASE + 0x10)

GPIO_D_PIN			equ	(GPIOD_BASE + 0x10)
GPIO_D_SET			equ (GPIOD_BASE + 0x18)
GPIO_D_CLR			equ	(GPIOD_BASE + 0x1A)
	
TIMER				equ (TIM2_BASE + 0x24)   ; CNT : current time stamp (32 bit),  resolution
TIM2_PSC			equ (TIM2_BASE + 0x28)   ; Prescaler  resolution
TIM2_ERG			equ (TIM2_BASE + 0x14)   ; 16 Bit register, Bit 0 : 1 Restart Timer


    EXTERN initITSboard
    EXTERN GUI_init
	EXTERN TP_Init
	EXTERN initTimer
	EXTERN lcdSetFont
	EXTERN lcdGotoXY      		; TFT goto x y function
	EXTERN lcdPrintS			; TFT output function	
    EXTERN lcdPrintC            ; TFT output one character		
	EXTERN Delay				; Delay (ms) function


;********************************************
; Data section, aligned on 4-byte boundery
;********************************************

INIT		equ		0
RUNNING		equ		1
HOLD		equ		2

SW5			equ		0x20
SW6			equ		0x40
SW7			equ		0x80


	AREA MyData, DATA, align = 2

DEFAULT_BRIGHTNESS	DCW     800
Time				DCB		"00:00:00", 0
Time_Default		DCB		"00:00:00", 0
FirstInit			DCB		0

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************
	AREA |.text|, CODE, READONLY, ALIGN = 3


;--------------------------------------------
; main subroutine
;--------------------------------------------
	EXPORT main [CODE]
	
main	PROC

		; Initialisierung der HW
		BL		initITSboard
		ldr   	r1, =DEFAULT_BRIGHTNESS
		ldrh 	r0, [r1]
		bl   	GUI_init
		bl  	initTimer
		ldr 	R1,=TIM2_PSC   			; Set pre scaler such that 1 timer tick represents 10 us
		mov 	R0,#(90*10-1) 
		strh	R0,[R1]
		ldr 	R1,=TIM2_ERG   			; Restart timer	
		mov		R0,#0x01
		strh	R0,[R1]					; Set UG Bit
		MOV 	R0, #24
		bl  	lcdSetFont

		; Ihre Initialisierung

		mov		r10, #0
superloop
		ldr		r0, =FirstInit
		ldrb	r1, [r0]
		cmp		r10, r1 
		beq		init

		ldr 	r0, =GPIO_F_PIN
		ldr 	r1, [r0]
		and		r1,	#0xFF
		eor 	r1,	#0xFF
if_01	
		cmp 	r10, #INIT
		bne		endif_01
then_01
		cmp 	r1, #SW7
		beq		running
endif_01
if_02	
		cmp		r10, #RUNNING
		bne		endif_02
then_02
		cmp		r1, #SW6
		beq		hold
		cmp		r1, #SW5
		beq		init
endif_02
if_03
		cmp		r10, #HOLD
		bne		endif_03
then_03
		cmp		r1, #SW5
		beq		init
endif_03
		b		superloop				; End of superloop

init
		mov		r10, #INIT
		ldr		r0, =FirstInit
		mov		r1, #1
		strb	r1, [r0]
		ldr     r0, =GPIO_D_CLR
		mov		r3, #3
		str		r3, [r0]

		mov		r0, #10
		mov		r1, #6
		bl		lcdGotoXY
		ldr		r0, =Time_Default
		bl		lcdPrintS
		b		superloop

running
		ldr		r0, =FirstInit
		mov		r1, #0
		strb	r1, [r0]
		mov		r10, #RUNNING
        ldr     r0, =GPIO_D_SET
		mov		r3, #1
        str     r3, [r0]
		b		superloop
hold
		mov		r10, #HOLD
		ldr		r0, =GPIO_D_SET
		mov		r3, #2
		str		r3, [r0]
		b		superloop
		


		ENDP

		ALIGN
		END
