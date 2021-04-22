-- Elementos de Sistemas
-- CounterDown.vhd

library ieee;
use ieee.std_logic_1164.all;

entity CounterDown is
	port(
		clock:  in std_logic;
		q:      out std_logic_vector(2 downto 0) :=(others => '0')
	);
end entity;

architecture arch of CounterDown is

  component FlipFlopT is
    port(
      clock:  in std_logic;
      t:      in std_logic;
      q:      out std_logic:= '0';
      notq:   out std_logic:= '1'
      );
	end component;
  
  signal nq0,nq1,nq2 : std_logic;
  signal q0,q1,q2 : std_logic;

begin

  tff0: FlipFlopT port map(clock,'1',q0,nq0);
  tff1: FlipFlopT port map(q0,'1',q1,nq1);
  tff2: FlipFlopT port map(q1,'1',q2,nq2);

  q(0)<=q0;
  q(1)<=q1;
  q(2)<=q2;

end architecture;
