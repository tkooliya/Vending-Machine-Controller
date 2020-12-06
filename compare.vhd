LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE Ieee.numeric_std.all;



ENTITY compare IS

PORT( price_in : IN unsigned(7 downto 0);
		accum_out : IN unsigned(7 downto 0); -- essentially insert_out, they are the same thing
		change : OUT unsigned(7 downto 0);
		done : OUT STD_LOGIC);


END compare;

ARCHITECTURE Behaviour of compare is

	begin

	process(price_in, accum_out)
	
	begin
	
		if (accum_out >= price_in) then  -- if you input enough, inset done signal
		
		
			done <= '1';
		
			change <= (accum_out - price_in);
		
			
		else
		
			done <= '0'; -- if price is not fulfilled, done signal is not asserted
			change <= "00000000"; -- no money is returned because payment isn't satisfied unless soft resetted
	
		end if;
	
	end process;
	
end Behaviour;
		
			
				
			
	

	

