; Arquivo: Max.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares 
; Data: 27/03/2017
; Log :
;     - Rafael Corsi portado para Z01
;
; Calcula R2 = max(R0, R1)  (R0,R1,R2 se referem a  RAM[0],RAM[1],RAM[2])
; ou seja, o maior valor que estiver, ou em R0 ou R1 sera copiado para R2
; Estamos considerando número inteiros

;  R2 = max(R0, R1)

; analisa R1 - R0 e faz jump
leaw $0, %A 
movw (%A), %D 
leaw $1, %A 
movw (%A), %A

; R1 = A
; R0 = D

subw %A, %D, %D 
;  (R1 - R0) --> se >0 ==> R1 é max, se <0 ==> R0 é max
; se >0:
leaw $UM, %A 
jg %D 
nop

; se <0:
leaw $ZERO, %A 
jl %D 
nop

; se = 0 ==> R1 = R0 ==> END
leaw $END, %A 
je %D 
nop

UM:
leaw $1, %A
movw (%A), %D 
leaw $2, %A 
movw %D, (%A) 
; pular para o fim
leaw $END, %A 
jmp
nop

ZERO:
leaw $0, %A
movw (%A), %D 
leaw $2, %A 
movw %D, (%A) 


END:
nop