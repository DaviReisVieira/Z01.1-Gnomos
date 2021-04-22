-- Elementos de Sistemas
-- FlipFlopJK.vhd

library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopJK is
	port(
		clock:  in std_logic;
		J:      in std_logic;
		K:      in std_logic;
		q:      out std_logic:= '0';
		notq:   out std_logic:= '1'
	);
end entity;

architecture arch of FlipFlopJK is

  signal state: std_logic:= '0';
  signal input: std_logic_vector(1 downto 0);

begin

  input <= J & K;

  process (clock) begin
    if (rising_edge(clock)) then
      case (input) is 
        when "11" => 
          state <= not state;
        when "10" =>
          state <= '1';
        when "01" =>
          state <= '0';
        when others => 
          null;
      end case;
    end if;
  end process;

  q <= state;
  notq <= not state;

end architecture;
