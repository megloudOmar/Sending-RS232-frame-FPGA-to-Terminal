library ieee;
use ieee.std_logic_1164.all;

entity top_level is
port(
	clk		 : in	std_logic;
	reset	 : in	std_logic;
	go	 	 : in	std_logic;
	Serial_Data	 	 : out	std_logic
);
end top_level;

architecture rtl of top_level is
	component sending is
	port
	(
		reset	  : in std_logic;
		busy	  : in std_logic;
		s		  : out std_logic_vector(3 downto 0)
	);
	end component;
	
	component rom is
	port 
	(
		clk		: in std_logic;
		address	: in std_logic_vector(3 downto 0);
		data_out: out std_logic_vector(7 downto 0)
	);
	end component;

	component clkGenerator is 
	generic (
		fCLK : integer:= 50000000;
		baudrate : integer:= 9600
	);
	port 
	( 
		iCLK, reset : in std_logic;
		oCLK : out std_logic
	);
	end component;
		
	component tx_fsm is
	port
	(
		clk		 	: in	std_logic;
		reset	 		: in	std_logic;
		go	 	 		: in	std_logic;
		word_tx	 	: in	std_logic_vector(7 downto 0);
		Serial_Data	 	 : out	std_logic;
		Busy            : out 	std_logic
	);
	end component;
	
	signal C_s : std_logic;
	signal busy_s : std_logic;
	signal word_tx	 :	std_logic_vector(7 downto 0);
	signal cnt : std_logic_vector(3 downto 0);
	
	begin
	u1 : Sending port map (reset, busy_s, cnt);
	u2 : rom port map (clk, cnt, word_tx);
	u3 : clkGenerator generic map (50000000, 9600) port map (clk, reset, C_s);
	u4 : tx_fsm port map (C_s, reset, go, word_tx, Serial_Data, busy_s);
	
end rtl;
	 