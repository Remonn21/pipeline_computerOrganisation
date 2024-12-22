----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    13:16:50 12/19/2024
-- Design Name: 
-- Module Name:    MUX_32 - Behavioral 
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

entity MUX_32 is
    Port ( MUX_IN1 : in  STD_LOGIC_VECTOR (31 downto 0);
           MUX_IN2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC;
           MUX_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_32;

architecture Behavioral of MUX_32 is

begin
MUX_OUT <= MUX_IN1 WHEN SEL ='0' else
         MUX_IN2 ; 
			 
END Behavioral;
