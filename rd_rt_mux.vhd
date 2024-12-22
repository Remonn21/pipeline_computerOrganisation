----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    15:07:52 12/19/2024
-- Design Name: 
-- Module Name:    RD_RT_MUX - Behavioral 
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

entity RD_RT_MUX is
    Port ( RT : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
			  X : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (4 downto 0)
           );
end RD_RT_MUX;

architecture Behavioral of RD_RT_MUX is

begin

OUTPUT <= RT WHEN X ='0' ELSE 
            RD; 
end Behavioral;

