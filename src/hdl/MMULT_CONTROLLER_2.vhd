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
    generic(C_S_AXI_DATA_WIDTH     : integer := 32;
            COLUMN_TOTAL           : integer := 3;
            OPCODE_WIDTH           : integer := 3;
            CMD_SIZE               : integer := 4;
            OPT_MEM_ADDR_BITS      : integer := 1;
            ADDR_WIDTH             : integer := 10;
            DATA_WIDTH             : integer := 18;
            DATA_WIDE_WIDTH        : integer := 48;

            -- Parameters of Axi Slave Bus Interface S00_AXIS
            C_S00_AXIS_TDATA_WIDTH : integer := 32;

            -- Parameters of Axi Master Bus Interface M00_AXIS
            C_M00_AXIS_TDATA_WIDTH : integer := 32;
            C_M00_AXIS_START_COUNT : integer := 32
    );
    Port(
        CLK              : in  STD_LOGIC; --connected to axi clock
        WREN             : in  STD_LOGIC; --AXI write enable, when '1' data is valid. connect this to: "slv_reg_wren"
        WDATA            : in  std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --AXI data, connect this to "S_AXI_WDATA"

        RDADDR           : in  std_logic_vector(OPT_MEM_ADDR_BITS downto 0); --AXI addr, connect to "rd_loc_addr_to_cntrl", same as var: loc_addr
        RDEN             : in  STD_LOGIC; --connect this to: "slv_reg_rden"

        RDY_FOR_CMD      : out STD_LOGIC;
        RDATA            : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --connected to slv_reg1
        RMATRIX_ADDR     : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --will be used later, COL and ROW addr, slv_reg2


        -- Ports of Axi Slave Bus Interface S00_AXIS
        s00_axis_aclk    : in  std_logic;
        s00_axis_aresetn : in  std_logic;
        s00_axis_tready  : out std_logic;
        s00_axis_tdata   : in  std_logic_vector(C_S00_AXIS_TDATA_WIDTH - 1 downto 0);
        s00_axis_tstrb   : in  std_logic_vector((C_S00_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
        s00_axis_tlast   : in  std_logic;
        s00_axis_tvalid  : in  std_logic;

        -- Ports of Axi Master Bus Interface M00_AXIS
        m00_axis_aclk    : in  std_logic;
        m00_axis_aresetn : in  std_logic;
        m00_axis_tvalid  : out std_logic;
        m00_axis_tdata   : out std_logic_vector(C_M00_AXIS_TDATA_WIDTH - 1 downto 0);
        m00_axis_tstrb   : out std_logic_vector((C_M00_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
        m00_axis_tlast   : out std_logic;
        m00_axis_tready  : in  std_logic
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
    constant cmd_P_to_G            : std_logic_vector := std_logic_vector(to_unsigned(5, 4));
    constant cmd_UNLOAD_G          : std_logic_vector := std_logic_vector(to_unsigned(6, 4));
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
        cntrl_P_to_G,
        cntrl_UNLOAD_G,
        cntrl_RESET_MMULT_IP
    );

    signal state, state_after_reset : mmult_state;

    --IP signals
    signal DIN, DOUT, single_data_buff : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal Bank_sel                    : std_logic;
    signal LOADING_DONE                : std_logic;
    signal UN_LOADING_DONE             : std_logic;
    signal RST                         : std_logic;
    signal LOAD_PG                     : std_logic_vector(1 downto 0);
    signal UN_LOAD                     : std_logic;
    signal P                           : std_logic;
    signal G                           : std_logic;
    signal READY                       : std_logic;
    signal OP_DONE                     : std_logic;
    --IP signals


    --controller signals
    signal cntlr_input_arr_G : t_BRAM_DATA_integer := (others => 0);
    signal cntlr_input_arr_P : t_BRAM_DATA_integer := (others => 0);

    signal cntrl_G_array_index : integer := 0;
    signal cntrl_P_array_index : integer := 0;
    signal cntrl_R_array_index : integer := 0;

    signal resetted_MMULT_IP, only_wait, first_read, data_available, RDEN_internal : std_logic;

    signal cntrl_reset_length_count       : integer := 0;
    signal cntrl_P_loading_predelay_count : integer := 0;
    signal cntrl_G_loading_predelay_count : integer := 0;

    constant cntrl_P_loading_predelay : integer := 3;
    constant cntrl_G_loading_predelay : integer := 0;
    constant cntrl_reset_length       : integer := 2;

    --slv_reg1_out bits: 32 used, 0 unused
    alias datain is WDATA(DATA_WIDTH - 1 downto 0); --18 bits
    alias cmdin is WDATA(DATA_WIDTH + CMD_SIZE - 1 downto DATA_WIDTH); --4 bits
    alias cmdin2 is WDATA(DATA_WIDTH + CMD_SIZE * 2 - 1 downto DATA_WIDTH + CMD_SIZE); --4 bits spared for future.
    --    alias cmdin3 is WDATA(C_S_AXI_DATA_WIDTH - 1 downto DATA_WIDTH + CMD_SIZE * 2); --6 bits spared for future.
    signal cmd_details : std_logic_vector(CMD_SIZE - 1 downto 0);

    --AXIS
    -- function called clogb2 that returns an integer which has the
    -- value of the ceiling of the log base 2.
    function clogb2(bit_depth : integer) return integer is
        variable depth : integer := bit_depth;
    begin
        if (depth = 0) then
            return (0);
        else
            for clogb2 in 1 to bit_depth loop -- Works for up to 32 bit integers
                if (depth <= 1) then
                    return (clogb2);
                else
                    depth := depth / 2;
                end if;
            end loop;
        end if;
    end;

    -- Total number of input data.
    constant s00_axis_NUMBER_OF_INPUT_WORDS : integer := COLUMN_TOTAL * COLUMN_TOTAL * 2 + 2;
    -- bit_num gives the minimum number of bits needed to address 'NUMBER_OF_INPUT_WORDS' size of FIFO.
    constant s00_axis_bit_num               : integer := clogb2(s00_axis_NUMBER_OF_INPUT_WORDS - 1);
    -- Define the states of state machine
    -- The control state machine oversees the writing of input streaming data to the FIFO,
    -- and outputs the streaming data from the FIFO
    type s00_axis_state is (IDLE,       -- This is the initial/idle state
                            WRITE_FIFO); -- In this state FIFO is written with the
    -- input stream data S_AXIS_TDATA
    signal s00_axis_axis_tready    : std_logic;
    -- State variable
    signal s00_axis_mst_exec_state : s00_axis_state;
    -- FIFO implementation signals
    signal s00_axis_byte_index     : integer;
    -- FIFO write enable
    signal s00_axis_fifo_wren      : std_logic;
    -- FIFO full flag
    signal s00_axis_fifo_full_flag : std_logic;
    -- FIFO write pointer
    signal s00_axis_write_pointer  : integer range 0 to s00_axis_bit_num - 1;
    -- sink has accepted all the streaming data and stored in FIFO
    signal s00_axis_writes_done    : std_logic;

    type s00_axis_BYTE_FIFO_TYPE is array (0 to (s00_axis_NUMBER_OF_INPUT_WORDS - 1)) of std_logic_vector(((C_S00_AXIS_TDATA_WIDTH) - 1) downto 0);
    signal s00_axis_stream_data_fifo : s00_axis_BYTE_FIFO_TYPE;

    signal MMULT_AXIS_INPUT_ENABLE : std_logic;
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

                cntlr_input_arr_G <= (others => 0);
                cntlr_input_arr_P <= (others => 0);

                Bank_sel      <= '0';
                rst           <= '1';
                LOAD_PG       <= (others => '1');
                UN_LOAD       <= '0';
                P             <= '0';
                G             <= '0';
                DIN           <= (others => '0');
                state         <= cntrl_WAIT_FOR_CMD;
                RDY_FOR_CMD   <= '0';
                RDEN_internal <= '0';

            else
                LOAD_PG                 <= IDLE_CMD;
                MMULT_AXIS_INPUT_ENABLE <= '0';
                case state is
                    when cntrl_WAIT_FOR_CMD =>
                        resetted_MMULT_IP <= '0';
                        first_read        <= '1';
                        --                        RDY_FOR_CMD       <= '1'; --TODO: add this signal to be used as interrupt in cortex
                        LOAD_PG           <= IDLE_CMD;
                        if WREN = '1' then
                            case cmdin is
                                when cmd_WAIT_FOR_CMD   => state <= cntrl_WAIT_FOR_CMD;
                                when cmd_RESET_MMULT_IP => state <= cntrl_RESET_MMULT_IP;
                                when cmd_SAVE_G_or_P    => state <= cntrl_SAVE_G_or_P;
                                when cmd_LOAD_G         => state <= cntrl_LOAD_G;
                                when cmd_LOAD_P         => state <= cntrl_LOAD_P;
                                when cmd_CALCULTE       => state <= cntrl_CALCULTE;
                                    cmd_details            <= cmdin2;
                                when cmd_P_to_G => state   <= cntrl_P_to_G;
                                    cmd_details            <= cmdin2;
                                when cmd_UNLOAD_G => state <= cntrl_UNLOAD_G;
                                when others => null;
                            end case;
                        end if;

                    when cntrl_RESET_MMULT_IP =>
                        --                        if only_wait = '1' then
                        --                            rst <= '0';
                        --                        else
                        --                            rst <= '1';
                        --                        end if;
                        rst <= '1';

                        if cntrl_reset_length_count < cntrl_reset_length then
                            cntrl_reset_length_count <= cntrl_reset_length_count + 1;

                        else
                            cntrl_reset_length_count <= 0;
                            rst                      <= '0';
                            resetted_MMULT_IP        <= '1';
                            state                    <= state_after_reset;
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
                        --NOTE: was losing first and last values, they were 0s.
                        --TODO: later, directly write into FSM one by one.
                        DIN     <= (others => '0');
                        LOAD_PG <= LOAD_G_CMD;

                        if resetted_MMULT_IP = '1' then
                            if cntrl_G_loading_predelay_count < cntrl_G_loading_predelay then
                                cntrl_G_loading_predelay_count <= cntrl_G_loading_predelay_count + 1;
                            else
                                MMULT_AXIS_INPUT_ENABLE <= '1';
                                if cntrl_G_array_index <= COLUMN_TOTAL * COLUMN_TOTAL then
                                    DIN                 <= s00_axis_tdata(DATA_WIDTH - 1 downto 0);
                                    cntrl_G_array_index <= cntrl_G_array_index + 1;
                                else
                                    MMULT_AXIS_INPUT_ENABLE <= '0';
                                    if LOADING_DONE = '1' then
                                        state                          <= cntrl_WAIT_FOR_CMD;
                                        cntrl_G_loading_predelay_count <= 0;
                                        cntrl_G_array_index            <= 0;
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
                        Bank_sel <= '0';
                        if resetted_MMULT_IP = '1' then
                            if cntrl_P_loading_predelay_count < cntrl_P_loading_predelay then
                                cntrl_P_loading_predelay_count <= cntrl_P_loading_predelay_count + 1;
                                if cntrl_P_loading_predelay_count = cntrl_P_loading_predelay - 1 then
                                end if;
                            else
                                MMULT_AXIS_INPUT_ENABLE <= '1';
                                if cntrl_P_array_index < COLUMN_TOTAL * COLUMN_TOTAL then
                                    DIN                 <= s00_axis_tdata(DATA_WIDTH - 1 downto 0);
                                    cntrl_P_array_index <= cntrl_P_array_index + 1;
                                else
                                    MMULT_AXIS_INPUT_ENABLE <= '0';
                                    if LOADING_DONE = '1' then
                                        state                          <= cntrl_WAIT_FOR_CMD;
                                        cntrl_P_loading_predelay_count <= 0;
                                        cntrl_P_array_index            <= 0;
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

                    when cntrl_P_to_G =>
                        UN_LOAD  <= '1';
                        LOAD_PG  <= OPERATE_CMD;
                        Bank_sel <= not cmd_details(2); --because it is inverted when reading

                        if resetted_MMULT_IP = '1' then
                            if READY = '1' or cntrl_R_array_index > 0 then
                                if cntrl_R_array_index < N_of_EL then
                                    cntrl_R_array_index <= cntrl_R_array_index + 1;
                                else
                                    state               <= cntrl_WAIT_FOR_CMD;
                                    cntrl_R_array_index <= 0;
                                end if;
                            end if;
                        else
                            state             <= cntrl_RESET_MMULT_IP;
                            state_after_reset <= cntrl_P_to_G;
                        end if;

                    when cntrl_UNLOAD_G =>
                        if first_read = '1' then
                            first_read    <= '0';
                            RDEN_internal <= '1';
                        else
                            RDEN_internal <= RDEN;
                        end if;
                        if RDADDR = DOUT_SLV_REG1_ADRR then
                            if data_available = '1' then
                                single_data_buff    <= DOUT;
                                cntrl_R_array_index <= cntrl_R_array_index + 1;
                            end if;

                            if WREN = '1' and cmdin = cmd_WAIT_FOR_CMD then
                                state               <= cntrl_WAIT_FOR_CMD;
                                first_read          <= '0';
                                single_data_buff    <= (others => '0');
                                cntrl_R_array_index <= 0;
                                RDEN_internal       <= '0';
                            end if;

                        --                            if cntrl_R_array_index = N_of_EL then
                        --                                state <= cntrl_WAIT_FOR_CMD;
                        --                            end if;
                        end if;
                end case;

            end if;
        end if;
    end process cntrl_FSM;

    --i made it combinational to remove 1 clock cycle delay.
    RDATA(DATA_WIDTH - 1 downto 0)                  <= single_data_buff;
    RDATA(C_S_AXI_DATA_WIDTH - 1 downto DATA_WIDTH) <= (others => '0');

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
            RDEN            => RDEN_internal,
            data_available  => data_available,
            DOUT            => DOUT,
            READY           => READY,
            OP_DONE         => OP_DONE,
            LOADING_DONE    => LOADING_DONE,
            UN_LOADING_DONE => UN_LOADING_DONE
        );

    --AXIS SLAVE

    -- I/O Connections assignments

    s00_axis_TREADY <= s00_axis_axis_tready;
    -- Control state machine implementation
    process(s00_axis_ACLK)
    begin
        if (rising_edge(s00_axis_ACLK)) then
            if (s00_axis_ARESETN = '0'  or rst = '1') then --reset addd for fsm
                -- Synchronous reset (active low)
                s00_axis_mst_exec_state <= IDLE;
            else
                case (s00_axis_mst_exec_state) is
                    when IDLE =>
                        -- The sink starts accepting tdata when
                        -- there tvalid is asserted to mark the
                        -- presence of valid streaming data
                        if (s00_axis_TVALID = '1') then
                            s00_axis_mst_exec_state <= WRITE_FIFO;
                        else
                            s00_axis_mst_exec_state <= IDLE;
                        end if;

                    when WRITE_FIFO =>
                        -- When the sink has accepted all the streaming input data,
                        -- the interface swiches functionality to a streaming master
                        if (s00_axis_writes_done = '1') then
                            s00_axis_mst_exec_state <= IDLE;
                        else
                            -- The sink accepts and stores tdata
                            -- into FIFO
                            s00_axis_mst_exec_state <= WRITE_FIFO;
                        end if;

                    when others =>
                        s00_axis_mst_exec_state <= IDLE;

                end case;
            end if;
        end if;
    end process;

    -- AXI Streaming Sink
    --
    -- The example design sink is always ready to accept the s00_axis_TDATA  until
    -- the FIFO is not filled with NUMBER_OF_INPUT_WORDS number of input words.
    s00_axis_axis_tready <= '1' when ((MMULT_AXIS_INPUT_ENABLE = '1') and (s00_axis_mst_exec_state = WRITE_FIFO) and (s00_axis_write_pointer <= s00_axis_NUMBER_OF_INPUT_WORDS - 1)) else '0';

    process(s00_axis_ACLK)
    begin
        if (rising_edge(s00_axis_ACLK)) then
            if (s00_axis_ARESETN = '0' or rst = '1') then --reset addd for s00_axis_write_pointer
                s00_axis_write_pointer <= 0;
                s00_axis_writes_done   <= '0';
            else
                if (s00_axis_write_pointer <= s00_axis_NUMBER_OF_INPUT_WORDS - 1) then
                    if (s00_axis_fifo_wren = '1') then
                        -- write pointer is incremented after every write to the FIFO
                        -- when FIFO write signal is enabled.
                        s00_axis_write_pointer <= s00_axis_write_pointer + 1;
                        s00_axis_writes_done   <= '0';
                    end if;
                    if ((s00_axis_write_pointer = s00_axis_NUMBER_OF_INPUT_WORDS - 1) or s00_axis_TLAST = '1') then
                        -- reads_done is asserted when NUMBER_OF_INPUT_WORDS numbers of streaming data
                        -- has been written to the FIFO which is also marked by s00_axis_TLAST(kept for optional usage).
                        s00_axis_writes_done <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- FIFO write enable generation
    s00_axis_fifo_wren <= s00_axis_TVALID and s00_axis_axis_tready;

end Behavioral;
