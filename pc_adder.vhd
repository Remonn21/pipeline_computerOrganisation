----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    13:11:25 12/19/2024
-- Design Name: 
-- Module Name:    PC_ADDER - Behavioral 
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

entity PC_ADDER is    ------CALCULATING PC+4
    Port ( INPUT1: in  STD_LOGIC_VECTOR (31 downto 0);
           INPUT2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ADD_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end PC_ADDER;

architecture Behavioral of PC_ADDER is

begin
ADD_OUT<=INPUT1+INPUT2;


end Behavioral;

