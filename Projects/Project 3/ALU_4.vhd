library ieee;
use ieee.std_logic_1164.all;

entity ALU_4 is
  port( a, b, ALU_control: in STD_LOGIC_VECTOR (3 downto 0);
	Ci: in STD_LOGIC;
	Co: out STD_LOGIC;
	output: out STD_LOGIC_VECTOR (3 downto 0));
end ALU_4;

architecture structural of ALU_4 is

	--define 1 bit ALU
	component ALU_4
	  port( a, b, Ci: in STD_LOGIC;
		ALU_control: in STD_LOGIC_VECTOR(3 downto 0);
		Co, output: out STD_LOGIC);
	end component;

	signal carry: STD_LOGIC_VECTOR(2 downto 0);
	
	--use 1-bit ALU to complete 4-bit ALU
	begin
	U1: ALU_4 port map(a => a(0), b => b(0), Ci => Ci => ALU_control => ALU_control, Co => carry(0), output => output(0));
	U2: ALU_4 port map(a => a(1), b => b(1), Ci => carry(0) => ALU_control => ALU_control, Co => carry(1), output => output(1));
	U3: ALU_4 port map(a => a(2), b => b(2), Ci => carry(1) => ALU_control => ALU_control, Co => carry(2), output => output(2));
	U4: ALU_4 port map(a => a(3), b => b(3), Ci => carry(2) => ALU_control => ALU_control, Co => Co, output => output(3));

end structural;