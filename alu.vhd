----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    22:35:05 12/18/2024
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: Pipeline processor 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_CONTROL : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_RESULT : out  STD_LOGIC_VECTOR (31 downto 0);
           ZERO_FLAG : out  STD_LOGIC;
           OVERFLOW_FLAG : out STD_LOGIC); -- Added overflow flag
end ALU;

architecture Behavioral of ALU is
    Signal result: std_logic_vector(31 downto 0) := x"00000000";
    Signal overflow: std_logic := '0'; -- Signal for overflow detection
begin

process(ALU_CONTROL, A, B)
begin
    overflow <= '0'; -- Default no overflow

    case ALU_CONTROL is
        when "0010" => -- add
            result <= A + B;
            -- Check for signed addition overflow
            if (A(31) = B(31)) and (result(31) /= A(31)) then
                overflow <= '1';
            end if;

        when "0110" => -- sub
            result <= A - B;
            -- Check for signed subtraction overflow
            if (A(31) /= B(31)) and (result(31) /= A(31)) then
                overflow <= '1';
            end if;

        when "0000" => -- and
            result <= A and B;

        when "0001" => -- or
            result <= A or B;

        when "0111" => -- slt
            if (A < B) then
                result <= x"00000001";
            else 
                result <= x"00000000";
            end if;

        when others => 
            result <= x"00000000"; -- fallback if no case matched
    end case;
end process;

ZERO_FLAG <= '1' when result = x"00000000" else '0';
ALU_RESULT <= result;
OVERFLOW_FLAG <= overflow; -- Assign overflow signal to output

end Behavioral;
