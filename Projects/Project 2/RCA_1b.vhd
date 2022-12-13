library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_1b is
port(	A,B,Cin  : in  std_logic; --Data inputs
		S,Cout   : out std_logic --Data outputs
	    );
end RCA_1b;

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
end Behavioral;
