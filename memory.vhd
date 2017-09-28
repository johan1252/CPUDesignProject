library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 

entity memory is 
port (
		address: in unsigned(8 downto 0);
		write_data: in std_logic_vector(31 downto 0);
		MemWrite, MemRead: in std_logic; 
		read_data: out std_logic_vector(31 downto 0)
		); 
end entity memory; 

architecture behavioral of memory is 

type mem_array is array(0 to 511) of std_logic_vector(31 downto 0); 
signal firstTime: boolean := false; 

begin
	mem_process: process(address,write_data, MemRead, MemWrite, firstTime) is 
	variable data_mem : mem_array; 
	variable addr: integer; 

	begin 
		if (not firstTime) then 
		for i in 0 to 511 loop 
				data_mem(i) := x"00000000"; 
		end loop;
		data_mem(0) := x"09800087";		-- ldi r3, x87
		data_mem(1) := x"09980001";		-- ldi r3,1(r3)
		data_mem(2) := x"01000066";		-- ld r2,0x66
		data_mem(3) := x"0917FFFF";	-- ldi r2,-1(r2)
		data_mem(4) := x"1B800061";	-- ldr r7, 0x61 
		data_mem(5) := x"2380004E";	-- str x60,r7
		data_mem(6) := x"00900000";	-- ld r1,0(r2)
		data_mem(7) := x"08000001"; 	-- ldi r0,1
		data_mem(8) := x"D8000000";   	-- NOP
		data_mem(9) := x"29918000";   	-- add r3,r2,r3
		data_mem(10) := x"6BB80002"; 	-- addi r7,r7,2 
		data_mem(11) := x"93B80000"; 	-- neg r7,r7
		data_mem(12) := x"9BB80000";  	-- not r7,r7	
		data_mem(13) := x"73B8000F";	-- andi r7,r7,x0F
		data_mem(14) := x"7B880003";	-- ori r7,r1,3
		data_mem(15) := x"49180000";	-- shr r2,r3,r0
		data_mem(16) := x"11000056";	--*st x56, r2 
		data_mem(17) := x"58880000";  	-- ror r1,r1,r0
		data_mem(18) := x"61100000"; 	-- rol r2,r2,r0
		data_mem(19) := x"41180000"; 	-- or r2,r3,r0 
		data_mem(20) := x"38908000"; 	-- and r2,r2,r1
		data_mem(21) := x"1188004C"; 	-- st x4c(r1),r3
		data_mem(86) := x"00000034"; 	-- $34
		data_mem(22) := x"31918000";	-- sub r2,r2,r3
		data_mem(23) := x"50900000"; 	-- shl r1,r2,r0
		data_mem(24) := x"0A000005"; 	-- ldi r4,5
		data_mem(25) := x"0A80001F"; 	-- ldi r5, x1F
		data_mem(102) := x"00000057";  -- value for ld r2, 0x66  $57
		data_mem(26) := x"82A00000"; 	-- mul r5,r4
		data_mem(27) := x"CB800000";  	-- mfhi r7
		data_mem(28) := x"D3000000";  	--*mflo r6
		data_mem(29) := x"8AA00000"; 	-- div r5,r4
		data_mem(117) := x"00000054";  -- value for ldr r7, 0x61
		data_mem(30) := x"0D200000"; 	-- ldi r10,0(r4)
		data_mem(31) := x"0DA80000"; 	--*ldi r11,0(r5)
		data_mem(32) := x"0E300000"; 	--*ldi r12,0(r6)
		data_mem(33) := x"0EB80000"; 	-- ldi r13,0(r7)
		data_mem(34) := x"B6700000";  	--*jal r12 --goes to subroutine A
		
		data_mem(35) := x"BA000000"; --in R4
		data_mem(36) := x"12000090"; --st $90,R4
		data_mem(37) := x"0880002A"; --ldi R1,$2A
		data_mem(38) := x"0900002E"; --ldi R2,$2E
		data_mem(39) := x"09800035"; --ldi R3,$35
		data_mem(40) := x"0B800001"; --ldi R7,1
		data_mem(41) := x"0A800040"; --ldi R5,40
		--loop
		data_mem(42) := x"C2000000"; --out R4
		data_mem(43) := x"0AAFFFFF"; --ldi R5,-1(R5)
		data_mem(44) := x"A2980000"; --brzr R5,R3
		data_mem(45) := x"030000F0"; --ld R6, $F0
		--loop2
		data_mem(46) := x"0B37FFFF"; --ldi R6,-1(R6)
		data_mem(47) := x"D8000000"; --nop
		data_mem(48) := x"A3100001"; --brnz R6,R2
		data_mem(49) := x"4A238000"; --shr R4,R4,R7
		data_mem(50) := x"A2080001"; --brnz R4,R1
		data_mem(51) := x"02000090"; --ld R4,x90
		data_mem(52) := x"A8800000"; --jr R1
		--done
		data_mem(53) := x"0A0000A5"; --ldi R4,$A5
		data_mem(54) := x"C2000000"; --Out R4
		data_mem(55) := x"E0000000";	-- halt
		
		--subroutine A
		data_mem(155) := x"2CD60000"; 	-- *add r9,r10,r12
		data_mem(156) := x"345E8000"; 	-- *sub r8,r11,r13
		data_mem(157) := x"34CC0000"; 	-- sub r9,r9,r8
		data_mem(158) := x"AF000000"; 	-- jr r14
		
		data_mem(240) := x"0000FFFF";		--$0xFFFF
		
			firstTime <= true; 
		else 
			addr := conv_integer(address(8 downto 0)); 
			if MemWrite = '1' then 
				data_mem(addr) := write_data; 
			elsif MemRead = '1' then 
				read_data <= data_mem(addr) after 10 ns;
			end if;
		end if; 
	end process; 
end architecture; 	
		
	