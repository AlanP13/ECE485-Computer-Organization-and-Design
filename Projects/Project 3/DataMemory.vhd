library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory is
    generic(N        : integer := 32);
    port(   CLK      : in  std_logic;
            NegReset : in  std_logic;
            MemAddr  : in  std_logic_vector(N-1 downto 0);
            MemWrite : in  std_logic;
            MemRead  : in  std_logic;
            DataIn   : in  std_logic_vector(N-1 downto 0);

            DataOut  : out std_logic_vector(N-1 downto 0)
        );
end entity;

architecture Behavioral of DataMemory is
    type mem_type is array(127 downto 0) of std_logic_vector(N-1 downto 0);
    signal mem : mem_type;
begin
    process(CLK,NegReset)
    begin
        if NegReset = '0' then
            mem <= (others => (others => '0'));
        elsif rising_edge(CLK) and MemWrite = '1' then
            mem(to_integer(unsigned(MemAddr))) <= DataIn;
        end if;
    end process;
    DataOut <= (mem(to_integer(unsigned(MemAddr)))) when MemRead = '1' else (others => '0');
end architecture;