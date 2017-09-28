Library IEEE;
USE IEEE.std_logic_1164.all;
USE work.common.all;

Entity control_unit is
	Port(
		Clock, Reset, CON_FF, stop : in std_logic;
		IR		: in std_logic_vector(31 downto 0);
		Gra, Grb, Grc, Rin, Rout, LOout, HIout, Zlowout, Zhighout, MDRout, PCout : out std_logic;
		ANDd, ORr, NOTt, NEG, SHR, SHL, RORr, ROLl, MUL, SUB, ADD, DIV : out std_logic;
		HIin, LOin, CONin, PCin, IRin, Yin, Zin, MARin, MDRin, Out_Portin, Cout, BAout : out std_logic;
		In_Portout,In_port_strobe, Readd, Writee, INCPC : out std_logic;
		runOut : out std_LOGIC;
		currentState : out State
	);
end entity control_unit;
	
Architecture Behavior of control_unit is

	SIGNAL Present_state: State := reset_state;
	
Begin
	PROCESS(Clock, Reset)
	begin	
		IF(Reset = '0') then    --when reset is set (active-low) then the program is put into the reset state
				Present_state <= Reset_state;
		elsif(stop = '1') then  --put the program into a halt state 
				Present_state <= halt;
		elsif(clock'event and clock = '1')then
				Case Present_state is
					When Reset_state =>
						Present_state <= fetch0;
					When fetch0 =>
						Present_state <= fetch1;
					When fetch1 =>
						Present_state <= fetch2;	--fetch2 gets the opcode which gets the instruction
					When addImmediate3 =>
						Present_state <= addImmediate4;
					When addImmediate4 =>
						Present_state <= addImmediate5;
					When addImmediate5 =>
						Present_state <= addImmediate6;
					When addImmediate6 =>
						Present_state <= zero;
					When zero =>
						Present_state <= fetch0;
					When add3 =>
						Present_state <= add4;
					When add4 =>
						Present_state <= add5;
					When add5 =>
						Present_state <= add6;
					When add6 =>
						Present_state <= zero;
					When load3 =>
						Present_state <= load4;
					When load4 =>
						Present_state <= load5;
					When load5 =>
						Present_state <= load6;
					When load6 =>
						Present_state <= load7;
					When load7 =>
						Present_state <= zero;
					When loadimmediate3 =>
						Present_state <= loadImmediate4;
					When loadImmediate4 =>
						Present_state <= loadImmediate5;
					When loadImmediate5 =>
						Present_state <= zero;
					When loadRelative3 =>
						Present_state <= loadRelative4;
					When loadRelative4 =>
						Present_state <= loadRelative5;
					When loadRelative5 =>
						Present_state <= loadRelative6;
					When loadRelative6 =>
						Present_state <= zero;
					When andImmediate3 =>
						Present_state <= andImmediate4;
					When andImmediate4 =>
						Present_state <= andImmediate5;
					When andImmediate5 =>
						Present_state <= zero;
					When sub3 =>
						Present_state <= sub4;
					When sub4 =>
						Present_state <= sub5;
					When sub5 =>
						Present_state <= zero;
					When negate3 =>
						Present_state <= negate4;
					When negate4 =>
						Present_state <= negate5;
					When negate5 =>
						Present_state <= zero;
					When not3 =>
						Present_state <= not4;
					When not4 =>
						Present_state <= not5;
					When not5 =>
						Present_state <= zero;
					When shr3 =>
						Present_state <= shr4;
					When shr4 =>
						Present_state <= shr5;
					When shr5 =>
						Present_state <= zero;
					When shl3 =>
						Present_state <= shl4;
					When shl4 =>
						Present_state <= shl5;
					When shl5 =>
						Present_state <= zero;
					When ror3 =>
						Present_state <= ror4;
					When ror4 =>
						Present_state <= ror5;
					When ror5 =>
						Present_state <= zero;
					When rol3 =>
						Present_state <= rol4;
					When rol4 =>
						Present_state <= rol5;
					When rol5 =>
						Present_state <= zero;
					When or3 =>
						Present_state <= or4;
					When or4 =>
						Present_state <= or5;
					When or5 =>
						Present_state <= zero;
					When and3 =>
						Present_state <= and4;
					When and4 =>
						Present_state <= and5;
					When and5 =>
						Present_state <= zero;
					When multiply3 =>
						Present_state <= multiply4;
					When multiply4 =>
						Present_state <= multiply5;
					When multiply5 =>
						Present_state <= multiply6;
					When multiply6 =>
						Present_state <= zero;
					When divide3 =>
						Present_state <= divide4;
					When divide4 =>
						Present_state <= divide5;
					When divide5 =>
						Present_state <= divide6;
					When divide6 =>
						Present_state <= zero;
					When mfhi3 =>
						Present_state <= zero;
					When mflo3 =>
						Present_state <= zero;
					When jal3 =>
						Present_state <= jal4;
					When jal4 =>
						Present_state <= jal5;
					When jal5 =>
						Present_state <= zero;
					When jr3 => 
						Present_state <= zero;	
					When orImmediate3 =>
						Present_state <= orImmediate4;
					When orImmediate4 =>	
						Present_state <= orImmediate5;
					When orImmediate5 =>
						Present_state <= zero;
					When storeRelative3 =>
						Present_state <= storeRelative4;
					When storeRelative4 =>
						Present_state <= storeRelative5;
					When storeRelative5 =>
						Present_state <= storeRelative6;
					When storeRelative6 =>
						Present_state <= storeRelative7;
					When storeRelative7 =>
						Present_state <= zero;
					When store3 =>
						Present_state <= store4;
					When store4 =>
						Present_state <= store5;
					When store5 =>
						Present_state <= store6;
					When store6 =>
						Present_state <= store7;
					When store7 =>
						Present_state <= zero;
					When out3 =>
						Present_state <= zero;
					When in3 =>
						Present_state <= in4;
					When in4 => 
						Present_state <= zero;
					When brnz3 =>
						Present_state <= brnz4;
					When brnz4 =>
						Present_state <= zero;
					When brzr3 =>
						Present_state <= brzr4;
					When brzr4 =>
						Present_state <= zero;
					when halt =>
					when nop =>
						Present_state <= zero;
					When fetch2 =>
						Case IR(31 downto 27) is 
							when "01101" => 
								Present_state <= addImmediate3;
							when "00000" =>
								Present_state <= load3;
							when "00001" =>
								Present_state <= loadImmediate3;
							when "00010" =>
								Present_state <= store3;
							when "00100" =>
								Present_state <= storeRelative3;
							when "00101" =>
								Present_state <= add3;
							When "00110" =>
								Present_state <= sub3;
							when "00111" =>
								Present_state <= and3;
							when "01000" =>
								Present_state <= or3;
							when "01001" =>
								Present_state <= shr3;
							when "01010" =>
								Present_state <= shl3;
							when "01011" =>
								Present_state <= ror3;
							when "01100" =>
								Present_state <= rol3; 
							when "01110" =>
								Present_state <= andImmediate3;
							when "10000" =>
								Present_state <= multiply3;
							when "10001" =>
								Present_state <= divide3;
							when "10010" =>
								Present_state <= negate3;
							when "10011" =>
								Present_state <= not3;
							when "10101" =>
								Present_state <= jr3;
							when "10110" =>
								Present_state <= jal3;
							when "11001" =>
								Present_state <= mfhi3;
							when "11010" =>
								Present_state <= mflo3;
							when "11011" =>
								Present_state <= nop;
							when "11100" => 
								Present_state <= halt;
							when "00011" =>
								Present_state <= loadRelative3;
							when "01111" =>
								Present_state <= orImmediate3;
							when "11000" =>
								Present_state <= out3;
							when "10111" =>
								Present_state <= in3;
							when "10100" =>
									if(IR(1 downto 0) = "01") then
										Present_state <= brnz3;
									elsif (IR(1 downto 0) = "00" ) then
										Present_state <= brzr3;	
									end if;	
							when others =>
						end case;
					when others =>
				 end case;
		end if;
	end process;
	
	process(Present_state)
	begin
		currentState <= present_state; --to show the current state in model sim
				PCout <= '0'; 
				Zlowout<= '0'; 
				MDRout<= '0'; 
				MARin<= '0'; 
				Zin <= '0'; 
				PCin <='0'; 
				MDRin <= '0'; 
				IRin <= '0'; 
				Yin <= '0';
				IncPC <= '0'; 
				Readd <= '0'; 
				ADD <= '0';
				Grb <= '0'; 
				BAout <= '0'; 
				Gra <= '0'; 
				Rin <= '0'; 
				Rout <= '0';
				Grc <= '0';
				readd <= '0';
				writee <= '0';
				In_Portout <= '0';
				In_port_strobe <= '0';
				mul <= '0';
				andd <= '0';
				orr <= '0';
				nott <= '0';
				neg <= '0';
				shr <= '0';
				shl <= '0';
				rorr <= '0';
				roll <= '0';
				sub <= '0';
				DIV <= '0';
				Cout <= '0';
				Hiout <= '0';
				Loout <= '0';
				Zhighout <= '0';
				Hiin <= '0';
				out_Portin <= '0';
				loin <= '0';
				CONin <= '0';
		Case present_state is
			when zero => 
				PCout <= '0'; 
				Zlowout<= '0'; 
				MDRout<= '0'; 
				MARin<= '0'; 
				Zin <= '0'; 
				PCin <='0'; 
				MDRin <= '0'; 
				IRin <= '0'; 
				Yin <= '0';
				IncPC <= '0'; 
				Readd <= '0'; 
				ADD <= '0';
				Grb <= '0'; 
				BAout <= '0'; 
				Gra <= '0'; 
				Rin <= '0'; 
				Rout <= '0';
				Grc <= '0';
				readd <= '0';
				writee <= '0';
				In_Portout <= '0';
				mul <= '0';
				andd <= '0';
				orr <= '0';
				nott <= '0';
				neg <= '0';
				shr <= '0';
				shl <= '0';
				rorr <= '0';
				roll <= '0';
				sub <= '0';
				DIV <= '0';
				Cout <= '0';
				Hiout <= '0';
				Loout <= '0';
				Zhighout <= '0';
				Hiin <= '0';
				out_Portin <= '0';
				loin <= '0';
				CONin <= '0';
				runOut <= '1';
			when reset_state =>
				PCout <= '0'; 
				Zlowout<= '0'; 
				MDRout<= '0'; 
				MARin<= '0'; 
				Zin <= '0'; 
				PCin <='0'; 
				MDRin <= '0'; 
				IRin <= '0'; 
				Yin <= '0';
				IncPC <= '0'; 
				Readd <= '0'; 
				ADD <= '0';
				Grb <= '0'; 
				BAout <= '0'; 
				Gra <= '0'; 
				Rin <= '0'; 
				Rout <= '0';
				Grc <= '0';
				readd <= '0';
				writee <= '0';
				mul <= '0';
				andd <= '0';
				orr <= '0';
				nott <= '0';
				neg <= '0';
				shr <= '0';
				shl <= '0';
				rorr <= '0';
				roll <= '0';
				sub <= '0';
				div <= '0';
				Cout <= '0';
				Hiout <= '0';
				Loout <= '0';
				Zhighout <= '0';
				Hiin <= '0';
				out_Portin <= '0';
				loin <= '0';
				runOut <= '1';
			when fetch0 =>
				PCout <= '1'; 
				MARin <= '1'; 
				IncPC <= '1';  
				Zin <= '1';
			when fetch1 => 
				Zlowout <= '1'; 
				PCin <= '1';
				Yin <= '1'; 
				Readd <= '1'; 
				MDRin <= '1';
			when fetch2 =>
				MDRout <= '1';
				IRin <= '1' after 5 ns; 
			when addImmediate3 =>
				Grb <= '1'; 
				Rout <= '1'; 
				Yin <= '1';
			when addImmediate4 =>
				Cout <= '1'; 
				ADD <= '1'; 
				Zin <= '1';
			when addImmediate5 =>
				Zlowout <= '1'; 
				Gra <= '1'; 
				Rin <= '1'; 
			when addImmediate6 =>
			when load3 =>
				Grb <= '1'; 
				BAout <= '1'; 
				Yin <= '1';
			when load4 =>
				Cout <= '1'; 
				ADD <= '1'; 
				Zin <= '1';
			when load5 =>
				Zlowout <= '1'; 
				MARin <= '1';
			when load6 =>
				Readd <= '1'; 
				MDRin <= '1';
			when load7 =>
				MDRout <= '1'; 
				Gra <= '1'; 
				Rin <= '1';
			when loadImmediate3 =>
				Grb <= '1'; 
				BAout <= '1'; 
				Yin <= '1';
			when loadImmediate4 =>
				Cout <= '1'; 
				ADD <= '1'; 
				Zin <= '1';
			when loadImmediate5 =>
				Zlowout <= '1'; 
				Gra <= '1'; 
				Rin <= '1';
			when loadRelative3 =>
				Cout<='1';
				ADD <= '1'; 
				Zin<='1'; 
			when loadRelative4 =>
				Zlowout <= '1';
				MARin <= '1';
			when loadRelative5 =>
				Readd <= '1';
				MDRin <= '1';
			when loadRelative6 =>
				Mdrout <= '1';
				Gra<= '1'; 
				Rin <= '1';
			when store3 =>
				Grb <= '1';
				BAout <= '1'; 
				Yin <= '1';
			when store4 =>
				Cout <= '1'; 
				ADD <= '1'; 
				Zin <= '1';
			when store5 =>
				Zlowout <= '1'; 
				MARin <= '1';
			when store6 =>
				Gra<= '1'; 
				Rout <= '1'; 
				MDRin <= '1'; 
			when store7 =>
				writee <= '1'; 
				MDRout <= '1'; 
			when storeRelative3 =>
				Grb <= '1'; 
				Yin <= '1'; 
				PCout<='1';
			when storeRelative4 =>
				Cout <= '1'; 
				ADD <= '1'; 
				Zin <= '1';
			when storeRelative5 =>
				Zlowout <= '1'; 
				MARin <= '1';
			when storeRelative6 =>
				Gra<= '1'; 
				Rout <= '1'; 
				MDRin <= '1'; 
			when storeRelative7 =>
				writee <= '1'; 
				MDRout <= '1'; 
			when andImmediate3 =>
				Grb <= '1'; 
				Rout <= '1'; 
				Yin <= '1';
			when andImmediate4 =>
				Cout <= '1'; 
				ANDd <= '1'; 
				Zin <= '1';
			when andImmediate5 =>
				Zlowout <= '1'; 
				Gra <= '1'; 
				Rin <= '1';
			when orImmediate3 =>
				Grb <= '1'; 
				Rout <= '1';  
				Yin <= '1';
			when orImmediate4 =>
				Cout <= '1'; 
				ORr <= '1'; 
				Zin <= '1';
			when orImmediate5 =>
				Zlowout <= '1'; 
				Gra <= '1'; 
				Rin <= '1'; 
			when add3 =>
				Rout <= '1'; 
				Yin <= '1'; 
				Grb <= '1';
			when add4 =>
				Grc <= '1'; 
				Rout <= '1';
				ADD <= '1'; 
				Zin <= '1';
			when add5 => 
				Gra <= '1'; 
				Zlowout <= '1'; 
				Rin <= '1'; 
			when sub3 =>
				Rout <= '1'; 
				Yin <= '1'; 
				Grb <= '1';
			WHEN sub4 =>
				Grc <= '1'; 
				Rout <= '1';
				SUB <= '1'; 
				Zin <= '1';
			WHEN sub5 =>
				Gra <= '1'; 
				Zlowout <= '1';
				Rin <= '1'; 
			when negate3 => 
				Rout <= '1'; 
				Yin <= '1'; 
				Grb <= '1';
			WHEN negate4 =>
				NEG <= '1'; 
				Zin <= '1'; 
			WHEN negate5 => 
				Gra <= '1';
				Zlowout <= '1'; 
				Rin <= '1';
			WHEN not3 =>
				Rout <= '1'; 
				Yin <= '1'; 
				Grb <= '1';
			WHEN not4 =>
				NOTt <= '1'; 
				Zin <= '1';
			WHEN not5 => 
				Gra <= '1';
				Zlowout <= '1'; 
				Rin <= '1';
			WHEN shr3 =>
				Grb <= '1';
				Rout <= '1'; 
				Yin <= '1';
			WHEN shr4 =>
				Grc <= '1';
				Rout <= '1'; 
				SHR <= '1'; 
				Zin <= '1';
			WHEN shr5 =>
				Zlowout <= '1'; 
				Rin <= '1';	
				Gra <= '1';	
			WHEN shl3 =>
				Grb <= '1';
				Rout <= '1'; 
				Yin <= '1';
			WHEN shl4 => 
				Grc <= '1';
				Rout <= '1'; 
				SHL <= '1'; 
				Zin <= '1';
			WHEN shl5 =>
				Zlowout <= '1'; 
				Rin <= '1'; 
				Gra <= '1';
			WHEN ror3 =>
				Rout <= '1'; 
				Yin <= '1'; 
				Grb <= '1';
			WHEN ror4 => 
				Grc <= '1';
				Rout <= '1'; 
				RORr <= '1'; 
				Zin <= '1';
			WHEN ror5 =>
				Zlowout <= '1'; 
				Rin <= '1'; 
				Gra <= '1';	
			WHEN rol3 => 
				Rout <= '1'; 
				Yin <= '1'; 
				Grb <= '1';
			WHEN rol4 =>
				Grc <= '1';
				Rout <= '1'; 
				ROLl <= '1'; 
				Zin <= '1';
			WHEN rol5 =>
				Zlowout <= '1'; 
				Rin <= '1'; 
				Gra <= '1';	
			WHEN or3 =>
				Grb <= '1'; 
				Rout <= '1'; 
				Yin <= '1';
			WHEN or4 =>
				Grc <= '1'; 
				Rout <= '1'; 
				ORr <= '1'; 
				Zin <= '1';
			WHEN or5 =>
				Zlowout <= '1'; 
				Gra <= '1'; 
				Rin <= '1'; 
			WHEN and3 =>
				Grb <= '1'; 
				Rout <= '1'; 
				Yin <= '1';
			WHEN and4 =>
				Grc <= '1'; 
				Rout <= '1'; 
				ANDd <= '1'; 
				Zin <= '1'; 
			WHEN and5 =>
				Zlowout <= '1'; 
				Gra <= '1'; 
				Rin <= '1'; 
			WHEN multiply3 =>
				Rout <= '1'; 
				Yin <= '1'; 
				Grb <= '1';
			WHEN multiply4 => 
				Rout <= '1';
				Gra <= '1'; 
				MUL <= '1'; 
				Zin <= '1';
			WHEN multiply5 =>
				Zlowout <= '1'; 
				LOin <= '1';
			WHEN multiply6 => 
				ZHighout <= '1'; 
				HIin <= '1';
			WHEN divide3 =>
				Rout <= '1'; 
				Yin <= '1'; 
				Gra <= '1';
			WHEN divide4 =>
				Grb <= '1';
				Rout <= '1'; 	
				DIV <= '1'; 
				Zin <= '1';
			WHEN divide5 =>
				Zlowout <= '1'; 
				LOin <= '1';
			WHEN divide6 => 
				ZHighout <= '1'; 
				HIin <= '1';
			WHEN mfhi3 => 
				HIout <= '1'; 
				GRa <= '1'; 
				Rin <= '1';	
			When mflo3 =>
				LOout <= '1'; 
				GRa <= '1'; 
				Rin <= '1';
			WHEN jal3 =>
				PCout <='1';
			WHEN jal4 =>
				PCout <='1';
				Grb <= '1'; 
				Rin <= '1';
			WHEN jal5 =>
				Gra <= '1'; 
				Rout <= '1'; 
				PCin <= '1';	
			WHEN jr3 =>
				Gra <= '1'; 
				Rout <= '1'; 
				PCin <= '1';
			WHEN out3 =>
				Gra <= '1';
				Rout <= '1'; 
				Out_Portin <= '1';
			WHEN in3 =>
				In_port_strobe <= '1';
			WHEN in4 =>	
				In_Portout <= '1';
				Gra <= '1';
				Rin <= '1';
			WHEN brzr3 =>
				Gra <= '1';
				Rout <= '1';
				CONin <= '1';
			WHEN brzr4 =>
				Grb <= '1';
				Rout <= '1';
				PCin <= CON_FF;
			WHEN brnz3 =>
				Gra <= '1';
				Rout <= '1';
				CONin <= '1';
			WHEN brnz4 =>
				Grb <= '1';
				Rout <= '1';
				PCin <= CON_FF;
			when nop =>
			when halt =>
				runOut <= '0';  --When halt set the run indicator to zero
			when others =>
				
		end case;
	end process;
end architecture;
								