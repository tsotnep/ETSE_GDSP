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
    Port(CLK             : in  STD_LOGIC;
         RST             : in  STD_LOGIC;
         LOAD_PG         : in  STD_LOGIC_VECTOR(1 downto 0);
         UN_LOAD         : in  STD_LOGIC;
         P               : in  STD_LOGIC;
         G               : in  STD_LOGIC;
         Bank_sel_in     : in  STD_LOGIC;
         DIN             : in  STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
         DOUT            : out STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
         READY           : out std_logic;
         OP_DONE         : out std_logic;
         LOADING_DONE    : out std_logic;
         UN_LOADING_DONE : out std_logic
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
    signal i_MEM2ALU : i_DATA_t;        ---- mem-to-alu signal
    type i_DATA_wide is array (0 to COLUMN_TOTAL - 1) of std_logic_vector(DATA_WIDE_WIDTH - 1 downto 0);
    signal i_ALU2ALU : i_DATA_wide;     ---- alu-to-alu signal

    constant DIN_DELAY   : integer := 2;
    constant DELAY_DEPTH : integer := 6 + DIN_DELAY; --7+DIN_DELAY;

    type pipelined_OPCODE_t is array (0 to DIN_DELAY - 1) of std_logic_vector(OPCODE_WIDTH - 1 downto 0);
    signal p_OPCODE : pipelined_OPCODE_t;
    signal i_OPCODE : std_logic_vector(OPCODE_WIDTH - 1 downto 0);

    type pipelined_B_t is array (0 to DELAY_DEPTH - 1) of std_logic_vector(0 to COLUMN_TOTAL - 1);
    signal p_WEB : pipelined_B_t;

    signal i_WEB : std_logic_vector(0 to COLUMN_TOTAL - 1);

    type pipelined_ADDR_t is array (0 to DELAY_DEPTH - 1) of std_logic_vector(ADDR_WIDTH - 2 downto 0);
    signal p_Write_ADDR, p_ADDRB        : pipelined_ADDR_t;
    signal i_P_Write_ADDR               : std_logic_vector(ADDR_WIDTH - 2 downto 0);
    signal s_fsm_CSEL                   : std_logic_vector(COLUMN_TOTAL - 1 downto 0);
    signal s_fsm_Read_ADDR              : std_logic_vector(ADDR_WIDTH - 2 downto 0);
    signal s_fsm_Read_SHFT              : std_logic;
    signal s_fsm_OPCODE                 : std_logic_vector(OPCODE_WIDTH - 1 downto 0);
    signal s_fsm_WE                     : std_logic;
    signal s_modified_fsm_Read_ADDR     : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    --signal Bank_Sel : std_logic;
    signal s_modified_fsm_Write_ADDR    : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal s_MUL_P_SHFT                 : std_logic;
    signal s_fsm_Write_ADDR             : STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
    signal s_fsm_UN_LOAD                : STD_LOGIC;
    signal s_fsm_CONTROL_A_INPUT_OF_DSP : std_logic_vector(1 downto 0);
    signal s_MUl_Din                    : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal s_fsm_Write_SHFT             : std_logic;

    signal s_G_ROW     : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal s_G_COLUMN  : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal s_G_O_EN    : STD_LOGIC;
    signal s_G_WE      : std_logic;
    signal s_GRAM_DOUT : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
begin

    -----------------------------------------------------------


    DELAY_GEN : process(CLK)
    begin
        if rising_edge(CLK) then
            p_Write_ADDR(0) <= s_fsm_Write_ADDR;
            for i in 0 to COLUMN_TOTAL - 1 loop
                p_WEB(0)(i) <= s_fsm_CSEL(i) and s_fsm_WE;
            end loop;
            for i in 1 to DELAY_DEPTH - 1 loop
                p_WEB(i)        <= p_WEB(i - 1); --The Write enable signal is pipelined for 2 + 7 cycles because the output of the DSP computation will have a total latency of 9 clk cycles. 2 for delayed deta input to DSP (A and B) 1 from scratchpad register and about 6 from DSP block.
                p_Write_ADDR(i) <= p_Write_ADDR(i - 1); --The Address for A port of the RAM is delayed for 2 + 7 clk cycles because the DSP takes about 6 clk cyles to finish its computation plus 1 clk delay from scratch pad and plus the data inputs which are delayed for 2 clk cyles.
                p_ADDRB(i)      <= p_ADDRB(i - 1);
            end loop;
            i_P_Write_ADDR <= p_Write_ADDR(DELAY_DEPTH - 1);
            i_WEB          <= p_WEB(DELAY_DEPTH - 1);

            p_OPCODE(0) <= s_fsm_OPCODE;

            for i in 1 to DIN_DELAY - 1 loop
                p_OPCODE(i) <= p_OPCODE(i - 1); --The opcode is also delayed for 2 clk cycles because it must be sent at the same time with the A and B input of the DSP.
            end loop;
            i_OPCODE <= p_OPCODE(DIN_DELAY - 1);

        --PLEASE NOTE: GRAM is delayed for 3 clk circles (2 clk circles for BRAM, 1 clk circle for FSM to settle down) to allow synchronization. This delay is implemented in GRAM itself (STANDARD_RAM.vhd)
        --However, In the real setup if the GRAM is not interfaced directly with the IP core e.g GRAM data is coming through a bus
        --Then a pipeline should be created here in this process to delay GRAM data for 3 clk circles so that it will be in synchronization with
        -- BRAM data. Also keep in mind that if this pipeline is implemented then it will affect the time it takes to load data into the IP core because both GRAM data and Data input
        -- use thesame input to the DSP48 block so as a result, the signal flags 'LOADING_DONE' and 'READY' located in the CONTROL_UNIT.vhd will have to be adjusted to accommodate the delay introduced by the pipeline.
        -- Adjusting these signals is easy. In "CONTROL_UNIT.vhd" There is a process called "FLAGS_and_Current_state_update", in this process you will notice that
        -- a counter is used to trigger when the flags should be set, simply adjust the count value in the conditional statements accordingly, that should do the trick.
        end if;
    end process;
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
            LOAD_PG                => LOAD_PG,
            UN_LOAD                => UN_LOAD,
            P                      => P,
            G                      => G,
            WE                     => s_fsm_WE,
            CSEL                   => s_fsm_CSEL,
            Read_ADDR              => s_fsm_Read_ADDR,
            Write_ADDR             => s_fsm_Write_ADDR,
            Read_SHFT              => s_fsm_Read_SHFT,
            Write_SHFT             => s_fsm_Write_SHFT,
            OPCODE                 => s_fsm_OPCODE,
            G_ROW                  => s_G_ROW,
            G_COLUMN               => s_G_COLUMN,
            G_WE                   => s_G_WE,
            G_EN                   => s_G_O_EN,
            OP_DONE                => OP_DONE,
            READY                  => READY,
            LOADING_DONE           => LOADING_DONE,
            UN_LOADING_DONE        => UN_LOADING_DONE,
            CONTROL_A_INPUT_OF_DSP => s_fsm_CONTROL_A_INPUT_OF_DSP
        );
    --------------------------------------------------------------

    GRAM : entity work.STANDARD_RAM
        generic map(
            COLUMN_TOTAL => COLUMN_TOTAL, -- num columns in ram
            ADDR_WIDTH   => ADDR_WIDTH, -- log2 of rows
            DATA_WIDTH   => DATA_WIDTH  --
        )
        Port map(CLK  => CLK,
                 ROW  => s_G_ROW,
                 COL  => s_G_COLUMN,
                 DIN  => DIN,
                 DOUT => s_GRAM_DOUT,
                 WE   => s_G_WE,
                 OE   => s_G_O_EN
        );

    --------------------------------------------------------------

    s_modified_fsm_Write_ADDR <= Bank_sel_in & i_P_Write_ADDR;
    s_modified_fsm_Read_ADDR <= not (Bank_sel_in) & s_fsm_Read_ADDR;
    s_MUl_Din <= DIN(DATA_WIDTH - 1 downto 0) when s_fsm_CONTROL_A_INPUT_OF_DSP = "00" else (0 => '1', others => '0') when s_fsm_CONTROL_A_INPUT_OF_DSP = "01" --set to 1 when FSM is in control. (B*A=B) when A = 1.
        else s_GRAM_DOUT;

    BLOCK_A_MEM_GEN : for i in 0 to COLUMN_TOTAL - 1 generate
        MEMA : entity work.BRAM_WRAPPER_V2
            generic map(
                COLUMN_NUMBER => i,
                NUM_COLUMNS   => COLUMN_TOTAL,
                ADDR_WIDTH    => ADDR_WIDTH,
                DATA_WIDTH    => DATA_WIDTH)
            PORT MAP(
                CLK        => CLK,
                Write_ADDR => s_modified_fsm_Write_ADDR, -- i_ADDR, -- Pipelined --
                DINA       => i_ALU2ALU(i)(DATA_WIDTH - 1 downto 0), --i_SPDOUT(i),
                Read_ADDR  => s_modified_fsm_Read_ADDR, -- ADDRB,-- multiplexed between FSM input and User input.
                DOUTB      => i_MEM2ALU(i),
                Read_SHFT  => s_fsm_Read_SHFT, --s_MUL_P_SHFT,--,s_i_ASHFT,
                Write_SHFT => s_fsm_Write_SHFT,
                WEA        => i_WEB(i),
                OEB        => s_fsm_CSEL(i)
            );
    end generate;
    --------------------------------------------------------------
    FIRST_DSP : component DSP_INPUT_C PORT MAP(
            clk => CLK,
            sel => i_OPCODE,
            a   => s_MUl_Din,           --DIN(17 downto 0),--i_DIN,
            b   => i_MEM2ALU(0),        --(17 downto 0),
            c   => i_ALU2ALU(COLUMN_TOTAL - 1),
            p   => i_ALU2ALU(0)
        );

    ---------------------------------------------------
    BLOCK_A_DSP_GEN : for i in 1 to COLUMN_TOTAL - 1 generate
        DSP : component DSP_INPUT_C PORT MAP(
                clk => CLK,
                sel => i_OPCODE,
                a   => s_MUl_Din,       --DIN(17 downto 0),--i_DIN,
                b   => i_MEM2ALU(i),    --(17 downto 0),
                c   => i_ALU2ALU(i - 1),
                p   => i_ALU2ALU(i)
            );
    end generate;

    DOUT <= i_ALU2ALU(COLUMN_TOTAL - 1)(DATA_WIDTH - 1 downto 0);
end Behavioral;
