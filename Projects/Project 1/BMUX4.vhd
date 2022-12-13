----------------------------------------------------------------------------------
-- 
-- Company: Illinois Institute of Technology
-- Engineer: Alan Palayi
-- 
-- Create Date: 10/05/2022 08:37:43 PM
-- Design Name: 4-bit Multiplexer
-- Module Name: BMUX4 - Behavioral
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BMUX4 is
Port ( 
           X: in STD_LOGIC_VECTOR (3 downto 0); --Input terminals
           S: in STD_LOGIC_VECTOR (1 downto 0); --Select          
           Z : out STD_LOGIC); --output terminal
end BMUX4;

architecture Behavioral of BMUX4 is
begin
    with S select
        Z<= X(0) when "00",
            X(1) when "01",
            X(2) when "10",
            X(3) when others;

end Behavioral;
