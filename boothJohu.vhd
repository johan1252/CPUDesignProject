library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity boothJohu is
port(
	clk : in std_logic;
	inA : in std_logic_vector(31 downto 0);
	inB : in std_logic_vector(31 downto 0);
	result : out std_logic_vector(31 downto 0);
	codes : out std_LOGIC_VECTOR (2 downto 0)
);
end entity;

architecture behaviour of boothJohu is

--component add is
--port(
--		dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
--		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
--		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
--	);
--end component add;

component shift_left IS
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component shift_left;

signal add_result : std_LOGIC_VECTOR(31 downto 0);
signal input : std_LOGIC_VECTOR(31 downto 0);
signal add1shift : std_LOGIC_VECTOR(31 downto 0);
signal intermediate_result : std_LOGIC_VECTOR(31 downto 0);

begin

--booth_add : add
--port map(
--		dataa	=> add1,	
--		datab	=> add2,	
--		result => add_result		
--	);

booth_shift : shift_left
port map(
		data => input,
		distance	=> "00001",
		result => add1shift
	);

procure : process(clk) is
	variable phase1 : std_logic;
	variable phase2 : std_logic;
	variable phase3 : std_logic;
	variable firstTime : std_logic;
	variable sum : std_LOGIC_VECTOR(31 downto 0);
	variable add1 : std_LOGIC_VECTOR(31 downto 0);
	variable tempProd : std_LOGIC_VECTOR(31 downto 0);
	variable add2 : std_LOGIC_VECTOR(31 downto 0);
	variable allcodes : std_LOGIC_VECTOR(31 downto 0);
	variable code : std_LOGIC_VECTOR(2 downto 0);
	variable i : integer := 0; 
begin 
	add1 := "00000000000000000000000000000000";
	sum := "00000000000000000000000000000000";
	input <= inA;
	add2 := inB;
	
phase1 := '1';
firstTime := '1';
for j in 0 to 1 loop
		if(phase1 = '1') then
			if (firstTime = '1') then
					if(add2(i)= add2(i+1)) then
						code := "000";
					elsif(add2(i)='1' and add2(i+1)='0') then
						code := "001";
					elsif(add2(i)='0' and add2(i+1)='1') then
						code := "110";
					end if;
				firstTime := '0';	
			else 
					i := 2;
					if(add2(i)='0' and add2(i+1)='0' and add2(i-1)='0') then
						code := "000";
					elsif(add2(i)='0' and add2(i+1)='0' and add2(i-1)='1') then
						code := "001";
					elsif(add2(i)='1' and add2(i+1)='0' and add2(i-1)='0') then
						code := "001";
					elsif(add2(i)='1' and add2(i+1)='0' and add2(i-1)='1') then
						code := "010";
					elsif(add2(i)='0' and add2(i+1)='1' and add2(i-1)='0') then
						code := "110";
					elsif(add2(i)='0' and add2(i+1)='1' and add2(i-1)='1') then
						code := "111";
					elsif(add2(i)='1' and add2(i+1)='1' and add2(i-1)='0') then
						code := "111";
					elsif(add2(i)='1' and add2(i+1)='1' and add2(i-1)='1') then
						code := "000";
					end if;
			end if;	
			phase1 := '0';
			phase2 := '1';	
		end if;
		
		if(phase2 = '1') then
				if(code = "000") then
					tempProd := (others=>'0');
				elsif(code="001") then
					tempProd := input;
				elsif(code="010") then
					tempProd := add1shift;
				elsif(code="110") then -- -2 0000000000000000000000000000000000000000000000000000000000000001
					tempProd := ((not add1shift) + 1 );
				elsif(code="111") then 
					tempProd := (not(input)+1); 
				end if;
		sum := (sum +tempProd);		
		phase1 := '1';
		phase2 := '0';
		phase3 := '0';
		end if;
	
--		if(phase3 = '1')then
--		sum := (sum + tempProd);
--		phase2 := '0';
--		phase3 := '0';
--		phase1 := '1';
--		end if;
		
end loop;		
codes <= code;
result <= sum;

end process;
end architecture;
