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


    --CMD:
    ------cmd that affect state transition, they are read inside state: cntrl_WAIT_FOR_CMD, fsm goes in this state only if previous command is completed
    constant cmd_NULL              : integer := 0;
    constant cmd_SAVE_G_or_P       : integer := 1;
    constant cmd_LOAD_G            : integer := 2;
    constant cmd_LOAD_P            : integer := 3;
    constant cmd_CALCULTE          : integer := 4;
    constant cmd_P_to_G            : integer := 5;
    constant cmd_UNLOAD_G          : integer := 6;
    constant cmd_RESET_MMULT_IP    : integer := 11;
    constant cmd_RESET_MMULT_CNTRL : integer := 12;
    constant cmd_SAVE_G            : integer := 13;
    constant cmd_SAVE_P            : integer := 14;
    constant cmd_FINISH_SAVING_G_P : integer := 15;


    --CMD2:
    ------calculation or unload details
    constant cmd2_P_LOWER_to_G          : integer := 11; --"1011";
    constant cmd2_P_HIGHER_to_G         : integer := 15; --"1111";
    constant cmd2_CALCULATE_PG_LOWER    : integer := 0; --"0000";
    constant cmd2_CALCULATE_PG_HIGHER   : integer := 4; --"0100";
    constant cmd2_CALCULATE_PGt_LOWER   : integer := 1; --"0001";
    constant cmd2_CALCULATE_PGt_HIGHER  : integer := 5; --"0101";
    constant cmd2_CALCULATE_PtG_LOWER   : integer := 2; --"0010";
    constant cmd2_CALCULATE_PtG_HIGHER  : integer := 6; --"0110";
    constant cmd2_CALCULATE_PtGt_LOWER  : integer := 3; --"0011";
    constant cmd2_CALCULATE_PtGt_HIGHER : integer := 7; --"0111";


    --signal for axi_write procedure.
    signal cmdin1_sig, cmdin2_sig, cmdin3_sig : std_logic_vector (CMD_SIZE -1 downto 0);
    signal datain_sig : std_logic_vector (DATA_WIDTH - 1 downto 0);

    --axi master simulation
    signal M_AXIS_TVALID  : std_logic;
    signal M_AXIS_TDATA   : std_logic_vector(C_M_AXIS_TDATA_WIDTH - 1 downto 0);
    signal M_AXIS_TSTRB   : std_logic_vector((C_M_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
    signal M_AXIS_TLAST   : std_logic;
    signal M_AXIS_TREADY  : std_logic;

    --axi slave simulation
    signal S_axis_tready  : std_logic;
    signal S_axis_tdata   : std_logic_vector(C_S00_AXIS_TDATA_WIDTH - 1 downto 0);
    signal S_axis_tstrb   : std_logic_vector((C_S00_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
    signal S_axis_tlast   : std_logic;
    signal S_axis_tvalid  : std_logic;


    --WRITE
    procedure simulate_AXI_write(
        constant val      : in  integer;
        constant command1  : in  integer;
        constant command2 : in  integer;
        signal WREN       : out std_logic;
        signal cmdin1_sig     : out std_logic_vector(CMD_SIZE - 1 downto 0);
        signal cmdin2_sig     : out std_logic_vector(CMD_SIZE - 1 downto 0);
        signal datain_sig     : out std_logic_vector(DATA_WIDTH - 1 downto 0)) is
    begin
        WREN   <= '1';
        WREN   <= '0' after period;
        datain_sig <= std_logic_vector(to_unsigned(val, DATA_WIDTH));
        cmdin1_sig <= std_logic_vector(to_unsigned(command1, CMD_SIZE));
        cmdin2_sig <= std_logic_vector(to_unsigned(command2, CMD_SIZE));
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
        wait for period * 10;
    end procedure simulate_AXI_read;

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


            --out rd
            RDY_FOR_CMD      => RDY_FOR_CMD,
            RMATRIX_ADDR     => RMATRIX_ADDR --slv_reg2
        );

    stimul : process is
    begin
        --reset
        WREN   <= '0';
        datain_sig <= (others => '0');
        cmdin1_sig <= (others => '0');
        cmdin2_sig <= (others => '0');
        cmdin3_sig <= (others => '0');
        RDADDR <= (others => '0');
        RDEN   <= '0';
        rst <= '0';
        wait for period * 20;
        rst <= '1';

        simulate_AXI_write(0, cmd_RESET_MMULT_CNTRL, cmd_NULL, WREN, cmdin1_sig, cmdin2_sig, datain_sig);
        simulate_AXI_write(0, cmd_LOAD_G, cmd_NULL, WREN, cmdin1_sig, cmdin2_sig, datain_sig);
        simulate_AXI_write(0, cmd_LOAD_P, cmd_NULL, WREN, cmdin1_sig, cmdin2_sig, datain_sig);
        simulate_AXI_write(0, cmd_CALCULTE, cmd2_CALCULATE_PG_HIGHER, WREN, cmdin1_sig, cmdin2_sig, datain_sig);
        simulate_AXI_write(0, cmd_P_to_G, cmd2_P_HIGHER_to_G, WREN, cmdin1_sig, cmdin2_sig, datain_sig);
        simulate_AXI_write(0, cmd_UNLOAD_G, cmd_NULL, WREN, cmdin1_sig, cmdin2_sig, datain_sig);

        wait;
    end process stimul;


    --here, outputs of axi write procedure is written in WDATA and sent into uut
    WDATA(DATA_WIDTH - 1 downto 0) <= datain_sig;
    WDATA(DATA_WIDTH + CMD_SIZE - 1 downto DATA_WIDTH) <= cmdin1_sig;
    WDATA(DATA_WIDTH + CMD_SIZE * 2 - 1 downto DATA_WIDTH + CMD_SIZE) <=cmdin2_sig;
    WDATA(C_S_AXI_DATA_WIDTH - 1 downto DATA_WIDTH + CMD_SIZE * 2) <= (others => '0');

end architecture RTL;
