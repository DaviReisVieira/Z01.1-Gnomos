library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sevenSeg is
	port (
			bcd : in  STD_LOGIC_VECTOR(3 downto 0);
			leds: out STD_LOGIC_VECTOR(6 downto 0));
end entity;

architecture arch of sevenSeg is
begin

	with bcd select
	
		leds <= "0000001" when "0000", -- Número 0
				"1001111" when "0001", -- Número 1 
				"0010010" when "0010", -- Número 2
				"0000110" when "0011", -- Número 3
				"1001100" when "0100", -- Número 4
				"0100100" when "0101", -- Número 5
				"0100000" when "0110", -- Número 6
				"0001111" when "0111", -- Número 7
				"0000000" when "1000", -- Número 8
				"0000100" when "1001", -- Número 9
				"0000010" when "1010", -- Dígito A
				"1100000" when "1011", -- Dígito B
				"1110010" when "1100", -- Dígito C
				"1000010" when "1101", -- Dígito D
				"0110000" when "1110", -- Dígito E
				"0111000" when "1111", -- Dígito F
				"1111111" when others; -- Led Desligado
end architecture;