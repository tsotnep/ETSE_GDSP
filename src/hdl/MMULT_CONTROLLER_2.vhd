library IEEE;
--
use IEEE.STD_LOGIC_1164.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

USE ieee.numeric_std.ALL;


entity MMULT_CONTROLLER_2 is
    generic(C_S_AXI_DATA_WIDTH     : integer := 32;
            COLUMN_TOTAL           : integer := 3;
            OPCODE_WIDTH           : integer := 3;
            CMD_SIZE               : integer := 4;
            ADDR_WIDTH             : integer := 10;
            DATA_WIDTH             : integer := 18;
            DATA_WIDE_WIDTH        : integer := 48;

            -- Parameters of Axi Slave Bus Interface S00_AXIS
            C_S00_AXIS_TDATA_WIDTH : integer := 32;

            -- Parameters of Axi Master Bus Interface M00_AXIS
            C_M00_AXIS_TDATA_WIDTH : integer := 32;

            -- Start count is the numeber of clock cycles the master will wait before initiating/issuing any transaction.
            C_M_START_COUNT        : integer := 10
    );
    Port(
        CLK              : in  STD_LOGIC; --connected to axi clock
        WREN             : in  STD_LOGIC; --AXI write enable, when '1' data is valid. connect this to: "slv_reg_wren"
        WDATA            : in  std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --AXI data, connect this to "S_AXI_WDATA"

        RDY_FOR_CMD      : out STD_LOGIC;
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
    );
end MMULT_CONTROLLER_2;

architecture Behavioral of MMULT_CONTROLLER_2 is
    constant N_of_EL            : integer          := COLUMN_TOTAL * COLUMN_TOTAL;

    --cmd-s that affect state transition, they are read inside state: cmd_WAIT_FOR_CMD
    constant cmd_WAIT_FOR_CMD      : std_logic_vector := std_logic_vector(to_unsigned(0, 4));
    constant cmd_LOAD_G            : std_logic_vector := std_logic_vector(to_unsigned(2, 4));
    constant cmd_LOAD_P            : std_logic_vector := std_logic_vector(to_unsigned(3, 4));
    constant cmd_CALCULTE          : std_logic_vector := std_logic_vector(to_unsigned(4, 4));
    constant cmd_P_to_G            : std_logic_vector := std_logic_vector(to_unsigned(5, 4));
    constant cmd_UNLOAD_G          : std_logic_vector := std_logic_vector(to_unsigned(6, 4));
    --7,8,9,10
    constant cmd_RESET_MMULT_IP    : std_logic_vector := std_logic_vector(to_unsigned(11, 4));
    constant cmd_RESET_MMULT_CNTRL : std_logic_vector := std_logic_vector(to_unsigned(12, 4));

    --cmd details inside states, they are read in state: cmd_SAVE_G_or_P



    type mmult_state is (
        cntrl_WAIT_FOR_CMD,
        cntrl_LOAD_G,
        cntrl_LOAD_P,
        cntrl_CALCULTE,
        cntrl_P_to_G,
        cntrl_UNLOAD_G,
        cntrl_RESET_MMULT_IP
    );

    signal state, state_after_reset : mmult_state;

    --IP signals
    signal DIN, DOUT : std_logic_vector(DATA_WIDTH - 1 downto 0);
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

    signal cntrl_G_array_index : integer := 0;
    signal cntrl_P_array_index : integer := 0;
    signal cntrl_R_array_index : integer := 0;

    signal resetted_MMULT_IP, only_wait, data_available, RDEN_internal : std_logic;

    signal cntrl_reset_length_count       : integer := 0;
    signal cntrl_P_loading_predelay_count : integer := 0;
    signal cntrl_G_loading_predelay_count : integer := 0;
    signal cntrl_finish_transmit_count    : integer := 0;


    --slv_reg1_out bits: 32 used, 0 unused
