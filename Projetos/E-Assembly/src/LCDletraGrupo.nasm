; Arquivo: LCDletraGrupo.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 28/3/2018
;
; Escreva no LCD a letra do grupo de vocês
;  - Valide no hardawre
;  - Bata uma foto!

; Guarda em D o vetor 11111...1
incw %D
negw %D

; Desenha partes horizontais da letra
leaw $16384, %A
movw %D, (%A)
leaw $16385, %A
movw %D, (%A)

leaw $17084, %A
movw %D, (%A)
leaw $17085, %A
movw %D, (%A)

leaw $16785, %A
movw %D, (%A)

; Guarda em D o vetor 100...0
leaw $32768, %A
movw %A, %D

; Desenha linhas verticais
leaw $16404, %A
movw %D, (%A)
leaw $16424, %A
movw %D, (%A)
leaw $16444, %A
movw %D, (%A)
leaw $16464, %A
movw %D, (%A)
leaw $16484, %A
movw %D, (%A)
leaw $16504, %A
movw %D, (%A)
leaw $16524, %A
movw %D, (%A)
leaw $16544, %A
movw %D, (%A)
leaw $16564, %A
movw %D, (%A)
leaw $16584, %A
movw %D, (%A)
leaw $16604, %A
movw %D, (%A)
leaw $16624, %A
movw %D, (%A)
leaw $16644, %A
movw %D, (%A)
leaw $16664, %A
movw %D, (%A)
leaw $16684, %A
movw %D, (%A)
leaw $16704, %A
movw %D, (%A)
leaw $16724, %A
movw %D, (%A)
leaw $16744, %A
movw %D, (%A)
leaw $16764, %A
movw %D, (%A)
leaw $16784, %A
movw %D, (%A)
leaw $16804, %A
movw %D, (%A)
leaw $16824, %A
movw %D, (%A)
leaw $16844, %A
movw %D, (%A)
leaw $16864, %A
movw %D, (%A)
leaw $16884, %A
movw %D, (%A)
leaw $16904, %A
movw %D, (%A)
leaw $16924, %A
movw %D, (%A)
leaw $16944, %A
movw %D, (%A)
leaw $16964, %A
movw %D, (%A)
leaw $16984, %A
movw %D, (%A)
leaw $17004, %A
movw %D, (%A)
leaw $17024, %A
movw %D, (%A)
leaw $17044, %A
movw %D, (%A)
leaw $17064, %A
movw %D, (%A)

leaw $16786, %A
movw %D, (%A)
leaw $16806, %A
movw %D, (%A)
leaw $16826, %A
movw %D, (%A)
leaw $16846, %A
movw %D, (%A)
leaw $16866, %A
movw %D, (%A)
leaw $16886, %A
movw %D, (%A)
leaw $16906, %A
movw %D, (%A)
leaw $16926, %A
movw %D, (%A)
leaw $16946, %A
movw %D, (%A)
leaw $16966, %A
movw %D, (%A)
leaw $16986, %A
movw %D, (%A)
leaw $17006, %A
movw %D, (%A)
leaw $17026, %A
movw %D, (%A)
leaw $17046, %A
movw %D, (%A)
leaw $17066, %A
movw %D, (%A)