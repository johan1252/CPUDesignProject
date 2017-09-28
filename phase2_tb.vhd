LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 

-- entity declaration only; no definition here
ENTITY phase2_tb IS
	END;

	-- Architecture of the testbench with the signal names
ARCHITECTURE behaviour OF phase2_tb IS 

signal BoothMULsel_tb, ANDsel_tb, ORsel_tb, NOTsel_tb, NEGsel_tb, SHRsel_tb, SHLsel_tb, RORsel_tb, ROLsel_tb, SUBsel_tb, ADDsel_tb, MULsel_tb, DIVsel_tb  : std_logic;
signal PCout_tb,MDRout_tb, read_tb, Cout_tb, HIout_tb, In_Portout_tb, LOout_tb, Zhighout_tb, Zlowout_tb, IncPC_tb : std_logic;
Signal MARout_tb : std_logic;
signal Yin_tb, Zin_tb, IRin_tb : std_LOGIC;
signal MDRin_tb, MARin_tb, Csignin_tb, Hiin_tb, In_port_Strobe_tb, Out_port_in_tb, Loin_tb, PCin_tb : std_LOGIC;
signal Mdatain_tb : std_LOGIC_VECTOR(31 downto 0);
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
signal R14Value : std_LOGIC_VECTOR(31 downto 0);
signal OutPortValue :  std_LOGIC_VECTOR(31 downto 0);
signal inPortValue :  std_LOGIC_VECTOR(31 downto 0);
signal ZLoValue : std_LOGIC_VECTOR(31 downto 0);
signal YValue : std_LOGIC_VECTOR(31 downto 0);
signal PCValue : std_LOGIC_VECTOR(31 downto 0);
signal IRValue : std_LOGIC_VECTOR(31 downto 0);
signal HIValue : std_LOGIC_VECTOR(31 downto 0);
signal LOValue : std_LOGIC_VECTOR(31 downto 0);
signal ZHiValue : std_LOGIC_VECTOR(31 downto 0);
signal address_tb :  unsigned(31 downto 0);
signal MemWrite_tb, R1inValue :  std_logic;
signal In_port_data_tb,tempCout_tb : std_LOGIC_VECTOR(31 downto 0); 
SIGNAL Clock_tb,instruction, CONin_tb: Std_logic;
signal Gra_tb, Grb_tb, Grc_tb, Rin_tb, Rout_tb, BAout_tb, CON_tb, tempConFF_tb : std_LOGIC;

TYPE State IS (default, PC_load_p1, PC_load_p2, T0, T1, T2, T3, T4, T5, T6, T7, Result);
SIGNAL Present_state: State := default;

TYPE insState IS (Load_Case_1, Load_Case_2, Load_Case_3, Load_Case_4, Load_Case_5,Pre_load_R4, Store_Case_1,Store_Case_1_Check,  Store_Case_2, 
						Store_Case_2_Check, Store_Case_3, Store_Case_3_Check, Addi, Andi, Ori, Pre_load_R5,  Pre_load_R6, brzr,brnz,brmi,brpl, jr, jal, Pre_load_Hi, Pre_load_LO, mfhi, mflo, outInstr, inInstr);
SIGNAL present_ins: insState := Load_Case_1;

