library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

entity MATRIX_MUL_IP_CORE_S_INT_G is
    generic(
        COLUMN_TOTAL    : integer := 4;
        OPCODE_WIDTH    : integer := 3;
        ADDR_WIDTH      : integer := 10;
        DATA_WIDTH      : integer := 18;
        DATA_WIDE_WIDTH : integer := 48
    );
    Port(CLK                              : in  STD_LOGIC;
         RST                              : in  STD_LOGIC;
         LOAD_PG_in                       : in  STD_LOGIC_VECTOR(1 downto 0);
         UN_LOAD_in                       : in  STD_LOGIC;
         P_in                             : in  STD_LOGIC;
         G_in                             : in  STD_LOGIC;
         Bank_sel_in                      : in  STD_LOGIC;
         DIN_in                           : in  STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
         AXIS_READ_ENABLE_in              : in  STD_LOGIC;
         Gram_data_available_for_axis_out : out STD_LOGIC;
         DOUT_out                         : out STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
         READY_out                        : out std_logic;
         OP_DONE_in                       : out std_logic;
         LOADING_DONE_in                  : out std_logic;
         UN_LOADING_DONE_out              : out std_logic
    );
end MATRIX_MUL_IP_CORE_S_INT_G;

architecture Behavioral of MATRIX_MUL_IP_CORE_S_INT_G is
    component DSP_INPUT_C
        port(clk : IN  STD_LOGIC;
             sel : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
             a   : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
             b   : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
             c   : IN  STD_LOGIC_VECTOR(47 DOWNTO 0);
             p   : OUT STD_LOGIC_VECTOR(47 DOWNTO 0));
    end component DSP_INPUT_C;

    -------------------------------------------SIGNALS-----------------------

    type i_DATA_t is array (0 to COLUMN_TOTAL - 1) of std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal i_MEM2ALU_inout : i_DATA_t;        ---- mem-to-alu signal
    type i_DATA_wide is array (0 to COLUMN_TOTAL - 1) of std_logic_vector(DATA_WIDE_WIDTH - 1 downto 0);
    signal ALU2ALU_i_inout                                                   : i_DATA_wide; ---- alu-to-alu signal
    signal ALU2ALU_reg, ALU2ALU_reg_i, ALU2ALU_reg_ii, ALU2ALU_reg_iii : std_logic_vector(DATA_WIDTH - 1 downto 0);
    constant DIN_DELAY                                                 : integer := 2;
    constant DELAY_DEPTH                                               : integer := 6 + DIN_DELAY; --7+DIN_DELAY;

    type pipelined_OPCODE_t is array (0 to DIN_DELAY - 1) of std_logic_vector(OPCODE_WIDTH - 1 downto 0);
    signal p_OPCODE : pipelined_OPCODE_t;
    signal i_OPCODE_out : std_logic_vector(OPCODE_WIDTH - 1 downto 0);

    type pipelined_B_t is array (0 to DELAY_DEPTH - 1) of std_logic_vector(0 to COLUMN_TOTAL - 1);
    signal p_WEB : pipelined_B_t;

    signal i_WEB_out : std_logic_vector(0 to COLUMN_TOTAL - 1);

    type pipelined_ADDR_t is array (0 to DELAY_DEPTH - 1) of std_logic_vector(ADDR_WIDTH - 2 downto 0);
    signal p_Write_ADDR, p_ADDRB           : pipelined_ADDR_t;
    signal i_P_Write_ADDR                  : std_logic_vector(ADDR_WIDTH - 2 downto 0);
    signal s_fsm_CSEL_out                   : std_logic_vector(COLUMN_TOTAL - 1 downto 0);
    signal s_fsm_Read_ADDR_in              : std_logic_vector(ADDR_WIDTH - 2 downto 0);
    signal s_fsm_Read_SHFT_out              : std_logic;
    signal s_fsm_OPCODE_in                 : std_logic_vector(OPCODE_WIDTH - 1 downto 0);
    signal s_fsm_WE_in                     : std_logic;
    signal s_modified_fsm_Read_ADDR_out        : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    --signal Bank_Sel : std_logic;
    signal s_modified_fsm_Write_ADDR_out       : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal s_MUL_P_SHFT                    : std_logic;
    signal s_fsm_Write_ADDR_in             : STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
    signal s_fsm_UN_LOAD                   : STD_LOGIC;
    signal s_fsm_CONTROL_A_INPUT_OF_DSP_in : std_logic_vector(1 downto 0);
    signal s_MUl_Din_out                       : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal s_fsm_Write_SHFT_out             : std_logic;

    signal s_G_ROW_in     : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal s_G_COLUMN_in  : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal s_G_O_EN_in    : STD_LOGIC;
    signal s_G_WE_in      : std_logic;
    signal s_GRAM_DOUT_in : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);

    ----------------------
    signal DIN_gram_out                                                                                                : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
    signal WE_gram_out, OE_gram_out, INTERNAL_FSM_READY_in, INTERNAL_FSM_READY, UN_LOADING_DONE_in, AXIS_READ_ENABLE_i : std_logic;
    signal COL_gram_out, ROW_gram_out, G_ROW_ADDR_in, G_COL_ADDR_in                                                    : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal AXIS_READ_ENABLE, AXIS_READ_ENABLE_ii, AXIS_READ_ENABLE_iii                                                 : std_logic;
    signal WE_p_to_g, WE_p_to_g_i, WE_p_to_g_ii                                                                        : std_logic;
    signal INTERNAL_FSM_READY_i, INTERNAL_FSM_READY_ii                                                                 : std_logic; --introduce 1 clock cycle delay, to write on G(0,0);
    signal P_to_G_Write_Enable_out                                                                                     : std_logic;
    signal P_out, G_out, UN_LOAD_out                                                                                   : std_logic;
    signal LOAD_PG_out                                                                                                 : STD_LOGIC_VECTOR(1 downto 0);
