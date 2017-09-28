LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
USE work.common.all;

-- entity declaration only; no definition here
ENTITY phase3_tb IS
	END;

	-- Architecture of the testbench with the signal names
ARCHITECTURE behaviour OF phase3_tb IS 

signal reset : std_LOGIC;
signal BusMuxOut : std_LOGIC_VECTOR(31 downto 0); --these signals are all test signals
signal MDRValue : std_LOGIC_VECTOR(31 downto 0);
signal MARValue : std_LOGIC_VECTOR(8 downto 0);
signal R0Value : std_LOGIC_VECTOR(31 downto 0);
signal R1Value : std_LOGIC_VECTOR(31 downto 0);
signal R2Value : std_LOGIC_VECTOR(31 downto 0); 
signal R3Value : std_LOGIC_VECTOR(31 downto 0);
signal R4Value : std_LOGIC_VECTOR(31 downto 0);
signal R5Value : std_LOGIC_VECTOR(31 downto 0);
signal R6Value : std_LOGIC_VECTOR(31 downto 0);
signal R7Value : std_LOGIC_VECTOR(31 downto 0);
signal R8Value : std_LOGIC_VECTOR(31 downto 0);
signal R9Value : std_LOGIC_VECTOR(31 downto 0);
signal R10Value : std_LOGIC_VECTOR(31 downto 0); 
signal R11Value : std_LOGIC_VECTOR(31 downto 0);
signal R12Value : std_LOGIC_VECTOR(31 downto 0);
signal R13Value : std_LOGIC_VECTOR(31 downto 0);
signal R14Value : std_LOGIC_VECTOR(31 downto 0);
signal R15Value : std_LOGIC_VECTOR(31 downto 0);
signal ZLoValue : std_LOGIC_VECTOR(31 downto 0);
signal YValue : std_LOGIC_VECTOR(31 downto 0);
signal PCValue : std_LOGIC_VECTOR(31 downto 0);
signal IRValue : std_LOGIC_VECTOR(31 downto 0);
signal HIValue : std_LOGIC_VECTOR(31 downto 0);
signal LOValue : std_LOGIC_VECTOR(31 downto 0);
signal runOut : std_LOGIC;
signal ZHiValue,OutportValue : std_LOGIC_VECTOR(31 downto 0);
signal In_port_data_tb: std_LOGIC_VECTOR(31 downto 0); 
SIGNAL Clock_tb, stop : Std_logic;
signal currentState : State;

-- component instantiation of the datapath
COMPONENT datapath
PORT (
	clk : in std_LOGIC;	
	reset, stop : in std_LOGIC;
	In_port_data : in std_LOGIC_VECTOR(31 downto 0);
	tempBusOut : out std_LOGIC_VECTOR(31 downto 0);
	MDRValue : out std_LOGIC_VECTOR(31 downto 0);
	MARValue : out std_LOGIC_VECTOR(8 downto 0);
	R0Value : out std_LOGIC_VECTOR(31 downto 0);
	R1Value : out std_LOGIC_VECTOR(31 downto 0);
	R2Value : out std_LOGIC_VECTOR(31 downto 0); 
	R3Value : out std_LOGIC_VECTOR(31 downto 0);
	R4Value : out std_LOGIC_VECTOR(31 downto 0);
	R5Value : out std_LOGIC_VECTOR(31 downto 0);
	R6Value : out std_LOGIC_VECTOR(31 downto 0);
	R7Value : out std_LOGIC_VECTOR(31 downto 0);
	R8Value : out std_LOGIC_VECTOR(31 downto 0);
	R9Value : out std_LOGIC_VECTOR(31 downto 0);
	R10Value : out std_LOGIC_VECTOR(31 downto 0); 
	R11Value : out std_LOGIC_VECTOR(31 downto 0);
	R12Value : out std_LOGIC_VECTOR(31 downto 0);
	R13Value : out std_LOGIC_VECTOR(31 downto 0);
	R14Value : out std_LOGIC_VECTOR(31 downto 0);
	R15Value : out std_LOGIC_VECTOR(31 downto 0);
	ZLoValue : out std_LOGIC_VECTOR(31 downto 0);
	YValue :  out std_LOGIC_VECTOR(31 downto 0);
	PCValue :  out std_LOGIC_VECTOR(31 downto 0);
	IRValue :  out std_LOGIC_VECTOR(31 downto 0);
	HIValue :  out std_LOGIC_VECTOR(31 downto 0);
	LOValue :  out std_LOGIC_VECTOR(31 downto 0);
	runOut : out std_LOGIC;
	ZHiValue, OutportValue : out std_LOGIC_VECTOR(31 downto 0);
	currentState : out State
	);
END COMPONENT datapath;

BEGIN

DUT : datapath
--port mapping: between the dut and the testbench signals
PORT MAP (
reset => reset, 
Clk => Clock_tb,
tempBusOut => BusMuxOut,
MDRValue => MDRValue,
R0Value => R0Value,
R1Value => R1Value,
R2Value => R2Value,
R3Value => R3Value,
R4Value => R4Value,
R5Value => R5Value,
R6Value => R6Value,
R7Value => R7Value,
R8Value => R8Value,
R9Value => R9Value,
R10Value => R10Value,
R11Value => R11Value,
R12Value => R12Value,
R13Value => R13Value,
R14Value => R14Value,
R15Value => R15Value,
ZLoValue => ZLoValue,
YValue => YValue,
PCValue => PCValue,
IRValue => IRValue,
HIValue => HIValue,
LOValue => LOValue,
ZHiValue => ZHiValue,
OutportValue => OutportValue,
In_port_data => In_port_data_tb,
MARValue => MARValue,
stop => stop,
runOut => runOut,
currentState => currentState
);

clk_process :process
begin 
		clock_tb <= '0';
		wait for 20ns;  --for 0.5 ns signal is '0'.
		clock_tb <= '1';
		wait for 10ns;  --for next 0.5 ns signal is '1'.
end process;

reset <= '1';
stop <= '0';
In_port_data_tb <= x"00000080";
			
END ARCHITECTURE;