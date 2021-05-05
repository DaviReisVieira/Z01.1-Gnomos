; Arquivo: isEven.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 28/3/2019
;
; Verifica se o valor salvo no endereço RAM[5] é
; par. Se for verdadeiro, salva 1
; em RAM[0] e 0 caso contrário.

; confere o último bit, já que se for impar. 1 and 1 = 1, então muda para 0.
; e se for par. 1 and 0 = 0, então muda para 1.
leaw $5, %A
movw (%A), %D
leaw $1, %A
andw %A, %D, %D
leaw $IMPAR, %A
jg %D
nop
leaw $1, %A
movw %A, %D
leaw $END, %A
jmp
nop
 
IMPAR: 
leaw $0, %A
movw %A, %D
 
END:
leaw $0, %A
movw %D, (%A)
