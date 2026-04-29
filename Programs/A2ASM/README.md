Adresse        Inhalt
VariableA      0xEF
VariableA + 1  0xBE

Anw01
ldr R0, =VariableA

Effekt:
- R0 enthält die Adresse von VariableA
- R2 und R3 bleiben unverändert
- Speicher bleibt unverändert

Anw02
ldrb R2, [R0]

Effekt:
- R2 = 0xEF (niederwertiges Byte von 0xBEEF)
- R0 und R3 bleiben unverändert
- Speicher bleibt unverändert


Anw03
ldrb R3, [R0, #1]

Effekt:
- R3 = 0xBE (höherwertiges Byte von 0xBEEF)
- R0 und R2 bleiben unverändert
- Speicher bleibt unverändert


Anw04
lsl R2, #8

Effekt:
- R2 = 0xEF00
- R0 und R3 bleiben unverändert
- Speicher bleibt unverändert


Anw05
orr R2, R3

Effekt:
- R2 = 0xEF00 OR 0xBE = 0xEFBE
- R0 und R3 bleiben unverändert
- Speicher bleibt unverändert


Anw06
strh R2, [R0]

Effekt:
- Der Wert 0xEFBE wird in den Speicher an Adresse von VariableA geschrieben

Neuer Speicherinhalt:

Adresse        Inhalt
VariableA      0xBE
VariableA + 1  0xEF

VariableA enthält jetzt den Wert 0xEFBE
