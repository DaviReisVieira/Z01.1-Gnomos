; Arquivo: SWeLED2.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
;
; Faça os LEDs exibirem 
; LED = SW[8] !SW[7] OFF ON ON RAM[5][3] ON SW[0] OFF
;
;                                ^            ^
;                                | TRUQUE!    | TRUQUE!

leaw $21185, %A
movw (%A), %D
leaw $256, %A 
andw %D, %A, %D
leaw $0, %A
movw %D, (%A)

leaw $21185, %A
movw (%A), %D
notw %D
leaw $128, %A 
andw %D, %A, %D
leaw $1, %A
movw %D, (%A)

leaw $21185, %A
movw (%A), %D
leaw $1, %A 
andw %D, %A, %D
movw %D, %A
addw %D, %A, %D
leaw $2, %A
movw %D, (%A)

leaw $5, %A
movw (%A), %D
leaw $8, %A 
andw %D, %A, %D
leaw $3, %A
movw %D, (%A)

leaw $52, %A
movw %A, %D

leaw $0, %A
addw (%A), %D, %D
leaw $1, %A

addw (%A), %D, %D
leaw $2, %A
addw (%A), %D, %D

leaw $3, %A
addw (%A), %D, %D

leaw $21184, %A
movw %D, (%A)