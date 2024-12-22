----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    14:24:04 12/19/2024
-- Design Name: 
-- Module Name:    HAZZARD_UNIT - Behavioral 
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

entity HAZZARD_UNIT is
    Port ( MEM_READ : in  STD_LOGIC;
           IDEX_RT : in  STD_LOGIC_VECTOR (4 downto 0);
           FID_RS : in  STD_LOGIC_VECTOR (4 downto 0);
           FID_RT : in  STD_LOGIC_VECTOR (4 downto 0); 
		   JUMP_D: in STD_LOGIC;
		   BRANCH_D: in STD_LOGIC;	
		   ZERO_BRANCH: in STD_LOGIC;
           PC_FLUSH : out  STD_LOGIC;
           FID_STALL : out  STD_LOGIC;	
		   FID_FLUSH: out STD_LOGIC;
           MUX_FLUX : out  STD_LOGIC);
end HAZZARD_UNIT;

architecture Behavioral of HAZZARD_UNIT is





begin



process ( MEM_READ, IDEX_RT ,  FID_RS , FID_RT)
begin 
-- ID/EX.MemRead and  ((ID/EX.RegisterRt = IF/ID.RegisterRs) or  (ID/EX.RegisterRt = IF/ID.RegisterRt))

if( (MEM_READ='1' )and( (IDEX_RT = FID_RS) or (IDEX_RT =  FID_RT) ) )then 
PC_FLUSH<='0';
FID_STALL<='0';
MUX_FLUX<='0';	   
FID_FLUSH <= '1';
elsif(( (BRANCH_D = '1') and (ZERO_BRANCH = '1') ) or JUMP_D = '1' )  then
	PC_FLUSH<='1';
	FID_STALL<='1';
	MUX_FLUX<='1';		
	FID_FLUSH<= '0';
	
	
else

PC_FLUSH<='1';
FID_STALL<='1';
MUX_FLUX<='1';	
FID_FLUSH <= '1';
end if;


end process;

end Behavioral;



