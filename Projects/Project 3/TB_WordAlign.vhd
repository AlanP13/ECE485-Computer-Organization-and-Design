library ieee;
use ieee.std_logic_1164.all;

entity TB_WordAlign is
end entity;

architecture Testbench of TB_WordAlign is 
	component WordAlign
        port(   A   : in  std_logic_vector(31 downto 0);
            
                B   : out std_logic_vector(31 downto 0)
        );
	end component;
	--set up signals
	signal A     : std_logic_vector(31 downto 0);
    signal B     : std_logic_vector(31 downto 0);
begin
	dut: WordAlign
        port map (
            A     => A,
            B     => B
        );
	test : process
	begin
        A <= x"30000000"; wait for 50 ps; -- Case A
        A <= x"00000003"; wait for 50 ps; -- Case B
	end process;
end architecture;