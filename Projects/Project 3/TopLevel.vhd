library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopLevel is
    generic(N : integer := 32);
    port(   CLK  : in std_logic;
            CTRL : in std_logic
        );
end entity;

architecture Behavioral of TopLevel is
    component ControlUnit is
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
    end component;

    component DataPath is
        port(   CLK      : in  std_logic;
                CTRL     : in  std_logic;
                I        : in  std_logic_vector(31 downto 0);

                ALUOp    : in  std_logic_vector(3 downto 0); --9 Ops
                ALUSrc   : in  std_logic;
                Branch   : in  std_logic;
                Jump     : in  std_logic;
                MemRead  : in  std_logic;
                MemToReg : in  std_logic;
                MemWrite : in  std_logic;
                RegDst   : in  std_logic;
                RegWrite : in  std_logic;

                NI       : out std_logic_vector(31 downto 0);
                ZC       : out std_logic
            );
    end component;

    component InstructionMemory is
        port(   RegAddr : in  std_logic_vector(31 downto 0);
                I       : out std_logic_vector(31 downto 0)
            );
    end component;

    signal TL_RegDst, TL_Jump, TL_Branch, TL_MemRead, TL_MemToReg : std_logic;
    signal TL_MemWrite, TL_ALUSrc, TL_RegWrite , TL_ZC     : std_logic;
    signal TL_ALUOp                                               : std_logic_vector(3 downto 0);
    signal TL_NI, TL_I                                            : std_logic_vector(31 downto 0);

begin
    CU : ControlUnit port map(
        TL_I,
        TL_ZC,

        TL_ALUOp,
        TL_ALUSrc,
        TL_Branch,
        TL_Jump,
        TL_MemRead,
        TL_MemToReg,
        TL_MemWrite,
        TL_RegDst,
        TL_RegWrite
    );

    DP : DataPath port map(
        CLK,
        CTRL,
        TL_I,

        TL_ALUOp,
        TL_ALUSrc,
        TL_Branch,
        TL_Jump,
        TL_MemRead,
        TL_MemToReg,
        TL_MemWrite,
        TL_RegDst,
        TL_RegWrite,

        TL_NI,
        TL_ZC
    );

    I : InstructionMemory port map(TL_NI, TL_I);
end architecture;