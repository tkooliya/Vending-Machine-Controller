LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;



ENTITY tb_accumulator IS
END tb_accumulator;



ARCHITECTURE test of tb_accumulator IS

	component accumulator IS
	PORT( clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			enable : IN STD_LOGIC;
			N : IN unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
			D : IN unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
			Q : IN unsigned(7 downto 0);
			accum_out : OUT unsigned(7 downto 0));
	END component;
	
	
	signal clksig : STD_LOGIC;
	signal resetsig : STD_LOGIC;
	signal enablesig : STD_LOGIC;
	signal Ncsig : unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
	signal Dcsig : unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
	signal Qcsig : unsigned(7 downto 0);
	signal accum_outsig : unsigned(7 downto 0);
	
	begin

		DUT : accumulator
		port map(clk => clksig, reset => resetsig, enable => enablesig, N => Ncsig, D => Dcsig, Q => Qcsig, accum_out => accum_outsig);
		
		process is
		
			begin
			
			clksig <= '0';
			resetsig <= '0';
			enablesig <= '1';
			Ncsig <= "00000001";
			Dcsig <= "00000001"; -- 40
			Qcsig <= "00000001";
			wait for 50 ns; 
			
			
			clksig <= '1';
			wait for 50 ns;
			
			
		end process;
end test;
