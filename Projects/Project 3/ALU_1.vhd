library ieee;
use ieee.std_logic_1164.all;

entity ALU_1 is
  	port(	X : in std_logic;
	  		Y : in std_logic;
			Ci : in std_logic;
			ALUOp: in STD_LOGIC_VECTOR(3 downto 0);
			Co : out std_logic;
			R : out std_logic);
end ALU_1;

architecture structural of ALU_1 is

	component RCA
	  	port (	a, b, Ci : in std_logic;
			Co, Sum : out std_logic);
	end component;

	signal sig_a, sig_b, sig_Ci, sig_clock, sig_less: std_logic;
	signal sig_adder, sig_and, sig_or, sig_Co, sig_slt: std_logic;

begin
	process(ALUOp, a, b) is
	begin
		if ALUOp(3) = '0' then
			sig_a <= a;
		else
			sig_a <= not a;
		end if;
		if ALUOp(2) = '0' then
			sig_b <= b;
		else
			sig_b <= not b;
		end if;
	end process;
	
	--set signals for mux
	adder: RCA port map (a => sig_a, b => sig_b, Ci => Ci, Co => sig_Co, Sum => adder_op);
	and_op <= a AND b;
	or_op: <= a or b;

	process(sig_adder, sig_and, sig_or, ALUOp) is
	begin
	--set mux
		case ALUOp(1 downto 0) is
			when "00" => R <= and_op; Co <= '0';
			when "01" => R <= or_op; Co <= '0';
			when "10" => R <= adder_op; Co <= sig_Co;
			when "11" => R <= adder_op; Co <= sig_Co;
			when others =>  R <= '0'; Co <= '0';
		end case;
	end process;
end structural;