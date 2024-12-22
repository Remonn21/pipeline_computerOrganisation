----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    15:12:54 12/19/2024
-- Design Name: 
-- Module Name:    FORWARDING_UNIT - Behavioral 
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

entity FORWARDING_UNIT is
    Port ( EX_MEM_REG_WRITE : in  STD_LOGIC;
           MEM_WB_REG_WRITE : in  STD_LOGIC;
           ID_EX_RS : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_RT : in  STD_LOGIC_VECTOR (4 downto 0);
           EX_MEM_RD : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WB_RD : in  STD_LOGIC_VECTOR (4 downto 0);
           FORWARD_A : out  STD_LOGIC_VECTOR (1 downto 0);
           FORWARD_B : out  STD_LOGIC_VECTOR (1 downto 0));
end FORWARDING_UNIT;

architecture Behavioral of FORWARDING_UNIT is


signal FOR_A_TEMP : std_logic_vector(1 downto 0) :="00";
signal FOR_B_TEMP : std_logic_vector(1 downto 0) :="00";
begin

FORWARD_A<=FOR_A_TEMP;
FORWARD_B<=FOR_B_TEMP;
process(EX_MEM_RD,MEM_WB_RD,EX_MEM_REG_WRITE,ID_EX_RS,ID_EX_RT,MEM_WB_REG_WRITE)
begin 

if( (EX_MEM_REG_WRITE='1')and(EX_MEM_RD /= "00000")and (EX_MEM_RD = ID_EX_RS) )then
FOR_A_TEMP<="10";
elsif((MEM_WB_REG_WRITE='1')and(MEM_WB_RD /= "00000")and(MEM_WB_RD = ID_EX_RS) )then
FOR_A_TEMP<="01";
else
FOR_A_TEMP<="00";
end if;

if((EX_MEM_REG_WRITE='1')and(EX_MEM_RD /= "00000")and(EX_MEM_RD = ID_EX_RT) )then
FOR_B_TEMP<="10";
elsif((MEM_WB_REG_WRITE='1')and(MEM_WB_RD /= "00000")and(MEM_WB_RD = ID_EX_RT) )then
FOR_B_TEMP<="01";
else 
FOR_B_TEMP<="00";
end if;

end process;
end Behavioral;