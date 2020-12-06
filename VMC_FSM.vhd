LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;

ENTITY VMC_FSM IS

PORT(
--Inputs: clock, reset, hard_reset, Start, set N, D, Q, funct, prod
		clock 		: IN STD_LOGIC; -- rising_edge
		reset 		: IN STD_LOGIC; -- return to idle state
	   hard_reset  : IN STD_LOGIC; -- all the memories wiped
		start			: IN STD_LOGIC; -- initiate the VMC to enter the “funct” specified mode of operation
		set			: IN STD_LOGIC; -- accumulated ammount goes to data_men and wen is enabled
		N				: IN UNSIGNED(7 DOWNTO 0); -- nickel
		D				: IN UNSIGNED(7 DOWNTO 0); -- dime
		Q				: IN UNSIGNED(7 DOWNTO 0); -- quarter
		funct			: IN UNSIGNED(1 DOWNTO 0); -- 00: program, 01: display, 10: vend, 11: free
		prod			: IN UNSIGNED(1 DOWNTO 0); -- -- specified number will represent the memory address for which the product's price will be stored

--Outputs: change0, change1, change2, runTotal0, runTotal1, runTotal2, total0, total1, total2, finished
		 change0		: OUT STD_LOGIC_VECTOR (3 downto 0); -- change_1s in vend_unit
		 change1		: OUT STD_LOGIC_VECTOR (3 downto 0); -- change_10s in vend_unit
		 change2		: OUT STD_LOGIC_VECTOR (3 downto 0); -- change_100s in vend_unit
		 runTotal0	: OUT STD_LOGIC_VECTOR (3 downto 0); -- running total of N
		 runTotal1	: OUT STD_LOGIC_VECTOR (3 downto 0); -- running total of D
		 runTotal2	: OUT STD_LOGIC_VECTOR (3 downto 0); -- running total of Q
		 total0		: OUT STD_LOGIC_VECTOR (3 downto 0); -- insert_out1s in vend_unit
		 total1		: OUT STD_LOGIC_VECTOR (3 downto 0); -- insert_out10s in vend_unit
		 total2		: OUT STD_LOGIC_VECTOR (3 downto 0); -- insert_out100s in vend_unit
		 finished	: OUT STD_LOGIC);
END VMC_FSM;

ARCHITECTURE Behaviour of VMC_FSM IS
--States: idle, hardReset, program, display, vend, free
TYPE State IS (idle, hardReset, program, display, vend, free);
	SIGNAL next_State, present_state : State;
	SIGNAL addr_outsig : UNSIGNED(1 DOWNTO 0);
	SIGNAL data_memsig : UNSIGNED(7 DOWNTO 0);
	SIGNAL donesig 	 : STD_LOGIC;
	SIGNAL wensig 		 : STD_LOGIC;
	SIGNAL enablesig_pro : STD_LOGIC;
	SIGNAL enablesig_vend : STD_LOGIC;
	SIGNAL binarysig	 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL resetsig    : STD_LOGIC;
	signal accum_outsignal : STD_LOGIC_VECTOR(7 DOWNTO 0) :="00000000";

--Components: sram, program_unit, vend_unit, convert2bcd
COMPONENT program_unit IS
PORT( clk 			: IN STD_LOGIC;
		rst 			: IN STD_LOGIC; -- return to idle state (connect to accumulator)
	   hard_reset  : IN STD_LOGIC; -- all the memories wiped
		set 			: IN STD_LOGIC; -- accumulated ammount goes to data_men and wen is enabled. 
		enable 		: IN STD_LOGIC;
		product 		: IN UNSIGNED(1 DOWNTO 0); -- specified number will represent the memory address for which the product's price will be stored
		N 				: IN unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
		D				: IN unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
		Q 				: IN unsigned(7 downto 0);
		data_mem 	: OUT unsigned(7 downto 0); -- outputs the amount of money that has been accumulating as someone enters a coin
		addr_out 	: OUT UNSIGNED(1 DOWNTO 0); -- memory address that represents the location of a food product the person wants to buy
		done 			: OUT STD_LOGIC; -- once the product has correct price, outputs done and goes to idle 
		wen 			: OUT STD_LOGIC); -- enable that we will use later to write to memory
END COMPONENT;

