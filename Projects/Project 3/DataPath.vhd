library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataPath is
    generic(N : integer := 32);
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
end entity;

architecture Behavioral of DataPath is
    component WordAlign is
        port(   A   : in  std_logic_vector(31 downto 0);

                B   : out std_logic_vector(31 downto 0)
        );
    end component;

    component SignExtend is
        port(   A   : in  std_logic_vector(15 downto 0);
            
                B   : out std_logic_vector(31 downto 0)
        );
    end component;

    component MUX is
        --generic(N : integer);
        port(   X : in  std_logic_vector(N-1 downto 0);
                Y : in  std_logic_vector(N-1 downto 0);
                S : in  std_logic;

                Z : out std_logic_vector(N-1 downto 0)
            );
    end component;

    component DataMemory is
        port(   CLK      : in std_logic;
                NegReset : in std_logic;
                MemAddr  : in std_logic_vector(N-1 downto 0);
                MemWrite : in std_logic;
                MemRead  : in std_logic;
                DataIn   : in std_logic_vector(N-1 downto 0);

                DataOut  : in std_logic_vector(N-1 downto 0)
            );
    end component;

    component Registers is
        port(   CLK       : in std_logic;
                NegReset  : in std_logic;
                Addr1     : in std_logic_vector(4 downto 0);
                Addr2     : in std_logic_vector(4 downto 0);
                AddrOut   : in std_logic_vector(4 downto 0);
                DataWrite : in std_logic_vector(N-1 downto 0);
                RegWrite  : in std_logic;

                Reg1      : out std_logic_vector(N-1 downto 0);
                Reg2      : out std_logic_vector(N-1 downto 0)
            );
    end component;

    component ProgramCounter is
        port(   A    : in  std_logic_vector(31 downto 0);
                CTRL : in  std_logic;
                CLK  : in  std_logic;
                
                B    : out std_logic_vector(31 downto 0)
            );
    end component;

    component ADD is
        port(   A : in  std_logic_vector (N-1 downto 0);
                B : in  std_logic_vector (N-1 downto 0);
                S : out std_logic_vector (N-1 downto 0)
            );
    end component;

    component ALU is
        port(   A      : in std_logic_vector(N-1 downto 0);
                B      : in std_logic_vector(N-1 downto 0);
                ALUOp  : in std_logic_vector(3   downto 0); --9 Operations Used

                R      : out std_logic_vector(N-1 downto 0);
                Z      : out std_logic
            );
    end component;


    constant PCInc          : std_logic_vector(31  downto 0) := "00000000000000000000000000000100";
    
    signal   PCOut          : std_logic_vector(31  downto 0);
    signal   MUX_RegWrite   : std_logic_vector(4   downto 0);
    signal   SignExtend_SLL : std_logic_vector(31  downto 0);
    signal   SLL_ADD        : std_logic_vector(31  downto 0);
    signal   DataRead1_ALU  : std_logic_vector(N-1 downto 0);
    signal   DataRead2_MUX  : std_logic_vector(N-1 downto 0);
    signal   MUX_ALU        : std_logic_vector(N-1 downto 0);
    signal   ALU_DataMemory : std_logic_vector(N-1 downto 0);
    signal   DataMemory_MUX : std_logic_vector(N-1 downto 0);
    signal   MUX_DataWrite  : std_logic_vector(N-1 downto 0);
    signal   ADD0_MUX        : std_logic_vector(31  downto 0);
    signal   MUX_MUX        : std_logic_vector(31  downto 0);
    signal   MUX_PC         : std_logic_vector(31  downto 0);
    signal   ADD1_MUX        : std_logic_vector(31  downto 0);
    signal   SLL_MUX        : std_logic_vector(31  downto 0);
    signal   SLLOut         : std_logic_vector(31  downto 0);
    signal   JumpShift      : std_logic_vector(31  downto 0);

begin

    SLL_MUX <= ADD0_MUX(31 downto 28) & SLLOut(27 downto 0);
    JumpShift <= "000000" & I(25 downto 0);

    MEM         : DataMemory     port map(CLK, CTRL, ALU_DataMemory, MemWrite, MemRead, DataRead2_MUX, DataMemory_MUX);
    ALUnit      : ALU            port map(DataRead1_ALU, MUX_ALU, ALUOp, ALU_DataMemory, ZC);

    ADDBranch   : ADD            port map(ADD1_MUX, SLL_ADD, ADD0_MUX);
    ADDPC       : ADD            port map(PCOut, PCInc, ADD1_MUX);

    MUXALU      : MUX            generic map(32) port map(DataRead2_MUX, SignExtend_SLL, ALUSrc, MUX_ALU);
    MUXBranch   : MUX            generic map(32) port map(ADD1_MUX, ADD0_MUX, Branch, MUX_MUX);
    MUXJump     : MUX            generic map(32) port map(MUX_MUX, SLL_MUX, Jump, MUX_PC);
    MUXMem      : MUX            generic map(32) port map(ALU_DataMemory, DataMemory_MUX, MemToReg, MUX_DataWrite);
    MUXReg      : MUX            generic map(5)  port map(I(20 downto 16), I(15 downto 11), RegDst, MUX_RegWrite);
    
    ShiftBranch : WordAlign      port map(SignExtend_SLL, SLL_ADD);
    ShiftJump   : WordAlign      port map(JumpShift, SLLOut);
    
    ShiftExtend : SignExtend     port map(I(15 downto 0), SignExtend_SLL);
    Reg         : Registers      port map(CLK, CTRL, I(25 downto 21), I(20 downto 16), MUX_RegWrite, MUX_DataWrite, RegWrite, DataRead1_ALU, DataRead2_MUX);

    PC          : ProgramCounter port map(MUX_PC, CTRL, CLK, PCOut);
    NI <= PCOut;
end architecture;