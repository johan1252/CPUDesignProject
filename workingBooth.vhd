-- Booth multiplier algorithm for two signed 32-bit numbers

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity workingBooth is
port(
	m, q: in std_logic_vector(31 downto 0);
	result2 : out std_logic_vector(63 downto 0)
);
end entity;

architecture behaviour of workingBooth is

-- Left shifter megafunction instantiation
component shiftL64 IS
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (63 DOWNTO 0);
		distance		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
	);
END component;								

signal ms: std_logic_vector(63 downto 0);	--shifted version of M
signal qrs, mex, shiftRegister: std_logic_vector(63 downto 0);
signal shift_value: std_LOGIC_VECTOR(5 downto 0); -- Shift value for 64 bit register

-- Function that returns 64 bit unshifted register based on inputed 3 bit code 
function qRecode (input: std_logic_vector(2 downto 0); mIn: std_logic_vector(63 downto 0); msIn: std_logic_vector(63 downto 0))
	return  std_logic_vector is 
	
	--declarations local to function
	variable code : std_logic_vector(2 downto 0);
	variable qr : std_logic_vector(63 downto 0);
	variable qrx: std_logic_vector(63 downto 0);
		
	begin
		-- Decide code based on input bits (uses truth table values)
		if(input = "000") then
			code := "000";
		elsif(input = "001") then
			code := "001";
		elsif(input = "010") then
			code := "001";
		elsif(input = "011") then	
			code := "010";
		elsif(input = "100") then	
			code := "110";
		elsif(input = "101") then
			code := "111";
		elsif(input = "110") then
			code := "111";
		elsif(input = "111") then
			code := "000";
		end if;

		-- Compute multiplication of M and value based on code (-2xM, -1xM, 0xM, 1xM, 2xM)
		if(code="000") then
			qr :=(others=>'0');
		elsif(code="001") then
			qr := mIn;
		elsif(code="010") then
			qr := msIn;
		elsif(code="110") then
			qr := (unsigned(not msIn) + 1 );
		elsif(code="111") then 
			qr := (unsigned(not mIn) + 1); 
		end if; 
		
		-- Sign extend q recoded
		if(code = "010" or code = "110")	then --if shifted
			if(qr(32) = '0') then 
				qrx := (others => '0'); 
				qrx(32 downto 0) := qr(32 downto 0); 
			elsif(qr(32) = '1') then 
			qrx := (others => '1'); 
			qrx(32 downto 0) := qr(32 downto 0);
			end if;
		else
			if(qr(31) = '0') then 
				qrx := (others => '0'); 
				qrx(31 downto 0) := qr(31 downto 0); 
			elsif(qr(31) = '1') then 
			qrx := (others => '1'); 
			qrx(31 downto 0) := qr(31 downto 0);
			end if;
		end if;
		
		return qrx;
	end qRecode;
	
begin 

qrx_shift_L : shiftL64
port map (
	data => mex, -- sign extended multiplier
	distance => "000001",
	result => ms
);

the_fsm: process (m,q,ms, mex)
--
variable tempResult, tempResultQ,tempResult0, shift : std_logic_vector(63 downto 0); 
variable code0 : std_logic_vector(2 downto 0);
variable qr0 : std_logic_vector(63 downto 0);
variable qrx0: std_logic_vector(63 downto 0);

begin
	tempResult0 := (others => '0'); 
	result2 <= (others => '0');
	mex <= (Others => '0');
	mex(31 downto 0) <= m;
				
			-- Determine recoding code based ONLY on first two bits due to implicit 0 on right 
			if(q(1 downto 0) = "00") then
					code0 := "000";
			elsif(q(1 downto 0) = "11") then
					code0 := "111";
			elsif(q(1 downto 0) = "01") then
					code0 := "001";
			elsif(q(1 downto 0)= "10") then
					code0 := "110";
			end if;
			
			-- Compute multiplication of multiplicand based on code 
			if(code0="000") then
				qr0 :=(others=>'0');
			elsif(code0="001") then
				qr0 := mex;
			elsif(code0="110") then -- -2 
				qr0 := (unsigned(not ms) + 1 );
			elsif(code0="111") then
				qr0 := (unsigned(not mex) + 1 );
			end if; 
		
			-- Sign extend multiplication
			if(code0 = "010" or code0 = "110")	then --if shifted
				if(qr0(32) = '0') then 
					qrx0 := (others => '0'); 
					qrx0(32 downto 0) := qr0(32 downto 0); 
				elsif(qr0(32) = '1') then 
				qrx0 := (others => '1'); 
				qrx0(32 downto 0) := qr0(32 downto 0);
				else
				qrx0 := (others => '0'); 
				end if;
			else
				if(qr0(31) = '0') then 
					qrx0 := (others => '0'); 
					qrx0(31 downto 0) := qr0(31 downto 0); 
				elsif(qr0(31) = '1') then 
				qrx0 := (others => '1'); 
				qrx0(31 downto 0) := qr0(31 downto 0);
				else
				qrx0 := (others => '0'); 
				end if;
			end if;
			
			-- Assign temporary result to first multiplication based on first two bits 
			tempResult0 := qrx0; 
		
				tempResultQ := qrecode(q(3 downto 1), mex, ms);	-- Returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 2) := tempResultQ(61 downto 0); -- Shift by two each time for summation of bits 
				tempResult := shift + tempResult0; -- Add shifted result to tempResult

				tempResultQ := qrecode(q(5 downto 3), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 4) := tempResultQ(59 downto 0);
				tempResult := shift + tempResult; 

				tempResultQ := qrecode(q(7 downto 5), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 6) := tempResultQ(57 downto 0);
				tempResult := shift + tempResult; 

				tempResultQ := qrecode(q(9 downto 7), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 8) := tempResultQ(55 downto 0);
				tempResult := shift + tempResult;  

				tempResultQ := qrecode(q(11 downto 9), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 10) := tempResultQ(53 downto 0);
				tempResult := shift + tempResult;  

				tempResultQ := qrecode(q(13 downto 11), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 12) := tempResultQ(51 downto 0);
				tempResult := shift + tempResult; 

				tempResultQ := qrecode(q(15 downto 13), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 14) := tempResultQ(49 downto 0);
				tempResult := shift + tempResult; 

				tempResultQ := qrecode(q(17 downto 15), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 16) := tempResultQ(47 downto 0);
				tempResult := shift + tempResult;  

				tempResultQ := qrecode(q(19 downto 17), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 18) := tempResultQ(45 downto 0);
				tempResult := shift + tempResult; 

				tempResultQ := qrecode(q(21 downto 19), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 20) := tempResultQ(43 downto 0);
				tempResult := shift + tempResult; 

				tempResultQ := qrecode(q(23 downto 21), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 22) := tempResultQ(41 downto 0);
				tempResult := shift + tempResult; 

				tempResultQ := qrecode(q(25 downto 23), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 24) := tempResultQ(39 downto 0);
				tempResult := shift + tempResult; 

				tempResultQ := qrecode(q(27 downto 25), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 26) := tempResultQ(37 downto 0);
				tempResult := shift + tempResult; 
				
				tempResultQ := qrecode(q(29 downto 27), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 28) := tempResultQ(35 downto 0);
				tempResult := shift + tempResult;  

				tempResultQ := qrecode(q(31 downto 29), mex, ms);	--returns 64 bit unshifted vector 
				shift := (others => '0');
				shift(63 downto 30) := tempResultQ(33 downto 0);
				tempResult := shift + tempResult; 
			
				result2 <= tempResult;
				
	end process; 
end architecture; 			
			