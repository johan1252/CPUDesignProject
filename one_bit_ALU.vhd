Library IEEE;
use IEEE.std_logic_1164.all;

entity one_bit_ALU is
port(	in1, in2, cin: in std_logic;
		result, cout : out std_logic;
		opcode: in std_logic_vector(4 downto 0)
		);
end entity one_bit_ALU;

architecture behaviour of one_bit_ALU is
signal in2Com : std_logic;

begin
	andOperation : process(in1,in2,cin,opcode) is
	begin 
		case opcode is
			when "00111" => 
				result <= (in1 and in2);
				cout <= cin;
			when "01000" =>
				result <= (in1 or in2);
			when "10011" => 
				result <= (not in1);
			when "00101" => 
				if ((in1 = '0') and (in2 = '0') and (cin = '0')) then
					result <= '0'; 
					cout <= '0';
				elsif ((in1 = '0') and (in2 = '0') and (cin = '1')) then
					result <= '1'; 
					cout <= '0';	
				elsif ((in1 = '0') and (in2 = '1') and (cin = '0')) then
					result <= '1';
					cout <= '0';		
				elsif ((in1 = '0') and (in2 = '1') and (cin = '1')) then
					result <= '0'; 
					cout <= '1';
				elsif ((in1 = '1') and (in2 = '0') and (cin = '0')) then
					result <= '1'; 
					cout <= '0';
				elsif ((in1 = '1') and (in2 = '0') and (cin = '1')) then
					result <= '0'; 
					cout <= '1';	
				elsif ((in1 = '1') and (in2 = '1') and (cin = '0')) then
					result <= '0';
					cout <= '1';		
				elsif ((in1 = '1') and (in2 = '1') and (cin = '1')) then
					result <= '1'; 
					cout <= '1';
				end if;	
			when "00110" =>
				in2Com <= not in2;
				if ((in1 = '0') and (in2Com = '0') and (cin = '0')) then
					result <= '0'; 
					cout <= '0';
				elsif ((in1 = '0') and (in2Com = '0') and (cin = '1')) then
					result <= '1'; 
					cout <= '0';	
				elsif ((in1 = '0') and (in2Com = '1') and (cin = '0')) then
					result <= '1';
					cout <= '0';		
				elsif ((in1 = '0') and (in2Com = '1') and (cin = '1')) then
					result <= '0'; 
					cout <= '1';
				elsif ((in1 = '1') and (in2Com = '0') and (cin = '0')) then
					result <= '1'; 
					cout <= '0';
				elsif ((in1 = '1') and (in2Com = '0') and (cin = '1')) then
					result <= '0'; 
					cout <= '1';	
				elsif ((in1 = '1') and (in2Com = '1') and (cin = '0')) then
					result <= '0';
					cout <= '1';		
				elsif ((in1 = '1') and (in2Com = '1') and (cin = '1')) then
					result <= '1'; 
					cout <= '1';
				end if;
--				if ((in1 = '0') and (in2 = '0')) then
--					result <= '0'; 
--				elsif ((in1 = '0') and (in2 = '1')) then
--					result <= '1';
--				elsif ((in1 = '1') and (in2 = '0')) then
--					result <= '1';  
--				elsif ((in1 = '1') and (in2 = '1')) then
--					result <= '0'; 
--				end if;			
				--cout <= '0';
			when others => 
				result <= '1';
			end case;
		
	end process; 
end architecture; 
