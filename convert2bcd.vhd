LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;


ENTITY convert2bcd IS
	
	PORT(binary : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			  bcd : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));

END convert2bcd;



architecture behaviour of convert2bcd is

	begin 	
		process(binary)
		variable n : STD_LOGIC_VECTOR(19 DOWNTO 0); -- need 17 down to 0 to shift binary values to represent ones, tens, and hundreds
		
		begin
			
			for i in 0 to 19 loop
					
					n(i) := '0'; 
					
			end loop;
			
			n(10 downto 3) := binary; -- binary would be 0000 0000 0nnn nnnn n000
			
			
			for i in 0 to 4 loop
				
				if n(11 downto 8) >= 5 then -- ones placement, if greater than 5, shift left by 3
						
						n(11 downto 8) := n(11 downto 8) + 3;
						
				end if;
				
				if n(15 downto 12) >= 5 then -- tens placement, if greater than 5, shift left by 3
						
						n(15 downto 12) := n(15 downto 12) + 3;
						
						
				end if; -- dont need a case for hundreds placement.
				
				n(19 downto 1) := n(18 downto 0);
			
			end loop;
			
			bcd <= n(19 downto 8); -- need 12 bits of shifted binary value
		
	 end process;
	
end behaviour;
		
