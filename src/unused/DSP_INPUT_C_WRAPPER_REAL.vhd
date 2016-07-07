----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:54:50 07/27/2015 
-- Design Name: 
-- Module Name:    DSP_INPUT_C_WRAPPER - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.g_DSP_P_OUT;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DSP_INPUT_C_WRAPPER_REAL is
		generic(OPCODE_WIDTH: integer:=3; DATA_WIDTH: integer:=18; FRACTION_WIDTH: integer:=12; DATA_WIDE_WIDTH: integer:=48 );
		port(	clk : IN  std_logic;
			Normalize : std_logic;
         sel : IN  std_logic_vector(OPCODE_WIDTH-1 downto 0);
         a : IN  std_logic_vector(DATA_WIDTH-1 downto 0);
         b : IN  std_logic_vector(DATA_WIDTH-1 downto 0);
         c : IN  std_logic_vector(DATA_WIDE_WIDTH-1 downto 0);
         p : OUT  std_logic_vector(DATA_WIDE_WIDTH-1 downto 0)
			);
end DSP_INPUT_C_WRAPPER_REAL;

architecture Behavioral of DSP_INPUT_C_WRAPPER_REAL is

signal s_DSP_P_Output: std_logic_vector(DATA_WIDE_WIDTH-1 downto 0);
signal s_p : std_logic_vector(DATA_WIDE_WIDTH-1 downto 0);

begin

DSP: entity work.DSP_INPUT_C
    PORT map(
         clk 	=> clk,
         sel 	=> sel,
         a 		=> a,
         b 		=> b,
         c 		=> c,
         p 		=> s_DSP_P_Output
        );       
s_p <= s_DSP_P_Output when Normalize = '0' else to_stdlogicvector(to_bitvector(s_DSP_P_Output) sra FRACTION_WIDTH);
p <= s_p(DATA_WIDE_WIDTH-1 downto 1) & (s_DSP_P_Output(13) or s_DSP_P_Output(12)) when Normalize = '1' else s_DSP_P_Output;--not the best implementation, but this is just for test purpose.

--p <= s_DSP_P_Output when Normalize = '0' else to_stdlogicvector(to_bitvector(s_DSP_P_Output) sra FRACTION_WIDTH);
   
end Behavioral;

