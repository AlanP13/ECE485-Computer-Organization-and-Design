----------------------------------------------------------------------------------
-- 
-- Company: Illinois Institute of Technology
-- Engineer: Alan Palayil
-- 
-- Create Date: 09/28/2022 06:05:40 PM
-- Design Name: 8-bit Multiplexer Implementation
-- Module Name: BMUX8 - Behavioral
-- Project Name: ECE 485 Project 1
-- Target Devices: 32-bit RISC processor 
-- Tool Versions: Xilinx Vivado VDHL simulator on Endeavour Server
-- Description: Design and implement an eight-input multiplexer in bothcbehavioral model and structural model using VHDL.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Create the entity for behavioral model initializing inputs and outputs.
entity BMUX8 is
    Port ( X: in STD_LOGIC_VECTOR (7 downto 0); --Input terminals
           S: in STD_LOGIC_VECTOR (2 downto 0); --Select (2^3 = 8 for 8 inputs )          
           Z : out STD_LOGIC); --output terminal           
end BMUX8;

--Creating the architecture for how the multiplexer will operate
architecture Behavioral of BMUX8 is
begin
    --Declare what the variables are being used in the process
    with S select
        Z<= X(0) when "000",
            X(1) when "001",
            X(2) when "010",
            X(3) when "011",
            X(4) when "100",
            X(5) when "101",
            X(6) when "110",
            X(7) when others;

end Behavioral;
