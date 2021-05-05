; Arquivo: Abs.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Copia o valor de RAM[1] para RAM[0] deixando o valor sempre positivo.

leaw $R1, %A
movw (%A), %D
; Se o valor em D for maior que 0, ignora o trecho abaixo:
leaw $ELSE, %A
jg %D
nop
; Pega negativo de D e move para RAM[0] e finaliza
negw %D
leaw $R0, %A
movw %D, (%A)
leaw $END, %A
jmp
nop
; Se D > 0 apenas grava o valor de D em RAM[0]
ELSE:
leaw $R0, %A
movw %D, (%A)
END: