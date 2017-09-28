LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 

-- entity declaration only; no definition here
ENTITY mem_tb IS



	END entity;
	
	-- Architecture of the testbench with the signal names
ARCHITECTURE behaviour OF mem_tb IS 

component memory
port(
		address: in unsigned(31 downto 0);
		write_data: in std_logic_vector(31 downto 0);
		MemWrite, MemRead: in std_logic; 
		read_data: out std_logic_vector(31 downto 0)
);
end component memory;


signal address_tb : unsigned(31 downto 0);
signal write_data_tb : std_logic_vector(31 downto 0);
signal MemWrite_tb, MemRead_tb : std_logic;
signal read_data_tb : std_logic_vector(31 downto 0);


BEGIN



mem : memory
port map(
	address => address_tb,
	write_data => write_data_tb,
	MemWrite => MemWrite_tb,
	MemRead => MemRead_tb,
	read_data => read_data_tb
);

process
begin
--	MemRead_tb <= '0';
--	address_tb <= "00000000000000000000000000000001"; 
--	write_data_tb <= x"FF1FF2FD";
--	MemWrite_tb <= '1';
--	wait for 20 ns;
--	MemWrite_tb <= '0';
--	address_tb <= "00000000000000000000000000000001";  
--	MemRead_tb <= '1';
--	wait for 20 ns;
--	address_tb <= "00000000000000000000000000000011";  
--	MemRead_tb <= '1';
--	wait for 20 ns;
--	MemRead_tb <= '0';
--	address_tb <= "00000000000000000000000000001001"; 
--	write_data_tb <= x"FF1DD2FD";
--	MemWrite_tb <= '1';
--	wait for 20 ns;
--	MemWrite_tb <= '0';
--	address_tb <= "00000000000000000000000000001001";  
--	MemRead_tb <= '1';
--	wait for 20 ns;
	MemWrite_tb <= '0';
	address_tb <= "00000000000000000000000000000001";  
	MemRead_tb <= '1';
	wait for 20 ns;
end process;
END ARCHITECTURE;

