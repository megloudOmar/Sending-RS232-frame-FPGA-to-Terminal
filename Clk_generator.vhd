-- Frequency divider
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clkGenerator is 
generic (
	fCLK : integer:= 50000000; 		-- Main frequency (Hz)
	baudrate : integer:= 9600			-- Baud rate (bps)
);
port 
( 
	iCLK, reset : in std_logic;
	oCLK : out std_logic
);
end clkGenerator;

architecture rtl of clkGenerator is
signal sCLK : std_logic := '0';
begin
	process(iCLK, reset)
	variable count : integer range 0 to 5208;
	begin
	if (reset = '0') then 
		count := 0;
		oCLK <= '0';
		sCLK <= '0';
	elsif (iCLK'event and iCLK ='1') then 
		if (count = (fCLK/baudrate)/2 )then
			sCLK <= not(sCLK);
			count := 0;
		else
			count := count + 1;
		end if;
	end if;
	oCLK <= sCLK;
	end process;
end rtl;		
		
		
