library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_32s is
    port(   A    : in  std_logic_vector (31 downto 0);
            B    : in  std_logic_vector (31 downto 0);
            Cin  : in  std_logic;
            S    : out std_logic_vector (31 downto 0);
            Cout : out std_logic
        );
end CLA_32s;

architecture Structural of CLA_32s is
function Carry(idx : integer; A : std_logic_vector; B : std_logic_vector; Cin : std_logic) return std_logic is     
    begin
        if (idx = 0) then
            return Cin;
        else
            return (A(idx-1) and B(idx-1)) or ((A(idx-1) or B(idx-1)) and Carry(idx-1, A, B, Cin));
        end if;
    end function;
begin
    process(A,B,Cin) is
    begin
        for i in 0 to 31 loop
            S(i) <= (A(i) xor B(i)) xor Carry(i, A, B, Cin);
        end loop;
        Cout <= Carry(32, A, B, Cin);
    end process;
end Structural;
