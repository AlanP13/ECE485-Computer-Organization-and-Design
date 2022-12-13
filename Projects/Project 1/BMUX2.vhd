----------------------------------------------------------------------------------
-- 
-- Company: Illinois Institute of Technology
-- Engineer: Alan Palayi
-- 
-- Create Date: 10/05/2022 08:37:43 PM
-- Design Name: 2-bit Multiplexer
-- Module Name: BMUX2 - Behavioral
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BMUX2 is
    Port ( 
           X: in STD_LOGIC_VECTOR (1 downto 0); --Input terminals
           S: in STD_LOGIC; --Select          
           Z : out STD_LOGIC); --output terminal
end BMUX2;

architecture Behavioral of BMUX2 is
begin
    with S select
        Z<= X(0) when '0',
            X(1) when others;

end Behavioral;
