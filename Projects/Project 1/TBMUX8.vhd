----------------------------------------------------------------------------------
-- 
-- Company: Illinois Institute of Technology
-- Engineer: Alan Palayil
-- 
-- Create Date: 09/28/2022 06:05:40 PM
-- Design Name: 8-bit Multiplexer Implementation
-- Module Name: TBMUX8 - TestBench
-- Project Name: ECE 485 Project 1
-- Target Devices: 32-bit RISC processor 
-- Tool Versions: Xilinx Vivado VDHL simulator on Endeavour Server
-- Description: Design and implement an eight-input multiplexer in bothcbehavioral model and structural model using VHDL.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TBMUX8 is
end TBMUX8;

architecture Testbench of TBMUX8 is

--8:1 Multiplexer component 
component BMUX8 --Change to SMUX8 for Structural Model
	Port ( X: in STD_LOGIC_VECTOR (7 downto 0); --Input terminals
               S: in STD_LOGIC_VECTOR (2 downto 0); --Select (2^3 = 8 for 8 inputs )          
               Z : out STD_LOGIC); --output terminal
end component;

--Signals
signal X: STD_LOGIC_VECTOR (7 downto 0):= (others=> '0');
signal S: STD_LOGIC_VECTOR (2 downto 0):= (others=> '0');
signal Z: STD_LOGIC;

begin

uut: BMUX8 port map ( --Change to SMUX8 for Structural Model
	X=> X,
	S=> S,
	Z=> Z
);

process_X: process
	begin
		X <= "10101010";
		wait for 1000 ns;
	end process;

process_S: process
	begin
		S <= "000";
		wait for 50 ns;
		S <= "001";
		wait for 50 ns;		
		S <= "010";
		wait for 50 ns;		
		S <= "011";
		wait for 50 ns;
		S <= "100";
		wait for 50 ns;
		S <= "101";
		wait for 50 ns;
		S <= "110";
		wait for 50 ns;
		S <= "111";
		wait for 50 ns;
	end process;

end Testbench;