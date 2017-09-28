Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALU_tb is
end ALU_tb;

architecture behaviour of ALU_tb is

component ALU_Toplevel
	PORT(
		inA: in std_logic_vector(31 downto 0);
		inB: in std_logic_vector(31 downto 0);
		resultHi : out std_logic_vector(31 downto 0);
		resultLo : out std_logic_vector(31 downto 0);
		ANDsel : in std_logic;
		ORsel : in std_logic;
		NOTsel : in std_logic;
		NEGsel : in std_logic;
		SHRsel : in std_logic;
		SHLsel : in std_logic;
		RORsel : in std_logic;
		ROLsel : in std_logic;
		SUBsel : in std_logic;
		ADDsel : in std_logic;
		MULsel : in std_logic;
		DIVsel : in std_logic
	);
end component;	
	
	signal in1 : std_LOGIC_VECTOR(31 downto 0);
	signal in2 : std_LOGIC_VECTOR(31 downto 0);
	signal resultHi : std_logic_vector(31 downto 0);
	signal resultLo : std_logic_vector(31 downto 0);
	signal ANDsel : std_logic;
	signal ORsel : std_logic;
	signal NOTsel : std_logic;
	signal NEGsel : std_logic;
	signal SHRsel : std_logic;
	signal SHLsel : std_logic;
	signal RORsel : std_logic;
	signal ROLsel : std_logic;
	signal SUBsel : std_logic;
	signal ADDsel : std_logic;
	signal MULsel : std_logic;
	signal DIVsel : std_logic;
	signal blahValue : boolean;
	
	begin
	--unit under test (UUT)
	UUT : ALU_Toplevel PORT MAP(
		inA => in1,
		inB => in2,
		resultHi => resultHi,
		resultLo => resultLo,
		ANDsel => ANDsel,
		ORsel => ORsel,
		NOTsel => NOTsel,
		NEGsel => NEGsel,
		SHRsel => SHRsel,
		SHLsel => SHLsel,
		RORsel => RORsel,
		ROLsel => ROLsel,
		SUBsel => SUBsel,
		ADDsel => ADDsel,
		MULsel => MULsel,
		DIVsel => DIVsel
	);	
	
	--stimulus process
	stimulate_proc : process
	begin
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		in1 <= "00000000000000000000000000001001"; --9 dec
		in2 <= "00000000000000000000000000000011"; --3 dec
		--and
		wait for 1 ns;
		ANDsel <= '1';
		wait for 5ns;
		assert(resultLo = (in1 and in2) ) report "or failed";
		
		--or
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		ORsel <= '1';
		wait for 5 ns;
		assert(resultLo = (in1 or in2) ) report "or failed";
		
		--not
		in1 <= "00000000000000000000000000001001";
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		NOTsel <= '1';
		wait for 5 ns;
		assert(resultLo = not in1) report "Not failed";
		
		--negate
		in1 <= "00000000000000000000000000001001";
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		NEGsel <= '1';
		wait for 5 ns;
		assert(resultLo = "11111111111111111111111111110111") report "Negate failed";
		
		--shift right
		in1 <= "00000000000000000000000000001001";
		in2 <= "00000000000000000000000000000001"; --shift amount
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		SHRsel <= '1';
		wait for 5 ns;
		assert(resultLo = "00000000000000000000000000000100") report "Shift right failed";
		
		--shift left
		in1 <= "00000000000000000000000000001001";
		in2 <= "00000000000000000000000000000001"; --shift amount
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		SHLsel <= '1';
		wait for 5 ns;
		assert(resultLo = "00000000000000000000000000010010") report "Shift left failed";
		
		--rotate right
		in1 <= "00000000000000000000000000001001";
		in2 <= "00000000000000000000000000000001"; --rotate amount
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		RORsel <= '1';
		wait for 5 ns;
		assert(resultLo = "10000000000000000000000000000100") report "Rotate right failed";
		
		--rotate left
		in1 <= "00000000000000000000000000001001";
		in2 <= "00000000000000000000000000000001"; --rotate amount
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		ROLsel <= '1';
		wait for 5 ns;
		assert(resultLo = "00000000000000000000000000010010") report "Rotate left failed";
	
		 --subtraction
		in1 <= "00000000000000000000000000001001"; --9 dec
		in2 <= "00000000000000000000000000000011"; --3 dec
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		SUBsel <= '1';
		wait for 5 ns;
		assert(resultLo = (in1 - in2 )) report "Subtraction failed";
		
		 --addition
		in1 <= "00000000000000000000000000001001"; --9 dec
		in2 <= "00000000000000000000000000000011"; --3 dec
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		ADDsel <= '1';
		wait for 5 ns;
		assert(resultLo = (in1 + in2)) report "Addition failed";
		
		 --multiply
		in1 <= "00000000000000000000000000001001"; --9 dec
		in2 <= "00000000000000000000000000000011"; --3 dec
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		MULsel <= '1';
		wait for 5 ns;
		assert(resultLo = 27) report "Multiplication failed";
		
		 --division (9/3)
		in1 <= "00000000000000000000000000001001"; --9 dec
		in2 <= "00000000000000000000000000000011"; --3 dec
		wait for 1 ns;
		ANDsel <= '0'; ORsel <='0'; NOTsel <='0'; NEGsel <='0'; SHRsel <='0'; SHLsel <='0'; RORsel <='0'; ROLsel <='0'; SUBsel <='0'; ADDsel <='0'; MULsel <='0'; DIVsel <='0';
		DIVsel <= '1';
		wait for 5 ns;
		assert(resultLo = 3) report "Division failed";
		
	end process;
end architecture;	