; ------------------------------------------------------------
; Arquivo: Mod.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017
;
; Calcula o resto da divisão (modulus) entre RAM[0] por RAM[1]
; e armazena o resultado na RAM[2].
;
; 4  % 3 = 1
; 10 % 7 = 3
; ------------------------------------------------------------

leaw $2, %A
movw $0, (%A)
WHILE:
 
leaw $0, %A
movw (%A), %D 
leaw $3, %A
movw %D, (%A) ; movi o que estava em RAM[0] para RAM[3]
leaw $1, %A
subw %D,(%A), %D
leaw $0, %A
movw %D, (%A)
leaw $END, %A
jl %D
nop
leaw $WHILE, %A
jmp
nop
 
END:
 
leaw $3, %A
movw (%A), %D
leaw $2, %A
movw %D, (%A)