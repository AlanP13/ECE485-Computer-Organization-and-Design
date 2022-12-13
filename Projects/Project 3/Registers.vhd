library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registers is
    generic(N : integer := 32);
    port(   CLK       : in std_logic;
            NegReset  : in std_logic;
            Addr1     : in std_logic_vector(4 downto 0);
            Addr2     : in std_logic_vector(4 downto 0);
            AddrOut   : in std_logic_vector(4 downto 0);
            DataWrite : in std_logic_vector(N-1 downto 0);
            RegWrite  : in std_logic;

            Reg1      : out std_logic_vector(N-1 downto 0);
            Reg2      : out std_logic_vector(N-1 downto 0)
        );
end entity;

architecture Behavioral of Registers is
    type registers_type is array(0 to 31) of std_logic_vector(N-1 downto 0);
    signal R : registers_type := ((others => (others => '0')));
begin
    process(CLK)
    begin
        if NegReset = '0' then
            R(to_integer(unsigned(AddrOut))) <= (others => '0');
        elsif rising_edge(CLK) and RegWrite = '1' then
            R(to_integer(unsigned(AddrOut))) <= DataWrite;
        end if;
    end process;
    Reg1 <= R(to_integer(unsigned(Addr1)));
    Reg2 <= R(to_integer(unsigned(Addr2)));
end Behavioral;