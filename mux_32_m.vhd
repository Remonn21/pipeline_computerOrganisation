----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    16:00:07 12/19/2024
-- Design Name: 
-- Module Name:    MUX_32_M - Behavioral 
-- Project Name: Pipeline processor 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--   A 32-bit multiplexer that selects between two inputs based on a condition.
-- Dependencies: 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX_32_M is
    Port ( 
        MUX_IN1 : in  STD_LOGIC_VECTOR (31 downto 0);
        IN2     : in  STD_LOGIC_VECTOR (31 downto 0);
        OUTPUT  : out STD_LOGIC_VECTOR (31 downto 0); -- OUTPUT is now 32-bit
        X       : in  STD_LOGIC_VECTOR (31 downto 0)
    );
end MUX_32_M;

architecture Behavioral of MUX_32_M is
begin
    -- Condition to check if X is zero (32-bit all zeros)
    OUTPUT <= MUX_IN1 when X = x"00000000" else
              IN2;

end Behavioral;
