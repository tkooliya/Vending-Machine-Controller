LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;



ENTITY vend_unit IS

PORT( clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		price_in : IN unsigned(7 downto 0);
		N : IN unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
		D : IN unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
		Q : IN unsigned(7 downto 0);
		change_1s, change_10s, change_100s : OUT STD_LOGIC_VECTOR (3 downto 0);
		insert_out1s, insert_out10s, insert_out100s : OUT STD_LOGIC_VECTOR (3 downto 0);
		done : OUT STD_LOGIC);


END vend_unit;

ARCHITECTURE Behaviour of vend_unit is

	
	component accumulator IS
	
	PORT( clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			enable : IN STD_LOGIC;
			N : IN unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
			D : IN unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
			Q : IN unsigned(7 downto 0);
			accum_out : OUT unsigned(7 downto 0));
			
	end component;
		
		

	component compare IS

	PORT( price_in : IN unsigned(7 downto 0);
			accum_out : IN unsigned(7 downto 0);
			change : OUT unsigned(7 downto 0);
			done : OUT STD_LOGIC);

	END component;
	
	
	
	component convert2bcd IS
		
		PORT(binary : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				  bcd : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
	
	END component;
	
	type states is (idle, calculating, convert);
	signal present_state, next_state : states;


	signal change_due : unsigned (7 downto 0);
	signal accum_outsig : unsigned(7 downto 0); -- need to use to convert unsigned to std_logic_vector type for bcd	 
	
	begin
	
	Acc : accumulator
	port map(N => N, D => D, Q => Q, clk => clk, enable => enable, reset => reset, accum_out => accum_outsig);
	
	
	Comp : compare
	port map(price_in => price_in, accum_out => accum_outsig, change => change_due, done => done);
	
	
	Bcdchange : convert2bcd
	port map(binary => std_logic_vector(change_due), bcd(11 downto 8) => change_100s, bcd(7 downto 4) => change_10s, bcd(3 downto 0) => change_1s );
	
	Bcdinsert : convert2bcd
	port map(binary => std_logic_vector(accum_outsig), bcd(11 downto 8) => insert_out100s, bcd(7 downto 4) => insert_out10s, bcd(3 downto 0) => insert_out1s);
	

	
	process(accum_outsig, reset)
	
	begin
	
	case present_state is
	
		
		when idle => 
							 
							 if (enable = '1') then
							 
							 present_state <= calculating;
							 
							 
							 else
							 present_state <= idle;
							 next_state <= calculating;
							 
							 end if;
						
								
						 
						 
						 
		when calculating =>  
							
							
								if (enable = '1') then
			
									if (accum_outsig >= price_in) then  -- if you input enough, inset done signal
										
											present_state <= convert;

										
									else
										
										present_state <= calculating;
										next_state <= convert;
									
									end if;
									
								else 
								
									present_state <= idle;
									next_state <= calculating;
					
								end if;
		
		
		
		when convert => 
		
							if (enable = '1') then
							
								present_state <= idle;
								next_state <= convert;

							
								
							else
								
								present_state <= idle;
								next_state <= calculating;
								
								
							end if;
							

	

	
	
	
	end case;
	
	end process;
	
		
end Behaviour;
		