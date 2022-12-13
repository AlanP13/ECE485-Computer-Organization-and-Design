library ieee;
use ieee.std_logic_1164.all;

entity TB_SignExtend is
end entity;

architecture Testbench of TB_SignExtend is 
	component SignExtend
        port(   A   : in  std_logic_vector(15 downto 0);
            
                B   : out std_logic_vector(31 downto 0)
        );
	end component;
	--set up signals
	signal A     : std_logic_vector(15 downto 0);
    signal B     : std_logic_vector(31 downto 0);
begin
	dut: SignExtend
        port map (
            A     => A,
            B     => B
        );
	test : process
	begin
        A <= x"0FFF"; wait for 50 ps; -- Case 0
        A <= x"F000"; wait for 50 ps; -- Case 1
	end process;
end architecture;