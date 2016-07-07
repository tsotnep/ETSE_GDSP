library Ieee;
use Ieee.std_logic_1164.all;
use Ieee.numeric_std.all;

use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

entity DSP_INPUT_C is
generic(DATA_WIDTH : natural := 18; DATA_WIDE_WIDTH : natural := 36; NO_OF_PIPELINE_REG: natural := 5; OPCODE_WIDTH: natural := 3);
port(clk, rst: in std_logic;
			sel : in std_logic_vector(OPCODE_WIDTH-1 downto 0);
			a, b: in std_logic_vector(DATA_WIDTH-1 downto 0);
			c : in std_logic_vector(2*DATA_WIDTH-1 downto 0);
			p: out std_logic_vector(DATA_WIDE_WIDTH-1 downto 0) );
end entity;

Architecture struct of DSP_INPUT_C is



--type t_a_reg is array (0 to NO_OF_PIPELINE_REG-1) of unsigned(DATA_WIDTH-1 downto 0);
--signal  p_a_reg_t: t_a_reg;
--
--type t_b_reg is array (0 to NO_OF_PIPELINE_REG-1) of unsigned(DATA_WIDTH-1 downto 0);
--signal  p_b_reg_t: t_b_reg;


type t_a_reg is array (0 to NO_OF_PIPELINE_REG-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal  p_a_reg_t: t_a_reg;

type t_b_reg is array (0 to NO_OF_PIPELINE_REG-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal  p_b_reg_t: t_b_reg;

type t_sel is array (0 to NO_OF_PIPELINE_REG-1) OF std_logic_vector(OPCODE_WIDTH-1 downto 0);
signal p_sel_t: t_sel;



--signal reg_primitive_mul_out,primitive_adder_out: unsigned(2*DATA_WIDTH-1 downto 0);
--
--signal reg_primitive_mul_out_ex, primitive_adder_out_ex, c_extended: unsigned(2*DATA_WIDTH-1+4 downto 0);
--
--signal overall_output: unsigned(2*DATA_WIDTH-1 downto 0);

signal reg_primitive_mul_out,primitive_adder_out: std_logic_vector(2*DATA_WIDTH-1 downto 0);

signal reg_primitive_mul_out_ex, primitive_adder_out_ex, c_extended: std_logic_vector(2*DATA_WIDTH-1+4 downto 0);

signal overall_output: std_logic_vector(2*DATA_WIDTH-1 downto 0);



signal p_a_reg_t_4_extended: std_logic_vector(2*DATA_WIDTH-1 downto 0);

begin



Pipeline_stage: process(clk) is
begin
if rising_edge(clk) then
	p_a_reg_t(0) <= a;
	p_b_reg_t(0) <= b;	
	
	for i in 1 to NO_OF_PIPELINE_REG-1 loop
		p_a_reg_t(i) <= p_a_reg_t(i-1);
		p_b_reg_t(i) <= p_b_reg_t(i-1);
	end loop;
	
	 p_sel_t(0) <= sel;
	for i in 1 to NO_OF_PIPELINE_REG-1 loop
		p_sel_t(i) <= p_sel_t(i-1);
	end loop;
end if;
end process;

P_reg: process(clk) is
begin
	if rising_edge(clk) then
		if rst = RESET_ACTIVE_LOGIC then
			p <= (others => '0');
		else
			p <= std_logic_vector(overall_output);
		end if;
	end if;
end process;


multiplier: entity work.Primitive_multiplier

	port map
	(
		dataa	=> p_a_reg_t(3),
		datab	=> p_b_reg_t(3),		
		clock => clk,		
		result => reg_primitive_mul_out
		);
		
--Adder: entity work.primitive_Adder_unsigned
--
--	port map
--	(
--		a	=> reg_primitive_mul_out,	 
--		b	=> unsigned(c),--unsigned(c_extended),
--		result => primitive_adder_out
--	);

Adder: entity work.primitive_Adder_unsigned

	port map
	(
		dataa	=> reg_primitive_mul_out_ex,	 
		datab	=> c_extended,
		result => primitive_adder_out_ex
	);

c_extended <= X"0" & c; --pad with 4 zeros to make it up to 40 bits for the adder.
reg_primitive_mul_out_ex <= X"0" & reg_primitive_mul_out;--pad with 4 zeros to make it up to 40 bits for the adder.


p_a_reg_t_4_extended <= "00" & x"0000" & std_logic_vector(p_a_reg_t(4));

	

	overall_output <= p_a_reg_t_4_extended when p_sel_t(4) = "000" else -- Output = A
	reg_primitive_mul_out when p_sel_t(4) = "001"	else-- Output = A * B
	primitive_adder_out_ex(35 downto 0) when p_sel_t(4) = "011" else -- Output = A*B + C
	c when p_sel_t(4) = "110" else	-- Output = C			 		    
	X"000000000";-- Output = zeros


end;