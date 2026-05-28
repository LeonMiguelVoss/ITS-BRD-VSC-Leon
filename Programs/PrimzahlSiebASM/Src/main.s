;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Leon Miguel Voß
;* Version            : V1.0
;* Date               : 27.05.2026
;* Description        : Sieb des Eratosthenes (Primzahlen 2-1000)
;*******************************************************************************
    EXTERN initITSboard
    EXTERN lcdPrintS
    EXTERN GUI_init

;********************************************
; Data section, aligned on 4-byte boundary
;********************************************

    AREA MyData, DATA, ALIGN = 2

sieb    FILL 1001, 1        ; Array[1001], alle Bytes = 1 (prim)

;********************************************
; Code section, aligned on 8-byte boundary
;********************************************

    AREA |.text|, CODE, READONLY, ALIGN = 3

;--------------------------------------------
; main subroutine
;--------------------------------------------
    EXPORT main [CODE]

main    PROC
        BL initITSboard

        ; Register:
        ; r0 = Basisadresse sieb
        ; r1 = i (äußere Schleife)
        ; r2 = t (innere Schleife) / temporär
        ; r3 = temporär (Byte-Wert)

        LDR     r0, =sieb
		STRB    r1, [r0, #0]    ; sieb[0] = 0
        STRB    r1, [r0, #1]    ; sieb[1] = 0
        MOV     r1, #2              ; i = 2


while_01
        CMP     r1, #1000
        BGT     endwhile_01         ; while (i <= 1000)

do_01
if_02
        LDRB    r3, [r0, r1]        ; r3 = sieb[i]
        CMP     r3, #1
        BNE     endif_02            ; if (sieb[i])

then_02
        MUL     r2, r1, r1          ; t = i * i

while_03
        CMP     r2, #1000
        BGT     endwhile_03         ; while (t <= 1000)

do_03
        MOV     r3, #0
        STRB    r3, [r0, r2]        ; sieb[t] = 0
        ADD     r2, r2, r1          ; t += i
        B       while_03

endwhile_03

endif_02
        ADD     r1, r1, #1          ; i++
        B       while_01

endwhile_01

forever b       forever
        ENDP

        ALIGN

        END