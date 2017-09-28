Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity shift_tb is
end shift_tb;

architecture behaviour of shift_tb is

component boothJohu
port(
	clk : in std_logic;
	inA : in std_logic_vector(31 downto 0);
	inB : in std_logic_vector(31 downto 0);
	result : out std_logic_vector(31 downto 0);

	codes : out std_logic_vector(2 downto 0)
);
end component;	
	signal clk : std_LOGIC;
	signal in1 : std_LOGIC_VECTOR(31 downto 0);
	signal in2 : std_LOGIC_VECTOR(31 downto 0);
	signal result : std_logic_vector(31 downto 0);

	signal codes : std_logic_vector(2 downto 0);
	
	begin
	--unit under test (UUT)
	UUT : boothJohu PORT MAP(
		inA => in1,
		inB => in2,
		result => result,
		codes => codes,
		clk => clk
	);
	
		clk_process :process
	begin 
			clk <= '0';
			wait for 0.5ns;  --for 0.5 ns signal is '0'.
			clk <= '1';
			wait for 0.5ns;  --for next 0.5 ns signal is '1'.
   end process;
	
	--stimulus process
	stimulate_proc : process
	begin
		in1 <= "00000000000000000000000000000010";
		in2 <= "00000000000000000000000000000001";
		wait for 5ns;
		
	
--		in1 <= "00000000000000000000000000001001"; --9 dec
--		in2 <= "00011"; --move right 3
--		wait for 5ns;
--		
--		in1 <= "00000000000000000000000000001001"; --9 dec
--		in2 <= "00001"; --move right 3
--		wait for 5ns;
		
	end process;
end architecture;	