-- component instantiation of the datapath
COMPONENT datapath
PORT (
clk : in std_LOGIC;
	PCout, Zlowout, MDRout, read_sel, Cout, HIout, In_Portout, LOout, Zhighout, IncPC : in std_logic;
	BoothMULsel, ANDsel, ORsel, NOTsel, NEGsel, SHRsel, SHLsel, RORsel, ROLsel, SUBsel, ADDsel, MULsel, DIVsel  : in std_logic;
	MARout : in std_LOGIC;
	Yin, Zin, IRin, CONin : in std_LOGIC;
	MDRin, MARin, Csignin, Hiin, In_port_Strobe, Out_port_in, Loin, PCin : in std_LOGIC;
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
	R14Value : out std_LOGIC_VECTOR(31 downto 0);
	inPortValue : out std_LOGIC_VECTOR(31 downto 0);
	ZLoValue : out std_LOGIC_VECTOR(31 downto 0);
	YValue :  out std_LOGIC_VECTOR(31 downto 0);
	PCValue :  out std_LOGIC_VECTOR(31 downto 0);
	IRValue :  out std_LOGIC_VECTOR(31 downto 0);
	HIValue :  out std_LOGIC_VECTOR(31 downto 0);
	LOValue,tempCout :  out std_LOGIC_VECTOR(31 downto 0);
	MemWrite : in std_logic; 
	In_port_data : in std_LOGIC_VECTOR(31 downto 0);
	Out_port_data : out std_LOGIC_VECTOR(31 downto 0);
	ZHiValue : out std_LOGIC_VECTOR(31 downto 0);
	Gra, Grb, Grc, Rin, Rout, BAout : in std_LOGIC;
	R1inValue, CON, tempConFF : out std_LOGIC
	);
END COMPONENT datapath;

BEGIN

DUT : datapath
--port mapping: between the dut and the testbench signals
PORT MAP (
PCout => PCout_tb,
Zlowout => Zlowout_tb,
MDRout => MDRout_tb,
read_sel => read_tb,
Cout => Cout_tb,   
HIout => HIout_tb, 
In_Portout => In_Portout_tb, 
Out_port_in => Out_port_in_tb,
LOout => LOout_tb, 
Zhighout => Zhighout_tb, 
IncPC => IncPC_tb,
ANDsel => ANDsel_tb, 
ORsel => ORsel_tb, 
NOTsel => NOTsel_tb, 
NEGsel => NEGsel_tb, 
SHRsel => SHRsel_tb, 
SHLsel => SHLsel_tb, 
RORsel => RORsel_tb, 
ROLsel => ROLsel_tb, 
SUBsel => SUBsel_tb, 
ADDsel => ADDsel_tb, 
MULsel => MULsel_tb, 
DIVsel => DIVsel_tb,
BoothMULsel => BoothMULsel_tb, 
MDRin => MDRin_tb,
Csignin => Csignin_tb, 
Hiin => Hiin_tb,
In_port_Strobe => In_Port_Strobe_tb, 
Loin => Loin_tb, 
MARin => MARin_tb,
MARout => MARout_tb,
PCin => PCin_tb,
IRin => IRin_tb,
Clk => Clock_tb,
Zin => Zin_tb,
Yin => Yin_tb,
tempBusOut => BusMuxOut,
MDRValue => MDRValue,
R0Value => R0Value,
R1Value => R1Value,
R2Value => R2Value,
R3Value => R3Value,
R4Value => R4Value,
R5Value => R5Value,
R6Value => R6Value,
R14Value => R14Value,
out_port_data => OutPortValue,
inPortValue => inPortValue,
ZLoValue => ZLoValue,
YValue => YValue,
PCValue => PCValue,
IRValue => IRValue,
HIValue => HIValue,
LOValue => LOValue,
ZHiValue => ZHiValue,
memWrite => memWrite_tb,
In_port_data => In_port_data_tb,
Gra => Gra_tb,
Grb => Grb_tb,
Grc => Grc_tb,
Rin => Rin_tb,
Rout => Rout_tb,
BAout => BAout_tb,
CONin => CONin_tb,
MARValue => MARValue,
R1inValue => R1inValue,
tempCout => tempCout_tb,
CON => CON_tb,
tempConFF => tempConFF_tb
);

clk_process :process
begin 
		clock_tb <= '0';
		wait for 20ns;  --for 0.5 ns signal is '0'.
		clock_tb <= '1';
		wait for 10ns;  --for next 0.5 ns signal is '1'.
end process;

instruction_process :process
begin 
		instruction <= '0';
		wait for 350ns;  --for 0.5 ns signal is '0'.
		instruction <= '1';
		wait for 10ns;  --for next 0.5 ns signal is '1'.
end process;

