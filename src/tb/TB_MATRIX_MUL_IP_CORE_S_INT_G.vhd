LIBRARY ieee;---
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use STD.textio.all;
use work.txt_util.all;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

ENTITY TB_MATRIX_MUL_IP_CORE_S_INT_G IS
    generic(
        COLUMN_TOTAL    : integer := 2;
        ADDR_WIDTH      : integer := 10;
        DATA_WIDTH      : integer := 18;
        DATA_WIDE_WIDTH : integer := 48;
        OPCODE_WIDTH    : integer := 3
    );

END TB_MATRIX_MUL_IP_CORE_S_INT_G;

ARCHITECTURE behavior OF TB_MATRIX_MUL_IP_CORE_S_INT_G IS
    signal LOAD_PG : std_logic_vector(1 downto 0) := "00"; --'1';
    signal P    : std_logic                    := '0';
    signal G    : std_logic                    := '0';

    signal DIN     : std_logic_vector(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal UN_LOAD : STD_LOGIC;

    --Outputs
    signal DOUT            : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal READY           : std_logic;
    signal OP_DONE         : std_logic;
    signal LOADING_DONE    : std_logic;
    signal UN_LOADING_DONE : std_logic;

    type t_BRAM_DATA_integer is array (1 to COLUMN_TOTAL * COLUMN_TOTAL) of integer;
    signal input_arr_G : t_BRAM_DATA_integer := (1,2,3,4);
    signal input_arr_P : t_BRAM_DATA_integer := (1,2,3,4);

    type t_BRAM_DATA_integer_big is array (0 to COLUMN_TOTAL * COLUMN_TOTAL * 3 - 1) of integer;
    signal input_arr_R : t_BRAM_DATA_integer_big := (others => 0);

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
        constant fileGdata : string := "/home/tsotne/git/ETSE_GDSP/src/matlab/g/" & str(COLUMN_TOTAL) & ".txt";
        constant filePdata : string := "/home/tsotne/git/ETSE_GDSP/src/matlab/p/" & str(COLUMN_TOTAL) & ".txt";

        --with next two line, i'm getting current entity name,
        constant entitynameRaw : string :=  behavior'INSTANCE_NAME;
        constant entityname : string :=  entitynameRaw(2 to entitynameRaw'right-11); -- to remove extra characters

        --Output Files
        constant fileOutput     : string := "/home/tsotne/git/ETSE_GDSP/src/results/r/" & entityname &"/" & str(COLUMN_TOTAL) & ".txt";
        constant fileOutputCSV : string := "/home/tsotne/git/ETSE_GDSP/src/results/rCSV/" & entityname &"/" & str(COLUMN_TOTAL) & ".txt";

        --strings for printing
        constant msg1 : string := "############# These are the values saved in BRAM ##############";
        constant msg2 : string := "#################################################";
        constant msg3 : string := "---------------BEGINNING OF SECTION (See end of Section for details)---------------";
        constant msg4 : string := " ";

        constant msgp0 : string := "INITIAL DATA";
        constant msgp1 : string := "RESULT of P * G";
        constant msgp2 : string := "RESULT of P G * G";
        constant msgp3 : string := "RESULT of P * Gt";
        constant msgp4 : string := "RESULT of PG * Gt";
        constant msgp5 : string := "RESULT of Pt * G";
        constant msgp6 : string := "RESULT of [PG]t * G";
        constant msgp7 : string := "RESULT of Pt * Gt";
        constant msgp8 : string := "RESULT of [PG]t * Gt";

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


BEGIN
    when_to_stop_simulation: process(UN_LOADING_DONE, CLK)
        -- this process is used to identify when simulation should stop.
        -- i'm using signal UN_LOADING_DONE. during simulation it becomes '1' but for short times ( < 1000 ns)
        -- so if that signal is '1' as long as 1000 ns, then i set when_to_stop_simulation_flag to '1' meaning that it's time to stop simulation.
        -- later, i'm using that flag in a condition in file: ETSE_GDSP/src/tcl/vivado/tclbatch_for_sim.tcl
    begin
        if rising_edge(CLK) then
            if UN_LOADING_DONE = '1' and UN_LOADING_DONE'STABLE(1000 ns) then
                when_to_stop_simulation_flag <= '1';
            end if;
        end if;
    end process;

    uut : entity work.MATRIX_MUL_IP_CORE_S_INT_G
        generic map(
            COLUMN_TOTAL    => COLUMN_TOTAL,
            OPCODE_WIDTH    => OPCODE_WIDTH,
            ADDR_WIDTH      => ADDR_WIDTH,
            DATA_WIDTH      => DATA_WIDTH,
            DATA_WIDE_WIDTH => DATA_WIDE_WIDTH
        )
        PORT MAP(
            CLK             => CLK,
            RST             => RST,
            LOAD_PG         => LOAD_PG,
            UN_LOAD         => UN_LOAD,
            P               => P,
            G               => G,
            Bank_sel_in     => Bank_sel_in,
            DIN             => DIN,
            DOUT            => DOUT,
            READY           => READY,
            OP_DONE         => OP_DONE,
            LOADING_DONE    => LOADING_DONE,
            UN_LOADING_DONE => UN_LOADING_DONE
        );

    -- Clock process definitions
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_period / 2;
        CLK <= '1';
        wait for CLK_period / 2;
    end process;

    CONTROL : process
        variable line_num, line_num2  : line;
        variable v_IsTheValueReadGood : boolean := true;
        variable v_Value              : string(1 to 10);
        file Result_file_pointer, Result_file_pointer2 : Text;
        variable line_num_cnt    : integer := 0;
        variable c               : character;
        variable is_string       : boolean;
        variable v_delay_latency : integer;
    begin

        CMD <= cmd_G_READ_START;
        wait until LOADING_DONE = '1';

        CMD <= cmd_P_READ_START;
        Bank_sel_in <= '0';             -- upper bank
        wait until LOADING_DONE = '1';

        sv_Result_File_Open := false;

        CMD                 <= cmd_Unload_BRAM_Content;
        Bank_sel_in         <= '1';--inv 0
        wait until UN_LOADING_DONE = '1';
        wait for clk_period;

        -----------Compute P * G ---------
            CMD         <= cmd_PG;          --Real Command
            Bank_sel_in <= '1';             -- Tell BRAM to save result in lower bank.
            wait until OP_DONE = '1';

            sv_Result_File_Open := true;

            CMD         <= cmd_Unload_BRAM_Content;
            Bank_sel_in <= '0';--inv 1
            wait until UN_LOADING_DONE = '1';
            wait for clk_period;


            CMD         <= cmd_PG;
            Bank_sel_in <= '0';
            wait until OP_DONE = '1';


            CMD         <= cmd_Unload_BRAM_Content;
            Bank_sel_in <= '1';--inv 0
            wait until UN_LOADING_DONE = '1';

        wait;

    end process;

    Execution_Process : process
        --X
        file file_pointer : text;
        file Result_file_pointer : text;
        variable line_num, line_num2 : line;
        --X
        type t_line_array is array (0 to COLUMN_TOTAL - 1) of line;
        variable v_line_array : t_line_array;
        variable x            : integer := 0;
        variable I_MAX, J_MAX : integer := COLUMN_TOTAL;
        variable i            : integer := 0;
        variable iram         : integer := 0;
    begin
        case cmd is
            when cmd_G_READ_START =>
                ------------------Begining of GRAM LOAD_PG------
                --when becoems 0, on third clock cycle from that, data shoulb be there
                rst  <= '1';
                wait for clk_period;
                LOAD_PG <= LOAD_G_CMD;
                rst <= '0';
                wait for clk_period * 2;

                -- wait until READY = '1';
                for i in 1 to COLUMN_TOTAL * COLUMN_TOTAL loop
                    DIN <= std_logic_vector(to_signed(input_arr_G(i), DATA_WIDTH));
                    wait for CLK_period;
                end loop;
                DIN <= (others => '0');

            -------------------End of GRAM LOAD_PG----------
            when cmd_P_READ_START =>
                ------------------Begining of BRAM LOAD_PG------

                LOAD_PG <= LOAD_P_CMD;


                wait until READY = '1'; -- wait unitl MEMARRAY_V3 sends ready signal.
                for i in 1 to COLUMN_TOTAL * COLUMN_TOTAL loop
                    DIN <= std_logic_vector(to_signed(input_arr_P(i), DATA_WIDTH));
                    wait for CLK_period;
                end loop;
                DIN <= (others => '0');

            -------------------End of BRAM LOAD_PG----------

            when cmd_Unload_BRAM_Content =>
                --------------------Begining of UNLOAD BRAM--
                LOAD_PG    <= "11";        --'0';
                UN_LOAD <= '1';         -- Tell FSM to go to unloading state.
                wait for clk_period * 3;
                wait until READY = '1';
                wait for clk_period;

                --X
                if sv_Result_File_Open = false then
                    file_open(Result_file_pointer, fileOutput, WRITE_MODE);
                else
                    file_open(Result_file_pointer, fileOutput, APPEND_MODE);
                end if;
                writeline(Result_file_pointer, line_num);
                --X


			while UN_LOADING_DONE = '0' loop
				BRAM_DATA(i) <= dout;
                input_arr_R(iram) <= to_integer(unsigned(dout));
				wait for CLK_period;
				i := i + 1;
                iram := iram + 1;
				if i = COLUMN_TOTAL then
					for k in 0 to COLUMN_TOTAL-1 loop
                        write(line_num,str(to_integer(unsigned(BRAM_DATA(COLUMN_TOTAL-1-k)))),LEFT,10);
					end loop;
					writeline(Result_file_pointer,line_num);
					i:=0;
				end if;
			end loop;

                --X
                writeline(Result_file_pointer, sv_line);
                write(line_num, msg4);  -- write empty space
                writeline(Result_file_pointer, line_num);
                file_close(Result_file_pointer);
                --X

            when cmd_PG =>
                LOAD_PG    <= "11";        --'0'; -- Tell FSM not to LOAD_PG data.
                UN_LOAD <= '0';         -- Tell FSM not to go to unloading state.
                P       <= '0';
                G       <= '0';
                rst     <= '1';
                wait for clk_period * 3;
                rst <= '0';
                wait until OP_DONE = '1';

            when others =>
        --do nothing dummy command.
        end case;

        wait on cmd;

    end process;
END;
