-- ROM to store data to be transmitted
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port 
	(
		clk		: in std_logic;
		address	: in std_logic_vector(3 downto 0);
		data_out: out std_logic_vector(7 downto 0)
	);

end entity;

architecture rtl of rom is
signal reg_address : std_logic_vector(3 downto 0);
type T_memo is array (0 to 15) of std_logic_vector(7 downto 0);
constant rom_memo : T_memo := (	
								X"20",  -- Characteres in ASCII Code 
								X"5F", 
								X"4F", 
								X"4D", 
								X"41",
								X"52",
								X"5F",
								X"4D",
								X"45",
								X"47",
								X"4C",
								X"4F",
								X"55",
								X"44",
								X"5F",
								X"20"
								);
begin

	process(clk)
	begin
	if(clk'event and clk = '1') then
		data_out <= rom_memo(to_integer(unsigned(address)));
	end if;
	end process;

end rtl;