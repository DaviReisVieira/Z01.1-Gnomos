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


leds <= "0000001" when "0000", -- numero 0
		  "1001111" when "0001", -- numero 1 
		  "0101101" when "0010", -- numero 2
		  "0000110" when "0011", -- numero 3
		  "1001100" when "0100", --numero 4
		  "0100100" when "0101", --numero 5
		  "0100000" when "0110", -- numero 6
		  "0001111" when "0111", --numero 7
		  "0000000" when "1000", --numero 8
		  "0000100" when "1001", --numero 9
		  "1111111" when others; --Leds desligados.

end architecture;
