-- Elementos de Sistemas
-- by Luciano Soares
-- Ram64.vhd

Library ieee;
use ieee.std_logic_1164.all;

entity Ram64 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR( 5 downto 0); -- vetor de 6 bits
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture arch of Ram64 is

	component Ram8 is
		port(
			clock:   in  STD_LOGIC;
			input:   in  STD_LOGIC_VECTOR(15 downto 0);
			load:    in  STD_LOGIC;
			address: in  STD_LOGIC_VECTOR( 2 downto 0);
			output:  out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	component Mux8Way16 is
		port (
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			c:   in  STD_LOGIC_VECTOR(15 downto 0);
			d:   in  STD_LOGIC_VECTOR(15 downto 0);
			e:   in  STD_LOGIC_VECTOR(15 downto 0);
			f:   in  STD_LOGIC_VECTOR(15 downto 0);
			g:   in  STD_LOGIC_VECTOR(15 downto 0);
			h:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC_VECTOR( 2 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	component DMux8Way is
		port (
			a:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q0:  out STD_LOGIC;
			q1:  out STD_LOGIC;
			q2:  out STD_LOGIC;
			q3:  out STD_LOGIC;
			q4:  out STD_LOGIC;
			q5:  out STD_LOGIC;
			q6:  out STD_LOGIC;
			q7:  out STD_LOGIC
		);
	end component;

	signal load0, load1, load2, load3, load4, load5, load6, load7 : STD_LOGIC;
	signal output0, output1, output2, output3, output4, output5, output6, output7 : STD_LOGIC_VECTOR(15 downto 0);

begin

	-- CONFIGURAÇÃO DAS RAM 8
	ram0: Ram8
	port map (
		clock => clock,
		load => load0,
		input => input,
		address => address(2 downto 0), -- endereça registrador da ram
		output => output0
	);

	ram1: Ram8
	port map (
		clock => clock,
		load => load1,
		input => input,
		address => address(2 downto 0),
		output => output1
	);

	ram2: Ram8
	port map (
		clock => clock,
		load => load2,
		input => input,
		address => address(2 downto 0),
		output => output2
	);

	ram3: Ram8
	port map (
		clock => clock,
		load => load3,
		input => input,
		address => address(2 downto 0),
		output => output3
	);

	ram4: Ram8
	port map (
		clock => clock,
		load => load4,
		input => input,
		address => address(2 downto 0),
		output => output4
	);

	ram5: Ram8
	port map (
		clock => clock,
		load => load5,
		input => input,
		address => address(2 downto 0),
		output => output5
	);

	ram6: Ram8
	port map (
		clock => clock,
		load => load6,
		input => input,
		address => address(2 downto 0),
		output => output6
	);

	ram7: Ram8
	port map (
		clock => clock,
		load => load7,
		input => input,
		address => address(2 downto 0),
		output => output7
	);


	-- CONFIGURAÇÃO DO DMUX8WAY
	-- 1 entrada e 8 saídas de 1 bit // seletor de 3 bits
	-- Esse componente seta o load para cada uma das RAMs
	dmux8w: DMux8Way
	port map (
		-- escolhe a ram8 a ser utilizada
		sel => address(5 downto 3),
		-- conecta entrada ao load para definir a operação
		a => load,
		-- conecta saídas do dmux aos sinais de load correspondentes
		q0 => load0,
		q1 => load1,
		q2 => load2,
		q3 => load3,
		q4 => load4,
		q5 => load5,
		q6 => load6,
		q7 => load7
	);


	-- CONFIGURAÇÃO DO MUX8WAY16
	-- 8 entradas e 1 saída de 16 bits // seletor de 3 bits
	-- Esse componente pega o output da ram que contém o registrador endereçado
	mux8w16: Mux8Way16
	port map (
		-- conecta seletor à ram8 correspondente
		sel => address(5 downto 3),
		-- conecta entradas do mux para receber outputs das RAMs
		a => output0,
		b => output1,
		c => output2,
		d => output3,
		e => output4,
		f => output5,
		g => output6,
		h => output7,
		-- conecta saída do mux ao output
		q => output
	);

end architecture;
