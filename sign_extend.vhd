----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    22:13:45 12/19/2024
-- Design Name: 
-- Module Name:    SIGN_EXTEND - Behavioral 
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

entity SIGN_EXTEND is
    Port ( INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end SIGN_EXTEND;

architecture Behavioral of SIGN_EXTEND is
begin
process(INPUT)
begin
  if INPUT(15) = '0' then
     OUTPUT <= "0000000000000000" & INPUT;  -- Sign-extend with 0s for positive numbers
  else
     OUTPUT <= "1111111111111111" & INPUT;  -- Sign-extend with 1s for negative numbers
  end if;
end process;
end Behavioral;









































