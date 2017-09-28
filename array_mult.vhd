-- 8 x 8 bit array multiplier, computing a 16 bit signed-result 

Library IEEE;
use IEEE.std_logic_1164.all;

entity array_mult is
port(
		mIn, qIn : in std_logic_vector(7 downto 0);
		pout : out std_logic_vector(15 downto 0)
);
end entity;

architecture behaviour of array_mult is

signal mqIn0, mqIn1, mqIn2, mqIn3, mqIn4, mqIn5, mqIn6, mqIn7: std_logic_vector(7 downto 0);
signal c0, c1, c2, c3, c4, c5, c6, c7: std_logic_vector(7 downto 0); -- carry out signals of each row of multiplier
signal s0, s1, s2, s3, s4, s5, s6, s7: std_logic_vector(7 downto 0); -- sum vectors for each row of multiplier

component fa1
	port(
		in1	: IN STD_LOGIC;
		in2		: IN STD_LOGIC;
		cin		: IN STD_LOGIC;
		cout		: OUT STD_LOGIC;
		result		: OUT STD_LOGIC
	);
end component;
begin
	-- Computes and of individual bits of multiplicand and multiplier
	mqIn0(0) <= mIN(0) and qIN(0);
	mqIn0(1) <= mIN(1) and qIN(0);
	mqIn0(2) <= mIN(2) and qIN(0);
	mqIn0(3) <= mIN(3) and qIN(0);
	mqIn0(4) <= mIN(4) and qIN(0);
	mqIn0(5) <= mIN(5) and qIN(0);
	mqIn0(6) <= mIN(6) and qIN(0);
	mqIn0(7) <= mIN(7) and qIN(0);
	
	mqIn1(0) <= mIN(0) and qIN(1);
	mqIn1(1) <= mIN(1) and qIN(1);
	mqIn1(2) <= mIN(2) and qIN(1);
	mqIn1(3) <= mIN(3) and qIN(1);
	mqIn1(4) <= mIN(4) and qIN(1);
	mqIn1(5) <= mIN(5) and qIN(1);
	mqIn1(6) <= mIN(6) and qIN(1);
	mqIn1(7) <= mIN(7) and qIN(1);
	
	mqIn2(0) <= mIN(0) and qIN(2);
	mqIn2(1) <= mIN(1) and qIN(2);
	mqIn2(2) <= mIN(2) and qIN(2);
	mqIn2(3) <= mIN(3) and qIN(2);
	mqIn2(4) <= mIN(4) and qIN(2);
	mqIn2(5) <= mIN(5) and qIN(2);
	mqIn2(6) <= mIN(6) and qIN(2);
	mqIn2(7) <= mIN(7) and qIN(2);
	
	mqIn3(0) <= mIN(0) and qIN(3);
	mqIn3(1) <= mIN(1) and qIN(3);
	mqIn3(2) <= mIN(2) and qIN(3);
	mqIn3(3) <= mIN(3) and qIN(3);
	mqIn3(4) <= mIN(4) and qIN(3);
	mqIn3(5) <= mIN(5) and qIN(3);
	mqIn3(6) <= mIN(6) and qIN(3);
	mqIn3(7) <= mIN(7) and qIN(3);
	
	mqIn4(0) <= mIN(0) and qIN(4);
	mqIn4(1) <= mIN(1) and qIN(4);
	mqIn4(2) <= mIN(2) and qIN(4);
	mqIn4(3) <= mIN(3) and qIN(4);
	mqIn4(4) <= mIN(4) and qIN(4);
	mqIn4(5) <= mIN(5) and qIN(4);
	mqIn4(6) <= mIN(6) and qIN(4);
	mqIn4(7) <= mIN(7) and qIN(4);
	
	mqIn5(0) <= mIN(0) and qIN(5);
	mqIn5(1) <= mIN(1) and qIN(5);
	mqIn5(2) <= mIN(2) and qIN(5);
	mqIn5(3) <= mIN(3) and qIN(5);
	mqIn5(4) <= mIN(4) and qIN(5);
	mqIn5(5) <= mIN(5) and qIN(5);
	mqIn5(6) <= mIN(6) and qIN(5);
	mqIn5(7) <= mIN(7) and qIN(5);
	
	mqIn6(0) <= mIN(0) and qIN(6);
	mqIn6(1) <= mIN(1) and qIN(6);
	mqIn6(2) <= mIN(2) and qIN(6);
	mqIn6(3) <= mIN(3) and qIN(6);
	mqIn6(4) <= mIN(4) and qIN(6);
	mqIn6(5) <= mIN(5) and qIN(6);
	mqIn6(6) <= mIN(6) and qIN(6);
	mqIn6(7) <= mIN(7) and qIN(6);
	
	mqIn7(0) <= mIN(0) and qIN(7);
	mqIn7(1) <= mIN(1) and qIN(7);
	mqIn7(2) <= mIN(2) and qIN(7);
	mqIn7(3) <= mIN(3) and qIN(7);
	mqIn7(4) <= mIN(4) and qIN(7);
	mqIn7(5) <= mIN(5) and qIN(7);
	mqIn7(6) <= mIN(6) and qIN(7);
	mqIn7(7) <= mIN(7) and qIN(7);
	
	-- Sets up port map for individual 64 full adders of array multiplier
	-- Format is as follows port map(input1, input2,carry_in,carry_out,result)
	FA01: fa1	port map (mqIn0(0), '0',   '0', c0(0), s0(0));
	FA02: fa1	port map (mqIn0(1), '0', c0(0), c0(1), s0(1));
	FA03: fa1	port map (mqIn0(2), '0', c0(1), c0(2), s0(2));
	FA04: fa1	port map (mqIn0(3), '0', c0(2), c0(3), s0(3));
	FA05: fa1	port map (mqIn0(4), '0', c0(3), c0(4), s0(4));
	FA06: fa1	port map (mqIn0(5), '0', c0(4), c0(5), s0(5));
	FA07: fa1	port map (mqIn0(6), '0', c0(5), c0(6), s0(6));
	FA08: fa1	port map (mqIn0(7), '0', c0(6), c0(7), s0(7));
	
	FA09: fa1	port map (mqIn1(0), s0(1),   '0', c1(0), s1(0));
	FA10: fa1	port map (mqIn1(1), s0(2), c1(0), c1(1), s1(1));
	FA11: fa1	port map (mqIn1(2), s0(3), c1(1), c1(2), s1(2));
	FA12: fa1	port map (mqIn1(3), s0(4), c1(2), c1(3), s1(3));
	FA13: fa1	port map (mqIn1(4), s0(5), c1(3), c1(4), s1(4));
	FA14: fa1	port map (mqIn1(5), s0(6), c1(4), c1(5), s1(5));
	FA15: fa1	port map (mqIn1(6), s0(7), c1(5), c1(6), s1(6));
	FA16: fa1	port map (mqIn1(7), c0(7), c1(6), c1(7), s1(7));
	
	FA17: fa1	port map (mqIn2(0), s1(1),   '0', c2(0), s2(0));
	FA18: fa1	port map (mqIn2(1), s1(2), c2(0), c2(1), s2(1));
	FA19: fa1	port map (mqIn2(2), s1(3), c2(1), c2(2), s2(2));
	FA20: fa1	port map (mqIn2(3), s1(4), c2(2), c2(3), s2(3));
	FA21: fa1	port map (mqIn2(4), s1(5), c2(3), c2(4), s2(4));
	FA22: fa1	port map (mqIn2(5), s1(6), c2(4), c2(5), s2(5));
	FA23: fa1	port map (mqIn2(6), s1(7), c2(5), c2(6), s2(6));
	FA24: fa1	port map (mqIn2(7), c1(7), c2(6), c2(7), s2(7));

	FA25: fa1	port map (mqIn3(0), s2(1),   '0', c3(0), s3(0));
	FA26: fa1	port map (mqIn3(1), s2(2), c3(0), c3(1), s3(1));
	FA27: fa1	port map (mqIn3(2), s2(3), c3(1), c3(2), s3(2));
	FA28: fa1	port map (mqIn3(3), s2(4), c3(2), c3(3), s3(3));
	FA29: fa1	port map (mqIn3(4), s2(5), c3(3), c3(4), s3(4));
	FA30: fa1	port map (mqIn3(5), s2(6), c3(4), c3(5), s3(5));
	FA31: fa1	port map (mqIn3(6), s2(7), c3(5), c3(6), s3(6));
	FA32: fa1	port map (mqIn3(7), c2(7), c3(6), c3(7), s3(7));

	FA33: fa1	port map (mqIn4(0), s3(1),   '0', c4(0), s4(0));
	FA34: fa1	port map (mqIn4(1), s3(2), c4(0), c4(1), s4(1));
	FA35: fa1	port map (mqIn4(2), s3(3), c4(1), c4(2), s4(2));
	FA36: fa1	port map (mqIn4(3), s3(4), c4(2), c4(3), s4(3));
	FA37: fa1	port map (mqIn4(4), s3(5), c4(3), c4(4), s4(4));
	FA38: fa1	port map (mqIn4(5), s3(6), c4(4), c4(5), s4(5));
	FA39: fa1	port map (mqIn4(6), s3(7), c4(5), c4(6), s4(6));
	FA40: fa1	port map (mqIn4(7), c3(7), c4(6), c4(7), s4(7));

	FA41: fa1	port map (mqIn5(0), s4(1),   '0', c5(0), s5(0));
	FA42: fa1	port map (mqIn5(1), s4(2), c5(0), c5(1), s5(1));
	FA43: fa1	port map (mqIn5(2), s4(3), c5(1), c5(2), s5(2));
	FA44: fa1	port map (mqIn5(3), s4(4), c5(2), c5(3), s5(3));
	FA45: fa1	port map (mqIn5(4), s4(5), c5(3), c5(4), s5(4));
	FA46: fa1	port map (mqIn5(5), s4(6), c5(4), c5(5), s5(5));
	FA47: fa1	port map (mqIn5(6), s4(7), c5(5), c5(6), s5(6));
	FA48: fa1	port map (mqIn5(7), c4(7), c5(6), c5(7), s5(7));

	FA49: fa1	port map (mqIn6(0), s5(1),   '0', c6(0), s6(0));
	FA50: fa1	port map (mqIn6(1), s5(2), c6(0), c6(1), s6(1));
	FA51: fa1	port map (mqIn6(2), s5(3), c6(1), c6(2), s6(2));
	FA52: fa1	port map (mqIn6(3), s5(4), c6(2), c6(3), s6(3));
	FA53: fa1	port map (mqIn6(4), s5(5), c6(3), c6(4), s6(4));
	FA54: fa1	port map (mqIn6(5), s5(6), c6(4), c6(5), s6(5));
	FA55: fa1	port map (mqIn6(6), s5(7), c6(5), c6(6), s6(6));
	FA56: fa1	port map (mqIn6(7), c5(7), c6(6), c6(7), s6(7));

	FA57: fa1	port map (mqIn7(0), s6(1),   '0', c7(0), s7(0));
	FA58: fa1	port map (mqIn7(1), s6(2), c7(0), c7(1), s7(1));
	FA59: fa1	port map (mqIn7(2), s6(3), c7(1), c7(2), s7(2));
	FA60: fa1	port map (mqIn7(3), s6(4), c7(2), c7(3), s7(3));
	FA61: fa1	port map (mqIn7(4), s6(5), c7(3), c7(4), s7(4));
	FA62: fa1	port map (mqIn7(5), s6(6), c7(4), c7(5), s7(5));
	FA63: fa1	port map (mqIn7(6), s6(7), c7(5), c7(6), s7(6));
	FA64: fa1	port map (mqIn7(7), c6(7), c7(6), c7(7), s7(7));	
	
	-- Individual bits of output product assigned to output sums of full adders 
	pout(0) <= mqIn0(0);
	pout(1) <= s1(0); 
	pout(2) <= s2(0);
	pout(3) <= s3(0);
	pout(4) <= s4(0);
	pout(5) <= s5(0);
	pout(6) <= s6(0);
	pout(7) <= s7(0);
	pout(8) <= s7(1);
	pout(9) <= s7(2);
	pout(10) <= s7(3);
	pout(11) <= s7(4);
	pout(12) <= s7(5);
	pout(13) <= s7(6);
	pout(14) <= s7(7);
	pout(15) <= c7(7);

end architecture; 