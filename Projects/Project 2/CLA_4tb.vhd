library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_4tb is
end CLA_4tb;

architecture TestBench of CLA_4tb is
component CLA_4s
        port(   A    : in  std_logic_vector (3 downto 0);
                B    : in  std_logic_vector (3 downto 0);
                Cin  : in  std_logic;
                S    : out std_logic_vector (3 downto 0);
                Cout : out std_logic
            );
    end component;

    signal A    : std_logic_vector (3 downto 0) := "0000";
    signal B    : std_logic_vector (3 downto 0) := "0000";
    signal Cin  : std_logic                     := '0';
    signal S    : std_logic_vector (3 downto 0) := "0000";
    signal Cout : std_logic                     := '0';
    
begin
    dut: CLA_4s
        port map(
            A    => A, 
            B    => B, 
            Cin  => Cin, 
            S    => S, 
            Cout => Cout
        );

    test : process
    begin
        A <= "0000"; B <= "0000"; Cin <= '0'; wait for 50 ps;
        A <= "1111"; B <= "1111"; Cin <= '1'; wait for 50 ps;
        A <= "0101"; B <= "0101"; Cin <= '0'; wait for 50 ps;
        A <= "1010"; B <= "1010"; Cin <= '1'; wait for 50 ps;
        A <= "1001"; B <= "1001"; Cin <= '0'; wait for 50 ps;
        A <= "0110"; B <= "0110"; Cin <= '1'; wait for 50 ps;
        A <= "0001"; B <= "0001"; Cin <= '0'; wait for 50 ps;
        A <= "1000"; B <= "1000"; Cin <= '1'; wait for 50 ps;
    end process;
    
end TestBench;
