library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--simulates Master side.
entity axi_stream_simulation is
    generic(
        -- Users to add parameters here

        -- User parameters ends
        -- Do not modify the parameters beyond this line

        -- Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
        C_M_AXIS_TDATA_WIDTH : integer := 32;
        -- Start count is the numeber of clock cycles the master will wait before initiating/issuing any transaction.
        C_M_START_COUNT      : integer := 64
    );
    port(
        -- Users to add ports here
--            rst : in std_logic;
        -- User ports ends
        -- Do not modify the ports beyond this line

        -- Global ports
        m00_AXIS_ACLK    : in  std_logic;
        -- 
        m00_AXIS_ARESETN : in  std_logic;
        -- Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
        m00_AXIS_TVALID  : out std_logic;
        -- TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
        m00_AXIS_TDATA   : out std_logic_vector(C_M_AXIS_TDATA_WIDTH - 1 downto 0);
        -- TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
        m00_AXIS_TSTRB   : out std_logic_vector((C_M_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
        -- TLAST indicates the boundary of a packet.
        m00_AXIS_TLAST   : out std_logic;
        -- TREADY indicates that the slave can accept a transfer in the current cycle.
        m00_AXIS_TREADY  : in  std_logic
    );
end axi_stream_simulation;

architecture implementation of axi_stream_simulation is
    --Total number of output data.
    -- function called clogb2 that returns an integer which has the   
    -- value of the ceiling of the log base 2.                              
    function clogb2(bit_depth : integer) return integer is
        variable depth : integer := bit_depth;
        variable count : integer := 1;
    begin
        for clogb2 in 1 to bit_depth loop -- Works for up to 32 bit integers
            if (bit_depth <= 2) then
                count := 1;
            else
                if (depth <= 1) then
                    count := count;
                else
                    depth := depth / 2;
                    count := count + 1;
                end if;
            end if;
        end loop;
        return (count);
    end;
    
    
    -- Total number of output data                                              
    constant m00_axis_NUMBER_OF_OUTPUT_WORDS : integer := 1024;
    

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
    type m00_axis_state is (IDLE,                -- This is the initial/idle state                    
                   INIT_COUNTER,        -- This state initializes the counter, ones        
                   -- the counter reaches C_M_START_COUNT count,     
                   -- the state machine changes state to INIT_WRITE  
                   SEND_STREAM);        -- In this state the                               
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
    signal m00_axis_stream_data_out   : std_logic_vector(C_M_AXIS_TDATA_WIDTH - 1 downto 0);
    signal m00_axis_tx_en             : std_logic;
    --The master has issued all the streaming data stored in FIFO
    signal m00_axis_tx_done           : std_logic;

begin
    
    
    -- I/O Connections assignments

    m00_AXIS_TVALID <= m00_axis_axis_tvalid_delay;
    m00_AXIS_TDATA  <= m00_axis_stream_data_out;
    m00_AXIS_TLAST  <= m00_axis_axis_tlast_delay;
    m00_AXIS_TSTRB  <= (others => '1');

    -- Control state machine implementation                                               
    process(m00_AXIS_ACLK)
    begin
        if (rising_edge(m00_AXIS_ACLK)) then
            if (m00_AXIS_ARESETN = '0') then
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

                    when others =>
                        m00_axis_mst_exec_state <= IDLE;

                end case;
            end if;
        end if;
    end process;

    --tvalid generation
    --axis_tvalid is asserted when the control state machine's state is SEND_STREAM and
    --number of output streaming data is less than the NUMBER_OF_OUTPUT_WORDS.
    m00_axis_axis_tvalid <= '1' when ((m00_axis_mst_exec_state = SEND_STREAM) and (m00_axis_read_pointer < m00_axis_NUMBER_OF_OUTPUT_WORDS)) else '0';

    -- AXI tlast generation                                                                        
    -- axis_tlast is asserted number of output streaming data is NUMBER_OF_OUTPUT_WORDS-1          
    -- (0 to NUMBER_OF_OUTPUT_WORDS-1)                                                             
    m00_axis_axis_tlast <= '1' when (m00_axis_read_pointer = m00_axis_NUMBER_OF_OUTPUT_WORDS - 1) else '0';

    -- Delay the axis_tvalid and axis_tlast signal by one clock cycle                              
    -- to match the latency of M_AXIS_TDATA                                                        
    process(m00_AXIS_ACLK)
    begin
        if (rising_edge(m00_AXIS_ACLK)) then
            if (m00_AXIS_ARESETN = '0') then
                m00_axis_axis_tvalid_delay <= '0';
                m00_axis_axis_tlast_delay  <= '0';
            else
                m00_axis_axis_tvalid_delay <= m00_axis_axis_tvalid;
                m00_axis_axis_tlast_delay  <= m00_axis_axis_tlast;
            end if;
        end if;
    end process;

    --read_pointer pointer

    process(m00_AXIS_ACLK)
    begin
        if (rising_edge(m00_AXIS_ACLK)) then
            if (m00_AXIS_ARESETN = '0') then
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

    --FIFO read enable generation 

    m00_axis_tx_en <= m00_AXIS_TREADY and m00_axis_axis_tvalid;

    -- FIFO Implementation                                                          

    -- Streaming output data is read from FIFO                                      
    process(m00_AXIS_ACLK)
        variable sig_one : integer := 1;
    begin
        if (rising_edge(m00_AXIS_ACLK)) then
            if (m00_AXIS_ARESETN = '0') then
                m00_axis_stream_data_out <= std_logic_vector(to_unsigned(0, C_M_AXIS_TDATA_WIDTH));
            elsif (m00_axis_tx_en = '1') then    -- && M_AXIS_TSTRB(byte_index)                   
--                stream_data_out <= std_logic_vector(to_unsigned(read_pointer, C_M_AXIS_TDATA_WIDTH) + to_unsigned(sig_one, C_M_AXIS_TDATA_WIDTH));
                m00_axis_stream_data_out <= std_logic_vector(to_unsigned(m00_axis_read_pointer, C_M_AXIS_TDATA_WIDTH) + to_unsigned(sig_one, C_M_AXIS_TDATA_WIDTH));
            end if;
        end if;
    end process;

-- Add user logic here

-- User logic ends

end implementation;