COMPONENT vend_unit IS
PORT( clk 		: IN STD_LOGIC;
		reset 	: IN STD_LOGIC;
		enable 	: IN STD_LOGIC;
		price_in : IN unsigned(7 downto 0);
		N 			: IN unsigned(7 downto 0); -- quantity of nickels, not price, also need to add an extra bit for signed operation
		D			: IN unsigned(7 downto 0); -- represents COUNT of coins, not cumulated PRICE!
		Q 			: IN unsigned(7 downto 0);
		change_1s, change_10s, change_100s 				: OUT STD_LOGIC_VECTOR (3 downto 0);
		insert_out1s, insert_out10s, insert_out100s  : OUT STD_LOGIC_VECTOR (3 downto 0);
		done 		: OUT STD_LOGIC);
END COMPONENT;

COMPONENT convert2bcd IS
	PORT(binary : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  bcd : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
END COMPONENT;

COMPONENT SRAM IS
PORT( address	: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END COMPONENT;

BEGIN

prog : program_unit
	port map (clk => clock, rst => reset, hard_reset => hard_reset, set => set, enable => enablesig_pro, product => prod, N => N, D => D, Q => Q, data_mem => data_memsig, addr_out => addr_outsig, done => donesig, wen => wensig);
		
ven : vend_unit
	port map (clk => clock, reset => reset, enable => enablesig_vend, price_in => data_memsig, N => N, D => D, Q => Q, change_1s => change0, change_10s => change1, change_100s => change2, insert_out1s => runTotal0, insert_out10s => runTotal1, insert_out100s => runTotal2, done => finished);
	
ram : SRAM
	port map (address => std_logic_vector(addr_outsig), clock => clock, data => std_logic_vector(data_memsig), rden => donesig, wren => wensig, q => binarysig);

totbcd : convert2bcd
	port map (binary => accum_outsignal, bcd(11 downto 8) => total0, bcd(7 downto 4) => total1, bcd(3 downto 0) => total2 );
	
PROCESS(funct, reset, start, set, data_memsig) 
BEGIN


accum_outsignal <= std_logic_vector(to_unsigned(((5*(to_integer(N))) + (10*(to_integer(D))) + (25*(to_integer(Q)))), 8));

CASE present_State IS
-- states: idle, hardReset, program, display, vend, free

	WHEN hardReset =>
		--wensig <= '1';
			data_memsig <= (others => '0'); -- makes all 0
			present_state <= idle;
			accum_outsignal <= "00000000";
			data_memsig <= "00000000";

	WHEN idle =>
		resetsig <= '0';
		
		-- 00: program, 01: display, 10: vend, 11: free
		IF (start = '1' AND funct = "00") THEN
			present_state <= program;
			
		ELSIF (start = '1' AND funct = "01") THEN
			present_state <= display;
			
		ELSIF (start = '1' AND funct = "10") THEN
			present_state <= vend;
			
		ELSIF (start = '1' AND funct = "11") THEN
			present_state <= free;
		
		ELSE
			present_state <= idle;
			
		END IF;
		

	WHEN program =>
		IF (resetsig = '1') THEN
			present_state <= idle;
			accum_outsignal <= "00000000";
			
		ELSE
			enablesig_pro <= '1';
			present_state <= program;
			
				IF (set = '1') THEN
					data_memsig <= UNSIGNED(accum_outsignal);

				END IF;
					
		END IF;
	
	WHEN display =>
		--wensig <= '1';
		data_memsig <= "ZZZZZZZZ";
			IF (resetsig = '1') THEN
				present_state <= idle;
				accum_outsignal <= "00000000";
				
			ELSIF (set = '1') THEN
				present_state <= display;
				
			ELSE
				present_state <= display;
				
			END IF;

	WHEN vend =>
		IF (resetsig = '1') THEN
			present_state <= idle;
			accum_outsignal <= "00000000";
			
		ELSE
			present_state <= vend;
			enablesig_vend <= '1';
			
		END IF;
	
	WHEN free =>
		--wensig <= '1';
		data_memsig <= "ZZZZZZZZ";

		IF (resetsig = '1') THEN
			present_state <= idle;
			accum_outsignal <= "00000000";
		
		ELSIF (prod = "00") THEN
			present_state <= free;
		
		ELSIF (prod = "01") THEN
			present_state <= free;			
			
		ELSIF (prod = "10") THEN
			present_state <= free;
			
		ELSIF (prod = "11") THEN
			present_state <= free;

		END IF;

END CASE;
END PROCESS;
END Behaviour;