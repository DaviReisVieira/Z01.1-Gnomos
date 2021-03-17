library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2Way is
	port ( 
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			sel: in  STD_LOGIC;
			q:   out STD_LOGIC);
end entity;

architecture arch of Mux2Way is
begin

	q <= '1' when (sel = '0' AND a = '1') else
		 '0' when (sel = '0' AND a = '0') else
		 '1' when (sel = '1' AND b = '1') else
		 '0';
end architecture;
