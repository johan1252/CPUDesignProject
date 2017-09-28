Library IEEE;
use IEEE.std_logic_1164.all;

entity nonRestor_division is
port(
		mIn, qIn : in std_logic_vector(31 downto 0);
		qoutient : out std_logic_vector(31 downto 0)
);
end entity;

architecture behaviour of nonRestor_division is
signal A : std_logic_vector(32 downto 0);
signal Q : std_logic_vector(31 downto 0);
signal Qshift : std_logic_vector(31 downto 0);
signal M : std_logic_vector(32 downto 0);


begin

A <= (others => '0');
M <= mIn;
Q <= qIn;

for i in 0 to 31 loop
	A <= Q(31 downto (31-i));
	if(A(32) = '0') then
		A <= A - M;
		Q(0) <= '1';
	else
		A <= A + M;
		Q(1) <= '0';
	end if;
		
end loop;	

end architecture; 