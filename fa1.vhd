-- Full Adder for two std_logic bits 
-- Computes result of addition of bits and outputs carry out and result 

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fa1 IS
	PORT
	(
		in1		: IN STD_LOGIC;
		in2		: IN STD_LOGIC;
		cin		: IN STD_LOGIC;
		cout		: OUT STD_LOGIC;
		result	: OUT STD_LOGIC
	);
END fa1;

architecture behaviour of fa1 is 
signal s1,s2,s3: STD_LOGIC; 

begin 
		-- Uses simplified logical expressions for full adder 
		s1 <= (in1 XOR in2); 
		s2 <= (cin AND s1); 
		s3 <= (in1 AND in2); 
		result <= (s1 XOR cin); 
		cout <= (s2 OR s3); 
end architecture;  	
				


