--Computes all arithmetic operations and assigns result based on 
--select signal assertion. 

Library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_Toplevel is
port(
		inA : in std_logic_vector(31 downto 0);
		inB : in std_logic_vector(31 downto 0);
		clk : in std_logic;
		ANDsel : in std_logic;
		ORsel : in std_logic;
		NOTsel : in std_logic;
		NEGsel : in std_logic;
		SHRsel : in std_logic;
		SHLsel : in std_logic;
		RORsel : in std_logic;
		ROLsel : in std_logic;
		BoothMULsel : in std_logic;
		SUBsel : in std_logic;
		ADDsel : in std_logic;
		DIVsel : in std_logic;
		IncPC  : in std_logic;
		result : out std_LOGIC_VECTOR(63 downto 0)
);
end entity ALU_Toplevel;

architecture behavioural of ALU_Toplevel is

--initiation of all necessary components
component PCincr is
	PORT
	(
		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component PCincr;

component mult32bit is
port(
		dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
	);
end component mult32bit;

--component array_mult is
--port(
--		mIn, qIn : in std_logic_vector(7 downto 0);
--		pout : out std_logic_vector(15 downto 0)
--);
--end component array_mult;

component signed_division is
port(
		denom		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		numer		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		quotient		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		remain		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component signed_division;

component sub is
port( 
	dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
end component sub;

component add is
port( 
	dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
end component add;

component negate is
port( 
		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
end component negate;
		
component shift_right is
port(
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
end component shift_right;

component shift_left is
port(
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
end component shift_left;

component rotate_right is
port(
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component rotate_right;

component rotate_left is
port(
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component rotate_left;
		
--Definition of signals required for architecture		
signal sub_result : std_LOGIC_VECTOR(31 downto 0);
signal add_result : std_LOGIC_VECTOR(31 downto 0);
signal shift_result_right : std_LOGIC_VECTOR(31 downto 0);
signal shift_result_left : std_LOGIC_VECTOR(31 downto 0);
signal rotate_right_result : std_LOGIC_VECTOR(31 downto 0);
signal rotate_left_result : std_LOGIC_VECTOR(31 downto 0);
signal array_mult_result : std_logic_vector(15 downto 0);
signal negate_out : std_LOGIC_VECTOR(31 downto 0);
signal division_quotient : std_logic_vector(31 downto 0);
signal division_remainder : std_logic_vector(31 downto 0);
signal booth_mult_result : std_LOGIC_VECTOR(63 downto 0);
signal PCresult : std_LOGIC_VECTOR(31 downto 0);

--Start architecture
begin 
--map all components
ALU_PCincr : PCincr
port map(
		datab	=> inB,	
		result => PCresult
);

ALU_sub : sub
port map(
	dataa	=> inA,
		datab	=> inB,
		result => sub_result
		);

ALU_add : add
port map(
		dataa	=> inA,	
		datab	=> inB,	
		result => add_result		
	);

ALU_shift_logical_right : shift_right --right
port map(
		data	=> inA,		
		distance	=> inB(4 downto 0),
		result => shift_result_right		
);

ALU_shift_logical_left : shift_left --left
port map(
		data	=> inA,		
		distance	=> inB(4 downto 0),
		result => shift_result_left		
);

ALU_rotate_right : rotate_right --rotate right
port map(
		data => inA,
		distance => inB(4 downto 0),
		result => rotate_right_result
);

ALU_rotate_left : rotate_left --rotate left
port map(
		data => inA,
		distance => inB(4 downto 0),
		result => rotate_left_result
);

ALU_negate : negate
port map(
		datab => inA,
		result => negate_out
);

--ALU_multiplyArray : array_mult
--port map(
--		mIn => inA(7 downto 0),
--		qIn => inB(7 downto 0),
--		pout => array_mult_result
--);

ALU_multiply : mult32bit
port map(
		dataa => inA,
		datab => inB,
		result => booth_mult_result
);

ALU_signed_division : signed_division
port map(
		denom => inB,
		numer => inA,
		quotient => division_quotient,
		remain => division_remainder
);

--determine which signal was asserted and assign result
check: process(SUBsel, BoothMULsel, ADDsel,ANDsel,ORsel,NOTsel,SHRsel,SHLsel,RORsel,ROLsel,NEGsel,inA,inB,sub_result,add_result, IncPC, PCresult,
		array_mult_result,DIVsel,division_remainder,division_quotient,booth_mult_result, shift_result_right,shift_result_left,rotate_right_result,rotate_left_result,negate_out) is
begin
if		(SUBsel = '1') then --sub
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= sub_result;
elsif (ADDsel = '1') then --add
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= add_result;
--elsif (MULsel = '1') then --multiply
--		result(63 downto 32) <= (others =>'0');
--		result(31 downto 0)  <= (31 downto array_mult_result'length => '0') & array_mult_result;
elsif (BoothMULsel = '1') then
		result <= booth_mult_result; 	
elsif (DIVsel = '1') then --divide
		result(63 downto 32) <= division_remainder;
		result(31 downto 0) <= division_quotient;	
elsif (ANDsel = '1') then --and
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= inA and inB;	
elsif (ORsel = '1') then --or
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= inA or inB;
elsif (NOTsel = '1') then --not
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= not inA;
elsif (SHRsel = '1') then --shift right
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= shift_result_right;
elsif (SHLsel = '1') then --shift left
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= shift_result_left;	
elsif (RORsel = '1') then --rotate right
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= rotate_right_result;
elsif (ROLsel = '1') then --rotate left
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= rotate_left_result;		
elsif (NEGsel = '1') then --negate
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= negate_out;	
elsif (IncPC ='1') then   --increments pc by 1
		result(63 downto 32) <= (others =>'0');
		result(31 downto 0)  <= PCresult;		
else					  --none of the signals were asserted
		result  <= (others =>'0');	
end if;
end process;		
end architecture;	