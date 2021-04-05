-- Elementos de Sistemas
-- by Luciano Soares
-- zerador16.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Shifter16 is
  port(
        z   : in STD_LOGIC_VECTOR(1 downto 0);
	      as  : in STD_LOGIC_VECTOR(15 downto 0);
        y   : out STD_LOGIC_VECTOR(15 downto 0)
      );
end Shifter16;

architecture rtl of Shifter16 is
  
  component Mux4Way is
		port (
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			c:   in  STD_LOGIC;
			d:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(1 downto 0);
			q:   out STD_LOGIC
		);
	end component;

begin
  
  -- u0 : Mux4Way port map (as(0),'0',as(1),'0',z,y(0));
  -- u1:  Mux4Way port map (as(1),as(0),as(2),'0',z,y(1));
  -- u2:  Mux4Way port map (as(2),as(1),as(3),'0',z,y(2));
  -- u3:  Mux4Way port map (as(3),as(2),as(4),'0',z,y(3));
  -- u4:  Mux4Way port map (as(4),as(3),as(5),'0',z,y(4));
  -- u5:  Mux4Way port map (as(5),as(4),as(6),'0',z,y(5));
  -- u6:  Mux4Way port map (as(6),as(5),as(7),'0',z,y(6));
  -- u7:  Mux4Way port map (as(7),as(6),as(8),'0',z,y(7));
  -- u8:  Mux4Way port map (as(8),as(7),as(9),'0',z,y(8));
  -- u9:  Mux4Way port map (as(9),as(8),as(10),'0',z,y(9));
  -- u10:  Mux4Way port map (as(10),as(9),as(11),'0',z,y(10));
  -- u11:  Mux4Way port map (as(11),as(10),as(12),'0',z,y(11));
  -- u12:  Mux4Way port map (as(12),as(11),as(13),'0',z,y(12));
  -- u13:  Mux4Way port map (as(13),as(12),as(14),'0',z,y(13));
  -- u14:  Mux4Way port map (as(14),as(13),as(15),'0',z,y(14));
  -- u15:  Mux4Way port map (as(15),as(14),'0','0',z,y(15));

  y<=as(14 downto 0) & '0' when z="01" else
    '0' & as(15 downto 1)  when z="10" else
    as;


end architecture;
