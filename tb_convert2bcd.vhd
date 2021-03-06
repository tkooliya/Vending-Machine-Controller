LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;



ENTITY tb_convert2bcd IS
END tb_convert2bcd;



ARCHITECTURE test of tb_convert2bcd IS

	component convert2bcd IS
		
		PORT(binary : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				  bcd : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
	
	END component;
	
	
	signal binarysig : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal bcdsig : STD_LOGIC_VECTOR(11 DOWNTO 0);

	
	begin

		DUT : convert2bcd
		port map(binary => binarysig, bcd => bcdsig);
		
		process is
		
			begin

			binarysig <= "10101010";
			wait for 50 ns; 
			
			
			binarysig <= "00011100";
			wait for 50 ns;
			
			
		end process;
end test;