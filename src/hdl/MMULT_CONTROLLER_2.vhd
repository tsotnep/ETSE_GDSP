library IEEE;                           ---
use IEEE.STD_LOGIC_1164.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

USE ieee.numeric_std.ALL;

--NOTES: cmd is the main command, while cmd2 is the details of this command when calculating or unloading,
--to select corresponding BANK or calculating method.

--CALCULATING:
--cmd == cmd_CALCULTE, cmd2 == cmd_CALCULATE_PG_LOWER or cmd_CALCULATE_PG_HIGHER or cmd_CALCULATE_PGt_LOWER

--UNLOADING:
--cmd == cmd_UNLOAD, cmd2 == cmd_UNLOAD_LOWER or cmd_UNLOAD_HIGHER

--LOADING:
--P is always loaded into LOWER bank


entity MMULT_CONTROLLER_2 is
    generic(C_S_AXI_DATA_WIDTH : integer := 32;
            COLUMN_TOTAL       : integer := 3;
            OPCODE_WIDTH       : integer := 3;
            CMD_SIZE           : integer := 4;
            OPT_MEM_ADDR_BITS  : integer := 1;
            ADDR_WIDTH         : integer := 10;
            DATA_WIDTH         : integer := 18;
            DATA_WIDE_WIDTH    : integer := 48
    );
    Port(
        CLK          : in  STD_LOGIC;   --connected to axi clock
        WREN         : in  STD_LOGIC;   --AXI write enable, when '1' data is valid. connect this to: "slv_reg_wren"
        WDATA        : in  std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --AXI data, connect this to "S_AXI_WDATA"

        RDADDR       : in  std_logic_vector(OPT_MEM_ADDR_BITS downto 0); --AXI addr, connect to "rd_loc_addr_to_cntrl", same as var: loc_addr
        RDEN         : in  STD_LOGIC;   --connect this to: "slv_reg_rden"

        RDY_FOR_CMD  : out STD_LOGIC;
        RDATA        : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --connected to slv_reg1
        RMATRIX_ADDR : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0) --will be used later, COL and ROW addr, slv_reg2

    --TODO: add forth register as input for COL ROW address
    );
end MMULT_CONTROLLER_2;

