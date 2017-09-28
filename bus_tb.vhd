Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bus_tb is
end bus_tb;

architecture behaviour of bus_tb is

component CPU_Bus_Redesign
	PORT(
		CLK : in std_logic;
		ENABLE: in std_logic;
		reset : in std_logic;
		R3In : in std_LOGIC_VECTOR(31 downto 0);
		R2RegOut : out std_LOGIC_VECTOR(31 downto 0);
		R3select : in std_LOGIC
	);
end component;	
	signal clk : std_LOGIC;
	signal reset : std_LOGIC;
	signal enable, regSelect : std_LOGIC;
	signal regIn : std_LOGIC_VECTOR(31 downto 0);
	signal regOut : std_LOGIC_VECTOR(31 downto 0);
	
	begin
	--unit under test (UUT)
	UUT : CPU_Bus_Redesign PORT MAP(
		CLK => clk,
		ENABLE => enable,
		reset => reset,
		R3In => regIn,
		R2RegOut => regOut,
		R3select => regSelect
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
		enable <= '1';
		reset <= '1';
		regSelect <= '1';
		wait for 5ns;
		regIn <= "00000000000000000000000000000101";
		wait for 10ns;
		regIn <= "00000000000000000000000000000011";
		RegSelect <= '1';
	end process;
end;	