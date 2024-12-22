----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    22:05:47 12/19/2024
-- Design Name: 
-- Module Name:    SHIFT - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SHIFT is
    Port ( INPUT : in  STD_LOGIC_VECTOR (31 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end SHIFT;

architecture Behavioral of SHIFT is

begin
OUTPUT<=INPUT(29 downto 0) & "00";

end Behavioral;