--    alias datain is WDATA(DATA_WIDTH - 1 downto 0); --18 bits
    alias cmdin is WDATA(DATA_WIDTH + CMD_SIZE - 1 downto DATA_WIDTH); --4 bits
    alias cmdin2 is WDATA(DATA_WIDTH + CMD_SIZE * 2 - 1 downto DATA_WIDTH + CMD_SIZE); --4 bits spared for future.
    --    alias cmdin3 is WDATA(C_S_AXI_DATA_WIDTH - 1 downto DATA_WIDTH + CMD_SIZE * 2); --6 bits spared for future.
    signal cmd_details : std_logic_vector(CMD_SIZE - 1 downto 0);

    --AXIS slave
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
    constant s00_axis_NUMBER_OF_INPUT_WORDS : integer := COLUMN_TOTAL * COLUMN_TOTAL * 2; --TODO: back * 2 * 4
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

    -- FIFO write enable
    signal s00_axis_fifo_wren      : std_logic;

    -- FIFO write pointer
    signal s00_axis_write_pointer  : integer range 0 to s00_axis_bit_num;
    -- sink has accepted all the streaming data and stored in FIFO
    signal s00_axis_writes_done    : std_logic;




    signal MMULT_AXIS_INPUT_ENABLE, MMULT_AXIS_OUTPUT_ENABLE, i_MMULT_AXIS_OUTPUT_ENABLE, ii_MMULT_AXIS_OUTPUT_ENABLE, iii_MMULT_AXIS_OUTPUT_ENABLE : std_logic;

    --AXIS master
    -- Total number of output data
    constant m00_axis_NUMBER_OF_OUTPUT_WORDS : integer := COLUMN_TOTAL * COLUMN_TOTAL;

    -- WAIT_COUNT_BITS is the width of the wait counter.
    constant m00_axis_WAIT_COUNT_BITS : integer := clogb2(C_M_START_COUNT - 1);

    -- In this example, Depth of FIFO is determined by the greater of
    -- the number of input words and output words.
    constant m00_axis_depth : integer := m00_axis_NUMBER_OF_OUTPUT_WORDS;

    -- bit_num gives the minimum number of bits needed to address 'depth' size of FIFO
    constant m00_axis_bit_num : integer := clogb2(m00_axis_depth);

    -- Define the states of state machine
    -- The control state machine oversees the writing of input streaming data to the FIFO,
    -- and outputs the streaming data from the FIFO
    type m00_axis_state is (IDLE,       -- This is the initial/idle state
                            INIT_COUNTER, -- This state initializes the counter, ones
                            -- the counter reaches C_M_START_COUNT count,
                            -- the state machine changes state to INIT_WRITE
                            SEND_STREAM); -- In this state the
    -- stream data is output through M_AXIS_TDATA
    -- State variable
    signal m00_axis_mst_exec_state : m00_axis_state;
    -- Example design FIFO read pointer
    signal m00_axis_read_pointer   : integer range 0 to m00_axis_bit_num - 1;

    -- AXI Stream internal signals
    --wait counter. The master waits for the user defined number of clock cycles before initiating a transfer.
    signal m00_axis_count             : std_logic_vector(m00_axis_WAIT_COUNT_BITS - 1 downto 0);
    --streaming data valid
    signal m00_axis_axis_tvalid       : std_logic;
    --streaming data valid delayed by one clock cycle
    signal m00_axis_axis_tvalid_delay : std_logic;
    --Last of the streaming data
    signal m00_axis_axis_tlast        : std_logic;
    --Last of the streaming data delayed by one clock cycle
    signal m00_axis_axis_tlast_delay  : std_logic;
    --FIFO implementation signals
    signal m00_axis_stream_data_out   : std_logic_vector(C_M00_AXIS_TDATA_WIDTH - 1 downto 0);
    signal m00_axis_tx_en             : std_logic;
    --The master has issued all the streaming data stored in FIFO
    signal m00_axis_tx_done           : std_logic;

    constant cntrl_P_loading_predelay : integer := 5; --should be 3, checked in simulation
    constant cntrl_G_loading_predelay : integer := 2; --should be 0, checked in simulation
    constant cntrl_reset_length       : integer := 2;

    constant cntrl_mem_delay : integer := 3;
