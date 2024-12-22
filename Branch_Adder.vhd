----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- Create Date:    06:40:54 12/18/2019 
-- Design Name: 
-- Module Name:    Branch_Adder - Behavioral 
-- Project Name: Pipeline processor 
-- Target Devices: 
-- Tool versions: 
-- Description: 
-- 
-- Dependencies: 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BRANCH_CHECKK is
    Port ( Operand1  : in   STD_LOGIC_VECTOR(31 downto 0);
           Operand2  : in   STD_LOGIC_VECTOR(31 downto 0);
           zero_branch  : out   STD_LOGIC );
end BRANCH_CHECKK;

architecture Behavioral of BRANCH_CHECKK is

signal OutputSig : STD_LOGIC_VECTOR(31 downto 0);

begin

process(Operand1, Operand2)
begin
    OutputSig <= Operand1 - Operand2;  -- Perform subtraction
end process;

-- Check if the result is zero (in hexadecimal format)
zero_branch <= '1' when OutputSig = x"00000000" else '0';

end Behavioral;
