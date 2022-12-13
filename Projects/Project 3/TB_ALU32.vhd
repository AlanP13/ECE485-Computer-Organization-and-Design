library ieee;
use ieee.std_logic_1164.all;

entity TB_ALU_32 is
end entity;

architecture testbench of TB_ALU_32 is 
	component ALU
        generic(N      : integer := 32);
		port(   A      : in std_logic_vector(N-1 downto 0);
                B      : in std_logic_vector(N-1 downto 0);
                ALUOp  : in std_logic_vector(3   downto 0); --9 Operations Used

                R      : out std_logic_vector(N-1 downto 0);
                Z      : out std_logic
            );
	end component;
	--set up signals
	signal A     : std_logic_vector(31 downto 0);
    signal B     : std_logic_vector(31 downto 0);
	signal ALUOp : std_logic_vector(3 downto 0);
	signal R     : std_logic_vector(31 downto 0);
	signal Z     : std_logic;
begin
	dut: ALU
        port map (
            A     => A,
            B     => B,
            ALUOp => ALUOp,
            R     => R,
            Z     => Z
        );
    

	test : process
	begin

        A   <= "10010011001011000000010110100100"; B   <= "11101011011110011010001011000100"; 

        ALUOp <= "0000"; wait for 50 ps; -- ADD
        ALUOp <= "0001"; wait for 50 ps; -- SUB
        ALUOp <= "0010"; wait for 50 ps; -- AND
        ALUOp <= "0011"; wait for 50 ps; -- OR
        ALUOp <= "0100"; wait for 50 ps; -- NOR
        ALUOp <= "0101"; wait for 50 ps; -- NAND
        ALUOp <= "0110"; wait for 50 ps; -- XOR
        ALUOp <= "0111"; wait for 50 ps; -- SLL
        ALUOp <= "1000"; wait for 50 ps; -- SRL
	end process;
end architecture;