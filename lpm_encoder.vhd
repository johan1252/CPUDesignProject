--Logic of a 32 to 5 encoder

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

ENTITY lpm_encoder IS
	--create all necessary signals
	PORT
	(
		data	: OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
		eq0		: IN STD_LOGIC ;
		eq1		: IN STD_LOGIC ;
		eq2		: IN STD_LOGIC ;
		eq3		: IN STD_LOGIC ;
		eq4		: IN STD_LOGIC ;
		eq5		: IN STD_LOGIC ;
		eq6		: IN STD_LOGIC ;
		eq7		: IN STD_LOGIC ;
		eq8		: IN STD_LOGIC ;
		eq9		: IN STD_LOGIC ;
		eq10	: IN STD_LOGIC ;
		eq11	: IN STD_LOGIC ;
		eq12	: IN STD_LOGIC ;
		eq13	: IN STD_LOGIC ;
		eq14	: IN STD_LOGIC ;
		eq15	: IN STD_LOGIC ;
		eq16	: IN STD_LOGIC ;
		eq17	: IN STD_LOGIC ;
		eq18	: IN STD_LOGIC ;
		eq19	: IN STD_LOGIC ;
		eq20	: IN STD_LOGIC ;
		eq21	: IN STD_LOGIC ;
		eq22	: IN STD_LOGIC ;
		eq23	: IN STD_LOGIC ;
		eq24	: IN STD_LOGIC ;
		eq25	: IN STD_LOGIC ;
		eq26	: IN STD_LOGIC ;
		eq27	: IN STD_LOGIC ;
		eq28	: IN STD_LOGIC ;
		eq29	: IN STD_LOGIC ;
		eq30	: IN STD_LOGIC ;
		eq31	: IN STD_LOGIC 
	);
END lpm_encoder;

architecture behaviour of lpm_encoder is
begin
	--initializes all possible values for input encoding
	data <= 	"00000" when eq0 =  '1' else
				"00001" when eq1 =  '1' else
				"00010" when eq2 =  '1' else
				"00011" when eq3 =  '1' else
				"00100" when eq4 =  '1' else
				"00101" when eq5 =  '1' else
				"00110" when eq6 =  '1' else
				"00111" when eq7 =  '1' else
				"01000" when eq8 =  '1' else
				"01001" when eq9 =  '1' else
				"01010" when eq10 = '1' else
				"01011" when eq11 = '1' else
				"01100" when eq12 = '1' else
				"01101" when eq13 = '1' else
				"01110" when eq14 = '1' else
				"01111" when eq15 = '1' else
				"10000" when eq16 = '1' else
				"10001" when eq17 = '1' else
				"10010" when eq18 = '1' else
				"10011" when eq19 = '1' else
				"10100" when eq20 = '1' else
				"10101" when eq21 = '1' else
				"10110" when eq22 = '1' else
				"10111" when eq23 = '1' else
				"11000" when eq24 = '1' else
				"11001" when eq25 = '1' else
				"11010" when eq26 = '1' else
				"11011" when eq27 = '1' else
				"11100" when eq28 = '1' else
				"11101" when eq29 = '1' else
				"11110" when eq30 = '1' else
				"11111"; --when eq31
end architecture;