architecture Behavioral of MMULT_CONTROLLER_2 is
    constant N_of_EL            : integer          := COLUMN_TOTAL * COLUMN_TOTAL;
    constant DOUT_SLV_REG1_ADRR : std_logic_vector := std_logic_vector(to_unsigned(1, OPT_MEM_ADDR_BITS + 1));

    --cmd-s that affect state transition, they are read inside state: cmd_WAIT_FOR_CMD
    constant cmd_WAIT_FOR_CMD      : std_logic_vector := std_logic_vector(to_unsigned(0, 4));
    constant cmd_SAVE_G_or_P       : std_logic_vector := std_logic_vector(to_unsigned(1, 4));
    constant cmd_LOAD_G            : std_logic_vector := std_logic_vector(to_unsigned(2, 4));
    constant cmd_LOAD_P            : std_logic_vector := std_logic_vector(to_unsigned(3, 4));
    constant cmd_CALCULTE          : std_logic_vector := std_logic_vector(to_unsigned(4, 4));
    constant cmd_UNLOAD            : std_logic_vector := std_logic_vector(to_unsigned(5, 4));
    constant cmd_PRINT             : std_logic_vector := std_logic_vector(to_unsigned(6, 4));
    --7,8,9,10 
    constant cmd_RESET_MMULT_IP    : std_logic_vector := std_logic_vector(to_unsigned(11, 4));
    constant cmd_RESET_MMULT_CNTRL : std_logic_vector := std_logic_vector(to_unsigned(12, 4));

    --cmd details inside states, they are read in state: cmd_SAVE_G_or_P
    constant cmd_SAVE_G            : std_logic_vector := std_logic_vector(to_unsigned(13, 4));
    constant cmd_SAVE_P            : std_logic_vector := std_logic_vector(to_unsigned(14, 4));
    constant cmd_FINISH_SAVING_G_P : std_logic_vector := std_logic_vector(to_unsigned(15, 4));

    type t_BRAM_DATA_integer is array (0 to N_of_EL - 1) of integer;

    type mmult_state is (
        cntrl_WAIT_FOR_CMD,
        cntrl_SAVE_G_or_P,
        cntrl_LOAD_G,
        cntrl_LOAD_P,
        cntrl_CALCULTE,
        cntrl_UNLOAD,
        cntrl_PRINT,
        cntrl_RESET_MMULT_IP,
        cntrl_RESET_MMULT_CNTRL
    );

    signal state, state_after_reset : mmult_state;

    --IP signals
    signal DIN, DOUT       : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal Bank_sel        : std_logic;
    signal LOADING_DONE    : std_logic;
    signal UN_LOADING_DONE : std_logic;
    signal RST             : std_logic;
    signal LOAD_PG         : std_logic_vector(1 downto 0);
    signal UN_LOAD         : std_logic;
    signal P               : std_logic;
    signal G               : std_logic;
    signal READY           : std_logic;
    signal OP_DONE         : std_logic;
    --IP signals


    --controller signals
    signal cntlr_input_arr_G  : t_BRAM_DATA_integer := (others => 0);
    signal cntlr_input_arr_P  : t_BRAM_DATA_integer := (others => 0);
    signal cntlr_output_arr_R : t_BRAM_DATA_integer := (others => 0);

    signal cntrl_G_array_index : integer := 0;
    signal cntrl_P_array_index : integer := 0;
    signal cntrl_R_array_index : integer := 0;

    signal resetted_MMULT_IP, only_wait : std_logic;

    signal cntrl_reset_length_count       : integer := 0;
    signal cntrl_P_loading_predelay_count : integer := 0;
    signal cntrl_G_loading_predelay_count : integer := 0;

    constant cntrl_P_loading_predelay : integer := 4;
    constant cntrl_G_loading_predelay : integer := 1;
    constant cntrl_reset_length       : integer := 2;

    --slv_reg1_out bits: 32 used, 0 unused
    alias datain is WDATA(DATA_WIDTH - 1 downto 0); --18 bits
    alias cmdin is WDATA(DATA_WIDTH + CMD_SIZE - 1 downto DATA_WIDTH); --4 bits
    alias cmdin2 is WDATA(DATA_WIDTH + CMD_SIZE * 2 - 1 downto DATA_WIDTH + CMD_SIZE); --4 bits spared for future.
    --    alias cmdin3 is WDATA(C_S_AXI_DATA_WIDTH - 1 downto DATA_WIDTH + CMD_SIZE * 2); --6 bits spared for future.
    signal cmd_details : std_logic_vector(CMD_SIZE - 1 downto 0);

