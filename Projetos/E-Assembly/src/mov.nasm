; Elementos de Sistemas : 2018a
; Rafael Corsi
; Hardware : Z0.1
;
; Data :
;    - Dez 2018
; Descrição :
;    - Movimentação de dados da memoria RAM
;
; RAM[0] = RAM[1]
; RAM[1] = RAM[0]
; RAM[3] = 1

; -----------------------
; RAM[0] = RAM[1]
; -----------------------


; -----------------------
; RAM[3] = 1
; -----------------------

leaw $0, %A
movw (%A), %D

leaw $R11, %A
movw %D, (%A)

leaw $1, %A
movw (%A), %D

leaw $R12, %A
movw %D, (%A)

leaw $R11, %A
movw (%A), %D

leaw $1, %A
movw %D, (%A)

leaw $R12, %A
movw (%A), %D

leaw $0, %A
movw %D, (%A)

leaw $1, %A
movw %A, %D

leaw $3, %A
movw %D, (%A)