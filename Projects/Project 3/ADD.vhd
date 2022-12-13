library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADD is
    generic(N : integer := 32);
    port(   A : in  std_logic_vector (N-1 downto 0);
            B : in  std_logic_vector (N-1 downto 0);
            S : out std_logic_vector (N-1 downto 0)
        );
end entity;

architecture Behavioral of ADD is
begin
    S <= std_logic_vector(signed(A) + signed(B));
end architecture;