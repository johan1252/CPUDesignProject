library ieee; 
use ieee.std_logic_1164.all; 

entity ConFF is 
	port( BusMuxOut : in std_logic_vector(31 downto 0);
			IRout : in std_logic_vector(31 downto 0);
			CONin : in std_LOGIC;
			Control : out std_logic
	);
end entity;
 
architecture behaviour of ConFF is 

component Decoder2to4
PORT(
		data		: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		eq0		: OUT STD_LOGIC ;
		eq1		: OUT STD_LOGIC ;
		eq2		: OUT STD_LOGIC ;
		eq3		: OUT STD_LOGIC 
	);
END component Decoder2to4;

signal decOut0, decOut1, decOut2, decOut3, Noroutput, andOuteq0, andOutnoteq0, andOutgret0, andOutless0  : std_LOGIC;
signal ORout : std_LOGIC;
signal Norout : std_LOGIC_VECTOR(31 downto 0);

begin

decoder : Decoder2to4
port map(
		data => IRout(1 downto 0),
		eq0 => decOut0,
		eq1 => decOut1,
		eq2 => decOut2,
		eq3 => decOut3
);


process(busMuxOut, decOut0, decOut1, noroutput, decOut2, decOut3, andOuteq0, andOutgret0, andOutless0, andOutnoteq0, Conin, Orout)
		begin 	
		noroutput <= not(BusMuxOut(0) or BusMuxOut(1) or BusMuxOut(2) or BusMuxOut(3) or BusMuxOut(4) or BusMuxOut(5) or BusMuxOut(6) or BusMuxOut(7) 
		or BusMuxOut(8) or BusMuxOut(9) or BusMuxOut(10) or BusMuxOut(11) or BusMuxOut(12) or BusMuxOut(13) or BusMuxOut(14) or BusMuxOut(15) 
		or BusMuxOut(16) or BusMuxOut(17) or BusMuxOut(18) or BusMuxOut(19) or BusMuxOut(20) or BusMuxOut(21) or BusMuxOut(22) or BusMuxOut(23) 
		or BusMuxOut(24) or BusMuxOut(25) or BusMuxOut(26) or BusMuxOut(27) or BusMuxOut(28) or BusMuxOut(29) or BusMuxOut(30) or BusMuxOut(31));
		
		andOuteq0 <= decOut0 and noroutput;
		andOutnoteq0 <= decOut1 and (not noroutput);
		andOutgret0 <= decOut2 and (not busMuxOut(31));
		andOutless0 <= decOut3 and busMuxOut(31);

		ORout <= andOuteq0 or andOutnoteq0 or andOutgret0 or andOutless0;

		if CONin = '1' then 
			Control <= ORout; 
		else
			Control <= '0';
		end if; 
end process;		
end architecture; 