firstProc : PROCESS (Clock_tb) is -- finite state machine
		BEGIN
				IF (Clock_tb'EVENT AND Clock_tb = '1') THEN -- if clock rising-edge
						CASE Present_state IS
								WHEN Default =>
										Present_state <= PC_load_p1;
								WHEN PC_load_p1 =>
										Present_state <= PC_load_p2;
								WHEN PC_load_p2 =>
										Present_state <= T0;
								WHEN T0 =>
										Present_state <= T1;
								WHEN T1 =>
										Present_state <= T2;
								WHEN T2 =>
										Present_state <= T3;
								WHEN T3 =>
										Present_state <= T4;
								WHEN T4 =>
										Present_state <= T5;
								WHEN T5 =>
										Present_state <= T6;
								WHEN T6 =>
										Present_state <= T7;
								WHEN T7 =>
										Present_state <= Result;
								WHEN Result =>
										Present_state <= Default;
								WHEN OTHERS =>
						END CASE;
				END IF;
		END PROCESS;

Proc : PROCESS (instruction) is -- finite state machine
BEGIN
		IF (instruction'EVENT AND instruction = '1') THEN -- if clock rising-edge
				CASE present_ins IS
						WHEN Load_Case_1  =>
								present_ins <= Load_Case_2;
						WHEN Load_Case_2  =>
								present_ins <= Load_Case_3; 
						WHEN Load_Case_3  =>
								present_ins <= Load_Case_4;
						WHEN Load_Case_4  =>
								present_ins <= Load_Case_5;
						WHEN Load_Case_5 =>
								present_ins <= Pre_load_R4;
						WHEN Pre_load_R4 =>
								present_ins <= Store_Case_1;
						WHEN Store_Case_1 =>
								present_ins <= Store_Case_1_Check;
						WHEN Store_Case_1_Check =>	
								present_ins <= Store_Case_2;
						WHEN Store_Case_2 =>
								present_ins <= Store_Case_2_Check;
						WHEN Store_Case_2_Check =>
								present_ins <= Store_Case_3;
						WHEN Store_Case_3 =>
								present_ins <= Store_Case_3_Check;
						WHEN Store_Case_3_Check =>
								present_ins <= Addi;
						WHEN Addi =>
								present_ins <= Andi;
						WHEN Andi =>
								present_ins <= Ori;
						WHEN Ori =>
								present_ins <= pre_load_R5;
						WHEN pre_load_R5 =>
								present_ins <= pre_load_R6;
						WHEN pre_load_R6 =>
								present_ins <= brzr;
						WHEN brzr =>
								present_ins <= brnz;
						WHEN brnz => 
								present_ins <= brmi; 
						WHEN brmi => 
								present_ins <= brpl; 
						WHEN brpl =>
								present_ins <= jr; 
						WHEN jr =>	
								present_ins <= jal; 
						WHEN jal =>
								present_ins <= Pre_load_Hi;
						WHEN Pre_load_Hi =>
								present_ins <= Pre_load_Lo;
						WHEN Pre_load_Lo =>
								present_ins <= mfhi;
						WHEN mfhi =>
								present_ins <= mflo;
						WHEN mflo =>
								present_ins <= outInstr;
						WHEN outInstr =>
								present_ins <= inInstr;
						WHEN OTHERS =>
				END CASE;
		END IF;
END PROCESS;

overallProc : PROCESS (present_ins, present_state) -- 
BEGIN
				CASE present_ins IS 				
		When Load_Case_1 =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; Grc_tb <= '0';
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0'; Conin_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';	
										ANDsel_tb <= '0'; ORSel_tb <= '0'; Cout_tb <= '0'; Hiout_tb <= '0'; In_Portout_tb <= '0';
										LOout_tb <= '0'; Hiin_tb <= '0'; In_Port_Strobe_tb <= '0'; Out_port_in_tb <= '0'; 
										Loin_tb <= '0'; MemWrite_tb <= '0';  Mdatain_tb(31 downto 0) <= x"00000000";
								WHEN PC_load_p1 =>
										In_port_data_tb <= x"00000000";
										In_Port_Strobe_tb <= '1'; 		
								WHEN PC_load_p2 =>
										In_Port_Strobe_tb <= '0';
										In_Portout_tb <= '1';
										PCin_tb <= '1'; 	
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"00800065"; -- opcode for ld R1, x65
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; MARin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; MARin_tb <= '0';
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T7 =>
										Read_tb <= '0'; MDRin_tb <= '0';
										MDRout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN Result =>
										MDRout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';
								WHEN OTHERS =>
						END CASE;
		
		When Load_Case_2 =>
					CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0';
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0'; 
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"00080055"; -- opcode for ld R0,x55(R1)
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '0'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1'; Rout_tb<='1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0'; Rout_tb<='0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0'; Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; MARin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; MARin_tb <= '0';
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T7 =>
										Read_tb <= '0'; MDRin_tb <= '0';
										MDRout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN Result =>
										MDRout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';
								WHEN OTHERS =>
						END CASE;	
		WHEN Load_Case_3 =>
					CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0';
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0'; 
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
					
								WHEN PC_load_p1 =>
								WHEN PC_load_p2 =>	
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"08800065";  --for ldi r1,x65
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0'; Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';
										
								WHEN T7 =>
								
								WHEN Result =>
										
								WHEN OTHERS =>
						END CASE;
		WHEN Load_Case_4 =>
					CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
					
								WHEN PC_load_p1 =>
								WHEN PC_load_p2 =>	
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"08880055";  --for ldi r1,0x55(R1)
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0'; Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';
										
								WHEN T7 =>
								
								WHEN Result =>
										
								WHEN OTHERS =>
						END CASE;
		WHEN Load_Case_5 =>
				CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
					
								WHEN PC_load_p1 =>
								WHEN PC_load_p2 =>	
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"18000065";  --for ldr r0,x65
										Yin_tb <= '1'; Read_tb <= '1'; MDRin_tb <= '1'; -- does Memory at [PC + Constant]
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0'; Yin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Cout_tb<='1'; ADDsel_tb <= '1'; Zin_tb<='1'; 
										MDRout_tb <= '0'; IRin_tb <= '0'; 
								WHEN T4 =>
										Cout_tb<='0'; ADDsel_tb <= '0'; Zin_tb<='0'; 
										Zlowout_tb <= '1'; MARin_tb <= '1';
								WHEN T5 =>
										Read_tb <= '1'; Mdatain_tb(31 downto 0) <= x"00000002";  
										MDRin_tb <= '1';
										Zlowout_tb <= '0'; MARin_tb <= '0';
								WHEN T6 => 
										Mdrout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
										Read_tb <= '0'; MDRin_tb <= '0';
								WHEN T7 =>
										Mdrout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';
								WHEN Result =>
										
								WHEN OTHERS =>
						END CASE;
			WHEN Pre_load_R4 =>		
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
					
								WHEN PC_load_p1 =>
								WHEN PC_load_p2 =>	
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"0A000067";  --for ldi r4,x67
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0'; Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';
										
								WHEN T7 =>
								
								WHEN Result =>
										
								WHEN OTHERS =>
						END CASE;
			WHEN Store_Case_1 =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';	
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"12000090"; -- opcode for st x90, R4
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; MARin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; MARin_tb <= '0';
										Gra_tb<= '1'; Rout_tb <= '1'; MDRin_tb <= '1'; Read_tb <= '0';
								WHEN T7 =>
										Gra_tb<= '0'; Rout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
										memWrite_tb <= '1'; MDRout_tb <= '1'; 
								WHEN Result =>
										memWrite_tb <= '0'; MDRout_tb <= '0'; 
								WHEN OTHERS =>
						END CASE;
			WHEN Store_Case_1_Check =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"01800090"; -- opcode for ld R3, x90 to check the store case 1
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; MARin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; MARin_tb <= '0';
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T7 =>
										Read_tb <= '0'; MDRin_tb <= '0';
										MDRout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN Result =>
										MDRout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';
								WHEN OTHERS =>
						END CASE;
			WHEN Store_Case_2 =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';	
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"12200090"; -- opcode for st x90(R4), R4
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '0'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1'; Rout_tb<='1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0'; Rout_tb<='0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; MARin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; MARin_tb <= '0';
										Gra_tb<= '1'; Rout_tb <= '1'; MDRin_tb <= '1'; Read_tb <= '0';
								WHEN T7 =>
										Gra_tb<= '0'; Rout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
										memWrite_tb <= '1'; MDRout_tb <= '1'; 
								WHEN Result =>
										memWrite_tb <= '0'; MDRout_tb <= '0'; 
								WHEN OTHERS =>
						END CASE;
			WHEN Store_Case_2_Check =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"018000F7"; -- opcode for ld R3, xF7 to check the store case 2
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; MARin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; MARin_tb <= '0';
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T7 =>
										Read_tb <= '0'; MDRin_tb <= '0';
										MDRout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN Result =>
										MDRout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';
								WHEN OTHERS =>
						END CASE;			
			WHEN Store_Case_3 =>
								CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';	
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"22000090"; -- opcode for str x90, R4
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '0'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1'; PCout_tb<='1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0'; PCout_tb<='0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; MARin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; MARin_tb <= '0';
										Gra_tb<= '1'; Rout_tb <= '1'; MDRin_tb <= '1'; Read_tb <= '0';
								WHEN T7 =>
										Gra_tb<= '0'; Rout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
										memWrite_tb <= '1'; MDRout_tb <= '1'; 
								WHEN Result =>
										memWrite_tb <= '0'; MDRout_tb <= '0'; 
								WHEN OTHERS =>
						END CASE;
			WHEN Store_Case_3_Check =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"018000BC"; -- opcode for ld R3, xBC to check the store case 3
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; MARin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; MARin_tb <= '0';
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T7 =>
										Read_tb <= '0'; MDRin_tb <= '0';
										MDRout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN Result =>
										MDRout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';
								WHEN OTHERS =>
						END CASE;
			WHEN Addi =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"69180025"; -- opcode for addi R2, R3, x25 //"98180025"
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; Rout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; Rout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1'; 
								WHEN T6 => 
										Zlowout_tb <= '0'; Rin_tb <= '0'; Gra_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN Andi =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"71180025"; -- opcode for andi R2, R3, x25
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; Rout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; Rout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ANDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ANDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1'; 
								WHEN T6 => 
										Zlowout_tb <= '0'; Rin_tb <= '0'; Gra_tb <= '0';
								WHEN OTHERS =>
						END CASE;		
				WHEN Ori =>
					CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"79180025"; -- opcode for ori R2, R3, x25
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; Rout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; Rout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ORsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0';  Zin_tb <= '0'; ORsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1'; 
								WHEN T6 => 
										Zlowout_tb <= '0'; Rin_tb <= '0'; Gra_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN Pre_load_R5 =>		
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN PC_load_p1 =>
								WHEN PC_load_p2 =>	
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"0A800022";  --for ldi r5,x22
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0'; Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';			
								WHEN OTHERS =>
						END CASE;
				WHEN Pre_load_R6 =>
								CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN PC_load_p1 =>
								WHEN PC_load_p2 =>	
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"0B000044";  --for ldi r6,x44
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0'; Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; Gra_tb <= '1'; Rin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0';			
								WHEN OTHERS =>
						END CASE;		
				WHEN brzr =>
					CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"AB280000"; -- opcode for brzr R6, R5
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Gra_tb <= '1'; Rout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										CONin_tb <= '1';
								WHEN T4 =>
										Gra_tb <= '0'; CONin_tb <= '0'; 
										Grb_tb <= '1'; Rout_tb <= '1'; PCin_tb <= CON_tb;
								WHEN T5 =>
										Grb_tb <= '0'; Rout_tb <= '0'; PCin_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN brnz =>
					CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0';
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN PC_load_p1 =>
										In_port_data_tb <= x"00000048";
										In_Port_Strobe_tb <= '1'; 		
								WHEN PC_load_p2 =>
										In_Port_Strobe_tb <= '0';
										In_Portout_tb <= '1';
										PCin_tb <= '1'; 	
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"AB280001"; -- opcode for brnz R6, R5
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Gra_tb <= '1'; Rout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										CONin_tb <= '1';
								WHEN T4 =>
										Gra_tb <= '0'; CONin_tb <= '0';
										Grb_tb <= '1'; Rout_tb <= '1'; PCin_tb <= CON_tb;
								WHEN T5 =>
										Grb_tb <= '0'; Rout_tb <= '0'; PCin_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN brmi =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN PC_load_p1 =>
										In_port_data_tb <= x"0000004C";
										In_Port_Strobe_tb <= '1'; 		
								WHEN PC_load_p2 =>
										In_Port_Strobe_tb <= '0';
										In_Portout_tb <= '1';
										PCin_tb <= '1'; 	
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"AB280003"; -- opcode for brmi R6, R5
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Gra_tb <= '1'; Rout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										CONin_tb <= '1';
								WHEN T4 =>
										Gra_tb <= '0'; CONin_tb <= '0';
										Grb_tb <= '1'; Rout_tb <= '1'; PCin_tb <= CON_tb;
								WHEN T5 =>
										Grb_tb <= '0'; Rout_tb <= '0'; PCin_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN brpl =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN PC_load_p1 =>
										In_port_data_tb <= x"00000050";
										In_Port_Strobe_tb <= '1'; 		
								WHEN PC_load_p2 =>
										In_Port_Strobe_tb <= '0';
										In_Portout_tb <= '1';
										PCin_tb <= '1'; 	
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"AB280002"; -- opcode for brpl R6, R5
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Gra_tb <= '1'; Rout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										CONin_tb <= '1';
								WHEN T4 =>
										Gra_tb <= '0'; CONin_tb <= '0';
										Grb_tb <= '1'; Rout_tb <= '1'; PCin_tb <= CON_tb;
								WHEN T5 =>
										Grb_tb <= '0'; Rout_tb <= '0'; PCin_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN jr =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN PC_load_p1 =>
										In_port_data_tb <= x"00000054";
										In_Port_Strobe_tb <= '1'; 		
								WHEN PC_load_p2 =>
										In_Port_Strobe_tb <= '0';
										In_Portout_tb <= '1';
										PCin_tb <= '1'; 	
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"A9000000"; -- opcode for jr, R2
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Gra_tb <= '1'; Rout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										PCin_tb <= '1';
								WHEN T4 =>
										Gra_tb <= '0'; Rout_tb <= '0'; PCin_tb <= '0';
								WHEN T5 =>
								WHEN OTHERS =>
						END CASE;
				WHEN jal =>	
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN PC_load_p1 =>
										In_port_data_tb <= x"00000058";
										In_Port_Strobe_tb <= '1'; 		
								WHEN PC_load_p2 =>
										In_Port_Strobe_tb <= '0';
										In_Portout_tb <= '1';
										PCin_tb <= '1'; 	
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"B1700000"; -- opcode for jal, R2
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										MDRout_tb <= '0'; IRin_tb <= '0'; PCout_tb <='1';
										IncPC_tb <= '1'; Zin_tb <= '1';
								WHEN T4 =>
										PCout_tb <='0'; IncPC_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; Grb_tb <= '1'; Rin_tb <= '1';
								WHEN T5 =>
										Zlowout_tb <= '0'; Grb_tb <= '0'; Rin_tb <= '0';	
										Gra_tb <= '1'; Rout_tb <= '1'; 
										PCin_tb <= '1';
								WHEN T6 =>
										Gra_tb <= '0'; Rout_tb <= '0'; PCin_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN Pre_load_Hi =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN PC_load_p1 =>
										In_port_data_tb <= x"0000005C";
										In_Port_Strobe_tb <= '1'; 		
								WHEN PC_load_p2 =>
										In_Port_Strobe_tb <= '0';
										In_Portout_tb <= '1';
										PCin_tb <= '1'; 	
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"00000034";  --for ldi HI,x34
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0'; Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; HIin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; HIin_tb <= '0';
										
								WHEN T7 =>
								
								WHEN Result =>
										
								WHEN OTHERS =>
						END CASE;
				WHEN Pre_load_Lo =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"00000024";  --for ldi LO,x24
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										Grb_tb <= '1'; BAout_tb <= '1'; MDRout_tb <= '0'; IRin_tb <= '0'; 
										Yin_tb <= '1';
								WHEN T4 =>
										Grb_tb <= '0'; BAout_tb <= '0'; Yin_tb <= '0';
										Cout_tb <= '1'; ADDsel_tb <= '1'; Zin_tb <= '1';
								WHEN T5 =>
										Cout_tb <= '0'; Zin_tb <= '0'; ADDsel_tb <= '0'; Zin_tb <= '0';
										Zlowout_tb <= '1'; LOin_tb <= '1';
								WHEN T6 => 
										Zlowout_tb <= '0'; Loin_tb <= '0';
										
								WHEN T7 =>
								
								WHEN Result =>
										
								WHEN OTHERS =>
						END CASE;
				WHEN mfhi =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"CA000000"; -- opcode for mfhi R4
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										MDRout_tb <= '0'; IRin_tb <= '0'; 
										HIout_tb <= '1'; GRa_tb <= '1'; Rin_tb <= '1';
								WHEN T4 =>
										HIout_tb <= '0'; Rin_tb <= '0'; GRa_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN mflo => 
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"D3000000"; -- opcode for mflo R6
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										MDRout_tb <= '0'; IRin_tb <= '0'; 
										LOout_tb <= '1'; GRa_tb <= '1'; Rin_tb <= '1';
								WHEN T4 =>
										LOout_tb <= '0'; Rin_tb <= '0'; GRa_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN outInstr =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0';
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"C1000000"; -- opcode for out R2
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										MDRout_tb <= '0'; IRin_tb <= '0'; 
										Gra_tb <= '1'; Rout_tb <= '1'; Out_port_in_tb <= '1';
								WHEN T4 =>
										Gra_tb <= '0'; Rout_tb <= '0'; Out_port_in_tb <= '0';
								WHEN OTHERS =>
						END CASE;
				WHEN inInstr =>
						CASE Present_state IS -- assert the required signals in each clock cycle
								WHEN Default =>
										PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
										MARin_tb <= '0'; Zin_tb <= '0'; 
										PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
										IncPC_tb <= '0'; Read_tb <= '0'; ADDsel_tb <= '0';
										Grb_tb <= '0'; BAout_tb <= '0'; Gra_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0';
								WHEN T0 =>
										In_Portout_tb <= '0';
										PCin_tb <= '0';
										PCout_tb <= '1'; 
										MARin_tb <= '1'; IncPC_tb <= '1';  Zin_tb <= '1';
								WHEN T1 =>
										MARin_tb <= '0'; IncPC_tb <= '0';
										PCout_tb <= '0'; Zin_tb <= '0'; Zlowout_tb <= '1'; PCin_tb <= '1';
										Mdatain_tb(31 downto 0) <= x"C1800000"; -- opcode for in R3
										Read_tb <= '1'; MDRin_tb <= '1';
								WHEN T2 =>
										MDRout_tb <= '1'; IRin_tb <= '1'; PCin_tb <= '0';
										Zlowout_tb <= '0'; MDRin_tb <= '0'; Read_tb <= '0';
								WHEN T3 =>
										MDRout_tb <= '0'; IRin_tb <= '0'; 
										In_Port_Strobe_tb <= '1'; In_port_data_tb <= x"0000FFFF";
								WHEN T4 =>
										In_Port_Strobe_tb <= '0'; In_Portout_tb <= '1';
										Gra_tb <= '1'; Rin_tb <= '1';
								WHEN T5 =>
										Gra_tb <= '0'; Rin_tb <= '0';
								WHEN OTHERS =>
						END CASE;		
		END CASE;
END PROCESS;		
				
END ARCHITECTURE;