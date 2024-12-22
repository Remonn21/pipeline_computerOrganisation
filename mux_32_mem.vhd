----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    15:35:59 12/19/2024
-- Design Name: 
-- Module Name:    MUX_32_MEM - Behavioral 
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

entity MUX_32_MEM is
    Port ( IN1 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN2 : in  STD_LOGIC_VECTOR (31 downto 0);
           X : in  STD_LOGIC;
           OUTPUT : OUT  STD_LOGIC_VECTOR (31 downto 0));
end MUX_32_MEM;

architecture Behavioral of MUX_32_MEM is

begin
OUTPUT <= IN1 WHEN X ='0' else
          IN2 ; 


end Behavioral;

