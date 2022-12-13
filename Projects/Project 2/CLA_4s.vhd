library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_4s is
port(   A    : in  std_logic_vector (3 downto 0);
            B    : in  std_logic_vector (3 downto 0);
            Cin  : in  std_logic;
            S    : out std_logic_vector (3 downto 0);
            Cout : out std_logic
        );
end CLA_4s;

architecture Structural of CLA_4s is

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
        for i in 0 to 3 loop
            S(i) <= (A(i) xor B(i)) xor Carry(i, A, B, Cin);
        end loop;
        Cout <= Carry(4, A, B, Cin);
    end process;

end Structural;
