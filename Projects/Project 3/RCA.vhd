library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


--Create entity for behavioral model initializing inputs and outputs
entity RCA_1b is
	port(	A,B,Cin  : in  std_logic; --Data inputs
		    S,Cout   : out std_logic  --Data outputs
	    );
end entity;

architecture Behavioral of RCA_1b is
begin
    process (A,B,Cin) is
    begin
        --Define logic for each output
        if    (A = '0' and B = '0' and Cin = '0') then
                S <= '0'; Cout <= '0';
        elsif (A = '0' and B = '0' and Cin = '1') then
                S <= '1'; Cout <= '0';
        elsif (A = '0' and B = '1' and Cin = '0') then
                S <= '1'; Cout <= '0';
        elsif (A = '0' and B = '1' and Cin = '1') then
                S <= '0'; Cout <= '1';
        elsif (A = '1' and B = '0' and Cin = '0') then
                S <= '1'; Cout <= '0';
        elsif (A = '1' and B = '0' and Cin = '1') then
                S <= '0'; Cout <= '1';
        elsif (A = '1' and B = '1' and Cin = '0') then
                S <= '0'; Cout <= '1';
        elsif (A = '1' and B = '1' and Cin = '1') then
                S <= '1'; Cout <= '1';
        end if;
    end process;
end architecture;