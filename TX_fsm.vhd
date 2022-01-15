library ieee;
use ieee.std_logic_1164.all;

entity tx_fsm is

	port
	(
		clk		 		: in	std_logic;								-- Main clock
		reset	 			: in	std_logic;								-- Main reset
		go	 	 			: in	std_logic;								-- Request SEND of data
		word_tx	 		: in	std_logic_vector(7 downto 0); 	-- Data to transmit
		Serial_Data	 	: out	std_logic;								-- RS232 transmitted serial data
		Busy           : out std_logic								-- Indicate the state of TX
	);

end entity;

architecture rtl of tx_fsm is
	type state_type is (idle, start, data_shift, stop);
	signal state : state_type := idle;
begin

	process (clk, reset, go)
	variable count : integer range 0 to 8;
	begin

		if reset = '0' then
			state <= idle;
			count := 0;
			Serial_Data <= '1'; 
			Busy <= '0';

		elsif (clk'event and clk = '1') then
			case state is
				when idle=>
					if go = '0' then
						state <= start;
					else
						state <= idle;						-- Drive line HIGH for Idle  
					end if;
				when start=>
					state <= data_shift;
					Serial_Data <= '0';
					Busy <= '1';
				when data_shift=>
					if count < 7 then
						state <= data_shift;
						Serial_Data <= word_tx(count);
						Busy <= '1';
						count := count + 1;
					else
						state <= stop;
						Serial_Data <= word_tx(count);
						Busy <= '1';
					end if;
				when stop=>
					state <= idle;
					count := 0;
					Serial_Data <= '1';
					Busy <= '0';	
			end case;
		end if;
	end process;
end rtl;
