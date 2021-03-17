library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Not16 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture arch of Not16 is
begin
	q(0) <= not a(0);	
	q(1) <= not a(1);
	q(2) <= not a(2);
	q(3) <= not a(3);
	q(4) <= not a(4);
	q(5) <= not a(5);
	q(6) <= not a(6);
	q(7) <= not a(7);
	q(8) <= not a(8);
	q(9) <= not a(9);
	q(10) <= not a(10);
	q(11) <= not a(11);
	q(12) <= not a(12);
	q(13) <= not a(13);
	q(14) <= not a(14);
	q(15) <= not a(15);
end architecture;
