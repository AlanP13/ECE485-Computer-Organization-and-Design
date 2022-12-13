library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    generic(N      : integer := 32);
    port(   A      : in std_logic_vector(N-1 downto 0);
            B      : in std_logic_vector(N-1 downto 0);
            ALUOp  : in std_logic_vector(3   downto 0); --9 Operations Used

            R      : out std_logic_vector(N-1 downto 0);
            Z      : out std_logic
        );
end entity;

architecture Behavioral of ALU is
    signal T : std_logic_vector(N-1 downto 0);
begin
    T <=
        std_logic_vector(unsigned(A) + unsigned(B))                                      after 1 ns when ALUOp = "0000" else --ADD
        std_logic_vector(unsigned(A) - unsigned(B))                                      after 1 ns when ALUOp = "0001" else --SUB
        A AND  B                                                                         after 1 ns when ALUOp = "0010" else --AND
        A OR   B                                                                         after 1 ns when ALUOp = "0011" else --OR
        A NOR  B                                                                         after 1 ns when ALUOp = "0100" else --NOR
        A NAND B                                                                         after 1 ns when ALUOp = "0101" else --NAND
        A XOR  B                                                                         after 1 ns when ALUOp = "0110" else --XOR
        std_logic_vector(shift_left( unsigned(A), to_integer(unsigned(B(10 downto 6))))) after 1 ns when ALUOp = "0111" else --SLL
        std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B(10 downto 6))))) after 1 ns when ALUOp = "1000" else --SRL
        (others => '0');
    Z <= '1' when (T <= "00000000000000000000000000000000") else '0';
    R <= T;
end architecture;