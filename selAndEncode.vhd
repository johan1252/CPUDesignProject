library ieee; 
use ieee.std_logic_1164.all; 

entity selAndEncode is 
	port( 
		Gra, Grb, Grc, Rin, Rout, BAout : in std_logic;
		IRout : in std_logic_vector(31 downto 0); 
		R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in : out std_LOGIC;
		R9in, R10in, R11in, R12in, R13in, R14in, R15in : out std_LOGIC;
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out : out std_LOGIC;
		R9out, R10out, R11out, R12out, R13out, R14out, R15out  : out std_LOGIC;
		CSignExtend : out std_logic_vector(31 downto 0)
	);
end entity;
 
architecture behaviour of selAndEncode is 

signal enable : std_logic; 
signal test,test2 :std_LOGIC;
signal graOut,grbOut, grcOut, grOR: std_logic_vector( 3 downto 0); 
signal decodeOut : std_logic_vector(15 downto 0);
signal tempIROut : std_logic_vector(31 downto 0); 
signal tempCOut2 : std_logic_vector(31 downto 0); 

component decoder4to16 is 
port( E : in std_logic; 
		A : in std_logic_vector(3 downto 0); 
		D    : out std_logic_vector(15 downto 0)
 );
end component;

begin
decoder: decoder4to16 port map(E => enable, A => grOr, D => decodeOut); 

PR: process(IRout, Gra, Grb, Grc, graOut, grbOut, decodeOut, Rin, GrcOut, Rout, BAout, tempIROut, tempCOut2)	--Sensitivity List is questionable.....  

begin

GRAnd: for i in 0 to 3 loop
graOut(i) <= Gra and IRout(23+i);
grbOut(i) <= Grb and IRout(19+i);
grcOut(i) <= Grc and IRout(15+i);
end loop;

grOr <= graOut OR grbOut OR grcOut; 
enable <= '1';
tempIROut <= IROut;


if(tempIROut(18) = '1') then 
tempCout2 <= (others => '1');
tempCout2(17 downto 0) <= IROut(17 downto 0); 
else  
tempCout2 <= (others => '0');
tempCout2(17 downto 0) <= IROut(17 downto 0); 
end if;
CsignExtend <= tempCout2;


R0in <= decodeOut(0) AND Rin; 
R1in <= decodeOut(1) AND Rin; 
R2in <= decodeOut(2) AND Rin; 
R3in <= decodeOut(3) AND Rin; 
R4in <= decodeOut(4) AND Rin; 
R5in <= decodeOut(5) AND Rin; 
R6in <= decodeOut(6) AND Rin; 
R7in <= decodeOut(7) AND Rin; 
R8in <= decodeOut(8) AND Rin; 
R9in <= decodeOut(9) AND Rin; 
R10in <= decodeOut(10) AND Rin; 
R11in <= decodeOut(11) AND Rin; 
R12in <= decodeOut(12) AND Rin; 
R13in <= decodeOut(13) AND Rin; 
R14in <= decodeOut(14) AND Rin; 
R15in <= decodeOut(15) AND Rin;


R0out <= decodeOut(0) AND (Rout OR BAout);
R1out <= decodeOut(1) AND (Rout OR BAout);
R2out <= decodeOut(2) AND (Rout OR BAout);
R3out <= decodeOut(3) AND (Rout OR BAout);
R4out <= decodeOut(4) AND (Rout OR BAout);
R5out <= decodeOut(5) AND (Rout OR BAout);
R6out <= decodeOut(6) AND (Rout OR BAout);
R7out <= decodeOut(7) AND (Rout OR BAout);
R8out <= decodeOut(8) AND (Rout OR BAout);
R9out <= decodeOut(9) AND (Rout OR BAout);
R10out <= decodeOut(10) AND (Rout OR BAout);
R11out <= decodeOut(11) AND (Rout OR BAout);
R12out <= decodeOut(12) AND (Rout OR BAout);
R13out <= decodeOut(13) AND (Rout OR BAout);
R14out <= decodeOut(14) AND (Rout OR BAout);
R15out <= decodeOut(15) AND (Rout OR BAout);

end process; 
end architecture; 