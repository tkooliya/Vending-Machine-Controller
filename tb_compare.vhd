LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;



ENTITY tb_compare IS
END tb_compare;



ARCHITECTURE test of tb_compare IS
	
	component compare IS

	PORT( price_in : IN unsigned(7 downto 0);
			accum_out : IN unsigned(7 downto 0);
			change : OUT unsigned(7 downto 0);
			done : OUT STD_LOGIC);

	END component;
	
	
	signal price_insig : unsigned(7 downto 0);
	signal accum_insig : unsigned(7 downto 0);
	signal changesig : unsigned(7 downto 0);
	signal insert_outsig : unsigned(7 downto 0);
	signal donesig : STD_LOGIC;
	
	
	begin
	
		DUT : compare
		port map (price_in => price_insig, accum_out => accum_insig, change => changesig, done => donesig);
		
		process is 
		
			begin
			
			price_insig <= "11111000";
			accum_insig <= "11111110";
			wait for 50 ns;


			price_insig <= "11111000";
			accum_insig <= "00000110";
			wait for 50 ns;
			
			
		end process;
		
end test;
			
			
			
			