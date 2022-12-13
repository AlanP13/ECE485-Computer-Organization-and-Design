--The file defines the shift left 2 operation
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WordAlign is
    port(   A   : in  std_logic_vector(31 downto 0);
            B   : out std_logic_vector(31 downto 0)
        );
end entity;

architecture Behavioral of WordAlign is
begin
    B <= std_logic_vector(unsigned(A) sll 2);
end architecture;