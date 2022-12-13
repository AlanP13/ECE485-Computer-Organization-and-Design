library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_16tb is
end CLA_16tb;

architecture TestBench of CLA_16tb is
component CLA_16s
        port(   A    : in  std_logic_vector (15 downto 0);
                B    : in  std_logic_vector (15 downto 0);
                Cin  : in  std_logic;
                S    : out std_logic_vector (15 downto 0);
                Cout : out std_logic
            );
    end component;

    signal A    : std_logic_vector (15 downto 0) := "0000000000000000";
    signal B    : std_logic_vector (15 downto 0) := "0000000000000000";
    signal Cin  : std_logic                      := '0';
    signal S    : std_logic_vector (15 downto 0) := "0000000000000000";
    signal Cout : std_logic                      := '0';
    
begin
    dut: CLA_16s
        port map(
            A    => A, 
            B    => B, 
            Cin  => Cin, 
            S    => S, 
            Cout => Cout
        );

    test : process
    begin
        A <= "0000000000000000"; B <= "0000000000000000"; Cin <= '0'; wait for 50 ps;
        A <= "1111111111111111"; B <= "1111111111111111"; Cin <= '1'; wait for 50 ps;
        A <= "0101010101010101"; B <= "0101010101010101"; Cin <= '0'; wait for 50 ps;
        A <= "1010101010101010"; B <= "1010101010101010"; Cin <= '1'; wait for 50 ps;
        A <= "1001100110011001"; B <= "1001100110011001"; Cin <= '0'; wait for 50 ps;
        A <= "0110011001100110"; B <= "0110011001100110"; Cin <= '1'; wait for 50 ps;
        A <= "0001000100010001"; B <= "0001000100010001"; Cin <= '0'; wait for 50 ps;
        A <= "1000100010001000"; B <= "1000100010001000"; Cin <= '1'; wait for 50 ps;
    end process;
end TestBench;
