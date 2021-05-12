-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: ControlUnit.vhd
-- date: 4/4/2017
-- Modificação:
--   - Rafael Corsi : nova versão: adicionado reg S
--
-- Unidade que controla os componentes da CPU

library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
    port(
		instruction                 : in STD_LOGIC_VECTOR(17 downto 0);  -- instrução para executar
		zr,ng                       : in STD_LOGIC;                      -- valores zr(se zero) e
                                                                     -- ng (se negativo) da ALU
		muxALUI_A                   : out STD_LOGIC;                     -- mux que seleciona entre
                                                                     -- instrução  e ALU para reg. A
		muxAM                       : out STD_LOGIC;                     -- mux que seleciona entre
                                                                     -- reg. A e Mem. RAM para ALU
                                                                     -- A  e Mem. RAM para ALU
		zx, nx, zy, ny, f, no       : out STD_LOGIC;                     -- sinais de controle da ALU
		loadA, loadD, loadM, loadPC : out STD_LOGIC               -- sinais de load do reg. A,
                                                                     -- reg. D, Mem. RAM e Program Counter
    );
end entity;

architecture arch of ControlUnit is

begin

  loadD <= instruction(17) and instruction(4);
  loadM <= instruction(17) and instruction(5); --escrita na memória RAM, utilizamos onde A aponta (%A)
  loadA <= not(instruction(17)) or (instruction(17) and instruction(3)); -- registrador %A que pode executar tanto leaw quanto mov

  muxALUI_A <= not(instruction(17)); --verifica o bit 17 para ver se é 1 (leaw) ou 0 (mov)
  muxAM <= instruction(17) and instruction(13); --mux : r0, que pode ser 0 ou 1. 

  zx <= instruction(17) and instruction(12); -- verifica o bit 12 que indica o zx e o bit 17 já que é do tipo C.
  nx <= instruction(17) and instruction(11); -- verifica o bit 11 que indica o nx. 
  zy <= instruction(17) and instruction(10); -- verifica o bit 10 que indica o zy.
  ny <= instruction(17) and instruction(9); -- verifica o bit 9 que indica o ny.
  f <= instruction (17) and instruction(8); -- verifica o bit 8 que indica o f.
  no <= instruction(17) and instruction(7); -- verifica o bit 7 que indica o no.

  loadPC <= '1' when instruction(17) = '1' and instruction(2 downto 0)= "001" and (ng = '0' and zr = '0') else --JG, > 0
            '1' when instruction(17) = '1' and instruction(2 downto 0) = "010" and (ng = '0' and zr = '1') else -- JE, =0
            '1' when instruction(17) = '1' and instruction(2 downto 0) = "011" and (ng = '0' and zr = '1') else --JGE, >=0
            '1' when instruction(17) = '1' and instruction(2 downto 0) = "100" and (ng = '1' and zr = '0') else -- JL, <0
            '1' when instruction(17) = '1' and instruction(2 downto 0) = "101" and (              zr = '0') else -- JNE, !=0 (pode ser neg ou não)
            '1' when instruction(17) = '1' and instruction(2 downto 0) = "110" and (ng = '1' and zr = '1') else -- JLE, <=0
            '1' when instruction(17) = '1' and instruction(2 downto 0) = "111"  else
            '0';

end architecture;
