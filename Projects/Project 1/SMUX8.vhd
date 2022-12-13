----------------------------------------------------------------------------------
-- Company: Illinois Institute of Technology
-- Engineer: Alan Palayil
-- 
-- Create Date: 09/28/2022 08:05:40 PM
-- Design Name: 8-bit Multiplexer Implementation
-- Module Name: SMUX8 - Structural
-- Project Name: ECE 485 Project 1
-- Target Devices: 32-bit RISC processor 
-- Tool Versions: Xilinx Vivado VDHL simulator on Endeavour Server
-- Description: Design and implement an eight-input multiplexer in bothcbehavioral model and structural model using VHDL.
-- 
-- Dependencies: Behavioral and Structural models
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Create the entity for structural model initializing inputs and outputs.
entity SMUX8 is
    Port ( X: in STD_LOGIC_VECTOR (7 downto 0); --Input terminals
           S: in STD_LOGIC_VECTOR (2 downto 0); --Select (2^3 = 8 for 8 inputs )          
           Z : out STD_LOGIC); --output terminal
end SMUX8;

--Creating the architecture for how the multiplexer will operate
architecture Structural of SMUX8 is

--2:1 Multiplexer component
component BMUX2
	Port ( 
           X: in STD_LOGIC_VECTOR (1 downto 0); --Input terminals
           S: in STD_LOGIC; --Select          
           Z : out STD_LOGIC); --output terminal
end component;

--4:1 Multiplexer component
component BMUX4
	Port ( 
           X: in STD_LOGIC_VECTOR (3 downto 0); --Input terminals
           S: in STD_LOGIC_VECTOR (1 downto 0); --Select          
           Z : out STD_LOGIC); --output terminal
end component;

--Signals
signal Z_s: STD_LOGIC_VECTOR (1 downto 0);

begin

i_MX41_1: BMUX4 port map (
	X(0)=> X(0),
	X(1)=> X(1),
	X(2)=> X(2),
	X(3)=> X(3),
	S(0)=> S(0),
	S(1)=> S(1),
	Z=> Z_s(0)
);

i_MX41_2: BMUX4 port map (
	X(0)=> X(4),
	X(1)=> X(5),
	X(2)=> X(6),
	X(3)=> X(7),
	S(0)=> S(0),
	S(1)=> S(1),
	Z=> Z_s(1)
);
i_MX21_1: BMUX2 port map (
	X(0)=> Z_s(0),
	X(1)=> Z_s(1),
	S=> S(2),
	Z=> Z
);

end Structural;