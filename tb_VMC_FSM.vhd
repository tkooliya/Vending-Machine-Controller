LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;

ENTITY tb_VMC_FSM IS
END tb_VMC_FSM;


ARCHITECTURE test of tb_VMC_FSM IS

COMPONENT VMC_FSM IS

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
		 runTotal0	: OUT STD_LOGIC_VECTOR (3 downto 0);
		 runTotal1	: OUT STD_LOGIC_VECTOR (3 downto 0);
		 runTotal2	: OUT STD_LOGIC_VECTOR (3 downto 0);
		 total0		: OUT STD_LOGIC_VECTOR (3 downto 0);
		 total1		: OUT STD_LOGIC_VECTOR (3 downto 0);
		 total2		: OUT STD_LOGIC_VECTOR (3 downto 0);
		 finished	: OUT STD_LOGIC);
END COMPONENT;

SIGNAL clocksigVMC 		: STD_LOGIC;
SIGNAL resetsigVMC 		: STD_LOGIC;
SIGNAL hard_resetsigVMC : STD_LOGIC;
SIGNAL startsigVMC		: STD_LOGIC; 
SIGNAL setsigVMC			: STD_LOGIC;
SIGNAL NsigVMC				: UNSIGNED(7 DOWNTO 0); -- nickel
SIGNAL DsigVMC				: UNSIGNED(7 DOWNTO 0); -- dime
SIGNAL QsigVMC				: UNSIGNED(7 DOWNTO 0); -- quarter
SIGNAL functsigVMC		: UNSIGNED(1 DOWNTO 0); -- 00: program, 01: display, 10: vend, 11: free
SIGNAL prodsigVMC			: UNSIGNED(1 DOWNTO 0); 
SIGNAL change0sigVMC		: STD_LOGIC_VECTOR (3 downto 0); 
SIGNAL change1sigVMC		: STD_LOGIC_VECTOR (3 downto 0); 
SIGNAL change2sigVMC		: STD_LOGIC_VECTOR (3 downto 0);
SIGNAL runTotal0sigVMC	: STD_LOGIC_VECTOR (3 downto 0);
SIGNAL runTotal1sigVMC	: STD_LOGIC_VECTOR (3 downto 0);
SIGNAL runTotal2sigVMC	: STD_LOGIC_VECTOR (3 downto 0);
SIGNAL total0sigVMC		: STD_LOGIC_VECTOR (3 downto 0);
SIGNAL total1sigVMC		: STD_LOGIC_VECTOR (3 downto 0);
SIGNAL total2sigVMC		: STD_LOGIC_VECTOR (3 downto 0);
SIGNAL finishedsigVMC	: STD_LOGIC;


BEGIN

		DUT : VMC_FSM
		port map(clock => clocksigVMC, reset => resetsigVMC, hard_reset => hard_resetsigVMC, start => startsigVMC, set => setsigVMC, N => NsigVMC, D => DsigVMC, Q => QsigVMC, funct => functsigVMC, prod => prodsigVMC, change0 => change0sigVMC, change1 => change1sigVMC, change2 => change2sigVMC, runTotal0 => runTotal0sigVMC, runTotal1 => runTOtal1sigVMC, runTotal2 => runTotal2sigVMC, total0 => total0sigVMC, total1 => total1sigVMC, total2 => total2sigVMC, finished => finishedsigVMC);
		
PROCESS IS

BEGIN
-- save me =>	 . . .	- - -	  . . .

	clocksigVMC <= '0';
	resetsigVMC <= '0';
	hard_resetsigVMC <= '0';
	startsigVMC <= '0';
	setsigVMC <= '0';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; -- mode
	prodsigVMC <= "01";
	wait for 50 ns;	
	
	clocksigVMC <= '1';
	startsigVMC <= '1';
	setsigVMC <= '0';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; --  mode
	prodsigVMC <= "01";
	wait for 50 ns;	
	
	clocksigVMC <= '0';
	startsigVMC <= '1';
	setsigVMC <= '0';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; -- mode
	prodsigVMC <= "01";
	wait for 50 ns;	
	
	clocksigVMC <= '1';
	startsigVMC <= '1';
	setsigVMC <= '1';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; -- mode
	prodsigVMC <= "01";
	wait for 50 ns;	
	
	clocksigVMC <= '0';
	startsigVMC <= '1';
	setsigVMC <= '1';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; -- mode
	prodsigVMC <= "01";
	wait for 50 ns;
	
	clocksigVMC <= '1';
	startsigVMC <= '1';
	setsigVMC <= '1';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; -- mode
	prodsigVMC <= "01";
	wait for 50 ns;	
	
	clocksigVMC <= '0';
	startsigVMC <= '0';
	setsigVMC <= '1';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; -- mode
	prodsigVMC <= "01";
	wait for 50 ns;	
	
	clocksigVMC <= '1';
	startsigVMC <= '1';
	setsigVMC <= '1';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; -- mode
	prodsigVMC <= "01";
	wait for 50 ns;	
	
	clocksigVMC <= '0';
	startsigVMC <= '1';
	setsigVMC <= '1';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; -- mode
	prodsigVMC <= "01";
	wait for 50 ns;
	
	clocksigVMC <= '1';
	startsigVMC <= '1';
	setsigVMC <= '1';
	NsigVMC <= "00000001";
	DsigVMC <= "00000001";
	QsigVMC <= "00000001";
	functsigVMC <= "00"; -- mode
	prodsigVMC <= "01";
	wait for 50 ns;


END PROCESS;
END test;


