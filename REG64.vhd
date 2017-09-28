--64 bit register that responds to rising clock edge
library ieee; 
use ieee.std_logic_1164.all; 

entity REG64 is 
	port( D_IN: in std_logic_vector(63 downto 0); 
			D_OUTHi: out std_logic_vector(63 downto 32):= x"00000000"; 
			D_OUTLo: out std_logic_vector(31 downto 0):= x"00000000";  
			ENABLE,CLK,RESET: in std_logic
	);
end entity;
 
architecture behaviour of REG64 is 

begin
	process(CLK,RESET)
		begin 
		if RESET = '0' then 
			D_OUTHi <= (others => '0');
			D_OUTLo <= (others => '0');
		elsif CLK'event and CLK = '1' then 
			if ENABLE = '1' then 
				D_OUTHi <= D_IN(63 downto 32);
				D_oUTLo <= D_IN(31 downto 0);	
			end if; 
		end if; 
	end process; 
end architecture; 

			
	