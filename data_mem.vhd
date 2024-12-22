----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    15:47:42 12/19/2024
-- Design Name: 
-- Module Name:    DATA_MEM - Behavioral 
-- Project Name: Pipeline processor 
-- Target Devices: 
-- Tool versions: 
-- Description:    Simple Data Memory with read and write functionality.
--
-- Dependencies: 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Use only NUMERIC_STD for arithmetic

entity DATA_MEM IS
	PORT (
		address   : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		writeData : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		clk       : IN STD_LOGIC;
		memRead   : IN STD_LOGIC;
		memWrite  : IN STD_LOGIC;
		readData  : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END DATA_MEM;

ARCHITECTURE Behavioral OF DATA_MEM IS
	TYPE RAM_16_x_32 IS ARRAY(0 TO 15) OF std_logic_vector(31 DOWNTO 0);
	SIGNAL DM : RAM_16_x_32 := (
		x"00000003", -- Memory initialized to zero
		x"00000002", x"00000000", x"00000000",
		x"00000007", x"00000008", x"00000000", x"00000000",
		x"00000000", x"00000000", x"00000000", x"00000000",
		x"00000000", x"00000000", x"00000000", x"00000000"
	);
	CONSTANT BASE_ADDRESS : INTEGER := 268500992; -- Base address: 0x10010000
BEGIN
	PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			-- Memory Write Operation
			IF (memWrite = '1') THEN
				DM((to_integer(unsigned(address)) - BASE_ADDRESS) ) <= writeData;
			END IF;
		END IF;
		
		-- Memory Read Operation (Combinational)
		IF (memRead = '1') THEN
			readData <= DM((to_integer(unsigned(address)) - BASE_ADDRESS));
		ELSE
			readData <= (others => '0'); -- Default output if memRead is low
		END IF;
	END PROCESS;
END Behavioral;
