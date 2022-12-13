library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_32s is
    port(   A    : in  std_logic_vector (31 downto 0);
            B    : in  std_logic_vector (31 downto 0);
            Cin  : in  std_logic;
            S    : out std_logic_vector (31 downto 0);
            Cout : out std_logic
        );
end RCA_32s;

architecture Structural of RCA_32s is
component RCA_4s
        port(   A    : in  std_logic_vector (3 downto 0);
                B    : in  std_logic_vector (3 downto 0);
                Cin  : in  std_logic;
                S    : out std_logic_vector (3 downto 0);
                Cout : out std_logic
            );
    end component;

    --Signals
    signal  C : std_logic_vector (7 downto 1);

begin
    --utilize eight 4-bit RCAs
    RCA1: RCA_4s port map(A(3  downto 0),   B(3 downto 0),  Cin,  S(3  downto 0),  C(1));
    RCA2: RCA_4s port map(A(7  downto 4),   B(7 downto 4),  C(1), S(7  downto 4),  C(2));
    RCA3: RCA_4s port map(A(11 downto 8),  B(11 downto 8),  C(2), S(11 downto 8),  C(3));
    RCA4: RCA_4s port map(A(15 downto 12), B(15 downto 12), C(3), S(15 downto 12), C(4));
    RCA5: RCA_4s port map(A(19 downto 16), B(19 downto 16), C(4), S(19 downto 16), C(5));
    RCA6: RCA_4s port map(A(23 downto 20), B(23 downto 20), C(5), S(23 downto 20), C(6));
    RCA7: RCA_4s port map(A(27 downto 24), B(27 downto 24), C(6), S(27 downto 24), C(7));
    RCA8: RCA_4s port map(A(31 downto 28), B(31 downto 28), C(7), S(31 downto 28), Cout);
end Structural;
