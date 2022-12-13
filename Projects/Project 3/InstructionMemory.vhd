library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory is
    port(   RegAddr : in  std_logic_vector(31 downto 0);
            I       : out std_logic_vector(31 downto 0)
        );
end entity;

architecture Behavioral of InstructionMemory is
    type R is array (0 to 1500) of std_logic_vector(7 downto 0);
    signal IMem : R := (
        --# => "8#",
        others => "00000000"
    );
begin
    I <= IMem(to_integer(unsigned(RegAddr)))   &
         IMem(to_integer(unsigned(RegAddr)+1)) &
         IMem(to_integer(unsigned(RegAddr)+2)) &
         IMem(to_integer(unsigned(RegAddr)+3));
end architecture;