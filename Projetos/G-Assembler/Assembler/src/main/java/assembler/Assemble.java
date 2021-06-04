/**
 * Curso: Elementos de Sistemas
 * Arquivo: Assemble.java
 * Created by Luciano <lpsoares@insper.edu.br>
 * Date: 04/02/2017
 *
 * 2018 @ Rafael Corsi
 */

package assembler;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Faz a geração do código gerenciando os demais módulos
 */
public class Assemble {
    private String inputFile;              // arquivo de entrada nasm
    File hackFile = null;                  // arquivo de saída hack
    private PrintWriter outHACK = null;    // grava saida do código de máquina em Hack
    boolean debug;                         // flag que especifica se mensagens de debug são impressas
    private SymbolTable table;             // tabela de símbolos (variáveis e marcadores)

    /*
     * inicializa assembler
     * @param inFile
     * @param outFileHack
     * @param debug
     * @throws IOException
     */
    public Assemble(String inFile, String outFileHack, boolean debug) throws IOException {
        this.debug = debug;
        inputFile  = inFile;
        hackFile   = new File(outFileHack);                      // Cria arquivo de saída .hack
        outHACK    = new PrintWriter(new FileWriter(hackFile));  // Cria saída do print para
                                                                 // o arquivo hackfile
        table      = new SymbolTable();                          // Cria e inicializa a tabela de simbolos
    }

    /**
     * primeiro passo para a construção da tabela de símbolos de marcadores (labels)
     * varre o código em busca de novos Labels e Endereços de memórias (variáveis)
     * e atualiza a tabela de símbolos com os endereços (table).
     *
     * Dependencia : Parser, SymbolTable
     * @return
     */
    public SymbolTable fillSymbolTable() throws FileNotFoundException, IOException {

        // primeira passada pelo código deve buscar os labels
        // LOOP:
        // END:
        Parser parser = new Parser(inputFile);
        int romAddress = 0;
        while (parser.advance()){
            if (parser.commandType(parser.command()) == Parser.CommandType.L_COMMAND) {
                String label = parser.label(parser.command());
                /* TODO: implementar */
                // deve verificar se tal label já existe na tabela,
                // se não, deve inserir. Caso contrário, ignorar.
                if (!table.contains(label)){
                    table.addEntry(label, romAddress);
                    if (this.debug){
                        System.out.println("Adicionando o novo label: " + label+" para a tabela de labels");
                    }
                }
            } else {
                if (this.debug){
                    System.out.println("Label já existente na tabela");
                }
                romAddress++;
            }
        }
        parser.close();

        // a segunda passada pelo código deve buscar pelas variáveis
        // leaw $var1, %A
        // leaw $X, %A
        // para cada nova variável deve ser alocado um endereço,
        // começando no RAM[15] e seguindo em diante.
        parser = new Parser(inputFile);
        int ramAddress = 15;
        while (parser.advance()){
            if (parser.commandType(parser.command()) == Parser.CommandType.A_COMMAND) {
                String symbol = parser.symbol(parser.command());
                if (Character.isDigit(symbol.charAt(0))){
                    /* TODO: implementar */
                    // deve verificar se tal símbolo já existe na tabela,
                    // se não, deve inserir associando um endereço de
                    // memória RAM a ele.
                    if (!table.contains(symbol)){
                        table.addEntry(symbol,ramAddress);
                        if (this.debug){
                            System.out.println("Adicionando o endereço "+ symbol+" de RAM na tabela");
                        }
                    }
                }
            } ramAddress++;
            if (this.debug){
                System.out.println("Endereço de RAM já existente");
            }
        }
        parser.close();
        return table;
    }

    /**
     * Segundo passo para a geração do código de máquina
     * Varre o código em busca de instruções do tipo A, C
     * gerando a linguagem de máquina a partir do parse das instruções.
     *
     * Dependencias : Parser, Code
     */
    public void generateMachineCode() throws FileNotFoundException, IOException{
        Parser parser = new Parser(inputFile);  // abre o arquivo e aponta para o começo
        String instruction  = "";


        /**
         * Aqui devemos varrer o código nasm linha a linha
         * e gerar a string 'instruction' para cada linha
         * de instrução válida do nasm
         * seguindo o instruction set
         */
        while (parser.advance()){
            switch (parser.commandType(parser.command())){
                /* TODO: implementar */
                case C_COMMAND:
                    if (this.debug){
                        System.out.println("Instrução do tipo C");
                    }
                    String[] instructionSet = parser.instruction(parser.command());
                    if (this.debug){
                        System.out.println("Gerando o vetor de String com o Parser");
                    }
                    String jmp = Code.jump(instructionSet);
                    if (this.debug){
                        System.out.println("Este é o jump: "+ jmp);
                    }
                    String dest = Code.dest(instructionSet);
                    if (dest=="errorMovDPointer"){
                        System.out.println("\nVocê não pode carregar para o pointer D! Verifique a linha: "+ parser.getLineNumber()+ " de seu nasm! :(");
                        return;
                    }
                    if (this.debug){
                        System.out.println("O destino da instrução é: "+ dest);
                    }
                    String comp = Code.comp(instructionSet);
                    if (this.debug){
                        System.out.println("A operação realizada é: "+comp);
                    }
                    instruction = "10" + comp + dest + jmp;
                    if (this.debug){
                        System.out.println("A instrução final é " + instruction);
                    }
                break;
            case A_COMMAND:
                if (this.debug){
                    System.out.println("Instrução do tipo A");
                }
                String symbolDecimal = parser.symbol(parser.command());

                String newLine = (parser.command()).replaceAll("\\s+","");
                List<String> commandList = new ArrayList<String>(Arrays.asList(newLine.split(",")));
                if (!commandList.get(1).contains("%A")){
                    System.out.println("\nVocê só pode fazer o carregamento efetivo no Reg.A! :( Verifique a linha "+ parser.getLineNumber()+" de seu nasm!");
                    return;
                }

                try{
                    if (this.debug){
                        System.out.println("Primeiro considerando o leaw feito com constantes");
                    }
                    String symbolBinary = Code.toBinary(symbolDecimal);
                    instruction = "00" + symbolBinary;
                    if (this.debug){
                        System.out.println("Leaw feito com o número "+ symbolDecimal+ " que resultou na instrução: "+ instruction);
                    }
                } catch (Exception e){
                    if (this.debug){
                        System.out.println("Leaw feito com label");
                    }
                    String TableAddress = table.getAddress(symbolDecimal).toString();
                    instruction = "00" + Code.toBinary(TableAddress);
                    if (this.debug){
                        System.out.println("Leaw feito com o label "+ symbolDecimal+ " que resultou na instrução: " + instruction);
                    }
                }


                break;
            default:
                continue;
            }
            // Escreve no arquivo .hack a instrução
            if(outHACK!=null) {
                outHACK.println(instruction);
            }
            instruction = null;
        }
        System.out.println("Conversão Assembly (NASM) para Código de Máquina (HACK) finalizado.");
    }

    /**
     * Fecha arquivo de escrita
     */
    public void close() throws IOException {
        if(outHACK!=null) {
            outHACK.close();
        }
    }

    /**
     * Remove o arquivo de .hack se algum erro for encontrado
     */
    public void delete() {
        try{
            if(hackFile!=null) {
                hackFile.delete();
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

}
