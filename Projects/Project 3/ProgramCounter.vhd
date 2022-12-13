--This file defines usages for the program counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ProgramCounter is
--define ports used, both input and output use 32 bits
    port(   A    : in  std_logic_vector(31 downto 0);
            CTRL : in  std_logic;
            CLK  : in  std_logic;
            
            B    : out std_logic_vector(31 downto 0)
        );
end entity;

architecture Behavioral of ProgramCounter is
begin     
    --if set enabled then change B
    process(CLK)
    begin
        if CTRL = '0' then
            B <= (others => '0');
        elsif rising_edge(CLK) then
            B <= A;
        end if;
    end process;
end architecture;