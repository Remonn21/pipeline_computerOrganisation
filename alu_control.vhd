----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    22:49:03 12/18/2024
-- Design Name: 
-- Module Name:    ALU_CONTROL_UNIT - Behavioral 
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

entity ALU_CONTROL_UNIT is
    Port ( ALU_OP : in  STD_LOGIC_VECTOR (1 downto 0);
	        ALU_FUNCT : in  STD_LOGIC_VECTOR (5 downto 0);
	        ALU_CONTROL : out  STD_LOGIC_VECTOR (3 downto 0));
           
end ALU_CONTROL_UNIT;

architecture Behavioral of ALU_CONTROL_UNIT is
begin
process(ALU_OP, ALU_FUNCT)
begin

if(ALU_OP="00")then               --ADD FOR load/store 
	ALU_CONTROL<="0010";
	
elsif(ALU_OP="01")then            --SUB FOR  Beq
	ALU_CONTROL<="0110";
	  
elsif(ALU_OP="10")then   -- R-TYPE LOOK AT FUNCT
	if(ALU_FUNCT="100000")then	      --add
		ALU_CONTROL<="0010";
	elsif(ALU_FUNCT="100010")then   	--sub
		ALU_CONTROL<="0110";
	elsif(ALU_FUNCT="100100")then 	--and
		ALU_CONTROL<="0000";
	elsif(ALU_FUNCT="100101")then	   --or
		ALU_CONTROL<="0001";
	elsif(ALU_FUNCT="101010")then	   --slt
		ALU_CONTROL<="0111";
	else
		ALU_CONTROL<="1111";
	end if;


end if;
end process;

end Behavioral;

