----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    22:10:57 12/19/2024
-- Design Name: 
-- Module Name:    JUMP_SH - Behavioral 
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

entity JUMP_SH is
    Port ( INPUT : in  STD_LOGIC_VECTOR (25 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end JUMP_SH;

architecture Behavioral of JUMP_SH is

begin

process (INPUT)
begin
   for i in 27 downto 2 loop
	  OUTPUT(i)<=INPUT(i-2);
   end loop;
	OUTPUT(1)<='0';
	OUTPUT(0)<='0';
	OUTPUT(31 downto 28)<=pc(31 downto 28);
end process;

end Behavioral;