begin
    RMATRIX_ADDR <= (others => '0');

    cntrl_FSM : process(CLK) is
    begin
        if rising_edge(CLK) then
            if WREN = '1' and cmdin = cmd_RESET_MMULT_CNTRL then
                state             <= cntrl_WAIT_FOR_CMD;
                state_after_reset <= cntrl_WAIT_FOR_CMD;

                cntrl_reset_length_count       <= 0;
                cntrl_P_loading_predelay_count <= 0;
                cntrl_G_loading_predelay_count <= 0;

                cntrl_G_array_index <= 0;
                cntrl_P_array_index <= 0;
                cntrl_R_array_index <= 0;

                Bank_sel                 <= '0';
                RST                      <= '1';
                LOAD_PG                  <= (others => '1');
                UN_LOAD                  <= '0';
                P                        <= '0';
                G                        <= '0';
                state                    <= cntrl_WAIT_FOR_CMD;
                RDY_FOR_CMD              <= '0';
                RDEN_internal            <= '0';
                MMULT_AXIS_OUTPUT_ENABLE <= '0';
                MMULT_AXIS_INPUT_ENABLE  <= '0';

            else
                --                RDY_FOR_CMD <= '0';
                LOAD_PG                 <= IDLE_CMD;
                MMULT_AXIS_INPUT_ENABLE <= '0';
                case state is
                    when cntrl_WAIT_FOR_CMD =>
                        resetted_MMULT_IP <= '0';
                        --                        RDY_FOR_CMD       <= '1'; --TODO: add this signal to be used as interrupt in cortex
                        LOAD_PG           <= IDLE_CMD;
                        if WREN = '1' then
                            case cmdin is
                                when cmd_WAIT_FOR_CMD   => state <= cntrl_WAIT_FOR_CMD;
                                when cmd_RESET_MMULT_IP => state <= cntrl_RESET_MMULT_IP;
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
                        if only_wait = '1' then
                            RST <= '0';
                        else
                            RST <= '1';
                        end if;
                        if cntrl_reset_length_count < cntrl_reset_length then
                            cntrl_reset_length_count <= cntrl_reset_length_count + 1;

                        else
                            cntrl_reset_length_count <= 0;
                            RST                      <= '0';
                            resetted_MMULT_IP        <= '1';
                            state                    <= state_after_reset;
                            only_wait                <= '0';
                        end if;

                    when cntrl_LOAD_G =>
                        LOAD_PG                   <= LOAD_G_CMD;

                        if resetted_MMULT_IP = '1' then
                            if cntrl_G_loading_predelay_count < cntrl_G_loading_predelay then
                                cntrl_G_loading_predelay_count <= cntrl_G_loading_predelay_count + 1;
                            else
                                MMULT_AXIS_INPUT_ENABLE <= '1';
                                if cntrl_G_array_index < COLUMN_TOTAL * COLUMN_TOTAL then
                                    cntrl_G_array_index <= cntrl_G_array_index + 1;
                                else
                                    MMULT_AXIS_INPUT_ENABLE <= '0';
                                    if LOADING_DONE = '1' then
                                        state                          <= cntrl_WAIT_FOR_CMD;
                                        state_after_reset              <= cntrl_WAIT_FOR_CMD;
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
                        LOAD_PG                   <= LOAD_P_CMD;
                        Bank_sel                  <= '0';
                        if resetted_MMULT_IP = '1' then
                            if cntrl_P_loading_predelay_count < cntrl_P_loading_predelay then
                                cntrl_P_loading_predelay_count <= cntrl_P_loading_predelay_count + 1;
                            else
                                MMULT_AXIS_INPUT_ENABLE <= '1';
                                if cntrl_P_array_index < COLUMN_TOTAL * COLUMN_TOTAL then
                                    cntrl_P_array_index <= cntrl_P_array_index + 1;
                                else
                                    MMULT_AXIS_INPUT_ENABLE <= '0';
                                    if LOADING_DONE = '1' then
                                        state                          <= cntrl_WAIT_FOR_CMD;
                                        state_after_reset              <= cntrl_WAIT_FOR_CMD;
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
                        Bank_sel <= not cmd_details(2);
                        P        <= cmd_details(1);
                        G        <= cmd_details(0);
                        if resetted_MMULT_IP = '1' then
                            if OP_DONE = '1' then
                                state             <= cntrl_WAIT_FOR_CMD;
                                state_after_reset <= cntrl_WAIT_FOR_CMD;
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
                                    state_after_reset   <= cntrl_WAIT_FOR_CMD;
                                    cntrl_R_array_index <= 0;
                                end if;
                            end if;
                        else
                            only_wait         <= '1';
                            state             <= cntrl_RESET_MMULT_IP;
                            state_after_reset <= cntrl_P_to_G;
                        end if;

                    when cntrl_UNLOAD_G =>
                        --if m00_axis_tready = '1' then
                        RDEN_internal              <= '1';
                        cntrl_R_array_index        <= cntrl_R_array_index + 1;
                        --end if;
                        i_MMULT_AXIS_OUTPUT_ENABLE <= MMULT_AXIS_OUTPUT_ENABLE;
                        ii_MMULT_AXIS_OUTPUT_ENABLE <= i_MMULT_AXIS_OUTPUT_ENABLE;
                        iii_MMULT_AXIS_OUTPUT_ENABLE <= ii_MMULT_AXIS_OUTPUT_ENABLE;

                        if cntrl_R_array_index < COLUMN_TOTAL * COLUMN_TOTAL then
                            if data_available = '1' then
                                MMULT_AXIS_OUTPUT_ENABLE <= '1';
                            end if;
                        else
                            RDEN_internal <= '0';

                            --wait until data transmit finishes
                            if cntrl_finish_transmit_count = cntrl_mem_delay then
                                state               <= cntrl_WAIT_FOR_CMD;
                                cntrl_R_array_index <= 0;
                            else
                                cntrl_finish_transmit_count <= cntrl_finish_transmit_count + 1;
                            end if;
                        end if;
                --                        end if;

                end case;

            end if;
        end if;
    end process cntrl_FSM;





    MATRIX_MUL_IP_CORE_S_INT_G_inst : entity work.MATRIX_MUL_IP_CORE_S_INT_G
        generic map(
            COLUMN_TOTAL    => COLUMN_TOTAL,
            OPCODE_WIDTH    => OPCODE_WIDTH,
            ADDR_WIDTH      => ADDR_WIDTH,
            DATA_WIDTH      => DATA_WIDTH,
            DATA_WIDE_WIDTH => DATA_WIDE_WIDTH
        )
        port map(
            CLK                              => CLK,
            RST                              => RST,
            LOAD_PG_in                       => LOAD_PG,
            UN_LOAD_in                       => UN_LOAD,
            P_in                             => P,
            G_in                             => G,
            Bank_sel_in                      => Bank_sel,
            DIN_in                           => DIN,
            AXIS_READ_ENABLE_in              => RDEN_internal,
            Gram_data_available_for_axis_out => data_available,
            DOUT_out                         => DOUT,
            READY_out                        => READY,
            OP_DONE_in                       => OP_DONE,
            LOADING_DONE_in                  => LOADING_DONE,
            UN_LOADING_DONE_out              => UN_LOADING_DONE
        );


