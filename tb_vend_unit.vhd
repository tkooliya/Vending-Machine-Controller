LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;


ENTITY tb_vend_unit IS
END tb_vend_unit;


ARCHITECTURE test of tb_vend_unit IS

COMPONENT vend_unit IS
PORT( clk : IN STD_LOGIC;
		reset : IN STD_LOGIC; -- return to idle state (connect to accumulator)
		price_in : IN unsigned(7 downto 0);
		enable : IN STD_LOGIC;
		N : IN unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
		D : IN unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
		Q : IN unsigned(7 downto 0);
		change_1s, change_10s, change_100s : OUT STD_LOGIC_VECTOR (3 downto 0);
		insert_out1s, insert_out10s, insert_out100s : OUT STD_LOGIC_VECTOR (3 downto 0);
		done : OUT STD_LOGIC);
END COMPONENT;

SIGNAL clksig : STD_LOGIC;
SIGNAL resetsig : STD_LOGIC; -- return to idle state (connect to accumulator)
--SIGNAL hard_reset : STD_LOGIC; -- all the memories wiped
signal price_insig : unsigned(7 downto 0);
SIGNAL enablesig1 : STD_LOGIC;
SIGNAL Nsig : unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
SIGNAL Dsig : unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
SIGNAL Qsig : unsigned(7 downto 0);
signal change_1sig : STD_LOGIC_VECTOR (3 downto 0);
signal change_10sig : STD_LOGIC_VECTOR (3 downto 0);
signal change_100sig : STD_LOGIC_VECTOR (3 downto 0);
signal insert_out1sig : STD_LOGIC_VECTOR (3 downto 0);
signal insert_out10sig : STD_LOGIC_VECTOR (3 downto 0);
signal insert_out100sig : STD_LOGIC_VECTOR (3 downto 0);
signal donesig : STD_LOGIC;

BEGIN

		DUT : vend_unit
		port map(clk => clksig, reset => resetsig,  enable => enablesig1, price_in => price_insig, N => Nsig, D => Dsig, Q => Qsig, done => donesig, change_1s => change_1sig, change_10s => change_10sig, change_100s => change_100sig, insert_out1s => insert_out1sig, insert_out10s => insert_out10sig, insert_out100s => insert_out100sig);
		
PROCESS IS

BEGIN
	
			
			
			clksig <= '0'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '0';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			
			clksig <= '1'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '0';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			
			
			clksig <= '0'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '0';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			

			clksig <= '1'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '1';
			enablesig1 <= '1';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			
			
			
			clksig <= '0'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '1';
			enablesig1 <= '1';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			
			
			
			clksig <= '1'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '1';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			
			
			clksig <= '0'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '1';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			
			clksig <= '1'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '0';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			
			
			clksig <= '0'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '1';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			

			clksig <= '1'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '1';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			
			clksig <= '0'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '1';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			
			
			clksig <= '1'; -- Idle State / must stay on idle cuz enable = 0
			resetsig <= '0';
			enablesig1 <= '1';
			price_insig <= "00000100";
			Nsig <= "00000111";
			Dsig <= "00000011";
			Qsig <= "00000011";
			wait for 50 ns; 
			

			
			
			

			

			
END PROCESS;
END test;