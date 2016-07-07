library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.txt_util.all;
USE ieee.numeric_std.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY_Syn.all;

package MATRIX_MUL_IP_CORE_LIBRARY_Sim is

constant msg1 : string(positive range<>):="############# These are the values saved in BRAM ##############";
constant msg2 : string(positive range<>):="#################################################";
constant msg3 : string(positive range<>):="---------------BEGINNING OF SECTION (See end of Section for details)---------------";
constant msg4 : string(positive range<>):=" ";

constant fileMATRIX_MUL_IP_CORE_S_INT : string(positive range<>):="/home/tsotne/git/ETSE_GDSP/src/io/MATRIX_MUL_IP_CORE_S_INT.txt";
constant fileGdata : string(positive range<>):="/home/tsotne/git/ETSE_GDSP/src/io/Gdata.txt";
constant filePdata : string(positive range<>):="/home/tsotne/git/ETSE_GDSP/src/io/Pdata.txt";

--------------------------------END OF GLOBAL SIGNALS--------------------------------------


procedure print_memarray_data_output(Data_input: inout std_logic_vector(DATA_WIDTH-1 downto 0); clk_period: inout time; stop_signal: inout std_logic);
procedure PrintResultToConsole;
procedure PrintResultInCSVFormat;

end package MATRIX_MUL_IP_CORE_LIBRARY_Sim;

package body MATRIX_MUL_IP_CORE_LIBRARY_Sim is


---------------------------------------------------------Procedures-----------------------------------------------
procedure PrintResultToConsole is
file  Result_file_pointer: Text;
variable line_num: line;
begin
				file_open(Result_file_pointer,"../../TestingFiles/MATRIX_MUL_IP_CORE_S_INT.txt",READ_MODE);
			while not endfile(Result_file_pointer) loop
				Readline(Result_file_pointer,line_num);
				--wait for clk_period;
				Writeline(output,line_num);
			end loop;
			file_close(Result_file_pointer);
end;

procedure PrintResultInCSVFormat is
variable line_num, line_num2: line;
variable v_IsTheValueReadGood: boolean:=true;
variable v_Value: string(1 to 10);
file Result_file_pointer, Result_file_pointer2: Text;
variable line_num_cnt: integer:=0;
begin

file_open(Result_file_pointer2,"../../TestingFiles/MATRIX_MUL_IP_CORE_S_INT_CSV.txt",WRITE_MODE);
			file_open(Result_file_pointer,"../../TestingFiles/MATRIX_MUL_IP_CORE_S_INT.txt",READ_MODE);
			line_num_cnt := 0;

			while not endfile(Result_file_pointer) loop
				ReadLine(Result_file_pointer,line_num);
				if line_num_cnt > 0 and line_num_cnt <= COLUMN_TOTAL then
					--ReadLine(Result_file_pointer,line_num); --procedure read(l : inout line; value : out string; good : out boolean);
					while v_IsTheValueReadGood = true loop
						str_read_remove_spaces(line_num,v_Value,v_IsTheValueReadGood);
					if v_IsTheValueReadGood = true then
						for i in 1 to string_valid_length(v_Value) loop
							write(line_num2, v_Value(i));
						end loop;
						write(line_num2, ',');
					end if;
					end loop;
					Writeline(Result_file_pointer2,line_num2);
					v_IsTheValueReadGood := true;
				end if;
				line_num_cnt := line_num_cnt + 1;
				if line_num_cnt = (COLUMN_TOTAL + 4) then
					line_num_cnt := 1;
				end if;
			end loop;
			file_close(Result_file_pointer2);
			file_close(Result_file_pointer);
end;


  procedure print_memarray_data_output(Data_input: inout std_logic_vector(DATA_WIDTH-1 downto 0); clk_period: inout time; stop_signal: inout std_logic) is
  	variable v_i: integer:=0;
  	variable v_line: line;
  	variable v_BRAM_DATA: t_BRAM_DATA;

   begin
		write(v_line,msg1);
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
		write(v_line,msg2);
		writeline(output, v_line);
	end print_memarray_data_output;

end package body MATRIX_MUL_IP_CORE_LIBRARY_Sim;
