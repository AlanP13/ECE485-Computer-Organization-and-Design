library ieee;
use ieee.std_logic_1164.all;

entity ALU_32 is
  port( a, b: in STD_LOGIC_VECTOR (31 downto 0);
	ALU_control: in STD_LOGIC_VECTOR (3 downto 0);
	Co, zero: out STD_LOGIC;
	output: out STD_LOGIC_VECTOR (31 downto 0));
end ALU_32;

architecture structural of ALU_32 is

	--define 4-bit ALU
	component ALU_4
  	  port( a, b, ALU_control: in STD_LOGIC_VECTOR (3 downto 0);
		Ci: in STD_LOGIC;
		Co: out STD_LOGIC;
		output: out STD_LOGIC_VECTOR (3 downto 0));
	end component;

	signal carry: STD_LOGIC_VECTOR(8 downto 0);
	signal sig_Co, sig_zero: STD_LOGIC;
	signal sig_out, sig_slt, sig_out1: STD_LOGIC_VECTOR(31 downto 0);

	begin
		process(ALU_control, carry, sig_Co) is
		begin
			carry(0) <= '0';
			sig_Co <= carry(8);
			if(ALU_control = x"6") or (ALU_control = x"7") then
				carry(0) <= '1';
				sig_Co <= not carry(8);
			end if;
		end process;
		
     		process(sig_out1, sig_zero) is 
		begin	
			sig_zero <= '0';
	 		if (sig_out1 = x"00000000") then
				sig_zero <= '1';
			end if;
     		end process;
	
		--use 4-bit ALU to complete 32-bit ALU
		U1: ALU_4 port map(a => a(3 downto 0), b => b(3 downto 0), ALU_control => ALU_control, Ci => carry(0) =Co => carry(1), output => sig_out(3 downto 0));
		U2: ALU_4 port map(a => a(7 downto 4), b => b(7 downto 4), ALU_control => ALU_control, Ci => carry(1) =Co => carry(2), output => sig_out(7 downto 4));
		U3: ALU_4 port map(a => a(11 downto 8), b => b(11 downto 8), ALU_control => ALU_control, Ci => carry(2) =Co => carry(3), output => sig_out(11 downto 8));
		U4: ALU_4 port map(a => a(15 downto 12), b => b(15 downto 12), ALU_control => ALU_control, Ci => carry(3) =Co => carry(4), output => sig_out(15 downto 12));
		U5: ALU_4 port map(a => a(19 downto 16), b => b(19 downto 16), ALU_control => ALU_control, Ci => carry(4) =Co => carry(5), output => sig_out(19 downto 16));
		U6: ALU_4 port map(a => a(23 downto 20), b => b(23 downto 20), ALU_control => ALU_control, Ci => carry(5) =Co => carry(6), output => sig_out(23 downto 20));
		U7: ALU_4 port map(a => a(27 downto 24), b => b(27 downto 24), ALU_control => ALU_control, Ci => carry(6) =Co => carry(7), output => sig_out(27 downto 24));
		U8: ALU_4 port map(a => a(31 downto 28), b => b(31 downto 28), ALU_control => ALU_control, Ci => carry(7) =Co => carry(8), output => sig_out(31 downto 28));

		--set output for slt
		process(sig_Co, sig_slt, ALU_control, sig_out)
		begin
			sig_out1 <= sig_out;
			sig_slt(31 downto 1) <= "0000000000000000000000000000000";
			sig_slt(0) <= sig_Co;
			if ALU_control = x"7" then
				sig_out1 <= sig_slt;
			end if;
		end process;

		Co <= sig_Co;
		output <= sig_out1;
		zero <= sig_zero;

end structural;