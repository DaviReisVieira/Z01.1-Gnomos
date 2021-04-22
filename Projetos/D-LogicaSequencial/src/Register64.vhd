-- Elementos de Sistemas
-- by Luciano Soares
-- Register64.vhd

Library ieee;
use ieee.std_logic_1164.all;

entity Register64 is
	port(
		-- entradas
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(63 downto 0); -- vetor 64 bits
		load:    in STD_LOGIC;
		-- saída
		output: out STD_LOGIC_VECTOR(63 downto 0)  -- vetor 64 bits
	);
end entity;

architecture arch of Register64 is

	component Register32 is
		port(
			-- entradas
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC_VECTOR(31 downto 0); -- vetor 32 bits
			load:    in STD_LOGIC;
			-- saída
			output: out STD_LOGIC_VECTOR(31 downto 0)  -- vetor 32 bits
      );
	end component;

begin

	-- Registrador 1 de 32 bits
	register1: Register32
	port map (
		clock => clock,
		load => load,
		input => input(31 downto 0),
		output => output(31 downto 0)
	);
	
	-- Registrador 2 de 32 bits
	register2: Register32
	port map (
		clock => clock,
		load => load,
		input => input(63 downto 32),
		output => output(63 downto 32)
	);

end architecture;
