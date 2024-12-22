library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REG_FILE is
    Port ( READ_ADD1   : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address of the first register
           READ_ADD2   : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address of the second register
           WRITE_ADD   : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address of the register to write
           WRITE_DATA  : in  STD_LOGIC_VECTOR (31 downto 0); -- Data to write
           REG_WRITE_S : in  STD_LOGIC; -- Register write signal
           CLK         : in  STD_LOGIC; -- Clock signal
           DATA1       : out  STD_LOGIC_VECTOR (31 downto 0); -- Data read from the first register
           DATA2       : out  STD_LOGIC_VECTOR (31 downto 0)  -- Data read from the second register
    );
end REG_FILE;

architecture Behavioral of REG_FILE is

    -- Define the register array: 32 registers of 32 bits each
    type REG_ARRAY is array (0 to 31) of std_logic_vector(31 downto 0);
    signal REGFILE : REG_ARRAY := (
        X"00000000", -- Register 0
        X"00000005", -- Register 1
        X"00000003", -- Register 2
        X"00000001", -- Register 3
        X"00000001", -- Register 4
        X"00000000", -- Register 5
        X"00000002", -- Register 6
        X"10010000", -- Register 7
        X"00000002", -- Register 8
        X"00000006", -- Register 9
        X"00000006", -- Register 10
        X"00000007", -- Register 11
        others => X"00000000"        
    );

begin

    -- writing to the registers (on rising edge of CLK)
    process(CLK)
    begin
        if rising_edge(CLK) then
            -- write data to register if REG_WRITE_S is active and not writing to register 0
            if REG_WRITE_S = '1' and WRITE_ADD /= "00000" then
                REGFILE(to_integer(unsigned(WRITE_ADD))) <= WRITE_DATA;
            end if;
        end if;
    end process;

  
    DATA1 <= WRITE_DATA when (REG_WRITE_S = '1' and WRITE_ADD = READ_ADD1 and WRITE_ADD /= "00000") 
            else REGFILE(to_integer(unsigned(READ_ADD1)));
    
    DATA2 <= WRITE_DATA when (REG_WRITE_S = '1' and WRITE_ADD = READ_ADD2 and WRITE_ADD /= "00000") 
            else REGFILE(to_integer(unsigned(READ_ADD2)));

end Behavioral;
