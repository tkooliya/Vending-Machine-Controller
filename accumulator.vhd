LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;



ENTITY accumulator IS

PORT( clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		N : IN unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
		D : IN unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
		Q : IN unsigned(7 downto 0);
		accum_out : OUT unsigned(7 downto 0));


END accumulator;

ARCHITECTURE Behaviour of accumulator is

	signal totalvalbin : unsigned(7 downto 0);
	

	begin 
	
	process(clk, enable)
	
	begin
	
	if (rising_edge(clk)) then
	
		if (reset = '1') then 
			
			accum_out <= "00000000";
	
		elsif (enable = '1') then 
			
			
			accum_out <= to_unsigned(((5*(to_integer(N))) + (10*(to_integer(D))) + (25*(to_integer(Q)))), 8); -- accum_out represents the accumulated monetary value
			
		end if;
	
	end if;
	
	end process;
	
end Behaviour;
		
		
		
		
		
	
	
	
		
	
	