begin

    -----------------------------------------------------------

    DELAY_GEN : process(CLK)
    begin
        if rising_edge(CLK) then
            p_Write_ADDR(0) <= s_fsm_Write_ADDR_in;
            for i in 0 to COLUMN_TOTAL - 1 loop
                p_WEB(0)(i) <= s_fsm_CSEL_out(i) and s_fsm_WE_in;
            end loop;
            for i in 1 to DELAY_DEPTH - 1 loop
                p_WEB(i)        <= p_WEB(i - 1); --The Write enable signal is pipelined for 2 + 7 cycles because the output of the DSP computation will have a total latency of 9 clk cycles. 2 for delayed deta input to DSP (A and B) 1 from scratchpad register and about 6 from DSP block.
                p_Write_ADDR(i) <= p_Write_ADDR(i - 1); --The Address for A port of the RAM is delayed for 2 + 7 clk cycles because the DSP takes about 6 clk cyles to finish its computation plus 1 clk delay from scratch pad and plus the data inputs which are delayed for 2 clk cyles.
                p_ADDRB(i)      <= p_ADDRB(i - 1);
            end loop;
            i_P_Write_ADDR <= p_Write_ADDR(DELAY_DEPTH - 1);
            i_WEB_out          <= p_WEB(DELAY_DEPTH - 1);

            p_OPCODE(0) <= s_fsm_OPCODE_in;

            for i in 1 to DIN_DELAY - 1 loop
                p_OPCODE(i) <= p_OPCODE(i - 1); --The opcode is also delayed for 2 clk cycles because it must be sent at the same time with the A and B input of the DSP.
            end loop;
            i_OPCODE_out <= p_OPCODE(DIN_DELAY - 1);

        --PLEASE NOTE: GRAM is delayed for 3 clk circles (2 clk circles for BRAM, 1 clk circle for FSM to settle down) to allow synchronization. This delay is implemented in GRAM itself (STANDARD_RAM.vhd)
        --However, In the real setup if the GRAM is not interfaced directly with the IP core e.g GRAM data is coming through a bus
        --Then a pipeline should be created here in this process to delay GRAM data for 3 clk circles so that it will be in synchronization with
        -- BRAM data. Also keep in mind that if this pipeline is implemented then it will affect the time it takes to load data into the IP core because both GRAM data and Data input
        -- use thesame input to the DSP48 block so as a result, the signal flags 'LOADING_DONE' and 'READY' located in the CONTROL_UNIT.vhd will have to be adjusted to accommodate the delay introduced by the pipeline.
        -- Adjusting these signals is easy. In "CONTROL_UNIT.vhd" There is a process called "FLAGS_and_Current_state_update", in this process you will notice that
        -- a counter is used to trigger when the flags should be set, simply adjust the count value in the conditional statements accordingly, that should do the trick.
        end if;
    end process;
 
    shift_registers : process(clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                Gram_data_available_for_axis_out <= '0';
                AXIS_READ_ENABLE_i               <= '0';
                AXIS_READ_ENABLE_ii              <= '0';
                AXIS_READ_ENABLE_iii             <= '0';
                INTERNAL_FSM_READY_i             <= '0';
                INTERNAL_FSM_READY_ii            <= '0';
                ALU2ALU_reg_ii                   <= (others => '0');
                ALU2ALU_reg_iii                  <= (others => '0');
                WE_p_to_g_i                      <= '0';
                WE_p_to_g_ii                     <= '0';
            else
                INTERNAL_FSM_READY_i  <= INTERNAL_FSM_READY_in;
                INTERNAL_FSM_READY_ii <= INTERNAL_FSM_READY_i;
                INTERNAL_FSM_READY    <= INTERNAL_FSM_READY_ii;

                AXIS_READ_ENABLE_i   <= AXIS_READ_ENABLE_in;
                AXIS_READ_ENABLE_ii  <= AXIS_READ_ENABLE_i;
                AXIS_READ_ENABLE_iii <= AXIS_READ_ENABLE_ii;
                AXIS_READ_ENABLE     <= AXIS_READ_ENABLE_ii;

                ALU2ALU_reg_i   <= ALU2ALU_i_inout(COLUMN_TOTAL - 1)(DATA_WIDTH - 1 downto 0);
                ALU2ALU_reg_ii  <= ALU2ALU_reg_i;
                ALU2ALU_reg_iii <= ALU2ALU_reg_ii;
                ALU2ALU_reg     <= ALU2ALU_reg_iii;

                WE_p_to_g_i  <= UN_LOAD_in and (not UN_LOADING_DONE_in);
                WE_p_to_g_ii <= WE_p_to_g_i;
                WE_p_to_g    <= WE_p_to_g_ii;
            end if;
        end if;
    end process shift_registers;

    LOAD_PG_out                      <= LOAD_PG_in;
    P_out                            <= P_in;
    G_out                            <= G_in;
    UN_LOAD_out                      <= UN_LOAD_in;
    READY_out                        <= INTERNAL_FSM_READY;
    UN_LOADING_DONE_out              <= UN_LOADING_DONE_in;
    Gram_data_available_for_axis_out <= AXIS_READ_ENABLE;
    
    P_to_G_Write_Enable_out          <= '1' when UN_LOAD_in = '1' and INTERNAL_FSM_READY = '1' and UN_LOADING_DONE_in = '0' else '0';
    DOUT_out                         <= s_GRAM_DOUT_in;

    GramControl : process(ALU2ALU_reg_iii, ALU2ALU_reg_ii, ALU2ALU_reg_i, AXIS_READ_ENABLE, DIN_in, G_COL_ADDR_in, G_ROW_ADDR_in, LOAD_PG_in, AXIS_READ_ENABLE_i, INTERNAL_FSM_READY_in, UN_LOAD_in, UN_LOADING_DONE_in, WE_p_to_g, s_G_COLUMN_in, s_G_O_EN_in, s_G_ROW_in, s_G_WE_in, P_to_G_Write_Enable_out, ALU2ALU_reg, WE_p_to_g)
    begin
        if LOAD_PG_in = OPERATE_CMD and P_to_G_Write_Enable_out = '1' then
            --P to G, when unloading from Bram data will come go GRAM
            ROW_gram_out <= G_ROW_ADDR_in;
            COL_gram_out <= G_COL_ADDR_in;
            DIN_gram_out <= ALU2ALU_reg; --output from fsm, data of Bram
            WE_gram_out  <= WE_p_to_g;
            OE_gram_out  <= '0';
        elsif LOAD_PG_in = IDLE_CMD and AXIS_READ_ENABLE = '1' then
            --G to AXI
            ROW_gram_out <= G_ROW_ADDR_in;
            COL_gram_out <= G_COL_ADDR_in;
            DIN_gram_out <= (others => '0'); --output from fsm, having data for G ram
            WE_gram_out  <= '0';
            OE_gram_out  <= AXIS_READ_ENABLE;
        else
            ----FSM <-> G, normal operating mode
            ROW_gram_out <= s_G_ROW_in;
            COL_gram_out <= s_G_COLUMN_in;
            DIN_gram_out <= DIN_in;     --output from fsm, having data for G ram
            WE_gram_out  <= s_G_WE_in;
            OE_gram_out  <= s_G_O_EN_in;
        end if;

    end process GramControl;

    --------------------------------------------------------------

    s_modified_fsm_Write_ADDR_out <= Bank_sel_in & i_P_Write_ADDR;
    s_modified_fsm_Read_ADDR_out  <= not (Bank_sel_in) & s_fsm_Read_ADDR_in;
    s_MUl_Din_out                 <= DIN_in(DATA_WIDTH - 1 downto 0) when s_fsm_CONTROL_A_INPUT_OF_DSP_in = "00" else (0 => '1', others => '0') when s_fsm_CONTROL_A_INPUT_OF_DSP_in = "01" --set to 1 when FSM is in control. (B*A=B) when A = 1.
        else s_GRAM_DOUT_in;

    BLOCK_A_MEM_GEN : for i in 0 to COLUMN_TOTAL - 1 generate
        MEMA : entity work.BRAM_WRAPPER_V2
            generic map(
                COLUMN_NUMBER => i,
                NUM_COLUMNS   => COLUMN_TOTAL,
                ADDR_WIDTH    => ADDR_WIDTH,
                DATA_WIDTH    => DATA_WIDTH)
            PORT MAP(
                CLK        => CLK,
                Write_ADDR => s_modified_fsm_Write_ADDR_out, -- i_ADDR, -- Pipelined --
                DINA       => ALU2ALU_i_inout(i)(DATA_WIDTH - 1 downto 0), --i_SPDOUT(i),
                Read_ADDR  => s_modified_fsm_Read_ADDR_out, -- ADDRB,-- multiplexed between FSM input and User input.
                DOUTB      => i_MEM2ALU_inout(i),
                Read_SHFT  => s_fsm_Read_SHFT_out, --s_MUL_P_SHFT,--,s_i_ASHFT,
                Write_SHFT => s_fsm_Write_SHFT_out,
                WEA        => i_WEB_out(i),
                OEB        => s_fsm_CSEL_out(i)
            );
    end generate;
    --------------------------------------------------------------
    FIRST_DSP : component DSP_INPUT_C PORT MAP(
            clk => CLK,
            sel => i_OPCODE_out,
            a   => s_MUl_Din_out,           --DIN(17 downto 0),--i_DIN,
            b   => i_MEM2ALU_inout(0),        --(17 downto 0),
            c   => ALU2ALU_i_inout(COLUMN_TOTAL - 1),
            p   => ALU2ALU_i_inout(0)
        );

    ---------------------------------------------------
    BLOCK_A_DSP_GEN : for i in 1 to COLUMN_TOTAL - 1 generate
        DSP : component DSP_INPUT_C PORT MAP(
                clk => CLK,
                sel => i_OPCODE_out,
                a   => s_MUl_Din_out,       --DIN(17 downto 0),--i_DIN,
                b   => i_MEM2ALU_inout(i),    --(17 downto 0),
                c   => ALU2ALU_i_inout(i - 1),
                p   => ALU2ALU_i_inout(i)
            );
    end generate;

   ----------------------------------------------------------------
    FSM_UNIT : entity work.CONTROL_UNIT_S_INT_G
        generic map(
            ADDR_WIDTH   => ADDR_WIDTH,
            DATA_WIDTH   => DATA_WIDTH,
            OPCODE_WIDTH => OPCODE_WIDTH,
            COLUMN_TOTAL => COLUMN_TOTAL
        )
        Port map(
            CLK                    => CLK,
            RST                    => RST,
            LOAD_PG                => LOAD_PG_out,
            UN_LOAD                => UN_LOAD_out,
            P                      => P_out,
            G                      => G_out,
            WE                     => s_fsm_WE_in,
            CSEL                   => s_fsm_CSEL_out,
            Read_ADDR              => s_fsm_Read_ADDR_in,
            Write_ADDR             => s_fsm_Write_ADDR_in,
            Read_SHFT              => s_fsm_Read_SHFT_out,
            Write_SHFT             => s_fsm_Write_SHFT_out,
            OPCODE                 => s_fsm_OPCODE_in,
            G_ROW                  => s_G_ROW_in,
            G_COLUMN               => s_G_COLUMN_in,
            G_WE                   => s_G_WE_in,
            G_EN                   => s_G_O_EN_in,
            OP_DONE                => OP_DONE_in,
            READY                  => INTERNAL_FSM_READY_in,
            LOADING_DONE           => LOADING_DONE_in,
            UN_LOADING_DONE        => UN_LOADING_DONE_in,
            CONTROL_A_INPUT_OF_DSP => s_fsm_CONTROL_A_INPUT_OF_DSP_in
        );
    --------------------------------------------------------------

    GRAM : entity work.STANDARD_RAM
        generic map(
            COLUMN_TOTAL => COLUMN_TOTAL, -- num columns in ram
            ADDR_WIDTH   => ADDR_WIDTH, -- log2 of rows
            DATA_WIDTH   => DATA_WIDTH  --
        )
        Port map(CLK      => CLK,
                 ROW_in   => ROW_gram_out,
                 COL_in   => COL_gram_out,
                 DIN_in   => DIN_gram_out,
                 DOUT_out => s_GRAM_DOUT_in,
                 WE_in    => WE_gram_out,
                 OE_in    => OE_gram_out
        );

    GRAM_ADDRESS_GENERATOR_inst : entity work.GRAM_ADDRESS_GENERATOR
        generic map(
            COLUMN_TOTAL => COLUMN_TOTAL,
            ADDR_WIDTH   => ADDR_WIDTH
        )
        port map(
            --out
            G_COL_ADDR_out      => G_COL_ADDR_in,
            G_ROW_ADDR_out      => G_ROW_ADDR_in,

            --in AXI
            AXIS_READ_ENABLE    => AXIS_READ_ENABLE,

            --in P-to-G
            P_to_G_Write_Enable => P_to_G_Write_Enable_out,
            LOAD_PG             => LOAD_PG_out,
            clk                 => clk,
            rst                 => rst
        );

end Behavioral;