-- BELOW ARE THE AXI STREAMING INTEFACE PROCESSES

    m00_axis_tvalid                                                        <= m00_axis_axis_tvalid_delay;
    m00_axis_tdata                                                         <= m00_axis_stream_data_out;
    m00_axis_tlast                                                         <= m00_axis_axis_tlast_delay;
    m00_axis_tstrb                                                         <= (others => '1');
    m00_axis_stream_data_out(DATA_WIDTH - 1 downto 0)                      <= DOUT;
    m00_axis_stream_data_out(C_M00_AXIS_TDATA_WIDTH - 1 downto DATA_WIDTH) <= (others => '0');
    m00_axis_axis_tvalid                                                   <= '1' when ((iii_MMULT_AXIS_OUTPUT_ENABLE = '1') and (m00_axis_mst_exec_state = SEND_STREAM) and (m00_axis_read_pointer < m00_axis_NUMBER_OF_OUTPUT_WORDS)) else '0';
    m00_axis_axis_tlast                                                    <= '1' when (m00_axis_read_pointer = m00_axis_NUMBER_OF_OUTPUT_WORDS - 1) else '0';
    m00_axis_tx_en                                                         <= m00_axis_tready and m00_axis_axis_tvalid;

    DIN <= s00_axis_tdata(DATA_WIDTH - 1 downto 0);
    s00_axis_tready <= s00_axis_axis_tready;
    s00_axis_axis_tready <= '1' when ((MMULT_AXIS_INPUT_ENABLE = '1') and (s00_axis_mst_exec_state = WRITE_FIFO) and (s00_axis_write_pointer <= s00_axis_NUMBER_OF_INPUT_WORDS - 1)) else '0';
    s00_axis_fifo_wren <= s00_axis_tvalid and s00_axis_axis_tready;


    --AXIS SLAVE
    -- I/O Connections assignments
    -- Control state machine implementation
    process(s00_axis_aclk)
    begin
        if (rising_edge(s00_axis_aclk)) then
            if (s00_axis_aresetn = '0' or RST = '1') then --reset addd for fsm
                -- Synchronous reset (active low)
                s00_axis_mst_exec_state <= IDLE;
            else
                case (s00_axis_mst_exec_state) is
                    when IDLE =>
                        -- The sink starts accepting tdata when
                        -- there tvalid is asserted to mark the
                        -- presence of valid streaming data
                        if (s00_axis_tvalid = '1') then
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

                end case;
            end if;
        end if;
    end process;

    -- AXI Streaming Sink
    --
    -- The example design sink is always ready to accept the s00_axis_TDATA  until
    -- the FIFO is not filled with NUMBER_OF_INPUT_WORDS number of input words.
    process(s00_axis_aclk)
    begin
        if (rising_edge(s00_axis_aclk)) then
            if (s00_axis_aresetn = '0' or RST = '1') then --reset addd for s00_axis_write_pointer
                s00_axis_write_pointer <= 0;
                s00_axis_writes_done   <= '0';
            else
                if (s00_axis_write_pointer <= s00_axis_NUMBER_OF_INPUT_WORDS) then
                    if (s00_axis_fifo_wren = '1') then
                        -- write pointer is incremented after every write to the FIFO
                        -- when FIFO write signal is enabled.
                        s00_axis_write_pointer <= s00_axis_write_pointer + 1;
                        s00_axis_writes_done   <= '0';
                    end if;
                    if ((s00_axis_write_pointer = s00_axis_NUMBER_OF_INPUT_WORDS - 1) or s00_axis_tlast = '1') then
                        -- reads_done is asserted when NUMBER_OF_INPUT_WORDS numbers of streaming data
                        -- has been written to the FIFO which is also marked by s00_axis_TLAST(kept for optional usage).
                        s00_axis_writes_done <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;



    -- Control state machine implementation
    process(m00_axis_aclk)
    begin
        if (rising_edge(m00_axis_aclk)) then
            if (m00_axis_aresetn = '0') then
                -- Synchronous reset (active low)
                m00_axis_mst_exec_state <= IDLE;
                m00_axis_count          <= (others => '0');
            else
                case (m00_axis_mst_exec_state) is
                    when IDLE =>
                        -- The slave starts accepting tdata when
                        -- there tvalid is asserted to mark the
                        -- presence of valid streaming data
                        --if (count = "0")then
                        m00_axis_mst_exec_state <= INIT_COUNTER;
                    --else
                    --  mst_exec_state <= IDLE;
                    --end if;

                    when INIT_COUNTER =>
                        -- This state is responsible to wait for user defined C_M_START_COUNT
                        -- number of clock cycles.
                        if (m00_axis_count = std_logic_vector(to_unsigned((C_M_START_COUNT - 1), m00_axis_WAIT_COUNT_BITS))) then
                            m00_axis_mst_exec_state <= SEND_STREAM;
                        else
                            m00_axis_count          <= std_logic_vector(unsigned(m00_axis_count) + 1);
                            m00_axis_mst_exec_state <= INIT_COUNTER;
                        end if;

                    when SEND_STREAM =>
                        -- The example design streaming master functionality starts
                        -- when the master drives output tdata from the FIFO and the slave
                        -- has finished storing the S_AXIS_TDATA
                        if (m00_axis_tx_done = '1') then
                            m00_axis_mst_exec_state <= IDLE;
                        else
                            m00_axis_mst_exec_state <= SEND_STREAM;
                        end if;
                end case;
            end if;
        end if;
    end process;

    --tvalid generation
    --axis_tvalid is asserted when the control state machine's state is SEND_STREAM and
    --number of output streaming data is less than the NUMBER_OF_OUTPUT_WORDS.
    -- AXI tlast generation
    -- axis_tlast is asserted number of output streaming data is NUMBER_OF_OUTPUT_WORDS-1
    -- (0 to NUMBER_OF_OUTPUT_WORDS-1)

    -- Delay the axis_tvalid and axis_tlast signal by one clock cycle
    -- to match the latency of M_AXIS_TDATA
    process(m00_axis_aclk)
    begin
        if (rising_edge(m00_axis_aclk)) then
            if (m00_axis_aresetn = '0') then
                m00_axis_axis_tvalid_delay <= '0';
                m00_axis_axis_tlast_delay  <= '0';
            else
                m00_axis_axis_tvalid_delay <= m00_axis_axis_tvalid;
                m00_axis_axis_tlast_delay  <= m00_axis_axis_tlast;
            end if;
        end if;
    end process;

    --read_pointer pointer
    process(m00_axis_aclk)
    begin
        if (rising_edge(m00_axis_aclk)) then
            if (m00_axis_aresetn = '0') then
                m00_axis_read_pointer <= 0;
                m00_axis_tx_done      <= '0';
            else
                if (m00_axis_read_pointer <= m00_axis_NUMBER_OF_OUTPUT_WORDS - 1) then
                    if (m00_axis_tx_en = '1') then
                        -- read pointer is incremented after every read from the FIFO
                        -- when FIFO read signal is enabled.
                        m00_axis_read_pointer <= m00_axis_read_pointer + 1;
                        m00_axis_tx_done      <= '0';
                    end if;
                elsif (m00_axis_read_pointer = m00_axis_NUMBER_OF_OUTPUT_WORDS) then
                    -- tx_done is asserted when NUMBER_OF_OUTPUT_WORDS numbers of streaming data
                    -- has been out.
                    m00_axis_tx_done <= '1';
                end if;
            end if;
        end if;
    end process;


end Behavioral;
