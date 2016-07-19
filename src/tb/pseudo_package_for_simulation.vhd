    --***********************PSEUDO_PACKAGE_DECLARATIONS_START
    -- This part of code is called Pseudo Package, because, in a perfect world, it should be in package declaration. but since this is not vhdl 2008,
    -- I can not pass generic parameters to package, even though i'm using generic parameters in this part of code.
    -- So, i decided that this code will simply be copied to each and every tesbench untouched. having a functionality like a package.
    -- P.s. if you change any 'instance' of this code, change all of them similarrly.
    signal when_to_stop_simulation_flag : std_logic := '0';
        constant CLK_period                 : time      := 10 ns;
        signal CLK                          : std_logic := '0';
        signal RST                          : std_logic := '0';
        signal Bank_sel_in                  : STD_LOGIC := '0';

        type COMMAND is (cmd_G_READ_START, cmd_P_READ_START, cmd_Unload_BRAM_Content, cmd_PG, cmd_PGt, cmd_PtG, cmd_PtGt, cmd_dummy);
        signal CMD : COMMAND;

        type t_BRAM_DATA is array (0 to COLUMN_TOTAL - 1) of std_logic_vector(DATA_WIDTH - 1 downto 0);
        signal BRAM_DATA : t_BRAM_DATA;

        shared variable sv_line             : line;
        shared variable sv_Result_File_Open : boolean;
        signal delay_latency                : integer := 0;

        --Input Files
        constant fileGdata : string(positive range <> ) := "/home/tsotne/git/ETSE_GDSP/src/matlab/g/" & str(COLUMN_TOTAL) & ".txt";
        constant filePdata : string(positive range <> ) := "/home/tsotne/git/ETSE_GDSP/src/matlab/p/" & str(COLUMN_TOTAL) & ".txt";

        --with next two line, i'm getting current entity name,
        constant entitynameRaw : string(positive range <> ) :=  behavior'INSTANCE_NAME;
        constant entityname : string(positive range <> ) :=  entitynameRaw(2 to entitynameRaw'right-11); -- to remove extra characters

        --Output Files
        constant fileOutput     : string(positive range <> ) := "/home/tsotne/git/ETSE_GDSP/src/results/r/" & entityname &"/" & str(COLUMN_TOTAL) & ".txt";
        constant fileOutputCSV : string(positive range <> ) := "/home/tsotne/git/ETSE_GDSP/src/results/rCSV/" & entityname &"/" & str(COLUMN_TOTAL) & ".txt";

        --strings for printing
        constant msg1 : string(positive range <> ) := "############# These are the values saved in BRAM ##############";
        constant msg2 : string(positive range <> ) := "#################################################";
        constant msg3 : string(positive range <> ) := "---------------BEGINNING OF SECTION (See end of Section for details)---------------";
        constant msg4 : string(positive range <> ) := " ";

        constant msgp0 : string(positive range <> ) := "INITIAL DATA";
        constant msgp1 : string(positive range <> ) := "RESULT of P * G";
        constant msgp2 : string(positive range <> ) := "RESULT of P G * G";
        constant msgp3 : string(positive range <> ) := "RESULT of P * Gt";
        constant msgp4 : string(positive range <> ) := "RESULT of PG * Gt";
        constant msgp5 : string(positive range <> ) := "RESULT of Pt * G";
        constant msgp6 : string(positive range <> ) := "RESULT of [PG]t * G";
        constant msgp7 : string(positive range <> ) := "RESULT of Pt * Gt";
        constant msgp8 : string(positive range <> ) := "RESULT of [PG]t * Gt";

        procedure PrintResultToConsole is
            file Result_file_pointer : Text;
            variable line_num : line;
        begin
            file_open(Result_file_pointer, fileOutput, READ_MODE);
            while not endfile(Result_file_pointer) loop
                Readline(Result_file_pointer, line_num);
                Writeline(output, line_num);
            end loop;
            file_close(Result_file_pointer);
        end;

        procedure PrintResultInCSVFormat is
            variable line_num, line_num2  : line;
            variable v_IsTheValueReadGood : boolean := true;
            variable v_Value              : string(1 to 10);
            file Result_file_pointer, Result_file_pointer2 : Text;
            variable line_num_cnt : integer := 0;
        begin
            file_open(Result_file_pointer2, fileOutputCSV, WRITE_MODE);
            file_open(Result_file_pointer, fileOutput, READ_MODE);
            line_num_cnt := 0;
            while not endfile(Result_file_pointer) loop
                ReadLine(Result_file_pointer, line_num);
                if line_num_cnt > 0 and line_num_cnt <= COLUMN_TOTAL then
                    while v_IsTheValueReadGood = true loop
                        str_read_remove_spaces(line_num, v_Value, v_IsTheValueReadGood);
                        if v_IsTheValueReadGood = true then
                            for i in 1 to string_valid_length(v_Value) loop
                                write(line_num2, v_Value(i));
                            end loop;
                            write(line_num2, ',');
                        end if;
                    end loop;
                    Writeline(Result_file_pointer2, line_num2);
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

        function Convert_Real_2_Std(real_number : real; Precision : real) return std_logic_vector is
            variable std : std_logic_vector(DATA_WIDTH - 1 downto 0);
        begin
            std := std_logic_vector(to_signed(integer(real_number * Precision), DATA_WIDTH));
            return std;
        end;

--***********************PSEUDO_PACKAGE_DECLARATIONS_END
