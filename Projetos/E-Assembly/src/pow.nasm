; Arquivo: Pow.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Eleva ao quadrado o valor da RAM[1] e armazena o resultado na RAM[0].
; Só funciona com números positivos

; Grava-se em RAM[0] o valor de RAM[1]
leaw $R1, %A
movw (%A), %D
leaw $R0, %A
movw %D, (%A)
; Inicia-se o contador RAM[2] em 1
leaw $R2, %A
movw (%A), %D
incw %D
movw %D, (%A)
; Soma-se RAM[1] a RAM[0] RAM[1] vezes, até que RAM[2] = RAM[1]
LOOP:
; Começamos verificando se RAM[2] = RAM[1]
leaw $R2, %A
movw (%A), %D
leaw $R1, %A
subw (%A), %D, %D
; ====== Esse trecho executa enquanto RAM[2] != RAM[1]
leaw $ELSE, %A
je %D
nop
; Soma RAM[0] a RAM[1] e grava em RAM[1]
leaw $R1, %A
movw (%A), %D
leaw $R0, %A
addw (%A), %D, %D
movw %D, (%A)
; Atualiza contador somando 1
leaw $R2, %A
movw (%A), %D
incw %D
movw %D, (%A)
; Volta para o começo do loop
leaw $LOOP, %A
jmp
nop
; ===== Esse trecho executa ao final do cálculo (RAM[2] = RAM[1])
ELSE:
leaw $END, %A
jmp
nop
END: