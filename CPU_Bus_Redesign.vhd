--VHDL file used to represent the bus. It uses a multiplexer with an encoder for the select signal.
--This file is used by the datapath to implement the single bus line.

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY CPU_Bus_Redesign IS 
	PORT
	(
		CLK : in std_logic;
		reset : in std_logic;
		BusMuxIn_Hi, BusMuxIn_MDR, BusMuxIn_In_Port, BusMuxIn_Lo, BusMuxIn_PC, BusMuxIn_R0, BusMuxIn_R1 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		BusMuxIn_R10,BusMuxIn_R11,BusMuxIn_R12,BusMuxIn_R13,BusMuxIn_R14,BusMuxIn_R15,BusMuxIn_ZHi,BusMuxIn_ZLo,BusMuxIn_Csign : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		PCout, Zlowout, MDRout, Cout, HIout, In_Portout, LOout, Zhighout : in std_logic;
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out : in std_LOGIC;
		R9out, R10out, R11out, R12out, R13out, R14out, R15out  : in std_LOGIC;		
		BusMuxOut : out std_LOGIC_VECTOR(31 downto 0)
	);
END entity;

ARCHITECTURE behaviour OF CPU_Bus_Redesign is

--Encoder used to set the select signal for the bus (one hot encoding)
COMPONENT lpm_encoder
	PORT(eq0 : IN STD_LOGIC;
		 eq1 : IN STD_LOGIC;
		 eq2 : IN STD_LOGIC;
		 eq3 : IN STD_LOGIC;
		 eq4 : IN STD_LOGIC;
		 eq5 : IN STD_LOGIC;
		 eq6 : IN STD_LOGIC;
		 eq7 : IN STD_LOGIC;
		 eq8 : IN STD_LOGIC;
		 eq9 : IN STD_LOGIC;
		 eq10 : IN STD_LOGIC;
		 eq11 : IN STD_LOGIC;
		 eq12 : IN STD_LOGIC;
		 eq13 : IN STD_LOGIC;
		 eq14 : IN STD_LOGIC;
		 eq15 : IN STD_LOGIC;
		 eq16 : IN STD_LOGIC;
		 eq17 : IN STD_LOGIC;
		 eq18 : IN STD_LOGIC;
		 eq19 : IN STD_LOGIC;
		 eq20 : IN STD_LOGIC;
		 eq21 : IN STD_LOGIC;
		 eq22 : IN STD_LOGIC;
		 eq23 : IN STD_LOGIC;
		 eq24 : IN STD_LOGIC;
		 eq25 : IN STD_LOGIC;
		 eq26 : IN STD_LOGIC;
		 eq27 : IN STD_LOGIC;
		 eq28 : IN STD_LOGIC;
		 eq29 : IN STD_LOGIC;
		 eq30 : IN STD_LOGIC;
		 eq31 : IN STD_LOGIC;
		 data : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

--Mux that selects all the data signals and chooses which one will be outputted by the bus.
COMPONENT lpm_mux0
	PORT(data0x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data1x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data2x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data4x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data5x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data6x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data7x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data8x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data9x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data10x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data11x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data12x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data13x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data14x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data15x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data16x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data17x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data18x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data19x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data20x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data21x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data22x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data23x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data24x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data25x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data26x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data27x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data28x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data29x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data30x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data31x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	muxSelect :  STD_LOGIC_VECTOR(4 DOWNTO 0);

begin 

--port mapping used for the multiplexer select signals
b2v_inst : lpm_encoder
PORT MAP(eq0 => R0out,
		 eq1 => R1out,
		 eq2 => R2out,
		 eq3 => R3out,
		 eq4 => R4out,
		 eq5 => R5out,
		 eq6 => R6out,
		 eq7 => R7out,
		 eq8 => R8out,
		 eq9 => R9out,
		 eq10 => R10out,
		 eq11 => R11out,
		 eq12 => R12out,
		 eq13 => R13out,
		 eq14 => R14out,
		 eq15 => R15out,
		 eq16 => HIout,
		 eq17 => LOout,
		 eq18 => Zhighout,
		 eq19 => Zlowout,
		 eq20 => PCout,
		 eq21 => MDRout,
		 eq22 => In_Portout,
		 eq23 => Cout,
		 eq24 => '0',
		 eq25 => '0',
		 eq26 => '0',
		 eq27 => '0',
		 eq28 => '0',
		 eq29 => '0',
		 eq30 => '0',
		 eq31 => '0',
		 data => muxSelect);


b2v_inst2 : lpm_mux0
PORT MAP(data0x => BusMuxIn_R0, --there is a bus input signal for each register used 
			data1x => BusMuxIn_R1, --each signal is selected using the muxselect given by the encoder
			data2x => BusMuxIn_R2,
			data3x => BusMuxIn_R3,
			data4x => BusMuxIn_R4,
			data5x => BusMuxIn_R5,
			data6x => BusMuxIn_R6,
			data7x => BusMuxIn_R7,
			data8x => BusMuxIn_R8,
			data9x => BusMuxIn_R9,
			data10x => BusMuxIn_R10,
			data11x => BusMuxIn_R11,
			data12x => BusMuxIn_R12,
			data13x => BusMuxIn_R13,
			data14x => BusMuxIn_R14,
			data15x => BusMuxIn_R15,
			data16x => BusMuxIn_Hi,
			data17x => BusMuxIn_Lo,
			data18x => BusMuxIn_ZHi,
			data19x => BusMuxIn_ZLo, 
			data20x => BusMuxIn_PC,
			data21x => BusMuxIn_MDR,
			data22x => BusMuxIn_In_Port,
			data23x => BusMuxIn_Csign,
			data24x => (others => '0'),
		   data25x => (others => '0'),
			data26x => (others => '0'),
			data27x => (others => '0'),
			data28x => (others => '0'),
			data29x => (others => '0'),
			data30x => (others => '0'),
			data31x => (others => '0'),
			sel => muxSelect,
			result => BusMuxOut);
		 
end architecture;  