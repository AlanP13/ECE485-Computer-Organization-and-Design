library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
    port(   I        : in std_logic_vector(31 downto 0);
            ZC       : in std_logic;

            ALUOp    : out std_logic_vector(3 downto 0); --9 Ops
            ALUSrc   : out std_logic;
            Branch   : out std_logic;
            Jump     : out std_logic;
            MemRead  : out std_logic;
            MemToReg : out std_logic;
            MemWrite : out std_logic;
            RegDst   : out std_logic;
            RegWrite : out std_logic
        );
end entity;

architecture Behavioral of ControlUnit is
    signal D : std_logic_vector(11 downto 0);
begin
    D <= 
        "100000000001" when (I(31 downto 26) = "000000" AND I(10 downto 0)  = "00000100000") else --ADD
        
        "100000001001" when (I(31 downto 26) = "000000" and I(10 downto 0)  = "00000100010") else --SUB
        
        "100000010001" when (I(31 downto 26) = "000000" and I(10 downto 0)  = "00000100100") else --AND
        
        "100000011001" when (I(31 downto 26) = "000000" and I(10 downto 0)  = "00000100101") else --OR
        
        "100000100001" when (I(31 downto 26) = "000000" and I(10 downto 0)  = "00000100111") else --NOR
        
        "100000110001" when (I(31 downto 26) = "000000" and I(5 downto 0)   = "100110") else -- XOR
        
        "100000111011" when (I(31 downto 26) = "000000" and I(5 downto 0)   = "000000") else --SLL
        
        "100001000011" when (I(31 downto 26) = "000000" and I(5 downto 0)   = "000010") else --SRL
        
        "100001001001" when (I(31 downto 26) = "000000" and I(10 downto 0)  = "00000101010") else --SLT
        
        "000000000011" when I(31 downto 26) = "001000" else --ADDI
        
        "000110000011" when I(31 downto 26) = "100011" else --LW
        
        "000000000110" when I(31 downto 26) = "101011" else --SW
        
        "000000010011" when I(31 downto 26) = "001100" else --ANDI
        
        "000000011011" when I(31 downto 26) = "001101" else --ORI
        
        "001000001000" when I(31 downto 26) = "000100" else --BEQ
        
        "001000110010" when I(31 downto 26) = "000101" else --BNQ
        
        "000001001011" when I(31 downto 26) = "001010" else --SLTI
        
        "010000000000" when I(31 downto 26) = "000010" else --JMP
        
        (others =>'0');



    ALUOp    <= D(6 downto 3);  -- 9 Ops
    ALUSrc   <= D(1);
    Branch   <= D(9) AND (ZC XOR I(26));
    Jump     <= D(10);
    MemRead  <= D(8);
    MemToReg <= D(7);
    MemWrite <= D(2);
    RegDst   <= D(11);
    RegWrite <= D(0);
end Behavioral;