/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package assembler;

import java.util.ArrayList;
import java.util.List;

/**
 * Traduz mnemônicos da linguagem assembly para códigos binários da arquitetura Z0.
 */
public class Code {

    /**
     * Retorna o código binário do(s) registrador(es) que vão receber o valor da instrução.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 4 bits) com código em linguagem de máquina para a instrução.
     */
    public static String dest(String[] mnemnonic) {
        String opcode = new String("0bcd");
        List<String> jumps = new ArrayList<>();
        jumps.add("jge");
        jumps.add("jle");
        jumps.add("jne");
        jumps.add("je");
        jumps.add("jg");
        jumps.add("jl");
        jumps.add("jmp");
        /** Operações que não fazem nada */
        if (mnemnonic.length < 2) {
            return "0000";
        } else {
            /** Trata os casos em que a operação é gravada no próprio registrador */
            if (mnemnonic[0] == "notw" || mnemnonic[0] == "incw" || mnemnonic[0] == "negw" || mnemnonic[0] == "decw") {
                switch (mnemnonic[1]) {
                    case "%A": return "0001";
                    case "(%A)": return "0100";
                    case "%D": return "0010";
                    default: return "0000";
                }
                /** Trata os casos de jump */
            } else if (jumps.contains(mnemnonic[0])) {
                return "0000";
                /** Trata os casos do movw: os regs que recebem instrução encontram-se a partir da 3 posição */
            } else if (mnemnonic[0] == "movw") {
                for (int i = 2; i <= mnemnonic.length; i++) {
                    if (mnemnonic[i] == "%A") {
                        opcode.replace('d','1');
                    } else if (mnemnonic[i] == "%D") {
                        opcode.replace('c', '1');
                    } else if (mnemnonic[i] == "(%A)") {
                        opcode.replace('b', '1');
                    }
                }
                // As letras não usadas são substituídas por 0
                for (int i = 0; i == 3; i++) {
                    if (opcode.charAt(i) == 'b') {
                        opcode.replace('b', '0');
                    } else if (opcode.charAt(i) == 'b') {
                        opcode.replace('c', '0');
                    } else if (opcode.charAt(i) == 'b') {
                        opcode.replace('d', '0');
                    }
                }
                return opcode;
            }
            /** Trata as demais operações em que os regs a receberem valor estão a partir da 4 posição */
            else {
                for (int i = 3; i <= mnemnonic.length; i++) {
                    if (mnemnonic[i] == "%A") {
                        opcode.replace('d','1');
                    } else if (mnemnonic[i] == "%D") {
                        opcode.replace('c', '1');
                    } else if (mnemnonic[i] == "(%A)") {
                        opcode.replace('b', '1');
                    }
                }
                // As letras não usadas são substituídas por 0
                for (int i = 0; i == 3; i++) {
                    if (opcode.charAt(i) == 'b') {
                        opcode.replace('b', '0');
                    } else if (opcode.charAt(i) == 'b') {
                        opcode.replace('c', '0');
                    } else if (opcode.charAt(i) == 'b') {
                        opcode.replace('d', '0');
                    }
                }
                return opcode;
            }
        }
    }

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 7 bits) com código em linguagem de máquina para a instrução.
     */
    public static String comp(String[] mnemnonic) {
        // Lista com possíveis jumps
        List<String> jumps = new ArrayList<>();
        jumps.add("jge");
        jumps.add("jle");
        jumps.add("jne");
        jumps.add("je");
        jumps.add("jg");
        jumps.add("jl");
        jumps.add("jmp");
        /** Trata casos de salto (retorna mesmo binário em todos) */
        if (jumps.contains(mnemnonic[0])) {
            return "000001100";
        }
        /** Trata operações que ocorrem no próprio registrador */
        else if (mnemnonic[0] == "incw") {
            switch (mnemnonic[1]) {
                case "%A":   return "000110111";
                case "(%A)": return "001110111";
                case "%D":   return "000011111";
            }
        }
        else if (mnemnonic[0] == "decw") {
            switch (mnemnonic[1]) {
                case "%A":   return "000110010";
                case "(%A)": return "001110010";
                case "%D":   return "000001110";
            }
        }
        else if (mnemnonic[0] == "negw") {
            switch (mnemnonic[1]) {
                case "%A":   return "000110011";
                case "(%A)": return "001110011";
                case "%D":   return "000001111";
            }
        }
        else if (mnemnonic[0] == "notw") {
            switch (mnemnonic[1]) {
                case "%A":   return "000110001";
                case "(%A)": return "001110001";
                case "%D":   return "000001101";
            }
        }
        /** Trata addw */
        else if (mnemnonic[0] == "addw") {
            // Calcula A + D
            if ((mnemnonic[1] == "%A" && mnemnonic[2] == "%D") || (mnemnonic[1] == "%D" && mnemnonic[2] == "%A")) {
                return "000000010";
            }
            // Calcula (A) + D
            else if ((mnemnonic[1] == "(%A)" && mnemnonic[2] == "%D") || (mnemnonic[1] == "%D" && mnemnonic[2] == "(%A)")){
                return "001000010";
            }
            // Calcula (A) + 1
            else if ((mnemnonic[1] == "$1" || mnemnonic[2] == "$1") && (mnemnonic[1] == "(%A)" || mnemnonic[2] == "(%A)")) {
                return "001110111";
            }
            // Calcula A + 1
            else {
                return "000110111";
            }
        }
        /** Trata subw */
        else if (mnemnonic[0] == "subw") {
            // Calcula D - A
            if (mnemnonic[1] == "%D" && mnemnonic[2] == "%A") {
                return "000010011";
            }
            // Calcula D - (A)
            else if (mnemnonic[1] == "%D" && mnemnonic[2] == "(%A)") {
                return "001010011";
            }
            // Calcula A - D
            else if (mnemnonic[1] == "%A" && mnemnonic[2] == "%D") {
                return "000000111";
            }
            // Calcula (A) - D
            else if (mnemnonic[1] == "(%A)" && mnemnonic[2] == "%D") {
                return "001000111";
            }
            // Calcula (A) - 1
            else if (mnemnonic[1] == "(%A)" && mnemnonic[2] == "$1") {
                return "001110010";
            }
            // Calcula A - 1
            else {
                return "000110010";
            }
        }
        /** Trata rsubw */
        else if (mnemnonic[0] == "rsubw") {
            // Calcula D - A
            if (mnemnonic[1] == "%A" && mnemnonic[2] == "%D") {
                return "000010011";
            }
            // Calcula D - (A)
            else if (mnemnonic[1] == "(%A)" && mnemnonic[2] == "%D") {
                return "001010011";
            }
            // Calcula A - D
            else if (mnemnonic[1] == "%D" && mnemnonic[2] == "%A") {
                return "000000111";
            }
            // Calcula (A) - D
            else if (mnemnonic[1] == "%D" && mnemnonic[2] == "(%A)") {
                return "001000111";
            }
            // Calcula (A) - 1
            else if (mnemnonic[1] == "$1" && mnemnonic[2] == "(%A)") {
                return "001110010";
            }
            // Calcula A - 1
            else {
                return "000110010";
            }
        }
        /** Trata AND */
        else if (mnemnonic[0] == "andw") {
            // Calcula A and D
            if (mnemnonic[1] == "%A" || mnemnonic[2] == "%A") {
                return "000000000";
            }
            // Calcula (A) and D
            else {
                return "001000000";
            }
        }
        /** Trata OR */
        else if (mnemnonic[0] == "orw") {
            // Calcula A or D
            if (mnemnonic[1] == "%A" || mnemnonic[2] == "%A") {
                return "000010101";
            }
            // Calcula (A) or D
            else {
                return "001010101";
            }
        }
        /** Trata movw */
        else if (mnemnonic[0] == "movw") {
            // Copia registrador A
            if (mnemnonic[1] == "%A") {
                return "000110000";
            }
            // Copia registrador (A)
            else if (mnemnonic[1] == "(%A)") {
                return "001110000";
            }
            // Copia registrador D
            else {
                return "000001100";
            }
        }
        else {
            return "000000000";
        }
        // Default
        return "000000000";
    }

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de jump (salto).
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
     */
    public static String jump(String[] mnemnonic) {
        switch (mnemnonic[0]) {
            case "jmp": return "111";
            case "jg": return "001";
            case "je": return "010";
            case "jge": return "011";
            case "jl": return "100";
            case "jne": return "101";
            case "jle": return "110";
            default: return "000";
        }
    }

    /**
     * Retorna o código binário de um valor decimal armazenado numa String.
     * @param  symbol valor numérico decimal armazenado em uma String.
     * @return Valor em binário (String de 15 bits) representado com 0s e 1s.
     */
    public static String toBinary(String symbol) {
        String binario = Integer.toBinaryString(Integer.parseInt(symbol));
        while (binario.length() < 16) {
            binario = '0' + binario;
        }
        return binario;
    }

}
