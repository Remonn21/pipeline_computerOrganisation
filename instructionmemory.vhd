library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Only use NUMERIC_STD for handling unsigned and signed types

entity instructionmemory is
    Port (
        readAddress : in  STD_LOGIC_VECTOR (31 downto 0); -- Input address for instruction fetch
        instruction : out STD_LOGIC_VECTOR (31 downto 0)  -- Output instruction
    );
end instructionmemory;

architecture Behavioral of instructionmemory is
    -- Define a simple 16 x 32-bit RAM array to hold instructions
    TYPE RAM_16_x_32 IS ARRAY(0 TO 255) OF std_logic_vector(31 DOWNTO 0);
    
    -- Initialize the instruction memory with sample instructions
    SIGNAL IM : RAM_16_x_32 := (
	x"8CE20005", -- 0x0000 0014: LW REG(2) 5(R7)
    x"01024824", -- 0x0000 0000: and 	reg(9), reg(8), reg(2) (and reg8, reg7 -> reg9)	
	x"12110003", -- 0x0000 0014: branch equal reg(16), reg(17), $L1 (branch equal reg16, reg17 -> $L1)
	x"01285024", -- 0x0000 0018: and 	reg(10), reg(9), reg(8) (and reg9, reg8 -> reg10)  
    x"01896825", -- 0x0000 0004: or  	reg(13), reg(12), reg(9) (or reg12, reg9 -> reg13) 
	x"01285024", -- 0x0000 0018: and 	reg(10), reg(9), reg(8) (and reg9, reg8 -> reg10) 
    x"01285020", -- 0x0000 0008: add 	reg(10), reg(9), reg(8) (add reg9, reg8 -> reg10) 
	x"0800000B", -- $L1 0x0000 002C: jump to address 0x00000000 (jump to address 0x00400000)
    x"01285022", --  0x0000 000C: sub 	reg(13), reg(9), reg(8) (sub reg9, reg8 -> reg13) 
    x"0149402a", -- 0x0000 0010: slt 	reg(8), reg(10), reg(9) (slt reg10, reg9 -> reg8)
    x"01285024", -- 0x0000 0018: and 	reg(10), reg(9), reg(8) (and reg9, reg8 -> reg10)
    x"018b6825", -- 0x0000 001C: or  	reg(13), reg(12), reg(11) (or reg12, reg11 -> reg13)
    others =>   x"00000000" -- Padding
   );

begin
    -- Instruction fetch process
    process(readAddress)
    begin
        -- The read address is mapped to the correct instruction in memory
        -- Convert the address to an integer, subtract base address, and divide by 4 to get the word index
        -- This assumes word addressing (4 bytes per instruction)
        instruction <= IM(to_integer(unsigned(readAddress)) / 4);  -- Fetch the instruction from memory
    end process;

end Behavioral;
