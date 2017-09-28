Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity workingBoothTB is
end workingBoothTB;

architecture behaviour of workingBoothTB is

component workingBooth
	PORT(
		m, q : in std_logic_vector(31 downto 0);
		--qTempOut : out std_logic_vector(31 downto 0);
		--codetest, i_value: out std_logic_vector(2 downto 0);
		clk, start, reset: in std_logic; 
		result2 : out std_logic_vector(63 downto 0)
		--test, finalROut: out std_logic_VECTOR (63 downto 0)
	);
end component;	
		
	
	signal in1 : std_LOGIC_VECTOR(31 downto 0);
	signal in2 : std_LOGIC_VECTOR(31 downto 0);
	signal clk, reset, start : std_logic; 
	--signal qTempOut : std_LOGIC_VECTOR(31 downto 0);
	--signal codet, ival : std_lOGIC_VECTOR(2 downto 0);
	signal result : std_logic_vector(63 downto 0);
	--signal test, finalROut: std_logic_VECTOR (63 downto 0);
	
	begin
	--unit under test (UUT)
	UUT : workingBooth PORT MAP(
		m => in1,
		q => in2,
		--codetest => codet,
		result2 => result,
		clk => clk,
		reset=> reset,
		start => start
		--i_value => ival,
		--qTempOut => qTempOut,
		--finalROut => finalROut,
		--test => test
	);
	
	--stimulus process
	clk_process :process
	begin 
			clk <= '0';
			wait for 0.5 ns;  --for 0.5 ns signal is '0'.
			clk <= '1';
			wait for 0.5 ns;  --for next 0.5 ns signal is '1'.
   end process;
	
	stimulate_proc : process
	begin
		in1 <= "11111111111111111111111111111111"; --9 dec
		in2 <= "01111111111111111111111111111111"; --move right 3
		reset <= '1';
		wait for  ns;
		reset <= '0';
		wait for 35 ns; 
		
--		in1 <= "0000000000000000000000000000100100000000000000000000000000001001"; --9 dec
--		in2 <= "0000000000000000010001111010110100000000000000000100011110101101"; --move right 3
--		wait for 5ns;
		
		
	end process;
end architecture;	