; Arquivo: stringLength.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi 
; Data: 28/03/2018
;
; Assuma que uma string é um conjunto de caracteres terminado
; em NULL (0).
; 
; Supondo que temos uma string que começa no endereço 8 da RAM.
; Calcule o seu tamanho e salve o resultado na RAM[0].
;
; Os caracteres estão formatados em ASCII
; http://sticksandstones.kstrom.com/appen.html
; 
; Exemplo:
;
;   Convertido para ASCII
;             |
;             v
;  RAM[8]  = `o`
;  RAM[9]  = `i`
;  RAM[10] = ` `
;  RAM[11] = `b`
;  RAM[12] =  l`
;  RAM[13] = `z`
;  RAM[14] = `?`
;  RAM[15] = NULL = 0x0000


;  Lê os R[i] até encontrar 0x000. 
; Guarda a posição [i] e subtrai 7 (-8 + 1), obtendo o tamanho da string
; salva o tamanho da string em R[0]
leaw $8, %A 
movw %A, %D 
leaw $0, %A 
movw %D, (%A) ; i_o = R[0] = 8

LOOP:
    leaw $0, %A 
    movw (%A), %A ; lê R[0] --> contador da posição: i = R[0] --> %A = i
    movw (%A), %D ; lê R[i] --> D = R[i]

    leaw $END, %A 
    je %D ; pula para END, se D == R[i] == 0
    nop 

    ; se D != 0:     i += 1, guarda em R[0]

    leaw $0, %A 
    movw (%A), %D 
    addw $1, %D, (%A)


    leaw $LOOP, %A 
    jmp 
    nop

; D == 0: FIM DA STRING 
END: 
    leaw $0, %A 
    movw (%A), %D ; obtém i do ultimo caractere (ex.: 12)
    leaw $8, %A 
    subw %D, %A, %D ; D = D - 8 => tamanho da string: (12 = NULL, 8 = caractere inicial -> Tamanho = 4 (12 - 8))
    leaw $0, %A 
    movw %D, (%A) 