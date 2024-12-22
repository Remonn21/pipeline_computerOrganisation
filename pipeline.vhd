----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Remon Ehab - Ibrahim amin - Ibrahim mousa - Hazem mohamed - adham ashraf - Basel Ahmed
-- 
-- Create Date:    12:44:12 12/19/2024
-- Design Name: 
-- Module Name:    PIPELINE - Behavioral 
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

entity PIPELINE is
    Port ( CLK : in  STD_LOGIC );
end PIPELINE;

architecture Behavioral of PIPELINE is

--------------------pc---------------------------------------------------------------------------------------------------------------------------------------------
component  PC is
    Port ( PC_N : in  STD_LOGIC_VECTOR (31 downto 0); -- load add
           CLK : in  STD_LOGIC;
           PC_OUT : out  STD_LOGIC_VECTOR (31 downto 0);  -- fetched  add
			   FLUSH : in  STD_LOGIC );
end component;

----------------------alu control-----------------------------------------------------------------------------------------------------------------------------
component ALU_CONTROL_UNIT is
    Port ( ALU_OP : in  STD_LOGIC_VECTOR (1 downto 0);
	        ALU_FUNCT : in  STD_LOGIC_VECTOR (5 downto 0);
	        ALU_CONTROL : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

-----------------alu----------------------------------------------------------------------------------------------------------------------------------------
component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_CONTROL : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_RESULT : out  STD_LOGIC_VECTOR (31 downto 0);
           ZERO_FLAG : out  STD_LOGIC;
           OVERFLOW_FLAG : out STD_LOGIC);
end component;

--------------------data memory------------------------------------------------------------------------------------------------------------------------------
 component DATA_MEM IS
	PORT (
		address   : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		writeData : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		clk       : IN STD_LOGIC;
		memRead   : IN STD_LOGIC;
		memWrite  : IN STD_LOGIC;
		readData  : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);			
end component;

