--MDR unit for the datapath
--Uses a mux to select between Mdatain and BusMuxOut
--Then a register holds the value

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
LIBRARY work;

ENTITY MDR_Unit IS 
	PORT
	(	ENABLE, CLK, RESET, READ_MUX : IN std_LOGIC;
		MDR_OUT : OUT STd_LOGIC_VECTOR(31 DOWNTO 0);
		MDR_IN_0, MDR_IN_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END MDR_Unit;

ARCHITECTURE bdf_type OF MDR_Unit IS 

--register component of the MDR unit
COMPONENT reg32
	PORT(ENABLE : IN STD_LOGIC;
		 CLK : IN STD_LOGIC;
		 RESET : IN STD_LOGIC;
		 D_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 D_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

--Mux used to select between Mdatain and BusMuxOut
COMPONENT lpm_mux1
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN 
b2v_inst : reg32
PORT MAP(D_IN => SYNTHESIZED_WIRE_0,
			ENABLE => ENABLE,
			CLK => CLK,
			RESET => RESET, 
			D_OUT => MDR_OUT
			);

b2v_inst1 : lpm_mux1
PORT MAP(	result => SYNTHESIZED_WIRE_0,
				data0x => MDR_IN_0,
				data1x => MDR_IN_1,
				sel => READ_MUX
			);

END bdf_type;