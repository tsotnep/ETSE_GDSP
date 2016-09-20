library IEEE;                           ---
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

entity TB_MMULT_CONROLLER_2 is
    generic(
        C_S_AXI_DATA_WIDTH     : integer := 32;
        C_M_AXIS_TDATA_WIDTH   : integer := 32;
        C_M_START_COUNT        : integer := 32;
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
end entity TB_MMULT_CONROLLER_2;

architecture RTL of TB_MMULT_CONROLLER_2 is
    constant period : time := 10 ns;
    signal clk, rst      : std_logic;

    signal WREN, RDEN, RDY_FOR_CMD    : std_logic;
    signal WDATA, RDATA, RMATRIX_ADDR : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
    signal RDADDR                     : std_logic_vector(1 downto 0);

    constant DOUT_SLV_REG1_ADRR    : std_logic_vector := std_logic_vector(to_unsigned(1, OPT_MEM_ADDR_BITS + 1));
    constant COLADDR_SLV_REG2_ADRR : std_logic_vector := std_logic_vector(to_unsigned(2, OPT_MEM_ADDR_BITS + 1));

    -- Ports of Axi Slave Bus Interface S00_AXIS
    signal s00_axis_aresetn : std_logic;
    signal s00_axis_tready  : std_logic;
    signal s00_axis_aclk    : std_logic;
    signal s00_axis_tdata   : std_logic_vector(C_S00_AXIS_TDATA_WIDTH - 1 downto 0);
    signal s00_axis_tstrb   : std_logic_vector((C_S00_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
    signal s00_axis_tlast   : std_logic;
    signal s00_axis_tvalid  : std_logic;
    
    signal m00_axis_aclk    : std_logic;
    signal m00_axis_aresetn : std_logic;
    signal m00_axis_tvalid  : std_logic;
    signal m00_axis_tdata   : std_logic_vector(C_M00_AXIS_TDATA_WIDTH - 1 downto 0);
    signal m00_axis_tstrb   : std_logic_vector((C_M00_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
    signal m00_axis_tlast   : std_logic;
    signal m00_axis_tready  : std_logic;

    ----------------------------------------------------->>>
    --CMD:
    ------cmd that affect state transition, they are read inside state: cntrl_WAIT_FOR_CMD
    constant cmd_NULL              : std_logic_vector := std_logic_vector(to_unsigned(0, 4));
    constant cmd_SAVE_G_or_P       : std_logic_vector := std_logic_vector(to_unsigned(1, 4));
    constant cmd_LOAD_G            : std_logic_vector := std_logic_vector(to_unsigned(2, 4));
    constant cmd_LOAD_P            : std_logic_vector := std_logic_vector(to_unsigned(3, 4));
    constant cmd_CALCULTE          : std_logic_vector := std_logic_vector(to_unsigned(4, 4));
    constant cmd_P_to_G            : std_logic_vector := std_logic_vector(to_unsigned(5, 4));
    constant cmd_UNLOAD_G          : std_logic_vector := std_logic_vector(to_unsigned(6, 4));
    constant cmd_RESET_MMULT_IP    : std_logic_vector := std_logic_vector(to_unsigned(11, 4));
    constant cmd_RESET_MMULT_CNTRL : std_logic_vector := std_logic_vector(to_unsigned(12, 4));
    --------those cmd are used as state-specific commands, they are read in state: cntrl_SAVE_G_or_P
    constant cmd_SAVE_G            : std_logic_vector := std_logic_vector(to_unsigned(13, 4));
    constant cmd_SAVE_P            : std_logic_vector := std_logic_vector(to_unsigned(14, 4));
    constant cmd_FINISH_SAVING_G_P : std_logic_vector := std_logic_vector(to_unsigned(15, 4));

    ----------------------------------------------------->>>
    --CMD2:
    ------calculation or unload details
    constant cmd_P_LOWER_to_G          : std_logic_vector := "1011";
    constant cmd_P_HIGHER_to_G         : std_logic_vector := "1111";
    constant cmd_CALCULATE_PG_LOWER    : std_logic_vector := "0000";
    constant cmd_CALCULATE_PG_HIGHER   : std_logic_vector := "0100";
    constant cmd_CALCULATE_PGt_LOWER   : std_logic_vector := "0001";
    constant cmd_CALCULATE_PGt_HIGHER  : std_logic_vector := "0101";
    constant cmd_CALCULATE_PtG_LOWER   : std_logic_vector := "0010";
    constant cmd_CALCULATE_PtG_HIGHER  : std_logic_vector := "0110";
    constant cmd_CALCULATE_PtGt_LOWER  : std_logic_vector := "0011";
    constant cmd_CALCULATE_PtGt_HIGHER : std_logic_vector := "0111";
    --------cmd2(3) 1=read or 0=write
    --------cmd2(2) 1=upperbank or 0=lowerbank
    --------cmd2(1 downto 0) -> what kind of calculation 00=PG, 01=PGt, etc.


    alias datain is WDATA(DATA_WIDTH - 1 downto 0); --18 bits
    --    alias datain is WDATA(0 to DATA_WIDTH - 1); --18 bits
    alias cmdin is WDATA(DATA_WIDTH + CMD_SIZE - 1 downto DATA_WIDTH); --4 bits current command
    alias cmdin2 is WDATA(DATA_WIDTH + CMD_SIZE * 2 - 1 downto DATA_WIDTH + CMD_SIZE); --4 bits next command.
    alias cmdin3 is WDATA(C_S_AXI_DATA_WIDTH - 1 downto DATA_WIDTH + CMD_SIZE * 2); --6 bits spared for future.


    --WRITE
    procedure simulate_AXI_write(
        constant val      : in  integer;
        constant command  : in  std_logic_vector(CMD_SIZE - 1 downto 0);
        constant command2 : in  std_logic_vector(CMD_SIZE - 1 downto 0);
        signal WREN       : out std_logic;
        signal cmdin      : out std_logic_vector(CMD_SIZE - 1 downto 0);
        signal cmdin2     : out std_logic_vector(CMD_SIZE - 1 downto 0);
        signal datain     : out std_logic_vector(DATA_WIDTH - 1 downto 0)) is
    begin
        WREN   <= '1';
        WREN   <= '0' after period;
        cmdin  <= command;
        cmdin2 <= command2;
        datain <= std_logic_vector(to_unsigned(val, DATA_WIDTH));
        wait for period * 30;
    end procedure simulate_AXI_write;

    --READ
    procedure simulate_AXI_read(
        constant RDADDR_IN : in  std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
        signal RDEN        : out std_logic;
        signal RDADDR      : out std_logic_vector(OPT_MEM_ADDR_BITS downto 0)) is
    begin
        RDEN   <= '1';
        RDEN   <= '0' after period;
        RDADDR <= RDADDR_IN;
        --        if RDADDR_IN = DOUT_SLV_REG1_ADRR then
        --            RDADDR <= DOUT_SLV_REG1_ADRR;
        --        else
        --            RDADDR <= COLADDR_SLV_REG2_ADRR;
        --        end if;
        wait for period * 10;
    end procedure simulate_AXI_read;
    signal M_AXIS_TVALID  : std_logic;
    signal M_AXIS_TDATA   : std_logic_vector(C_M_AXIS_TDATA_WIDTH - 1 downto 0);
    signal M_AXIS_TSTRB   : std_logic_vector((C_M_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
    signal M_AXIS_TLAST   : std_logic;
    signal M_AXIS_TREADY  : std_logic;
        
    
    signal S_axis_tready  : std_logic;
    signal S_axis_tdata   : std_logic_vector(C_S00_AXIS_TDATA_WIDTH - 1 downto 0);
    signal S_axis_tstrb   : std_logic_vector((C_S00_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
    signal S_axis_tlast   : std_logic;
    signal S_axis_tvalid  : std_logic;
begin
    clock_driver : process
    begin
        clk <= '0';
        wait for period / 2;
        clk <= '1';
        wait for period / 2;
    end process clock_driver;

    axi_stream_simulation_slave_inst : entity work.axi_stream_simulation_slave
        generic map(
            C_S00_AXIS_TDATA_WIDTH => C_S00_AXIS_TDATA_WIDTH
        )
        port map(
            s00_axis_aclk    => clk,
            s00_axis_aresetn => rst,
            s00_axis_tready  => S_AXIS_tready,
            s00_axis_tdata   => S_AXIS_tdata,
            s00_axis_tstrb   => S_AXIS_tstrb,
            s00_axis_tlast   => S_AXIS_tlast,
            s00_axis_tvalid  => S_AXIS_tvalid
        );
        
    axi_stream_simulation_inst : entity work.axi_stream_simulation_master
        generic map(
            C_M_AXIS_TDATA_WIDTH => C_M_AXIS_TDATA_WIDTH,
            C_M_START_COUNT      => C_M_START_COUNT
        )
        port map(
            m00_AXIS_ACLK    => clk,
            m00_AXIS_ARESETN => rst,
            m00_AXIS_TVALID  => M_AXIS_TVALID,
            m00_AXIS_TDATA   => M_AXIS_TDATA,
            m00_AXIS_TSTRB   => M_AXIS_TSTRB,
            m00_AXIS_TLAST   => M_AXIS_TLAST,
            m00_AXIS_TREADY  => M_AXIS_TREADY --in
        );

    MMULT_CONTROLLER_2_inst : entity work.MMULT_CONTROLLER_2
        generic map(
            C_S_AXI_DATA_WIDTH => C_S_AXI_DATA_WIDTH,
            COLUMN_TOTAL       => COLUMN_TOTAL,
            OPCODE_WIDTH       => OPCODE_WIDTH,
            CMD_SIZE           => CMD_SIZE,
            OPT_MEM_ADDR_BITS  => OPT_MEM_ADDR_BITS,
            ADDR_WIDTH         => ADDR_WIDTH,
            DATA_WIDTH         => DATA_WIDTH,
            DATA_WIDE_WIDTH    => DATA_WIDE_WIDTH
        )
        port map(
            s00_axis_aresetn => rst,
            s00_axis_aclk    => clk,
            s00_axis_tready  => M_AXIS_TREADY, --out
            s00_axis_tdata   => M_AXIS_TDATA,
            s00_axis_tstrb   => M_AXIS_TSTRB,
            s00_axis_tlast   => M_AXIS_TLAST,
            s00_axis_tvalid  => M_AXIS_TVALID,
            
            m00_axis_aclk    => clk,
            m00_axis_aresetn => rst,
            m00_axis_tvalid  => S_AXIS_tvalid,
            m00_axis_tdata   => S_AXIS_tdata,
            m00_axis_tstrb   => S_AXIS_tstrb,
            m00_axis_tlast   => S_AXIS_tlast,
            m00_axis_tready  => S_AXIS_tready,
            
            
            CLK              => CLK,
            --in wr
            WREN             => WREN,   --slv_reg_wren
            WDATA            => WDATA,  --S_AXI_WDATA

            --in rd
            RDADDR           => RDADDR, --rd_loc_addr_to_cntrl
            RDEN             => RDEN,   --slv_reg_rden

            --out rd
            RDY_FOR_CMD      => RDY_FOR_CMD,
            RDATA            => RDATA,  --slv_reg1
            RMATRIX_ADDR     => RMATRIX_ADDR --slv_reg2
        );

    stimul : process is
    begin
        WREN   <= '0';
        datain <= (others => '0');
        cmdin  <= cmd_NULL;
        cmdin2 <= (others => '0');
        cmdin3 <= (others => '0');
        RDADDR <= (others => '0');
        RDEN   <= '0';
        rst <= '0';
        wait for period * 20;
        rst <= '1';

        simulate_AXI_write(7, cmd_RESET_MMULT_CNTRL, cmd_NULL, WREN, cmdin, cmdin2, datain);

        simulate_AXI_write(0, cmd_LOAD_G, cmd_NULL, WREN, cmdin, cmdin2, datain);
        
        simulate_AXI_write(0, cmd_LOAD_P, cmd_NULL, WREN, cmdin, cmdin2, datain);

        simulate_AXI_write(0, cmd_P_to_G, cmd_NULL, WREN, cmdin, cmdin2, datain);


--        simulate_AXI_write(0, cmd_CALCULTE, cmd_CALCULATE_PG_HIGHER, WREN, cmdin, cmdin2, datain);

--        simulate_AXI_write(0, cmd_P_to_G, cmd_P_HIGHER_to_G, WREN, cmdin, cmdin2, datain);

        --
        --
        simulate_AXI_write(0, cmd_UNLOAD_G, cmd_NULL, WREN, cmdin, cmdin2, datain);
--                simulate_AXI_read(DOUT_SLV_REG1_ADRR, RDEN, RDADDR);
--                simulate_AXI_read(DOUT_SLV_REG1_ADRR, RDEN, RDADDR);
--                simulate_AXI_read(DOUT_SLV_REG1_ADRR, RDEN, RDADDR);
--                simulate_AXI_read(DOUT_SLV_REG1_ADRR, RDEN, RDADDR);
--                simulate_AXI_read(DOUT_SLV_REG1_ADRR, RDEN, RDADDR);
--                simulate_AXI_read(DOUT_SLV_REG1_ADRR, RDEN, RDADDR);
--                simulate_AXI_read(DOUT_SLV_REG1_ADRR, RDEN, RDADDR);
--                simulate_AXI_read(DOUT_SLV_REG1_ADRR, RDEN, RDADDR);
--                simulate_AXI_read(DOUT_SLV_REG1_ADRR, RDEN, RDADDR);
        --        wait for period * 30;
        --        --wait until RDY_FOR_CMD = '1';


        wait;
    end process stimul;

end architecture RTL;