-----------------instruction memory--------------------------------------------------------------------------------------------------------------------------------
component instructionmemory is
    PORT (
        readAddress : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
        instruction : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
end component ;

-----------------------mux 32 BIT-----------------------------------------------------------------------------------------------------------------------------------
component MUX_32 is
    Port ( MUX_IN1 : in  STD_LOGIC_VECTOR (31 downto 0);
           MUX_IN2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC;
           MUX_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--------------------------mux 5 bit--------------------------------------------------------------------------------------------------------------------------
component RD_RT_MUX is
    Port ( RT : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
			  X : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (4 downto 0)
           );
end component;

--------------------------control unit--------------------------------------------------------------------------------------------------------------------------
component MAIN_CONTROL_UNIT is
    Port ( OP_CODE : in  STD_LOGIC_VECTOR (5 downto 0);
           BRANCH : out  STD_LOGIC;
           MEM_READ : out  STD_LOGIC;
           MEM_TO_REG : out  STD_LOGIC;
           MEM_WRITE : out  STD_LOGIC;
           ALU_SRC : out  STD_LOGIC;
           REG_WRITE : out  STD_LOGIC;
           REG_DES : out  STD_LOGIC;
           JUMP : out  STD_LOGIC;
           ALU_OP : out  STD_LOGIC_VECTOR (1 downto 0));
end component;
---------------------adder------------------------------------------------------------------------------------------------------------------------------------
component PC_ADDER is    ------CALCULATING PC+4
    Port ( INPUT1: in  STD_LOGIC_VECTOR (31 downto 0);
           INPUT2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ADD_OUT : out  STD_LOGIC_VECTOR (31 downto 0));

end component;	
---------------------branch adder------------------------------------------------------------------------------------------------------------------------------------
component BRANCH_CHECKK is    ------CALCULATING PC+4
    Port ( Operand1  : in   STD_LOGIC_VECTOR(31 downto 0);
           Operand2  : in   STD_LOGIC_VECTOR(31 downto 0);
           zero_branch  : out   STD_LOGIC);

end component;

-------------------------jump shift left-------------------------------------------------------------------------------------------------------------------------
component JUMP_SH is
    Port ( INPUT : in  STD_LOGIC_VECTOR (25 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

---------------------branch shift left---------------------------------------------------------------------------------------------------------------------------
component SHIFT is
    Port ( INPUT : in  STD_LOGIC_VECTOR (31 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

-----------------sign extend------------------------------------------------------------------------------------------------------------------------------------
component SIGN_EXTEND is
    Port ( INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

-------------------------register file-----------------------------------------------------------------------------------------------------------------------
component REG_FILE is
    Port ( READ_ADD1 : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address of the first register
           READ_ADD2 : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address of the second register
           WRITE_ADD : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address of the register to write
           WRITE_DATA : in  STD_LOGIC_VECTOR (31 downto 0); -- Data to write
           REG_WRITE_S : in  STD_LOGIC; -- Register write signal
           CLK : in  STD_LOGIC; -- Clock signal
           DATA1 : out  STD_LOGIC_VECTOR (31 downto 0); -- Data read from the first register
           DATA2 : out  STD_LOGIC_VECTOR (31 downto 0)  -- Data read from the second register
    );
end component;

-------------------------if/id state reg-----------------------------------------------------------------------------------------------------------------------
component F_ID_REG is
    Port ( INSTRUCT : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           BRANCH : in  STD_LOGIC_VECTOR (31 downto 0);
			  INSTRUCT_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
			  PC_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC;
           STALL : in  STD_LOGIC;
           FLUSH : in  STD_LOGIC
           
           );
end component;

-------------------------id/ex state reg----------------------------------------------------------------------------------------------------------------------
component ID_EX_REG is
    Port ( BRANCH : in  STD_LOGIC;
           REG1 : in  STD_LOGIC_VECTOR (31 downto 0);
           REG2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SIGN_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RT : in  STD_LOGIC_VECTOR (4 downto 0);
           RS : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           INSTRUCT : in  STD_LOGIC_VECTOR (5 downto 0);
           EX_S_IN : in  STD_LOGIC_VECTOR (3 downto 0);
           MEM_S_IN : in  STD_LOGIC_VECTOR (1 downto 0);
           WB_S_IN : in  STD_LOGIC_VECTOR (1 downto 0);
           BRANCH_OUT : out  STD_LOGIC;
           REG1_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           REG2_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           SIGN_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           PC_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           RT_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
           RS_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
           RD_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
           INSTRUCT_OUT : out  STD_LOGIC_VECTOR (5 downto 0);
           EX_S_OUT : out  STD_LOGIC_VECTOR (3 downto 0);
           MEM_S_OUT : out  STD_LOGIC_VECTOR (1 downto 0);
           WB_S_OUT : out  STD_LOGIC_VECTOR (1 downto 0);
           CLK : in  STD_LOGIC);
	 
end component;

-------------------------ex_mem_reg ----------------------------------------------------------------------------------------------------------------------------
component EX_MEM_REG is
    Port ( IN_TO_REG : in  STD_LOGIC_VECTOR (72 downto 0);   --- 32 ALU  --32 MUX --4 WB /MEM SIGNAL --5 BIT MUS RS/RT =73
           OUT_FROM_REG : out  STD_LOGIC_VECTOR (72 downto 0);
           CLK : in  STD_LOGIC);
end component;

-------------------------mem_wb_reg --------------------------------------------------------------------------------------------------------------------------
component WB is
    Port ( MEM_WB_IN : in  STD_LOGIC_VECTOR (70 downto 0);  --- 2 WB   32 ALU  32DATA MEM  5 MUX RT/RS
           MEM_WB_OUT : out  STD_LOGIC_VECTOR (70 downto 0);
           CLK : in  STD_LOGIC);
end component;

-------------------------hazzard unit-------------------------------------------------------------------------------------------------------------------------------
component HAZZARD_UNIT is
    Port ( MEM_READ : in  STD_LOGIC;
           IDEX_RT : in  STD_LOGIC_VECTOR (4 downto 0);
           FID_RS : in  STD_LOGIC_VECTOR (4 downto 0);
           FID_RT : in  STD_LOGIC_VECTOR (4 downto 0);	   
		   JUMP_D: in STD_LOGIC;
		   BRANCH_D: in STD_LOGIC;	 
		   ZERO_BRANCH: in STD_LOGIC;
           PC_FLUSH : out  STD_LOGIC; 
		   FID_STALL: out STD_LOGIC;
           FID_FLUSH : out  STD_LOGIC;
           MUX_FLUX : out  STD_LOGIC);
end component;


-------------------------ForwardingUnit--------------------------------------------------------------------------------------------------------------------------
component FORWARDING_UNIT is
    Port ( EX_MEM_REG_WRITE : in  STD_LOGIC;
           MEM_WB_REG_WRITE : in  STD_LOGIC;
           ID_EX_RS : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_RT : in  STD_LOGIC_VECTOR (4 downto 0);
           EX_MEM_RD : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WB_RD : in  STD_LOGIC_VECTOR (4 downto 0);
           FORWARD_A : out  STD_LOGIC_VECTOR (1 downto 0);
           FORWARD_B : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

-------------------------control_mux------in hazard unit--------------------------------------------------------------------------------------------------------------------
component  MUX_CONTROL_HAZ is
    Port ( CONTROL_IN : in  STD_LOGIC_VECTOR (9 downto 0); --9 SIGNALS  --10bit
           X : in  STD_LOGIC;
           CONTROL_OUT : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

-------------------------forward_mux----------------forward b is the same so we used one-----------------------------------------------------------------------------------------------------------
component FORWARD_A_MUX is
    Port ( IN1 : in  STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
           IN2 : in  STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
           IN3 : in  STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0);
           X : in  STD_LOGIC_VECTOR (1 downto 0));
	
end component;
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
  
  
  
  
-- signals for connections and storing data for components
-------------fetch signals----------------------------------------------------------------------------------------------------------------------------------------
signal pc_loading , pc_F , pc4 , instruction  : std_logic_vector(31 downto 0):=x"00000000";
signal pc_stall  , jump_or_branch , en_pc: std_logic:='0';
signal jump_add ,branch_add ,jump_pos:std_logic_vector(31 downto 0):=x"00000000";

-------------decode signals--------------------------------------------------------------------------------------------------------------------------------------	
--instruction in decode stage 
signal instruction_D , pc_D 	:	std_logic_vector(31 downto 0):=x"00000000";
signal F_D_REG_stall 					: 	std_logic:='1';	  
signal F_D_REG_flush					: 	std_logic:='1';	
signal opcode_D 					:	std_logic_vector(5 downto 0):="000000";
signal rs_D ,rt_D , rd_D 		:  std_logic_vector(4 downto 0):="00000";
signal imm_D 						:  std_logic_vector(15 downto 0):="0000000000000000"; --immediate
signal fun_D 						:	std_logic_vector(5 downto 0):="000000";
signal j_D 							:  std_logic_vector(25 downto 0):="00000000000000000000000000";	 
signal zero_branch                  : std_logic := '0'; -- zero for branch check in decode stage
--control signals
signal Branch_D , MemRead_D , MemtoReg_D , MemWrite_D , AluSrc_D , RegWrite_D , RegDest_D , Jump_D 	   :   STD_LOGIC:='0';
signal AluOp_D    :   STD_LOGIC_VECTOR (1 downto 0):="00";
--control signal 1  
signal control_d : std_logic_vector(9 downto 0):= "0000000000";
signal control_dMux : std_logic_vector(9 downto 0):= "0000000000";


--sign extend
signal sign_extended : std_logic_vector(31 downto 0); -- out of sign 
signal sign_extended_shif : std_logic_vector(31 downto 0):=x"00000000"; -- shift sign 
signal input_of_sign :std_logic_vector(15 downto 0):=x"0000"; -- which is imm

--register file 
signal data1_D , data2_D : std_logic_vector(31 downto 0):= x"00000000";
-------------excute signals---------------------------------------------------------------------------------------------------------------------------------	
signal control_EX : std_logic_vector (9 downto 0):= "0000000000";
signal data1_ex ,data2_ex ,sign_extended_ex , pc_ex: std_logic_vector(31 downto 0):=x"00000000";
signal rs_ex , rt_ex ,rd_ex , Dest_reg_ex: std_logic_vector (4 downto 0):= "00000";

---contro signals
signal Branch_ex, AluSrc_ex , RegDest_ex , MemRead_ex , MemWrite_ex , MemtoReg_ex , RegWrite_ex , Jump_ex , haz_cntrl_flush: std_logic := '0';

  
--forward 
signal forward_A , forward_B : std_logic_vector(1 downto 0):="00"; 
signal mux1_output , mux2_output : std_logic_vector(31 downto 0):=x"00000000";
 
--alu
signal AluOp_ex : std_logic_vector(1 downto 0):= "00";
signal fun_ex : std_logic_vector(5 downto 0):="000000";
signal alu_cntrl : std_logic_vector(3 downto 0):="0000";
signal alu_output ,alu_input_2: std_logic_vector(31 downto 0):=x"00000000";
signal zero_ex : std_logic:='0'; 
signal overflow_ex : std_logic:='0';
signal ex_mem_in : std_logic_vector(72 downto 0):=(others => '0');

-------------mem signals--------------------------------------------------------------	
signal ex_mem_out : std_logic_vector(72 downto 0):=(others => '0');

signal data_memory , data_mem_add  , data_mem_output : std_logic_vector(31 downto 0):= x"00000000"; --
signal dest_reg_mem : std_logic_vector(4 downto 0):= "00000"; 
--control mem-------------------------------------------------------------------------
signal control_mem : std_logic_vector(3 downto 0);
signal MemRead_mem ,MemWrite_mem ,MemtoReg_mem ,RegWrite_mem: std_logic:='0'; 
signal mem_wb_in : std_logic_vector (70 downto 0):=(others =>'0');

-------------write back signals---------------------------------------------------------	
signal mem_wb_out : std_logic_vector (70 downto 0):=(others =>'0');
signal data_WB : std_logic_vector(31 downto 0):= x"00000000";
signal RegWrite_WB ,MemtoReg_WB: std_logic:='0';
signal mem_data_mem , alu_data_mem : std_logic_vector(31 downto 0):=x"00000000";
signal rd_WB : std_logic_vector(4 downto 0):="00000";




begin 


-- fetch stage
en_pc <= (pc_stall);  --prevent from update when 0
pc_component : pc port map(pc_loading , CLK , pc_F , en_pc );
pc_4 : PC_ADDER port map(pc_F,x"00000004",pc4);
pc_mux : mux_32 port map (pc4 , jump_pos , jump_or_branch , pc_loading );

jump_or_branch <= jump_D or (Branch_D and zero_branch);     --merge two mux for src of pc 
jump_pos <= branch_add when (branch_D and zero_branch) = '1' else
           jump_add when jump_D = '1' ;

ins: instructionmemory port map ( pc_F , instruction );
F_D_REG : F_ID_REG port map ( instruction , pc4 , x"00000000" , instruction_D , pc_D ,CLK , F_D_REG_stall , F_D_REG_flush );
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

-- decode stage-------------dividing instruction 
opcode_D <= instruction_D(31 downto 26);
rs_D		<=	instruction_D(25 downto 21);
rt_D		<= instruction_D(20 downto 16);
rd_D		<= instruction_D(15 downto 11);	
fun_D	   <= instruction_D(5 downto 0);	
imm_D		<= instruction_D(15 downto 0);	
j_D		<= instruction_D(25 downto 0);

control_unit : MAIN_CONTROL_UNIT port map ( opcode_D , Branch_D , MemRead_D , MemtoReg_D , MemWrite_D , AluSrc_D , RegWrite_D , RegDest_D , Jump_D , AluOp_D);

register_file : REG_FILE port map ( rs_D , rt_D , rd_WB , data_WB , RegWrite_WB , CLK , data1_D , data2_D );

branch_check : 	BRANCH_CHECKK port map ( data1_D, data2_D, zero_branch);	  -- check if branch or no and get the zero flag

	-- HAZZARD_UNIT
input_of_sign <=	(imm_D) 	when AluOp_D = "00" else   -- lw and sw
						(imm_D)	when Branch_D = '1' else
						x"0000";
						
signex: SIGN_EXTEND port map (input_of_sign,sign_extended);	 

shiftS : SHIFT port map ( sign_extended , sign_extended_shif );  --shift left for branch
branch_adder : PC_ADDER port map(sign_extended_shif , pc4 , branch_add);  -- branch target address 

jump_check:JUMP_SH port map (j_D,pc4,jump_add);  -- jump target address
control_d <= Branch_D & AluOp_D & AluSrc_D & RegDest_D & MemRead_D & MemWrite_D & MemtoReg_D & RegWrite_D & Jump_D; -- 10 bit forming vector to enter mux then id/ex
--				9		   8-7				6				5				4				 3				 2					1			 0
control_muxx :MUX_CONTROL_HAZ port map ( control_d , haz_cntrl_flush ,control_dmux ) ;



hazzard_unitt : HAZZARD_UNIT PORT MAP ( MemRead_EX , rt_ex , rs_D , rt_D , Jump_D  , BRANCH_D, zero_branch , pc_stall, F_D_REG_stall , F_D_REG_flush,  haz_cntrl_flush ) ;


D_X_REG : ID_EX_REG port map (control_dmux(9) , data1_D , data2_D , sign_extended ,   pc_D ,  rs_D , rt_D  , rd_D  , fun_D , control_dmux(8 downto 5) , control_dmux(4 downto 3) , control_dmux(2 downto 1),
										 control_EX(9) , data1_ex , data2_ex , sign_extended_ex ,pc_ex, rs_ex , rt_ex ,rd_ex , fun_ex,  control_EX(8 downto 5) , 	control_EX(4 downto 3 ) , control_EX(2 downto 1) , CLK);

-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

--excute stage	


 --control signals  ex
Branch_ex 	<= control_EX(9);
AluOp_ex 	<= control_EX(8 downto 7); -- 2 bit 
AluSrc_ex	<= control_EX(6);
RegDest_ex 	<= control_EX(5);
MemRead_ex 	<= control_EX(4);
MemWrite_ex <= control_EX(3);
MemtoReg_ex <= control_EX(2);
RegWrite_ex <= control_EX(1);
Jump_ex 		<= control_EX(0);


--muxes--forward unit-- alu 
rd_rt_muxxx :RD_RT_MUX port map( rt_ex ,rd_ex , RegDest_ex , Dest_reg_ex ); -- determine dest reg

forward: FORWARDING_UNIT port map(RegWrite_mem , RegWrite_wb , rs_ex , rt_ex , Dest_reg_mem , rd_wb , forward_A , forward_B);
forward_mux_1 : FORWARD_A_MUX port map (data1_ex , data_WB , data_mem_add , mux1_output , forward_A);
forward_mux_2 : FORWARD_A_MUX port map (data2_ex , data_WB , data_mem_add , mux2_output , forward_B);

alu_src_mux : mux_32 port map ( mux2_output , sign_extended_ex , AluSrc_ex, alu_input_2 );  --after choosing from forward mux check alu scr between sign extend or mux output
aluControl : ALU_CONTROL_UNIT port map (AluOp_ex , fun_ex , alu_cntrl); 
aluComponent : ALU port map( mux1_output , alu_input_2 , alu_cntrl , alu_output, zero_ex , overflow_ex);

ex_mem_in <=control_EX(4 downto 1) & alu_output & mux2_output & Dest_reg_ex;    --- 32 ALU  --32 MUX --4 WB /MEM SIGNAL --5 BIT MUS RS/RT =73  
X_MEM_REG : ex_mem_reg port map(ex_mem_in , ex_mem_out , CLK);

-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

--mem stage 
 control_mem 	<= ex_mem_out(72 downto 69);
 data_mem_add	<= ex_mem_out(68 downto 37);
 data_memory   <= ex_mem_out(36 downto 5);
 dest_reg_mem	<= ex_mem_out(4 downto 0);

--control signals needed
MemRead_mem  <= control_mem(3);
MemWrite_mem <= control_mem(2);
MemtoReg_mem <= control_mem(1);
RegWrite_mem <= control_mem(0);

data_memm : DATA_MEM port map ( data_mem_add , data_memory , CLK ,MemRead_mem , MemWrite_mem , data_mem_output);
mem_wb_in <= MemtoReg_mem & RegWrite_mem & data_mem_output & data_mem_add & dest_reg_mem ;  --- 2 WB   32 ALU  32DATA from MEM  5 MUX RT/RS --preparing input for wb reg
MEM_WB_REG :WB port map (mem_wb_in , mem_wb_out , CLK ) ;

-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

-- WB stage
MemtoReg_WB <= mem_wb_out(70);
RegWrite_WB <= mem_wb_out(69);
mem_data_mem <= mem_wb_out(68 downto 37);
alu_data_mem <= mem_wb_out(36 downto 5);
rd_WB <= mem_wb_out(4 downto 0);
write_back_mux : mux_32 port map(alu_data_mem , mem_data_mem , MemtoReg_WB , data_WB);



end Behavioral;