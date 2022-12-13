library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_4s is
    port(   A    : in  std_logic_vector (3 downto 0);
            B    : in  std_logic_vector (3 downto 0);
            Cin  : in  std_logic;
            S    : out std_logic_vector (3 downto 0);
            Cout : out std_logic
        );
end RCA_4s;

architecture Structural of RCA_4s is
component RCA_1b
        port(   A,B,Cin  : in  std_logic;
                S,Cout   : out std_logic
            );
    end component;

    --Set signals
    signal C : std_logic_vector (3 downto 1);
begin
    --Utilize 1-bit RCA to create 4-bit RCA
    RCA1: RCA_1b port map(A(0), B(0), Cin,  S(0), C(1));
    RCA2: RCA_1b port map(A(1), B(1), C(1), S(1), C(2));
    RCA3: RCA_1b port map(A(2), B(2), C(2), S(2), C(3));
    RCA4: RCA_1b port map(A(3), B(3), C(3), S(3), Cout);
end Structural;
