--Connects all components of the data path

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
USE work.common.all;

entity datapath is
port(
	clk : in std_LOGIC;	
	reset,stop : in std_LOGIC;
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
	ZHiValue,OutportValue : out std_LOGIC_VECTOR(31 downto 0);
	seg_output1,seg_output2,seg_output3,seg_output4 : out std_LOGIC_VECTOR(7 downto 0);
	currentState : out State
	);
end entity datapath;

architecture behavioural of datapath is

--Declaration of all components
component control_unit is
	port(
		Clock, Reset, CON_FF, stop : in std_logic;
		IR		: in std_logic_vector(31 downto 0);
		IncPC, Gra, Grb, Grc, Rin, Rout, LOout, HIout, Zlowout, Zhighout, MDRout, PCout : out std_logic;
		ANDd, ORr, NOTt, NEG, SHR, SHL, RORr, ROLl, MUL, SUB, ADD, DIV : out std_logic;
		HIin, LOin, CONin, PCin, IRin, Yin, Zin, MARin, MDRin, Out_Portin, Cout, BAout : out std_logic;
		In_Portout, In_port_strobe, Readd, Writee : out std_logic;
		runOut : out std_LOGIC;
		currentState : out State
	);
end component control_unit;

component Seven_Segment IS
PORT	(	clk: IN STD_LOGIC;
			data: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END component Seven_Segment;

component ConFF is 
	port( BusMuxOut : in std_logic_vector(31 downto 0);
			IRout : in std_logic_vector(31 downto 0);
			CONin : in std_LOGIC;
			Control : out std_logic
	);
end component ConFF;

component selAndEncode is 
	port( 
		Gra, Grb, Grc, Rin, Rout, BAout : in std_logic;
		IRout : in std_logic_vector(31 downto 0); 
		R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in : out std_LOGIC;
		R9in, R10in, R11in, R12in, R13in, R14in, R15in : out std_LOGIC;
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out : out std_LOGIC;
		R9out, R10out, R11out, R12out, R13out, R14out, R15out  : out std_LOGIC;
		CSignExtend : out std_logic_vector(31 downto 0)
	);
end component selAndEncode;

component ALU_Toplevel is
port(
		inA : in std_logic_vector(31 downto 0);
		inB : in std_logic_vector(31 downto 0);
		clk : in std_LOGIC;
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
		DIVsel : in std_logic;
		IncPC  : in std_logic;
		BoothMULsel : in std_LOGIC;
		result : out std_logic_vector(63 downto 0)
);
end component ALU_Toplevel;

component CPU_Bus_Redesign IS 
port(
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
end component CPU_Bus_Redesign;

component marReg is 
port( D_IN: in std_logic_vector(31 downto 0); 
			D_OUT: out unsigned(8 downto 0); 
			ENABLE,CLK,RESET: in std_logic
	);
end component marReg;

COMPONENT mdr_unit
	PORT(ENABLE : IN STD_LOGIC;
		 CLK : IN STD_LOGIC;
		 RESET : IN STD_LOGIC;
		 READ_MUX : IN STD_LOGIC;
		 MDR_IN_0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 MDR_IN_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 MDR_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

component REG64 is 
	port( D_IN: in std_logic_vector(63 downto 0); 
			D_OUTHi: out std_logic_vector(63 downto 32); 
			D_OUTLo: out std_logic_vector(31 downto 0); 
			ENABLE,CLK,RESET: in std_logic
	);
end component;

component reg32
port(ENABLE : IN STD_LOGIC;
		 CLK : IN STD_LOGIC;
		 RESET : IN STD_LOGIC;
		 D_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 D_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component RegSpecial0
	port( D_IN: in std_logic_vector(31 downto 0); 
			BAout : in std_logic;
			D_OUT: out std_logic_vector(31 downto 0); 
			ENABLE,CLK,RESET: in std_logic
	);
end component;

component memory
port(
		address: in unsigned(8 downto 0);
		write_data: in std_logic_vector(31 downto 0);
		MemWrite, MemRead: in std_logic; 
		read_data: out std_logic_vector(31 downto 0)
);
end component memory;

component IRreg is 
	port( D_IN: in std_logic_vector(31 downto 0); 
			D_OUT: out std_logic_vector(31 downto 0) := x"00000000"; 
			ENABLE,RESET : in std_logic
	);
end component IRreg;

--Declaration of required signals

signal YdataOut : std_LOGIC_VECTOR(31 downto 0);
signal ZdataIn : std_LOGIC_VECTOR(63 downto 0);
signal BusMuxIn_Hi, BusMuxIn_MDR, BusMuxIn_In_Port, BusMuxIn_Lo, BusMuxIn_PC, BusMuxIn_R0, BusMuxIn_R1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
signal BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9 : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal BusMuxIn_R10,BusMuxIn_R11,BusMuxIn_R12,BusMuxIn_R13,BusMuxIn_R14,BusMuxIn_R15,BusMuxIn_ZHi,BusMuxIn_ZLo,BusMuxIn_Csign : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal BusMuxOut : std_LOGIC_VECTOR(31 downto 0);
signal IRcontrol : std_LOGIC_VECTOR(31 downto 0);
signal Mdatain : std_LOGIC_VECTOR(31 downto 0);
signal marDataOut : unsigned(8 downto 0);
signal R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out : std_LOGIC;
signal R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in : std_LOGIC;
signal CON, Out_port_In, IN_port_strobe : std_LOGIC;
signal IGra, Gra, Grb, Grc, Rin, Rout, LOout, HIout, Zlowout, Zhighout, MDRout, PCout : std_logic;
signal BoothMULsel, ANDsel, ORsel, NOTsel, NEGsel, SHRsel, SHLsel, RORsel, ROLsel, SUBsel, ADDsel, DIVsel : std_logic;
signal HIin, LOin, CONin, PCin, IRin, Yin, Zin, MARin, MDRin, Out_Portin, Cout, BAout : std_logic;
signal In_Portout, read_sel, MemWrite, incPC : std_logic;
signal out_port_data : std_LOGIC_VECTOR(31 downto 0);

begin	--architecture

--signal assignments
tempBusOut <= BusMuxOut;
MDRValue <= BusMuxIn_MDR;
R0Value <= BusMuxIn_R0;
R1Value <= BusMuxIn_R1;
R2Value <= BusMuxIn_R2;
R3Value <= BusMuxIn_R3;
R4Value <= BusMuxIn_R4;
R5Value <= BusMuxIn_R5;
R6Value <= BusMuxIn_R6;
R7Value <= BusMuxIn_R7;
R8Value <= BusMuxIn_R8;
R9Value <= BusMuxIn_R9;
R10Value <= BusMuxIn_R10;
R11Value <= BusMuxIn_R11;
R12Value <= BusMuxIn_R12;
R13Value <= BusMuxIn_R13;
R14Value <= BusMuxIn_R14;
R15Value <= BusMuxIn_R15;
ZLoValue <= BusMuxIn_ZLo;
YValue <= YdataOut;
PCValue <= BusMuxIn_PC;
IRValue <= IRcontrol;
HIValue <= BusMuxIn_Hi;
LOValue <= BusMuxIn_Lo;
ZHiValue <= BusMuxIn_ZHi;
OutportValue <= Out_port_data;
MARValue <= std_LOGIC_VECTOR(MarDataOut);
 
--map all components
controlMap : control_unit
port map(
	Clock => clk, 
	Reset => reset, 
	CON_FF => CON,
	IR => IRcontrol,
	Gra => Gra, 
	Grb => Grb, 
	Grc => Grc, 
	Rin => Rin, 
	Rout => Rout, 
	LOout => LOout, 
	HIout => HIout, 
	Zlowout => Zlowout, 
	Zhighout => Zhighout, 
	MDRout => MDRout, 
	PCout => PCout,
	ANDd => ANDsel, 
	ORr => ORsel, 
	NOTt => NOTsel, 
	NEG => NEGsel, 
	SHR => SHRsel, 
	SHL => SHLsel, 
	RORr => RORsel, 
	ROLl => ROLsel, 
	MUL => BoothMULsel, 
	SUB => SUBsel, 
	ADD => ADDsel, 
	DIV => DIVsel,
	HIin => HIin, 
	LOin => LOin, 
	CONin => CONin, 
	PCin => PCin, 
	IRin => IRin, 
	Yin => Yin, 
	Zin => Zin, 
	MARin => MARin, 
	MDRin => MDRin, 
	Out_Portin => Out_port_In, 
	Cout => Cout, 
	BAout => BAout,
	In_Portout => In_Portout, 
	In_port_strobe => In_port_strobe,
	Readd => read_sel, 
	Writee => memWrite,
	IncPC => incPC,
	runOut => runOut,
	stop => stop,
	currentState => currentState
);

BUSmap : CPU_Bus_Redesign 
port map(
		CLK => clk,
		reset => '1',
		PCout => PCout,
		Zlowout => Zlowout,
		MDRout => MDRout,
		Cout => Cout,
		HIout => HIout,
		In_Portout => In_Portout,
		LOout => LOout,
		Zhighout => Zhighout,
		R0out => R0out,
		R1out => R1out,
		R2out => R2out,
		R3out => R3out,
		R4out => R4out,
		R5out => R5out,
		R6out => R6out,
		R7out => R7out,
		R8out => R8out,
		R9out => R9out,
		R10out => R10out,
		R11out => R11out,
		R12out => R12out,
		R13out => R13out,
		R14out => R14out,
		R15out => R15out,
		BusMuxOut => BusMuxOut,
		BusMuxIn_Hi => BUSMuxIn_Hi, 
		BusMuxIn_MDR => BusMuxIn_MDR, 
		BusMuxIn_In_Port => BusMuxIn_In_Port, 
		BusMuxIn_Lo => BusMuxIn_Lo, 
		BusMuxIn_PC => BusMuxIn_PC, 
		BusMuxIn_R0 => BusMuxIn_R0, 
		BusMuxIn_R1 => BusMuxIn_R1, 
		BusMuxIn_R2 => BusMuxIn_R2, 
		BusMuxIn_R3 => BusMuxIn_R3, 
		BusMuxIn_R4 => BusMuxIn_R4, 
		BusMuxIn_R5 => BusMuxIn_R5, 
		BusMuxIn_R6 => BusMuxIn_R6, 
		BusMuxIn_R7 => BusMuxIn_R7, 
		BusMuxIn_R8 => BusMuxIn_R8, 
		BusMuxIn_R9 => BusMuxIn_R9,
		BusMuxIn_R10 => BusMuxIn_R10,
		BusMuxIn_R11 => BusMuxIn_R11,
		BusMuxIn_R12 => BusMuxIn_R12,
		BusMuxIn_R13 => BusMuxIn_R13,
		BusMuxIn_R14 => BusMuxIn_R14,
		BusMuxIn_R15 => BusMuxIn_R15,
		BusMuxIn_ZHi => BusmuxIn_ZHi,
		BusMuxIn_ZLo => BusmuxIn_ZLo,
		BusMuxIn_Csign => BusMuxIn_Csign
);

Select_and_Encode : selAndEncode
port map(
		Gra => Gra,
		Grb => Grb,
		Grc => Grc,
		Rin => Rin,
		Rout => Rout,
		BAout => BAout,
		IRout => IRcontrol,
		R0in => R0in,
		R1in => R1in,
		R2in => R2in,
		R3in => R3in,
		R4in => R4in,
		R5in => R5in,
		R6in => R6in,
		R7in => R7in,
		R8in => R8in,
		R9in => R9in,
		R10in => R10in,
		R11in => R11in,
		R12in => R12in,
		R13in => R13in,
		R14in => R14in,
		R15in => R15in,
		R0out => R0out,
		R1out => R1out,
		R2out => R2out,
		R3out => R3out,
		R4out => R4out,
		R5out => R5out,
		R6out => R6out,
		R7out => R7out,
		R8out => R8out,
		R9out => R9out,
		R10out => R10out,
		R11out => R11out,
		R12out => R12out,
		R13out => R13out,
		R14out => R14out,
		R15out => R15out,
		CsignExtend => BusMuxIn_Csign
);

con_logic : ConFF 
port map(
			BusMuxOut => BusMuxOut,
			IRout => IRControl,
			CONin => CONin,
			Control => CON
); 

ALU : ALU_Toplevel
port map(
		inA => YdataOut,
		inB => BusMuxOut,
		clk => clk,
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
		DIVsel => DIVsel,
		IncPC  => IncPC,
		BoothMULsel => BoothMULsel,
		result => ZdataIn
);


seg_display1 : Seven_Segment
port map(
	clk => clk,
	data => out_port_data(3 downto 0),
	output => seg_output1
);

seg_display2 : Seven_Segment
port map(
	clk => clk,
	data => out_port_data(7 downto 4),
	output => seg_output2
);

seg_display3 : Seven_Segment
port map(
	clk => clk,
	data => out_port_data(11 downto 8),
	output => seg_output3
);

seg_display4 : Seven_Segment
port map(
	clk => clk,
	data => out_port_data(15 downto 12),
	output => seg_output4
);

mem : memory
port map(
	address => marDataOut, 
	write_data => BusMuxIn_MDR,
	MemWrite => MemWrite, --
	MemRead => read_sel,
	read_data => Mdatain
);

REGZ : REG64 
port map( D_IN => ZdataIn,
			D_OUTHi => BusmuxIn_ZHi,
			D_OUTLo => BusmuxIn_ZLo,
			ENABLE => Zin,
			CLK => clk,
			RESET => reset
	);

b2v_REGY : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => YdataOut,
		 ENABLE => Yin,
		 RESET => reset, 
		 CLK => clk);
		 
b2v_MDR_Unit : mdr_unit
PORT MAP(MDR_IN_0 => BusMuxOut,
		 MDR_IN_1 => Mdatain,
		 MDR_OUT => BusMuxIn_MDR,
		 ENABLE => MDRin,
		 RESET => reset, 
		 CLK => clk, 
		 READ_MUX => read_sel);		 

b2v_REGPC : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_PC,
		ENABLE => PCin,
		 RESET => reset, 
		 CLK => clk);		 
		 
		MAR : marReg
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => marDataOut,
		 ENABLE => MARin,
		 RESET => reset, 
		 CLK => clk);		 
		 
b2v_REG0 : RegSpecial0
PORT MAP(D_IN => BusMuxOut,
			BAout => BAout,
		 D_OUT => BusMuxIn_R0,
		 ENABLE => R0in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG1 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R1,
		 ENABLE => R1in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG10 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R10,
		 ENABLE => R10in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG11 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R11,
		 ENABLE => R11in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG12 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R12,
		 ENABLE => R12in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG13 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R13,
		 ENABLE => R13in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG14 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R14,
		 ENABLE => R14in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG15 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R15,
		 ENABLE => R15in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG2 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R2,
		 ENABLE => R2in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG3 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R3,
		 ENABLE => R3in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG4 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R4,
		 ENABLE => R4in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG5 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R5,
		 ENABLE => R5in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG6 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R6,
		 ENABLE => R6in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG7 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R7,
		 ENABLE => R7in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG8 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R8,
		 ENABLE => R8in,
		 RESET => reset, 
		 CLK => clk);

b2v_REG9 : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_R9,
		 ENABLE => R9in,
		 RESET => reset, 
		 CLK => clk);

b2v_REGHi : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_Hi,
		 ENABLE => Hiin,
		 RESET => reset, 
		 CLK => clk);

b2v_REGIn_Port : reg32
PORT MAP(D_IN => In_port_data,
		 D_OUT => BusMuxIn_In_Port,
		 ENABLE => In_port_strobe, 
		 RESET => reset, 
		 CLK => clk);
		 
b2v_REGOut_Port : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => Out_port_data,
		 ENABLE => Out_port_In, 
		 RESET => reset, 
		 CLK => clk);

b2v_REGLo : reg32
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => BusMuxIn_Lo,
		 ENABLE => Loin,
		 RESET => reset, 
		 CLK => clk);

REGIR : IRreg
PORT MAP(D_IN => BusMuxOut,
		 D_OUT => IRcontrol,
		 ENABLE => IRin,
		 RESET => reset
		 );	 
		 
end architecture;



