LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;



ENTITY vend_unit IS

PORT( clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		N : IN signed(6 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
		D : IN signed(6 downto 0); -- represents COUNT of coins, not cumulated PRICE!
		Q : IN signed(6 downto 0);
		price_in : IN signed(6 downto 0);
		accum_out : OUT signed(6 downto 0);
		done : OUT STD_LOGIC;
		change : OUT signed(6 downto 0);
		insert_out : OUT STD_LOGIC);
		


END vend_unit;


ARCHITECTURE Behaviour of vend_unit is


	component  accumulator IS

	PORT( clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			enable : IN STD_LOGIC;
			N : IN signed(6 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
			D : IN signed(6 downto 0); -- represents COUNT of coins, not cumulated PRICE!
			Q : IN signed(6 downto 0);
			accum_out : OUT signed(6 downto 0));

	END component;
	
	begin
	
	process(clk, enable)
	
	begin

	accum : accumulator
	
	port map(clk => clk, reset => reset, enable => enable, N => N, D => D, Q => Q, accum_out => accum_out)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	else
	
	
	