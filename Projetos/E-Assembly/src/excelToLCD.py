# Escrever um script em python que le
# uma tabela do excel
# e gera o código em assembly
# para gerar a imagem no LCD

# Guilherme Rosada 
# Grupo G-Gnomos - 2021.1

import openpyxl 
from openpyxl import load_workbook 
import os

print(os.getcwd())
wb = load_workbook('src/excelToLCD.xlsx')
ws = wb.active 


# Separa cada linha em um dicionário, guardando suas colunas em uma lista:
def find_cells(worsheet):
    """
    Identifica a coordenada de cada célula do excel que foi editada.
    Associa cada célula ao vetor correspondente (de 0 a 19, na linha dada)    
    """
    coord_cells = {}
    for cell in ws._cells:
        linha, coluna = cell
        if linha in coord_cells.keys():
            coord_cells[linha].append(coluna)
        else:
            coord_cells[linha] = [coluna]

    #% converte para o vetor correspondente na linha:
    """ passar um filtro:
    se n estiver entre 0 + k*16 <= x < 16 + k*16:
    joga para a lista de ordem [k]
    se não estiver, joga uma lista vazia em na ordem [k] """
    coord_vetores = {}
    for linha, colunas in coord_cells.items():
        lista_vetores = []
        k = 0
        
        while k < 20:
            lista_vetores.append([])
            for coord in colunas:
                # Coloca todos os números correspondente ao k-ésimo vetor
                # na lista de ordem k
                if (0 + k*16) <= coord < (16 + k*16):
                    lista_vetores[k].append(coord)
            k += 1
        
        coord_vetores[linha] = lista_vetores

    return coord_vetores



def converte_em_bits(coord_vetores):
    """
    Transforma todas as coordenadas em números de 0 a 15, 
    em que cada número corresponde à ordem do bit 1 
    """
    mod_coord_vetores = {}
    for linha, lista_vetores in coord_vetores.items():
        lista_mod_colunas = []
        k=0
        while k< len(lista_vetores):
            if k == 0:
                mod = list(map(lambda n: n % (1*16), lista_vetores[k]))
            else:
                mod = list(map(lambda n: n % ((k)*16), lista_vetores[k]))
            
            lista_mod_colunas.append(mod)
            k += 1
        
        mod_coord_vetores[linha] = lista_mod_colunas

    #$ Transforma coordenadas no vetor de bits:
    coord_vetores_bits = {}
    for linha, lista_vetores in mod_coord_vetores.items():
        lista_vetor_bits = []
        for vetor in lista_vetores:
            k = 0
            vetor_bits = '0000000000000000'
            while k<=15:
                if k in vetor:
                    vetor_bits = vetor_bits[:k] + '1' + vetor_bits[k+1:]
                
                k += 1
            lista_vetor_bits.append(vetor_bits)

        coord_vetores_bits[linha] = lista_vetor_bits

    return coord_vetores_bits
        

def bitToDecimal(vetor_bits):
    decimal = 0
    i = len(vetor_bits) -1
    for a in vetor_bits:
        decimal += int(a) * 2**i
        i -= 1
    
    return decimal

def escreve_nasm(dict_vetores_bits):

    with open("src/excelToLCD.nasm", "w") as f:
        f.write("")

    for linha, vetores_bits in dict_vetores_bits.items():
        total_string_linha = ''
        address_linha = 16384 + 20*linha
        pos_ram = address_linha

        for vetor in vetores_bits:
            if bitToDecimal(vetor) != 0:
                str_loop = ( 
                    f"leaw ${bitToDecimal(vetor)}, %A \n" +
                    "movw %A, %D \n" +
                    f"leaw ${pos_ram}, %A \n" +
                    "movw %D, (%A) \n")
                
                total_string_linha += str_loop
            pos_ram += 1

        with open("src/excelToLCD.nasm", "a") as f:
            f.write(total_string_linha)



#! Chama as funções
coord = find_cells(ws)
vetores_bits = converte_em_bits(coord)
escreve_nasm(vetores_bits)