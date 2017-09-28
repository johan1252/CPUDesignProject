LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- entity declaration only; no definition here
ENTITY random_tb IS
	END;

	-- Architecture of the testbench with the signal names
ARCHITECTURE behaviour OF random_tb IS 


SIGNAL Clock_tb: Std_logic;

component ConFF 
	port( BusMuxOut : in std_logic_vector(31 downto 0);
			IRout : in std_logic_vector(31 downto 0);
			CONin : in std_LOGIC;
			Control : out std_logic;
			temp : out std_LOGIC
	);
end component ConFF;

signal BusMuxOut, IRout : std_logic_vector(31 downto 0);
signal CONin, Control, temp : std_logic;

BEGIN

conlogic : ConFF
port map(
	BusMuxOut => BusMuxOut,
	IRout => IRout,
	CONin => CONin,
	Control => Control,
	temp => temp
);

--clk_process :process
--begin 
--		clock_tb <= '0';
--		wait for 20ns;  --for 0.5 ns signal is '0'.
--		clock_tb <= '1';
--		wait for 10ns;  --for next 0.5 ns signal is '1'.
--end process;

SecondProc : PROCESS -- do the required job in each state
BEGIN
BusMuxOut <= x"00000000";
IRout <= x"00000000";
CONin <= '1';
wait for 5 ns;
BusMuxOut <= x"00000100";
IRout <= x"00000001";
CONin <= '1';
wait for 5 ns;
BusMuxOut <= x"00000000";
IRout <= x"00000002";
CONin <= '1';
wait for 5 ns;				
BusMuxOut <= x"00001000";
IRout <= x"00000003";
CONin <= '1';
wait for 5 ns;	
BusMuxOut <= x"00000010";
IRout <= x"00000000";
CONin <= '1';
wait for 5 ns;
	
END PROCESS;

END ARCHITECTURE;