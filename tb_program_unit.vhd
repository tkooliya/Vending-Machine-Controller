LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;


ENTITY tb_program_unit IS
END tb_program_unit;


ARCHITECTURE test of tb_program_unit IS

COMPONENT program_unit IS
PORT( clk : IN STD_LOGIC;
		rst : IN STD_LOGIC; -- return to idle state (connect to accumulator)
	   hard_reset : IN STD_LOGIC; -- all the memories wiped
		set : IN STD_LOGIC; -- accumulated ammount goes to data_men and wen is enabled. 
		enable : IN STD_LOGIC;
		product : IN UNSIGNED(1 DOWNTO 0); -- specified number will represent the memory address for which the product's price will be stored
		N : IN unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
		D : IN unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
		Q : IN unsigned(7 downto 0);
		data_mem : OUT unsigned(7 downto 0); -- outputs the amount of money that has been accumulating as someone enters a coin
		addr_out : OUT UNSIGNED(1 DOWNTO 0); -- memory address that represents the location of a food product the person wants to buy
		done : OUT STD_LOGIC; -- once the product has correct price, outputs done and goes to idle 
		wen : OUT STD_LOGIC); -- enable that we will use later to write to memory
END COMPONENT;

SIGNAL clksig : STD_LOGIC;
SIGNAL rstsig : STD_LOGIC; -- return to idle state (connect to accumulator)
SIGNAL hard_resetsig : STD_LOGIC; -- all the memories wiped
SIGNAL setsig : STD_LOGIC; -- accumulated ammount goes to data_men and wen is enabled. 
SIGNAL enablesig1 : STD_LOGIC;
SIGNAL productsig : UNSIGNED(1 DOWNTO 0); -- specified number will represent the memory address for which the product's price will be stored
SIGNAL Nsig : unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
SIGNAL Dsig : unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
SIGNAL Qsig : unsigned(7 downto 0);
SIGNAL data_memsig : unsigned(7 downto 0); -- outputs the amount of money that has been accumulating as someone enters a coin
SIGNAL addr_outsig : UNSIGNED(1 DOWNTO 0); -- memory address that represents the location of a food product the person wants to buy
SIGNAL donesig : STD_LOGIC; -- once the product has correct price, outputs done and goes to idle 
SIGNAL wensig : STD_LOGIC; -- enable that we will use later to write to memory

BEGIN

		DUT : program_unit
		port map(clk => clksig, rst => rstsig, set => setsig, enable => enablesig1, product => productsig, N => Nsig, D => Dsig, Q => Qsig, data_mem => data_memsig, addr_out => addr_outsig, done => donesig, wen => wensig, hard_reset => hard_resetsig);
		
PROCESS IS

BEGIN
	
			clksig <= '1'; -- Idle State 
			rstsig <= '0';
			hard_resetsig <= '0';
			enablesig1 <= '0';
			setsig <= '0';
			productsig <= "10";
			Nsig <= "00000000";
			Dsig <= "00000000";
			Qsig <= "00000000";
			wait for 50 ns; 
			
			clksig <= '0';
			rstsig <= '0';
			enablesig1 <= '0';
			setsig <= '0';
			productsig <= "10";
			Nsig <= "00000000";
			Dsig <= "00000000";
			Qsig <= "00000000";
			wait for 50 ns;

			clksig <= '1';
			rstsig <= '0';
			enablesig1 <= '1';
			setsig <= '0';
			productsig <= "10";
			Nsig <= "00000000";
			Dsig <= "00000000";
			Qsig <= "00000000";
			wait for 50 ns;
			
			clksig <= '0';
			rstsig <= '0';
			enablesig1 <= '0';
			setsig <= '0';
			productsig <= "10";
			Nsig <= "00000001";
			Dsig <= "00000001";
			Qsig <= "00000001";
			wait for 50 ns;
			
			clksig <= '1';
			rstsig <= '0';
			enablesig1 <= '0';
			setsig <= '0';
			productsig <= "10";
			Nsig <= "00000001";
			Dsig <= "00000001";
			Qsig <= "00000001";
			wait for 50 ns;
			
			clksig <= '0';
			rstsig <= '0';
			enablesig1 <= '1';
			setsig <= '0';
			productsig <= "10";
			Nsig <= "00000001";
			Dsig <= "00000001";
			Qsig <= "00000001";
			wait for 50 ns;
			
			setsig <= '1'; -- Adding state 
			clksig <= '1';
			rstsig <= '0';
			enablesig1 <= '1';
			productsig <= "10"; -- must go to mem_writing state
			Nsig <= "00000001";
			Dsig <= "00000001";
			Qsig <= "00000001";
			wait for 50 ns;
			
			setsig <= '1';
			clksig <= '0';
			rstsig <= '0';
			enablesig1 <= '1';
			productsig <= "10";
			Nsig <= "00000000"; -- must go to adding state
			Dsig <= "00000000";
			Qsig <= "00000000";
			wait for 50 ns;
			
			setsig <= '1';
			clksig <= '1';
			rstsig <= '0';
			enablesig1 <= '1';
			productsig <= "10"; -- must go to mem_writing state
			Nsig <= "00000001";
			Dsig <= "00000001";
			Qsig <= "00000001";
			wait for 50 ns;
			
			setsig <= '0';
			clksig <= '0';
			rstsig <= '0';
			enablesig1 <= '1';
			productsig <= "10";
			Nsig <= "00000001"; -- must go to adding state
			Dsig <= "00000001";
			Qsig <= "00000001";
			wait for 50 ns;
			
			setsig <= '0';			-- mem_writing state
			clksig <= '1';
			rstsig <= '0';
			enablesig1 <= '1';
			productsig <= "10";
			Nsig <= "00000001"; 
			Dsig <= "00000001";
			Qsig <= "00000001";
			wait for 50 ns;
			
			setsig <= '0';			-- mem_writing state
			clksig <= '0';
			rstsig <= '0';
			enablesig1 <= '1';
			productsig <= "10";
			Nsig <= "00000001"; 
			Dsig <= "00000001";
			Qsig <= "00000001";
			wait for 50 ns;
			
END PROCESS;
END test;
		
		