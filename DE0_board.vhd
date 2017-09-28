LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
USE work.common.all;

-- entity declaration only; no definition here
ENTITY DE0_board IS
port(
		clk : in std_LOGIC;	
	reset : in std_LOGIC;
	In_port_data : in std_LOGIC_VECTOR(31 downto 0);
	seg_output1,seg_output2,seg_output3,seg_output4 : out std_LOGIC_VECTOR(7 downto 0));
	END ENTiTY;

	-- Architecture of the testbench with the signal names
ARCHITECTURE behaviour OF DE0_board IS 


-- component instantiation of the datapath
COMPONENT datapath
PORT (
	clk : in std_LOGIC;	
	reset : in std_LOGIC;
	In_port_data : in std_LOGIC_VECTOR(31 downto 0);
	seg_output1,seg_output2,seg_output3,seg_output4 : out std_LOGIC_VECTOR(7 downto 0)
	);
END COMPONENT datapath;

BEGIN

DUT : datapath
--port mapping: between the dut and the testbench signals
PORT MAP (
reset => reset, 
Clk => Clk,
In_port_data => In_port_data,
seg_output1 => seg_output1,
seg_output2 => seg_output2,
seg_output3 => seg_output3,
seg_output4 => seg_output4
);



			
END ARCHITECTURE;