; Arquivo: Abs.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Multiplica o valor de RAM[1] com RAM[0] salvando em RAM[3]

  LOOP:
    leaw $0, %A
    movw (%A), %D
    leaw $END, %A
    je %D
    nop
    leaw $3, %A
    movw (%A), %D
    leaw $1, %A
    addw (%A), %D, %A
    movw %A, %D
    leaw $3, %A
    movw %D, (%A)
    leaw $0, %A
    movw (%A), %D
    decw %D
    movw %D, (%A)
    leaw $LOOP, %A
    jmp
    nop
END: 