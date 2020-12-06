LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;

ENTITY program_unit IS

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

END program_unit;


-- Done =>
-- TODO: hard_reset
-- TODO: if enable = 0, displays 0; if enable = 1, proceed to adding state
-- TODO: use inputs N,D,Q and accumulator should tally it; If set = 1,
-- a) value goes to data_memoutput, accompanied with wen & addr_out.
-- b) accumulator must be all '0'
-- c) goes to next state
-- TODO: waits for 'x' cycles until product price is successfully written
-- goes back to idle state with "done" signal


ARCHITECTURE Behaviour of program_unit IS
TYPE State IS (idle, adding, mem_writing);
	SIGNAL n_State, p_state : State;
	SIGNAL accum_outssig : unsigned(7 downto 0);

COMPONENT accumulator IS

PORT( clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		N : IN unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
		D : IN unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
		Q : IN unsigned(7 downto 0);
		accum_out : OUT unsigned(7 downto 0)); -- accumulated value
END COMPONENT;

BEGIN
	
Acc : accumulator
		port map (clk => clk, reset => rst, accum_out => accum_outssig, N => N, D => D, Q => Q, enable => enable);
		
		
PROCESS (accum_outssig)
BEGIN

	IF hard_reset = '1' THEN
		wen <= '1';
		data_mem <= (others=> '0'); -- makes all 0
		addr_out <= (others=> '0');
		done <= '0';
		p_state <= idle;

	END IF;
	
	IF rst <= '1' THEN
		wen <= '1';
		data_mem <= "ZZZZZZZZ";
		done <= '0';
		p_state <= idle;
	
	END IF;
	
CASE p_State IS
	
	WHEN idle =>
			done <= '0';
		
		IF enable = '1' THEN
			p_state <= adding;
			n_state <= mem_writing;
			
		ELSE -- enable = '0';
			data_mem <= "ZZZZZZZZ";
			wen <= '1';
			n_state <= idle;
			p_state <= idle;
			
		END IF;
	
	WHEN adding =>
			done <= '0';

		IF set = '1' THEN
			p_state <= mem_writing;
			n_state <= idle;
			addr_out <= product;
			wen <= '0';
			data_mem <= accum_outssig;
			
		ELSE
			n_state <= adding;
			p_state <= adding;
		END IF;
	
	WHEN mem_writing =>
		n_state <= adding;
		done <= '1' after 100 ns;
		p_state <= idle after 100 ns;
	
END CASE;
END PROCESS;
END Behaviour;

	