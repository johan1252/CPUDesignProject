Library IEEE;
use IEEE.std_logic_1164.all;

entity multi_bit_ALU is
generic(gate_delay:time:= 1ns; width:natural:=32);
port(	in1: in std_logic_vector(width-1 downto 0);
		in2: in std_logic_vector(width-1 downto 0);
		result : out std_logic_vector(width-1 downto 0);
		opcode: in std_logic_vector(4 downto 0);
		cin : in std_logic;
		cout: out std_logic
		);
end entity multi_bit_ALU;

architecture behavioural of multi_bit_ALU is	

component one_bit_ALU is 
generic (gate_delay:time);
port(	in1, in2, cin: in std_logic;
		result, cout : out std_logic;
		opcode: in std_logic_vector(4 downto 0));
end component one_bit_ALU;

signal carry_vector: std_logic_vector(width-2 downto 0);

begin

a0: one_bit_ALU generic map (gate_delay)
port map(in1=>in1(0),
			in2=>in2(0), 
			result=>result(0), 
			cin=>cin, 
			opcode=>opcode, 
			cout=>carry_vector(0));
	
a2to62: for i in 1 to width-2 generate 
a1: one_bit_ALU generic map(gate_delay)
port map(in1=>in1(i),
			in2=>in2(i),
			cin=>carry_vector(i-1),
			result=>result(i), 
			cout=>carry_vector(i),
			opcode=>opcode);
end generate;

a63: one_bit_ALU generic map(gate_delay)
port map( in1=>in1(width-1), 
			 in2=>in2(width-1), 
			 result=>result(width-1),
			 cin=>carry_vector(width-2), 
			 opcode=>opcode, 
			 cout=>cout);
end architecture behavioural;