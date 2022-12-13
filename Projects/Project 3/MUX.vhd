library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity MUX is
    generic(N : integer := 32);
    port(   X : in  std_logic_vector(N-1 downto 0);
            Y : in  std_logic_vector(N-1 downto 0);
            S : in  std_logic;

            Z : out std_logic_vector(N-1 downto 0)
        );
end entity;

architecture Behavioral of MUX is
begin
    process(X,Y,S)
    begin
        if    (S = '0') then
                Z <= X;
        elsif (S = '1') then
            Z <= Y;
        end if;
    end process;
end architecture;