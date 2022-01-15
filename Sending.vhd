-- Component that reads ROM and sends characters to the transmitter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sending is

	port
	(
		reset	  : in std_logic;
		busy	  : in std_logic;
		s		  : out std_logic_vector(3 downto 0)
	);

end entity;

architecture rtl of sending is
begin

	process (busy, reset)
		variable   cnt		   : integer range 0 to 15 := 0;
	begin
			if (reset = '0') then
				cnt := 0;
			elsif ( busy'event and busy = '0') then
				if (cnt < 16) then
					cnt := cnt + 1;
				else
					cnt := 0;
				end if;
			end if;
		
		s <= std_logic_vector(to_unsigned(cnt, s'length));
	end process;

end rtl;
