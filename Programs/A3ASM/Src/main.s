;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base
VariableA          DCW 0x1234
VariableB          DCW 0x4711
VariableC          DCD  0
MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45
MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000
MeinTextFeld       DCB "ABab0123",0

                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl    initITSboard

; Lädt Konstante 0x12 in r0
                mov   r0,#0x12                      ; Anw-01
; Lädt Konstante -128 in r1
                mov   r1,#-128                      ; Anw-02
; Lädt 32-Bit-Konstante in r2
                ldr   r2,=0x12345678                ; Anw-03

; Lädt Adresse von VariableA in r0
                ldr   r0,=VariableA                 ; Anw-04
; Lädt Halbwort von VariableA in r1
                ldrh  r1,[r0]                       ; Anw-05
; Lädt Wort ab Adresse VariableA in r2
                ldr   r2,[r0]                       ; Anw-06
; Speichert r2 in VariableC
                str   r2,[r0,#VariableC-VariableA]  ; Anw-07

; Lädt Adresse von MeinHalbwortFeld in r0
                ldr   r0,=MeinHalbwortFeld          ; Anw-08
; Lädt erstes Halbwort des Feldes in r1
                ldrh  r1,[r0]                       ; Anw-09
; Lädt zweites Halbwort des Feldes in r2
                ldrh  r2,[r0,#2]                    ; Anw-10
; Lädt Konstante 10 in r3
                mov   r3,#10                        ; Anw-11
; Lädt Halbwort mit Register-Offset in r4
                ldrh  r4,[r0,r3]                    ; Anw-12

; Lädt Halbwort und erhöht r0 um 2
                ldrh  r5,[r0,#2]!                   ; Anw-13
; Lädt weiteres Halbwort und erhöht r0 erneut
                ldrh  r6,[r0,#2]!                   ; Anw-14
; Speichert Halbwort und erhöht r0
                strh  r6,[r0,#2]!                   ; Anw-15

; Lädt Adresse von MeinWortFeld in r0
                ldr  r0,=MeinWortFeld               ; Anw-16
; Lädt erstes Wort des Feldes in r1
                ldr  r1,[r0]                        ; Anw-17
; Lädt zweites Wort des Feldes in r2
                ldr  r2,[r0,#4]                     ; Anw-18
; Addiert r1 und r2 und speichert Ergebnis in r3
                adds r3,r1,r2                       ; Anw-19

; Lädt drittes Wort des Feldes in r4
                ldr  r4,[r0,#8]                     ; Anw-20
; Lädt viertes Wort des Feldes in r5
                ldr  r5,[r0,#12]                    ; Anw-21
; Subtrahiert r5 von r4 und speichert Ergebnis in r6
                subs r6,r4,r5                       ; Anw-22

; Lädt fünftes Wort des Feldes in r7
                ldr  r7,[r0,#16]                    ; Anw-23
; Lädt sechstes Wort des Feldes in r8
                ldr  r8,[r0,#20]                    ; Anw-24
; Subtrahiert r8 von r7 und speichert Ergebnis in r9
                subs r9,r7,r8                       ; Anw-25

; Endlosschleife
forever         b   forever                         ; Anw-26

                ENDP
                END