begin
    RMATRIX_ADDR <= (others => '0');

    cntrl_FSM : process(clk) is
    begin
        if rising_edge(clk) then
            if WREN = '1' and cmdin = cmd_RESET_MMULT_CNTRL then
                state             <= cntrl_WAIT_FOR_CMD;
                state_after_reset <= cntrl_WAIT_FOR_CMD;

                cntrl_reset_length_count       <= 0;
                cntrl_P_loading_predelay_count <= 0;
                cntrl_G_loading_predelay_count <= 0;

                cntrl_G_array_index <= 0;
                cntrl_P_array_index <= 0;
                cntrl_R_array_index <= 0;

                cntlr_input_arr_G  <= (others => 0);
                cntlr_input_arr_P  <= (others => 0);
                cntlr_output_arr_R <= (others => 0);

                Bank_sel <= '0';
                rst      <= '1';
                LOAD_PG  <= (others => '1');
                UN_LOAD  <= '0';
                P        <= '0';
                G        <= '0';
                DIN      <= (others => '0');
                state    <= cntrl_WAIT_FOR_CMD;

            else
                RDY_FOR_CMD <= '0';
                LOAD_PG     <= IDLE_CMD;
                case state is
                    when cntrl_RESET_MMULT_CNTRL =>
                        Bank_sel <= '0';
                        rst      <= '1';
                        LOAD_PG  <= IDLE_CMD;
                        UN_LOAD  <= '0';
                        P        <= '0';
                        G        <= '0';
                        DIN      <= (others => '0');
                        state    <= cntrl_WAIT_FOR_CMD;

                    when cntrl_RESET_MMULT_IP =>
                        if only_wait = '1' then
                            rst <= '0';
                        else
                            rst <= '1';
                        end if;
                        if cntrl_reset_length_count < cntrl_reset_length then
                            cntrl_reset_length_count <= cntrl_reset_length_count + 1;
                        else
                            cntrl_reset_length_count <= 0;
                            rst                      <= '0';
                            resetted_MMULT_IP        <= '1';
                            state                    <= state_after_reset;
                        end if;

                    when cntrl_WAIT_FOR_CMD =>
                        resetted_MMULT_IP <= '0';
                        RDY_FOR_CMD       <= '1';
                        LOAD_PG           <= IDLE_CMD;
                        if WREN = '1' then
                            case cmdin is
                                when cmd_WAIT_FOR_CMD      => state <= cntrl_WAIT_FOR_CMD;
                                when cmd_RESET_MMULT_CNTRL => state <= cntrl_RESET_MMULT_CNTRL;
                                when cmd_RESET_MMULT_IP    => state <= cntrl_RESET_MMULT_IP;
                                when cmd_SAVE_G_or_P       => state <= cntrl_SAVE_G_or_P;
                                when cmd_LOAD_G            => state <= cntrl_LOAD_G;
                                when cmd_LOAD_P            => state <= cntrl_LOAD_P;
                                when cmd_CALCULTE          => state <= cntrl_CALCULTE;
                                    cmd_details          <= cmdin2;
                                when cmd_UNLOAD => state <= cntrl_UNLOAD;
                                    cmd_details          <= cmdin2;
                                when cmd_PRINT => state  <= cntrl_PRINT;
                                when others => null;
                            end case;
                        end if;

                    when cntrl_SAVE_G_or_P =>
                        if WREN = '1' and cmdin = cmd_SAVE_P then
                            cntlr_input_arr_P(N_of_EL - 1) <= to_integer(unsigned(datain));
                            for i in N_of_EL - 1 downto 1 loop
                                cntlr_input_arr_P(i - 1) <= cntlr_input_arr_P(i);
                            end loop;
                        end if;

                        if WREN = '1' and cmdin = cmd_SAVE_G then
                            cntlr_input_arr_G(N_of_EL - 1) <= to_integer(unsigned(datain));
                            for i in N_of_EL - 1 downto 1 loop
                                cntlr_input_arr_G(i - 1) <= cntlr_input_arr_G(i);
                            end loop;
                        end if;

                        if WREN = '1' and (cmdin2 = cmd_FINISH_SAVING_G_P or cmdin = cmd_FINISH_SAVING_G_P) then
                            state <= cntrl_WAIT_FOR_CMD;
                        end if;

                    when cntrl_LOAD_G =>
                        --TODO: later, directly write into GRAM
                        DIN     <= (others => '0');
                        LOAD_PG <= LOAD_G_CMD;

                        if resetted_MMULT_IP = '1' then
                            if cntrl_G_loading_predelay_count <= cntrl_G_loading_predelay then
                                cntrl_G_loading_predelay_count <= cntrl_G_loading_predelay_count + 1;
                            else
                                if cntrl_G_array_index <= COLUMN_TOTAL * COLUMN_TOTAL - 1 then
                                    DIN                 <= std_logic_vector(to_unsigned(cntlr_input_arr_G(cntrl_G_array_index), DATA_WIDTH));
                                    cntrl_G_array_index <= cntrl_G_array_index + 1;
                                else
                                    if LOADING_DONE = '1' then
                                        state <= cntrl_WAIT_FOR_CMD;
                                    end if;
                                end if;
                            end if;
                        else
                            state             <= cntrl_RESET_MMULT_IP;
                            state_after_reset <= cntrl_LOAD_G;
                        end if;

                    when cntrl_LOAD_P =>
                        --TODO: later, directly write into BRAM
                        DIN      <= (others => '0');
                        LOAD_PG  <= LOAD_P_CMD;
                        Bank_sel <= '0'; --TODO: attach to cmd2
                        if resetted_MMULT_IP = '1' then
                            if cntrl_P_loading_predelay_count <= cntrl_P_loading_predelay then
                                cntrl_P_loading_predelay_count <= cntrl_P_loading_predelay_count + 1;
                            else
                                if cntrl_P_array_index <= COLUMN_TOTAL * COLUMN_TOTAL - 1 then
                                    DIN                 <= std_logic_vector(to_unsigned(cntlr_input_arr_P(cntrl_P_array_index), DATA_WIDTH));
                                    cntrl_P_array_index <= cntrl_P_array_index + 1;
                                else
                                    if LOADING_DONE = '1' then
                                        state <= cntrl_WAIT_FOR_CMD;
                                    end if;
                                end if;
                            end if;
                        else
                            state             <= cntrl_RESET_MMULT_IP;
                            state_after_reset <= cntrl_LOAD_P;
                        end if;

                    when cntrl_CALCULTE =>
                        UN_LOAD  <= '0';
                        LOAD_PG  <= OPERATE_CMD;
                        Bank_sel <= cmd_details(2);
                        P        <= cmd_details(1);
                        G        <= cmd_details(0);
                        if resetted_MMULT_IP = '1' then
                            if OP_DONE = '1' then
                                state <= cntrl_WAIT_FOR_CMD;
                            end if;
                        else
                            state             <= cntrl_RESET_MMULT_IP;
                            state_after_reset <= cntrl_CALCULTE;
                        end if;

                    when cntrl_UNLOAD =>
                        UN_LOAD  <= '1';
                        LOAD_PG  <= OPERATE_CMD;
                        Bank_sel <= not cmd_details(2); --because it is inverted when reading

                        if resetted_MMULT_IP = '1' then
                            if READY = '1' or cntrl_R_array_index > 0 then
                                if cntrl_R_array_index <= N_of_EL - 1 then
                                    cntlr_output_arr_R(cntrl_R_array_index) <= to_integer(unsigned(DOUT));
                                    cntrl_R_array_index                     <= cntrl_R_array_index + 1;
                                else
                                    state               <= cntrl_WAIT_FOR_CMD;
                                    cntrl_R_array_index <= 0;
                                end if;
                            end if;
                        else
                            only_wait         <= '0';
                            state             <= cntrl_RESET_MMULT_IP;
                            state_after_reset <= cntrl_UNLOAD;
                        end if;
                    when cntrl_PRINT =>
                        --TODO: later, read from GRAM
                        if RDEN = '1' and RDADDR = DOUT_SLV_REG1_ADRR then
                            cntrl_R_array_index <= cntrl_R_array_index + 1;
                        end if;
                        if cntrl_R_array_index >= N_of_EL - 1 then
                            cntrl_R_array_index <= 0;
                            state               <= cntrl_WAIT_FOR_CMD;
                        end if;
                end case;

            end if;
        end if;
    end process cntrl_FSM;

    --i made it combinational to remove 1 clock cycle delay.
    RDATA <= std_logic_vector(to_unsigned(cntlr_output_arr_R(cntrl_R_array_index), C_S_AXI_DATA_WIDTH)) when (RDEN = '1' and RDADDR = DOUT_SLV_REG1_ADRR) else (others => '0');

    MATRIX_MUL_IP_CORE_S_INT_G_inst : entity work.MATRIX_MUL_IP_CORE_S_INT_G
        generic map(
            COLUMN_TOTAL    => COLUMN_TOTAL,
            OPCODE_WIDTH    => OPCODE_WIDTH,
            ADDR_WIDTH      => ADDR_WIDTH,
            DATA_WIDTH      => DATA_WIDTH,
            DATA_WIDE_WIDTH => DATA_WIDE_WIDTH
        )
        port map(
            CLK             => CLK,
            RST             => RST,
            LOAD_PG         => LOAD_PG,
            UN_LOAD         => UN_LOAD,
            P               => P,
            G               => G,
            Bank_sel_in     => Bank_sel,
            DIN             => DIN,
            DOUT            => DOUT,
            READY           => READY,
            OP_DONE         => OP_DONE,
            LOADING_DONE    => LOADING_DONE,
            UN_LOADING_DONE => UN_LOADING_DONE
        );
end Behavioral;
