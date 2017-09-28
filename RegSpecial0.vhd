--Logic for a 32 bit register that that responds to a rising clock edge
library ieee; 
use ieee.std_logic_1164.all; 

entity RegSpecial0 is 
	port( D_IN: in std_logic_vector(31 downto 0); 
			BAout : in std_logic;
			D_OUT: out std_logic_vector(31 downto 0):= x"00000000"; 
			ENABLE,CLK,RESET: in std_logic
	);
end entity;
 
architecture behaviour of RegSpecial0 is 
	signal dValue : std_logic_vector(31 downto 0) := X"00000000";
begin
	process(CLK,RESET, BAout)
		begin 
		if RESET = '0' then 
			D_OUT <= (others => '0');
		elsif(BAout = '1') then
					D_out <= (others => '0');	
		elsif CLK'event and CLK = '1' then 			
			if(ENABLE = '1') then
					D_out <= D_IN;
					DValue <= D_IN;
			else
					d_OUT <= DvALUE;
			end if;
		end if; 
	end process; 
end architecture; 