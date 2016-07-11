-- Create Date:   11:22:55 07/03/2015
-- Module Name:   C:/FPGA/Internship Jobs/Codes/ETSE_GDSP/Matrix_for_RBM/TB_MEMARRAY_V3.vhd
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use STD.textio.all;
use work.txt_util.all;
use work.MATRIX_MUL_IP_CORE_LIBRARY_Syn.all;
use work.MATRIX_MUL_IP_CORE_LIBRARY_Sim.all;

ENTITY TB_MATRIX_MUL_IP_CORE_S_INT IS
generic(
		COLUMN_TOTAL: integer:=8;
      ADDR_WIDTH: integer:=10;
      DATA_WIDTH:integer:=18;
      FRACTION_WIDTH:integer:=12;
		DATA_WIDE_WIDTH: integer:=48;
		OPCODE_WIDTH: integer:=3
   );
END TB_MATRIX_MUL_IP_CORE_S_INT;

ARCHITECTURE behavior OF TB_MATRIX_MUL_IP_CORE_S_INT IS
---------------------------------------------------General Signals----------------------------------------------

	--Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal Mul_DIN: std_logic_vector(DATA_WIDTH-1 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;

   -- Control Signals----
   signal DATA_INPUT: std_logic:='0';
   signal GREAD_DONE: std_logic :='0';
   type COMMAND is (cmd_G_READ_START,cmd_P_READ_START,cmd_Unload_BRAM_Content,cmd_PG,cmd_PGt,cmd_PtG,cmd_PtGt, cmd_dummy);
   signal CMD: COMMAND;

   signal MSG: string(1 to 40);
   shared variable sv_line: line;
   shared variable sv_Result_File_Open: boolean;
   file Result_file_pointer: Text;

-------------------------------------------------End of General Signals------------------------------------------

---------------------------------------------------MEMARRY_V3 Signals--------------------------------------------

	--Inputs
--   signal Ctrl_BRAM : STD_LOGIC:='0';
--   signal P_SHFT_IN : STD_LOGIC:='0';
--   signal ADDRB : std_logic_vector(ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(3,10));--(others => '0');
   signal OE : std_logic := '0';
   signal SSEN : std_logic := '0';

   signal LOAD : std_logic := '1';
   signal P : std_logic := '0';
   signal G : std_logic := '0';

   signal DIN : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
	signal UN_LOAD : STD_LOGIC;
 	--Outputs
   signal DOUT : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal f_gROW : std_logic_vector(ADDR_WIDTH-1 downto 0);
   signal f_gCOL : std_logic_vector(ADDR_WIDTH-1 downto 0);
   signal READY : std_logic;
   signal OP_DONE : std_logic;
   signal LOADING_DONE : std_logic;
	signal UN_LOADING_DONE : std_logic;
	signal delay_latency: integer:=0;

-------------------------------------------------End of MEMARRY_V3 Signals---------------------------------------

--------------------------------------------------------GRAM Signals---------------------------------------------

   signal gROW : STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
   signal gCOL : STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
   signal gDIN : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
   signal gDOUT : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
   signal gWE : STD_LOGIC;
   signal f_gOE : STD_LOGIC;

	signal MUL_GCOL : std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal MUL_GROW : std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal Bank_sel_in : STD_LOGIC:='0';

----------------------------------------------------End of GRAM Signals ------------------------------------------

type t_BRAM_DATA is array (0 to COLUMN_TOTAL-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal BRAM_DATA : t_BRAM_DATA;



--------------GENERICS START
--------------PACKAGEDECLARATION
--Input Files
constant fileGdata                          : string(positive range<>):="/home/tsotne/git/ETSE_GDSP/src/matlab/g/" & str(COLUMN_TOTAL) & ".txt";
constant filePdata                          : string(positive range<>):="/home/tsotne/git/ETSE_GDSP/src/matlab/p/" & str(COLUMN_TOTAL) & ".txt";

--Output Files
constant fileMATRIX_MUL_IP_CORE_S_INT       : string(positive range<>):="/home/tsotne/git/ETSE_GDSP/src/results/r/" & str(COLUMN_TOTAL) & ".txt";
constant fileMATRIX_MUL_IP_CORE_S_INT_CSV   : string(positive range<>):="/home/tsotne/git/ETSE_GDSP/src/results/rCSV/" & str(COLUMN_TOTAL) & ".txt";
--------------GENERICS END


constant msg1 : string(positive range<>):="############# These are the values saved in BRAM ##############";
constant msg2 : string(positive range<>):="#################################################";
constant msg3 : string(positive range<>):="---------------BEGINNING OF SECTION (See end of Section for details)---------------";
constant msg4 : string(positive range<>):=" ";

constant msgp0 : string(positive range<>):="INITIAL DATA";
constant msgp1 : string(positive range<>):="RESULT of P * G";
constant msgp2 : string(positive range<>):="RESULT of P G * G";
constant msgp3 : string(positive range<>):="RESULT of P * Gt";
constant msgp4 : string(positive range<>):="RESULT of PG * Gt";
constant msgp5 : string(positive range<>):="RESULT of Pt * G";
constant msgp6 : string(positive range<>):="RESULT of [PG]t * G";
constant msgp7 : string(positive range<>):="RESULT of Pt * Gt";
constant msgp8 : string(positive range<>):="RESULT of [PG]t * Gt";



---------------------------------------------------------Procedures-----------------------------------------------
procedure PrintResultToConsole is
file  Result_file_pointer: Text;
variable line_num: line;
begin
				file_open(Result_file_pointer,fileMATRIX_MUL_IP_CORE_S_INT,READ_MODE);
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

            file_open(Result_file_pointer2,fileMATRIX_MUL_IP_CORE_S_INT_CSV,WRITE_MODE);
			file_open(Result_file_pointer,fileMATRIX_MUL_IP_CORE_S_INT,READ_MODE);
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
--------------PACKAGEDECLARATION

constant LOAD_P_CMD: std_logic_vector(1 downto 0):="01";
constant LOAD_G_CMD: std_logic_vector(1 downto 0):="00";
signal g_cnt_delay_ready: integer:=0;

BEGIN


Mul_DIN	 <= DIN when DATA_INPUT = '0' else gDOUT;


process(cmd, f_gCOL, f_gROW, gCOL, gROW)
begin
	if cmd = cmd_G_READ_START then
		MUL_GCOL <= gCOL;
		MUL_GROW <= gROW;
  	else
  		MUL_GCOL <=	f_gCOL;
  		MUL_GROW <= f_gROW; ----STDRM
  	end if;
end process;

   uut: entity work.MATRIX_MUL_IP_CORE_S_INT
generic map(
	COLUMN_TOTAL => COLUMN_TOTAL,
	OPCODE_WIDTH => OPCODE_WIDTH,
    ADDR_WIDTH => ADDR_WIDTH,
    DATA_WIDTH => DATA_WIDTH,
	DATA_WIDE_WIDTH => DATA_WIDE_WIDTH
   )
	PORT MAP (
          CLK => CLK,
          RST => RST,
          LOAD => LOAD,
          UN_LOAD => UN_LOAD,
          P => P,
          G => G,
          Bank_sel_in => Bank_sel_in,
          DIN => Mul_DIN,
          DOUT => DOUT,
          G_ROW => f_gROW,
          G_COLUMN => f_gCOL,
          G_O_EN => f_gOE,
          READY		=> READY,
          OP_DONE => OP_DONE,
          LOADING_DONE => LOADING_DONE,
          UN_LOADING_DONE => UN_LOADING_DONE
        );

GRAM:	entity work.STANDARD_RAM
generic map(
		COLUMN_TOTAL => COLUMN_TOTAL,		-- num columns in ram //4
      ADDR_WIDTH => ADDR_WIDTH,		-- log2 of rows //10
      DATA_WIDTH => DATA_WIDTH			--//18
   )
    Port map ( CLK 	=> CLK ,
           ROW 		=> Mul_gROW,
           COL 		=> Mul_gCOL,
           DIN 		=> gDIN,
           DOUT 	=> gDOUT,
           WE 		=> gWE,
           OE 		=> f_gOE
           );

--GRAM:	entity work.GRAM
--    Port map ( CLK 	=> CLK ,
--           ROW 		=> Mul_gROW,
--           COL 		=> Mul_gCOL,
--           DIN 		=> gDIN,
--           DOUT 	=> gDOUT,
--           WE 		=> gWE,
--           OE 		=> f_gOE
--           );

    -- Clock process definitions
CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;


CONTROL: process
variable line_num, line_num2: line;
variable v_IsTheValueReadGood: boolean:=true;
variable v_Value: string(1 to 10);
file Result_file_pointer, Result_file_pointer2: Text;
variable line_num_cnt: integer:=0;
variable c:         character;
variable is_string: boolean;
variable v_delay_latency: integer;
begin

------------------------------------------- Load GRAM and Load BRAM with initial Data ---------------------------------------------------------------------------------
	CMD <= cmd_G_READ_START;
	wait until GREAD_DONE<='1';

	Bank_sel_in <= '0'; -- Tell BRAM to save data in upper bank
	CMD <= cmd_P_READ_START;
	wait until LOADING_DONE ='1';
	v_delay_latency := g_cnt_delay_ready; --get the time at which the operation completed

	--file_open(Result_file_pointer,"../TestingFiles/PG_Result.txt",WRITE_MODE);
	sv_Result_File_Open := false;
    --work.txt_util.
    write(sv_line,msgp0);
    --write(sv_line,"INITIAL DATA" );--Data loaded into BRAM. " & str(v_delay_latency) & " clock cycles to load,");
	Bank_sel_in <= '1'; -- Tell BRAM to Read from upper Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
	CMD <= cmd_Unload_BRAM_Content;
	wait until UN_LOADING_DONE = '1';
------------------------------------------End of Load GRAM and Load BRAM ------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------Compute P * G -----------------------------------------------------------------------------

	CMD <= cmd_dummy; -- fake command. This was necessary because the simulator will not respond unless this fake command is used to create an event. I guess it is a bug.
	wait for clk_period;
	CMD <= cmd_PG; --Real Command
	Bank_sel_in <= '1'; -- Tell BRAM to save result in lower bank.
	wait until OP_DONE= '1';

	v_delay_latency := g_cnt_delay_ready;--get the time at which the operation completed
	sv_Result_File_Open := true;

    --work.txt_util.
    write(sv_line,msgp1);
    --write(sv_line,"RESULT of P * G");--from upper bank of BRAM. " & str(v_delay_latency) & " clock cycles to finish multiplication, ");
	Bank_sel_in <= '0'; -- Tell BRAM to Read from lower Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
	CMD <= cmd_Unload_BRAM_Content;
	wait until UN_LOADING_DONE = '1';

	CMD <= cmd_dummy;-- fake command. used to force the simulator to see a change in the process.
	wait for clk_period;
	CMD <= cmd_PG; --Real Command
	Bank_sel_in <= '0'; -- Tell BRAM to save result in lower bank.
	wait until OP_DONE = '1';
	v_delay_latency := g_cnt_delay_ready;--get the time at which the operation completed


    --work.txt_util.
    write(sv_line,msgp2);
    --write(sv_line,"RESULT of P G * G");-- from upper bank of BRAM. " & str(v_delay_latency) & " clock cycles to finish multiplication, ");
	Bank_sel_in <= '1'; -- Tell BRAM to Read from lower Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
    CMD <= cmd_Unload_BRAM_Content;
	wait until UN_LOADING_DONE = '1';
	----------------------------------------------------------------------End of Comput P * G -----------------------------------------------------------

	-----------------------------------------------------------------------Compute P * Gt ---------------------------------------------------------------

	-------------------------------Reload BRAM with initial data -----------------------------------
	CMD <= cmd_dummy; -- fake command. This was necessary because the simulator will not respond unless this fake command is used to create an event. I guess it is a bug.
	wait for clk_period;
	Bank_sel_in <= '0'; -- Tell BRAM to save data in upper bank
	CMD <= cmd_P_READ_START;
	wait until LOADING_DONE ='1';
	v_delay_latency := g_cnt_delay_ready; --get the time at which the operation completed
	-------------------------------------------------------------------------------------------------

--	------------------------------------------------------------Display Values ---------------------------------------------------------------------------------------
--	Bank_sel_in <= '1'; -- Tell BRAM to Read from upper Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
--	CMD <= cmd_Unload_BRAM_Content;
--	write(sv_line," Data loaded into BRAM. " & str(v_delay_latency) & " clock cycles to load,");
--	wait until UN_LOADING_DONE = '1';
--    ------------------------------------------End of Display Values ------------------------------------------------------------------------------------------


	CMD <= cmd_dummy; -- fake command. This was necessary because the simulator will not respond unless this fake command is used to create an event. I guess it is a bug.
	wait for clk_period;
	CMD <= cmd_PGt; --Real Command
	Bank_sel_in <= '1'; -- Tell BRAM to save result in lower bank.
	wait until OP_DONE= '1';

	v_delay_latency := g_cnt_delay_ready;--get the time at which the operation completed
	sv_Result_File_Open := true;

    --work.txt_util.
    write(sv_line,msgp3);
    --write(sv_line,"RESULT of P * Gt");-- from upper bank of BRAM. " & str(v_delay_latency) & " clock cycles to finish multiplication, ");
    Bank_sel_in <= '0'; -- Tell BRAM to Read from lower Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
    CMD <= cmd_Unload_BRAM_Content;
	wait until UN_LOADING_DONE = '1';

	CMD <= cmd_dummy;-- fake command. used to force the simulator to see a change in the process.
	wait for clk_period;
	CMD <= cmd_PGt; --Real Command
	Bank_sel_in <= '0'; -- Tell BRAM to save result in upper bank.
	wait until OP_DONE = '1';
	v_delay_latency := g_cnt_delay_ready;--get the time at which the operation completed


	--work.txt_util.
    write(sv_line,msgp4);
    --write(sv_line,"RESULT of PG * Gt");-- from upper bank of BRAM. " & str(v_delay_latency) & " clock cycles to finish multiplication, ");
    Bank_sel_in <= '1'; -- Tell BRAM to Read from lower Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
    CMD <= cmd_Unload_BRAM_Content;
	wait until UN_LOADING_DONE = '1';
----------------------------------------------------------------- End of Comput P * Gt ------------------------------------------------------------------

-----------------------------------------------------------------------Compute Pt * G --------------------------------------------------------------------

	-------------------------------Reload BRAM with initial data -----------------------------------
	CMD <= cmd_dummy; -- fake command. This was necessary because the simulator will not respond unless this fake command is used to create an event. I guess it is a bug.
	wait for clk_period;
	Bank_sel_in <= '0'; -- Tell BRAM to save data in upper bank
	CMD <= cmd_P_READ_START;
	wait until LOADING_DONE ='1';
	v_delay_latency := g_cnt_delay_ready; --get the time at which the operation completed
	-------------------------------------------------------------------------------------------------

--	------------------------------------------------------------Display Values ---------------------------------------------------------------------------------------
--	Bank_sel_in <= '1'; -- Tell BRAM to Read from upper Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
--	CMD <= cmd_Unload_BRAM_Content;
--	write(sv_line," Data loaded into BRAM. " & str(v_delay_latency) & " clock cycles to load,");
--	wait until UN_LOADING_DONE = '1';
--    ------------------------------------------End of Display Values ------------------------------------------------------------------------------------------


	CMD <= cmd_dummy; -- fake command. This was necessary because the simulator will not respond unless this fake command is used to create an event. I guess it is a bug.
	wait for clk_period;
	CMD <= cmd_PtG; --Real Command
	Bank_sel_in <= '1'; -- Tell BRAM to save result in lower bank.
	wait until OP_DONE= '1';

	v_delay_latency := g_cnt_delay_ready;--get the time at which the operation completed
	sv_Result_File_Open := true;

    --work.txt_util.
    write(sv_line,msgp5);
    --write(sv_line,"RESULT of Pt * G");-- from upper bank of BRAM. " & str(v_delay_latency) & " clock cycles to finish multiplication, ");
    Bank_sel_in <= '0'; -- Tell BRAM to Read from lower Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
    CMD <= cmd_Unload_BRAM_Content;
	wait until UN_LOADING_DONE = '1';

	CMD <= cmd_dummy;-- fake command. used to force the simulator to see a change in the process.
	wait for clk_period;
	CMD <= cmd_PtG; --Real Command
	Bank_sel_in <= '0'; -- Tell BRAM to save result in upper bank.
	wait until OP_DONE = '1';
	v_delay_latency := g_cnt_delay_ready;--get the time at which the operation completed


    --work.txt_util.
    write(sv_line,msgp6);
    --write(sv_line,"RESULT of [PG]t * G");-- from upper bank of BRAM. " & str(v_delay_latency) & " clock cycles to finish multiplication, ");
	Bank_sel_in <= '1'; -- Tell BRAM to Read from upper Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
    CMD <= cmd_Unload_BRAM_Content;
	wait until UN_LOADING_DONE = '1';
----------------------------------------------------------------- End of Comput Pt * G ------------------------------------------------------------------

-----------------------------------------------------------------------Compute Pt * Gt --------------------------------------------------------------------

	-------------------------------Reload BRAM with initial data -----------------------------------
	CMD <= cmd_dummy; -- fake command. This was necessary because the simulator will not respond unless this fake command is used to create an event. I guess it is a bug.
	wait for clk_period;
	Bank_sel_in <= '0'; -- Tell BRAM to save data in upper bank
	CMD <= cmd_P_READ_START;
	wait until LOADING_DONE ='1';
	v_delay_latency := g_cnt_delay_ready; --get the time at which the operation completed
	-------------------------------------------------------------------------------------------------

--	------------------------------------------------------------Display Values ---------------------------------------------------------------------------------------
--	Bank_sel_in <= '1'; -- Tell BRAM to Read from upper Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
--	CMD <= cmd_Unload_BRAM_Content;
--	write(sv_line," Data loaded into BRAM. " & str(v_delay_latency) & " clock cycles to load,");
--	wait until UN_LOADING_DONE = '1';
--    ------------------------------------------End of Load GRAM and Load BRAM ------------------------------------------------------------------------------------------


	CMD <= cmd_dummy; -- fake command. This was necessary because the simulator will not respond unless this fake command is used to create an event. I guess it is a bug.
	wait for clk_period;
	CMD <= cmd_PtGt; --Real Command
	Bank_sel_in <= '1'; -- Tell BRAM to save result in lower bank.
	wait until OP_DONE= '1';

	v_delay_latency := g_cnt_delay_ready;--get the time at which the operation completed
	sv_Result_File_Open := true;

    --work.txt_util.
    write(sv_line,msgp7);
    --write(sv_line,"RESULT of Pt * Gt");-- from upper bank of BRAM. " & str(v_delay_latency) & " clock cycles to finish multiplication, ");
	Bank_sel_in <= '0'; -- Tell BRAM to Read from lower Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
	CMD <= cmd_Unload_BRAM_Content;
	wait until UN_LOADING_DONE = '1';

	CMD <= cmd_dummy;-- fake command. used to force the simulator to see a change in the process.
	wait for clk_period;
	CMD <= cmd_PtGt; --Real Command
	Bank_sel_in <= '0'; -- Tell BRAM to save result in upper bank.
	wait until OP_DONE = '1';
	v_delay_latency := g_cnt_delay_ready;--get the time at which the operation completed


    --work.txt_util.
    write(sv_line,msgp8);
    --write(sv_line,"RESULT of [PG]t * Gt");-- from upper bank of BRAM. " & str(v_delay_latency) & " clock cycles to finish multiplication, ");
    Bank_sel_in <= '1'; -- Tell BRAM to Read from upper Bank. Note MSB of ADDR Port B is Banksel and it is inverted.
	CMD <= cmd_Unload_BRAM_Content;
	wait until UN_LOADING_DONE = '1';
----------------------------------------------------------------- End of Comput Pt * Gt ------------------------------------------------------------------

wait for clk_period; -- wait for the all values to be written to file

PrintResultToConsole; -- Procedure to print the result to console. Read from Result file then print to console.
PrintResultInCSVFormat; -- Procedure to print the result to a file in CSV format.





end process;


Execution_Process:process
file file_pointer : text;
file Result_file_pointer: text;
variable line_num, line_num2: line;
type t_line_array is array (0 to COLUMN_TOTAL-1) of line;
variable v_line_array: t_line_array;
variable x: integer:=0;
variable I_MAX,J_MAX :integer:=0;
variable i:integer:=0;
begin

	case cmd is
		when cmd_G_READ_START =>
		---------------------------------------Begining of GRAM LOAD-----------------------------------------------------
					rst <= '1';
					file_open(file_pointer,fileGdata,READ_MODE);  --TSO
					readline (file_pointer,line_num);
					read(line_num,I_MAX);
					readline (file_pointer,line_num);
					read(line_num,J_MAX);
					report "COLS number: " & integer'image(I_MAX);
					report "ROWS number:" & integer'image(J_MAX);
					GWE<='1';
					--  Assuming that file has enough lines as stated in first two lines COLS and ROWS
					      for i in 1 to I_MAX loop
									for j in 1 to J_MAX loop
										readline (file_pointer,line_num);  --Read the whole line from the file
										READ (line_num,x);
										--report "The value of G" & integer'image(i) & integer'image(j) &" = " & integer'image(x);
												GCOL<=std_logic_vector(to_unsigned(i-1,ADDR_WIDTH));
												GROW<=std_logic_vector(to_signed(j-1,ADDR_WIDTH));
												GDIN<=std_logic_vector(to_signed(x,DATA_WIDTH)); --STDRM
												wait for CLK_period;
									end loop;
					        end loop;
			       	file_close(file_pointer);  --after reading all the lines close the file.
					GWE<='0';--disable writing.
			      	GREAD_DONE<='1';

		----------------------------------------End of GRAM LOAD---------------------------------------------------------
		when cmd_P_READ_START =>
		---------------------------------------Begining of BRAM LOAD-----------------------------------------------------
				rst <= '1'; --release FSM from Reset state
				LOAD <= '1';--PUT the FSM in MEMARRAY_V3 in Loading State.
				wait for clk_period*3;
				rst <= '0';
				DATA_INPUT <= '0';-- Switch Input data of MEMARRAY_V3 to DIN
			    -------------------------------------------------- READING THE P MATRIX from file to device
				  file_open(file_pointer,filePdata,READ_MODE);
					--LOAD <= '1';--PUT the FSM in MEMARRAY_V3 in Loading State.

					wait until READY = '1';-- wait unitl MEMARRAY_V3 sends ready signal.
					for i in 1 to COLUMN_TOTAL loop
						for j in 1 to COLUMN_TOTAL loop
							readline (file_pointer,line_num);  --Read the whole line from the file
							READ (line_num,x);
							--report "The value of P" & integer'image(i) & integer'image(j) &" = " & integer'image(x);
							DIN <= std_logic_vector(to_signed(x,DATA_WIDTH)); --TSO
							wait for CLK_period;
						end loop;
					end loop;
					file_close(file_pointer);  --after reading all the lines close the file.
					DIN <= (others => '0');

		----------------------------------------End of BRAM LOAD---------------------------------------------------------

		when cmd_Unload_BRAM_Content =>
		-----------------------------------------Begining of UNLOAD BRAM-------------------------------------------------
			LOAD <= '0';
			UN_LOAD <= '1'; -- Tell FSM to go to unloading state.
			--Bank_sel_in <= '1'; -- Tell BRAM to read data from upper bank. Note that this bit is the MSB of ADDRB and it is inverted For Address B. making it 1 means it is 0 for address B
			wait for clk_period*3;
			wait until READY = '1';
			wait for clk_period;
		---------------------------------Write the values to Terminal---------------------
			i:=0;
			if sv_Result_File_Open = false then
				file_open(Result_file_pointer,fileMATRIX_MUL_IP_CORE_S_INT, WRITE_MODE);
			else
				file_open(Result_file_pointer,fileMATRIX_MUL_IP_CORE_S_INT, APPEND_MODE);
			end if;
			-- write(line_num,msg3);
--			writeline(output, line_num);
			writeline(Result_file_pointer,line_num);
			while UN_LOADING_DONE = '0' loop	-- Read out the values stored in BRAM and display on simulator waveform viewer. The values are read out in exactly the way they were saved.

				BRAM_DATA(i) <= dout;
				wait for CLK_period;
				i := i + 1;
				if i = COLUMN_TOTAL then
					for k in 0 to COLUMN_TOTAL-1 loop
						if k = 0 then
							write(line_num,str(to_integer(unsigned(BRAM_DATA(COLUMN_TOTAL-1-k)))),LEFT,10);
							--write(v_line_array(k),str(to_integer(unsigned(BRAM_DATA(COLUMN_TOTAL-1-k)))),RIGHT,10);
						else
							write(line_num, str(to_integer(unsigned(BRAM_DATA(COLUMN_TOTAL-1-k)))),LEFT,10);
							--write(v_line_array(k),str(to_integer(unsigned(BRAM_DATA(COLUMN_TOTAL-1-k)))),RIGHT,10);
						end if;
					end loop;
					--writeline(output, line_num);
					writeline(Result_file_pointer,line_num);
					i:=0;
				end if;
			end loop;

			-- write(sv_line, str(g_cnt_delay_ready) & " clock cycles to unload" & "---------------");
			--writeline(output, sv_line);
			writeline(Result_file_pointer,sv_line);
			write(line_num,msg4);-- write empty space
			--writeline(output, line_num);-- write empty new line
			writeline(Result_file_pointer,line_num);
			file_close(Result_file_pointer);
		----------------------------------------End of UNLOAD BRAM--------------------------------------------------------
		when cmd_PG =>
			LOAD <= '0';	-- Tell FSM not to LOAD data.
			UN_LOAD <= '0'; -- Tell FSM not to go to unloading state.
			DATA_INPUT <= '1'; -- Switch Input data of MEMARRAY_V3 to GRAM.
			P <= '0';
			G <= '0';
			rst <= '1';
			wait for clk_period*3;
			rst <= '0';
			wait until OP_DONE = '1';

		when cmd_PGt =>
			LOAD <= '0';	-- Tell FSM not to LOAD data.
			UN_LOAD <= '0'; -- Tell FSM not to go to unloading state.
			DATA_INPUT <= '1'; -- Switch Input data of MEMARRAY_V3 to GRAM.
			P <= '0';
			G <= '1';
			rst <= '1';
			wait for clk_period*3;
			rst <= '0';
			wait until OP_DONE = '1';

		when cmd_PtG =>
			LOAD <= '0';	-- Tell FSM not to LOAD data.
			UN_LOAD <= '0'; -- Tell FSM not to go to unloading state.
			DATA_INPUT <= '1'; -- Switch Input data of MEMARRAY_V3 to GRAM.
			P <= '1';
			G <= '0';
			rst <= '1';
			wait for clk_period*3;
			rst <= '0';
			wait until OP_DONE = '1';


		when cmd_PtGt =>
			LOAD <= '0';	-- Tell FSM not to LOAD data.
			UN_LOAD <= '0'; -- Tell FSM not to go to unloading state.
			DATA_INPUT <= '1'; -- Switch Input data of MEMARRAY_V3 to GRAM.
			P <= '1';
			G <= '1';
			rst <= '1';
			wait for clk_period*3;
			rst <= '0';
			wait until OP_DONE = '1';
		when others =>
			--do nothing dummy command.
	end case;

	wait on cmd;

end process;

END;
