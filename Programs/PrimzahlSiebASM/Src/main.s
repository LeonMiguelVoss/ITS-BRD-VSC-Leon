;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Silke Behn	
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main.
;					  :
;					  : Replace this main with yours.
;
;*******************************************************************************
    EXTERN initITSboard
    EXTERN lcdPrintS            ;Display ausgabe
    EXTERN GUI_init
;	EXTERN TP_Init

;********************************************
; Data section, aligned on 4-byte boundery
;********************************************
	
	AREA MyData, DATA, align = 2
	
	    GLOBAL text
DEFAULT_BRIGHTNESS DCW  800
	
text	DCB	"Hallo liebes TI-Labor (asm-project)",0

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************

	AREA |.text|, CODE, READONLY, ALIGN = 3

;--------------------------------------------
; main subroutine
;--------------------------------------------
	EXPORT main [CODE]
	
main	PROC
        BL initITSboard
		ldr r1, =DEFAULT_BRIGHTNESS
		ldrh r0, [r1]
		bl GUI_init
		mov r0, #0x00
;		bl TP_Init
		
		LDR	r0,=text
        BL  lcdPrintS

;		anlegen des indexes/feldes für alle zahlen
;		Alle werte auf 1 (istPrimzahl) setzen

;		MAIN LOOP
;		Loop durch den zahlenbereich
;		Wenn der Aktuelle wert True ist dann,
;		setze variable c auf aktuelle Stelle + 1
;		Solange c kleiner als der gesammte zahlenbereich,
;		dann frage ab ob c % i == 0 ist
;		Wenn ja, dann ist die Zahl teilbar und der wert wird auf false gesetzt
;		Wenn nein, dann erhöhe c
;		Dieser ablauf widerholt sich solange, bis alle zahlen des Bereiches einmal druchgegangen wurden

;		Am ende werden alle Zahlen ausgeben die den Wert True haben.


forever	b	forever		; nowhere to retun if main ends		
		ENDP
	
		ALIGN
       
		END
