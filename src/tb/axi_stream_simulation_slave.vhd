library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

--simulates Master side.
entity axi_stream_simulation_slave is
    generic(
        -- Users to add parameters here

        -- User parameters ends
        -- Do not modify the parameters beyond this l
            -- Parameters of Axi Slave Bus Interface S00_AXIS
            C_S00_AXIS_TDATA_WIDTH : integer := 32
    );
    port(
        -- Users to add ports here
--            rst : in std_logic;
        -- User ports ends
        -- Do not modify the ports beyond this line
        -- Ports of Axi Slave Bus Interface S00_AXIS
        s00_axis_aclk    : in  std_logic;
        s00_axis_aresetn : in  std_logic;
        s00_axis_tready  : out std_logic;
        s00_axis_tdata   : in  std_logic_vector(C_S00_AXIS_TDATA_WIDTH - 1 downto 0);
        s00_axis_tstrb   : in  std_logic_vector((C_S00_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
        s00_axis_tlast   : in  std_logic;
        s00_axis_tvalid  : in  std_logic

    );
end axi_stream_simulation_slave;

architecture implementation of axi_stream_simulation_slave is
    --Total number of output data.
    -- function called clogb2 that returns an integer which has the
    -- value of the ceiling of the log base 2.



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
    constant s00_axis_NUMBER_OF_INPUT_WORDS : integer := COLUMN_TOTAL * COLUMN_TOTAL * 4;
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

    signal MMULT_AXIS_INPUT_ENABLE, MMULT_AXIS_OUTPUT_ENABLE : std_logic;

    signal rst : std_logic := '0';

begin

---
    ------
    --AXIS SLAVE

    -- I/O Connections assignments

    s00_axis_TREADY <= s00_axis_axis_tready;
    -- Control state machine implementation
    process(s00_axis_ACLK)
    begin
        if (rising_edge(s00_axis_ACLK)) then
            if (s00_axis_ARESETN = '0' or rst = '1') then --reset addd for fsm
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
                        s00_axis_stream_data_fifo(s00_axis_write_pointer) <= s00_axis_tdata;
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
    s00_axis_axis_tready <= '1' when ((s00_axis_mst_exec_state = WRITE_FIFO) and (s00_axis_write_pointer <= s00_axis_NUMBER_OF_INPUT_WORDS - 1)) else '0';

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

    ------
    ------

end implementation;
