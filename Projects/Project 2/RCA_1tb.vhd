library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_1tb is
end RCA_1tb;

architecture TestBench of RCA_1tb is
component RCA_1b
        port(   A, B, Cin : in  std_logic;
                S, Cout   : out std_logic
            );
    end component;

    --Signals
    signal A    : std_logic := '0';
    signal B    : std_logic := '0';
    signal Cin  : std_logic := '0';
    signal S    : std_logic := '0';
    signal Cout : std_logic := '0';
    
begin
    dut: RCA_1b
        port map(
            A    => A, 
            B    => B, 
            Cin  => Cin, 
            S    => S, 
            Cout => Cout
        );

    test : process
    begin
        --Tests
        A <= '0'; B <= '0'; Cin <= '0'; wait for 50 ps;
        A <= '0'; B <= '0'; Cin <= '1'; wait for 50 ps;
        A <= '0'; B <= '1'; Cin <= '0'; wait for 50 ps;
        A <= '0'; B <= '1'; Cin <= '1'; wait for 50 ps;
        A <= '1'; B <= '0'; Cin <= '0'; wait for 50 ps;
        A <= '1'; B <= '0'; Cin <= '1'; wait for 50 ps;
        A <= '1'; B <= '1'; Cin <= '0'; wait for 50 ps;
        A <= '1'; B <= '1'; Cin <= '1'; wait for 50 ps;
    end process;
end TestBench;
