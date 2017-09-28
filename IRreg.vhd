library ieee; 
use ieee.std_logic_1164.all; 

entity IRreg is 
	port( D_IN: in std_logic_vector(31 downto 0); 
			D_OUT: out std_logic_vector(31 downto 0) := x"00000000"; 
			ENABLE,RESET: in std_logic
	);
end entity;
 
architecture behaviour of IRreg is 

begin
	process(EnaBLE, RESET, D_IN) --recently added D_IN
		begin 
		if RESET = '0' then 
			D_OUT <= (others => '0');
		elsif ENABLE = '1' then 
				D_OUT <= D_IN;   
		end if;			
	end process; 
end architecture; 