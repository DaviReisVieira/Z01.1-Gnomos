; ------------------------------------
; Calcule a média dos valores de um vetor
; que possui inicio em RAM[5] e tamanho
; definido em RAM[4],
;
; 1. Salve a soma em RAM[1]
; 2. Salve a média em RAM[0]
; 
; ------------------------------------
; antes       | depois
;             |
; RAM[0]:     | RAM[0]:  2  : média 
; RAM[1]:     | RAM[1]:  8  : soma
; RAM[2]:     | RAM[2]:  
; RAM[3]:     | RAM[3]:     
; RAM[4]:  4  | RAM[4]:  4 
; RAM[5]:  1  | RAM[5]:  1 - 
; RAM[6]:  2  | RAM[6]:  2 | vetor
; RAM[7]:  1  | RAM[7]:  1 |
; RAM[8]:  4  | RAM[8]:  4 -
; ------------------------------------

leaw $0, %A
movw %A, %D
leaw $1, %A
movw %D, (%A) ; garantir que RAM[1] = 0

WHILE:
leaw $4, %A
movw (%A), %D

leaw $END, %A ; confere se RAM[4] <= 0 
jle %D
nop

leaw $4, %A
movw (%A), %D
leaw $NUMM, %A
movw %D, (%A) ; guardar o tamanho para divisão 

leaw $4, %A
movw (%A), %D
addw %A, %D, %D ; D indica até onde vai
leaw $2, %A
movw %D, (%A)
leaw $2, %A
movw (%A), %A
movw (%A), %D ; o valor de RAM[8] está em D

leaw $1, %A
movw (%A), %A
addw %D, %A, %D
leaw $1, %A
movw %D, (%A)

leaw $4, %A
subw (%A), $1, %D
leaw $4, %A
movw %D, (%A)

leaw $WHILE, %A
jmp
nop

END:

leaw $1, %A
movw (%A), %D
leaw $NUM, %A
movw %D, (%A)

WHILEE:
leaw $NUM, %A
movw (%A), %D 
leaw $ENDD, %A
jle %D
nop 

leaw $NUM, %A
movw (%A), %D 
leaw $NUMM, %A
subw %D,(%A), %D
leaw $NUM, %A
movw %D, (%A)

leaw $0, %A
movw (%A), %D
addw $1, %D, %D
leaw $0, %A
movw %D, (%A)
leaw $WHILEE, %A
jmp
nop

ENDD:

