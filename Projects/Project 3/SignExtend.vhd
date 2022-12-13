--This file defines the sign extend operation
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SignExtend is
--define ports
    port(   A   : in  std_logic_vector(15 downto 0);
            
            B   : out std_logic_vector(31 downto 0)
        );
end entity;

architecture Behavioral of SignExtend is
--the most significant bit needs to be copied to the upper 16
begin
    B <=   "0000000000000000" & A when (A(15) = '0') else
            "1111111111111111" & A;
end architecture;