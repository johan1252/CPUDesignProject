--Logic for a 32 bit register that that responds to a rising clock edge

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;

entity marReg is 
	port( D_IN: in std_logic_vector(31 downto 0); 
			D_OUT: out unsigned(8 downto 0) := "000000000"; 
			ENABLE,CLK,RESET: in std_logic
	);
end entity;
 
architecture behaviour of marReg is 

begin
	process(CLK,RESET)
		begin 
		if RESET = '0' then 
			D_OUT <= (others => '0');
		elsif CLK'event and CLK = '1' then 
			if ENABLE = '1' then 
				D_OUT <= unsigned(D_IN(8 downto 0)); 
			end if; 
		end if; 
	end process; 
end architecture; 