library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.txt_util.all;
USE ieee.numeric_std.ALL;

package MATRIX_MUL_IP_CORE_LIBRARY is

--------------------------------CONSTANTS GENERICS--------------------------------------------------
CONSTANT COLUMN_TOTAL	: integer:=3;
CONSTANT ADDR_WIDTH		: integer:=10;
CONSTANT DATA_WIDTH		:integer:=18;
CONSTANT DATA_WIDE_WIDTH: integer:=48;
CONSTANT OPCODE_WIDTH	: integer:=3;
-----------------------------END OF GENERIC CONSTANTS-------------------------------------------------

---------------------------------------CONSTANT SIGNALS-----------------------------------------------

-------------------------------These are use in CONTROL_UNIT_S_G.vhd and TB_MATRIX_MUL_IP_CORE-----------------------------------

constant IDLE_CMD: std_logic_vector(1 downto 0):="00";
constant LOAD_P_CMD: std_logic_vector(1 downto 0):="01";
constant LOAD_G_CMD: std_logic_vector(1 downto 0):="10";
constant PG_CMD: std_logic_vector(1 downto 0):="11";

-------------------------------------END OF CONSTANT SIGNALS------------------------------------------
 
-------------------------------CUSTOM TYPES------------------------------------------------
type t_BRAM_DATA is array (0 to COLUMN_TOTAL-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal v_BRAM_DATA : t_BRAM_DATA;
-----------------------------END OF CUSTOM TYPES-------------------------------------------

-------------------------------GLOBAL SIGNALS----------------------------------------------

signal g_cnt_delay_ready: integer:=0;
--signal g_DSP_P_OUT: std_logic_vector(47 downto 0);

--------------------------------END OF GLOBAL SIGNALS--------------------------------------
 
 	
procedure print_memarray_data_output(Data_input: inout std_logic_vector(DATA_WIDTH-1 downto 0); clk_period: inout time; stop_signal: inout std_logic);
	
end package MATRIX_MUL_IP_CORE_LIBRARY;

package body MATRIX_MUL_IP_CORE_LIBRARY is
  
  
  procedure print_memarray_data_output(Data_input: inout std_logic_vector(DATA_WIDTH-1 downto 0); clk_period: inout time; stop_signal: inout std_logic) is
  	variable v_i: integer:=0;
  	variable v_line: line;
  	variable v_BRAM_DATA: t_BRAM_DATA;
  	
   begin   		
		write(v_line,"############# These are the values saved in BRAM ##############");
		writeline(output, v_line);
		while stop_signal = '0' loop	-- Read out the values stored in BRAM and display on simulator waveform viewer. The values are read out in exactly the way they were saved.
			
			v_BRAM_DATA(v_i) := Data_input;			
			wait for clk_period;
			v_i := v_i + 1;
			if v_i = COLUMN_TOTAL then
				for k in 0 to COLUMN_TOTAL-1 loop
					if k = 0 then
					write(v_line, "          " & str(to_integer(unsigned(v_BRAM_DATA(COLUMN_TOTAL-1-k)))) & " ");
					else						
						write(v_line, str(to_integer(unsigned(v_BRAM_DATA(COLUMN_TOTAL-1-k)))) & " ");
					end if;
				end loop;
				writeline(output, v_line);
				v_i:=0;
			end if;
			--wait for CLK_period;
		end loop;
		write(v_line,"#################################################");
		writeline(output, v_line);
	end print_memarray_data_output;
   
end package body MATRIX_MUL_IP_CORE_LIBRARY;
