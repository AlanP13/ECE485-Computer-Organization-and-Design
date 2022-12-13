library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_32tb is
end RCA_32tb;

architecture TestBench of RCA_32tb is
component RCA_32s
        port(   A    : in  std_logic_vector (31 downto 0);
                B    : in  std_logic_vector (31 downto 0);
                Cin  : in  std_logic;
                S    : out std_logic_vector (31 downto 0);
                Cout : out std_logic
            );
    end component;

    --Signals
    signal A    : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";
    signal B    : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";
    signal Cin  : std_logic                      := '0';
    signal S    : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";
    signal Cout : std_logic                      := '0';
    
begin
    dut: RCA_32s
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
        A <= "00000000000000000000000000000000"; B <= "00000000000000000000000000000000"; Cin <= '0'; wait for 50 ps;
        A <= "11111111111111111111111111111111"; B <= "11111111111111111111111111111111"; Cin <= '1'; wait for 50 ps;
        A <= "01010101010101010101010101010101"; B <= "01010101010101010101010101010101"; Cin <= '0'; wait for 50 ps;
        A <= "10101010101010101010101010101010"; B <= "10101010101010101010101010101010"; Cin <= '1'; wait for 50 ps;
        A <= "10011001100110011001100110011001"; B <= "10011001100110011001100110011001"; Cin <= '0'; wait for 50 ps;
        A <= "01100110011001100110011001100110"; B <= "01100110011001100110011001100110"; Cin <= '1'; wait for 50 ps;
        A <= "00010001000100010001000100010001"; B <= "00010001000100010001000100010001"; Cin <= '0'; wait for 50 ps;
        A <= "10001000100010001000100010001000"; B <= "10001000100010001000100010001000"; Cin <= '1'; wait for 50 ps;
    end process;
end TestBench;
