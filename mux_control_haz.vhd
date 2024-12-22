----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    14:42:05 12/19/2024
-- Design Name: 
-- Module Name:    MUX_CONTROL_HAZ - Behavioral 
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

entity MUX_CONTROL_HAZ is
    Port ( CONTROL_IN : in  STD_LOGIC_VECTOR (9 downto 0); --9 SIGNALS  --10bit
           X : in  STD_LOGIC;
           CONTROL_OUT : out  STD_LOGIC_VECTOR (9 downto 0));
end MUX_CONTROL_HAZ;

architecture Behavioral of MUX_CONTROL_HAZ is

Signal TEMP : std_logic_vector(9 downto 0):="0000000000";
begin

CONTROL_OUT<=TEMP;
TEMP<= "0000000000" when X ='0' else
		CONTROL_IN;

end Behavioral;

