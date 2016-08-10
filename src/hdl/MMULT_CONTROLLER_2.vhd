library IEEE;                           ---
use IEEE.STD_LOGIC_1164.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

USE ieee.numeric_std.ALL;

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

        RDATA        : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --connected to slv_reg1
        RMATRIX_ADDR : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0) --will be used later, COL and ROW addr, slv_reg2

    --TODO: add forth register as input for COL ROW address
    );
end MMULT_CONTROLLER_2;

architecture Behavioral of MMULT_CONTROLLER_2 is
    constant N_of_EL            : integer          := COLUMN_TOTAL * COLUMN_TOTAL;
    constant DOUT_SLV_REG1_ADRR : std_logic_vector := std_logic_vector(to_unsigned(1, OPT_MEM_ADDR_BITS + 1));

    constant cmd_RESET_CNTRL       : std_logic_vector := "1111";
    constant cmd_SAVE_G            : std_logic_vector := "0001";
    constant cmd_SAVE_P            : std_logic_vector := "0010";
    constant cmd_LOAD_IN_MMULT     : std_logic_vector := "0011";
    constant cmd_take_next_command : std_logic_vector := "0100";
    constant cmd_UNLOAD            : std_logic_vector := "0101";
    constant cmd_CALCULTE_PG       : std_logic_vector := "0110";

    type t_BRAM_DATA_integer is array (0 to N_of_EL - 1) of integer;

    type mmult_state is (
        cntrl_RESET_MMULT, cntrl_READ_NEXT_CMD,
        cntrl_WAIT_RESET, cntrl_WAIT_P_delay, cntrl_WAIT_G_delay, cntrl_WAIT_UNLOAD,
        cntrl_SAVE_G_P,
        cntrl_LOAD_G, cntrl_LOAD_P,
        cntrl_CALCULTE, cntrl_UNLOAD, cntrl_WRITE_RESULTS,
        cntrl_FINISHED
    );

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

    signal cntrl_P_saved   : std_logic;
    signal cntrl_G_saved   : std_logic;
    signal cntrl_G_loaded  : std_logic;
    signal cntrl_P_loaded  : std_logic;
    signal cntrl_G_loading : std_logic;
    signal cntrl_P_loading : std_logic;

    signal state : mmult_state;

    signal cntrl_reset_length_count       : integer := 0;
    signal cntrl_P_loading_predelay_count : integer := 0;
    signal cntrl_G_loading_predelay_count : integer := 0;

    constant cntrl_P_loading_predelay : integer := 4;
    constant cntrl_G_loading_predelay : integer := 0;
    constant cntrl_reset_length       : integer := 2;

    --slv_reg1_out bits: 32 used, 0 unused
    alias datain is WDATA(DATA_WIDTH - 1 downto 0); --18 bits
    alias cmdin is WDATA(DATA_WIDTH + CMD_SIZE - 1 downto DATA_WIDTH); --4 bits
    alias cmdin2 is WDATA(DATA_WIDTH + CMD_SIZE * 2 - 1 downto DATA_WIDTH + CMD_SIZE); --4 bits spared for future.
    alias cmdin3 is WDATA(C_S_AXI_DATA_WIDTH - 1 downto DATA_WIDTH + CMD_SIZE * 2); --6 bits spared for future.
    signal cmd_next_command : std_logic_vector(CMD_SIZE - 1 downto 0);

begin
    RMATRIX_ADDR <= (others => '0');

    readNextCommand : process(clk) is
    begin
        if rising_edge(clk) then
            if WREN = '1' and cmdin = cmd_take_next_command then
                --TODO: next_cmd_command can be removed
                cmd_next_command <= cmdin2;
            end if;
        end if;
    end process readNextCommand;

    cntrl_FSM : process(clk) is
    begin
        if rising_edge(clk) then
            if WREN = '1' and cmdin = cmd_RESET_CNTRL then
                state <= cntrl_RESET_MMULT;

                cntrl_reset_length_count       <= 0;
                cntrl_P_loading_predelay_count <= 0;
                cntrl_G_loading_predelay_count <= 0;

                cntrl_G_array_index <= 0;
                cntrl_P_array_index <= 0;
                cntrl_R_array_index <= 0;

                cntlr_input_arr_G  <= (others => 0);
                cntlr_input_arr_P  <= (others => 0);
                cntlr_output_arr_R <= (others => 0);

                cntrl_P_saved   <= '0';
                cntrl_G_saved   <= '0';
                cntrl_G_loaded  <= '0';
                cntrl_P_loaded  <= '0';
                cntrl_G_loading <= '0';
                cntrl_P_loading <= '0';
            else
                case state is
                    when cntrl_RESET_MMULT =>
                        Bank_sel <= '0';
                        rst      <= '1'; --resetting IP
                        LOAD_PG  <= (others => '1');
                        UN_LOAD  <= '0';
                        P        <= '0';
                        G        <= '0';
                        Bank_sel <= '0';
                        DIN      <= (others => '0');
                        state    <= cntrl_SAVE_G_P;

                    when cntrl_SAVE_G_P =>
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

                        if WREN = '1' and cmdin = cmd_LOAD_IN_MMULT then
                            state <= cntrl_WAIT_RESET;
                        end if;

                    when cntrl_WAIT_RESET =>
                        --wait until the IP finishs resetting, 2 clock cycles
                        rst           <= '0';
                        LOAD_PG       <= (others => '1');
                        cntrl_P_saved <= '0';
                        cntrl_G_saved <= '0';
                        if cntrl_reset_length_count < cntrl_reset_length - 1 then
                            cntrl_reset_length_count <= cntrl_reset_length_count + 1;
                        else
                            state <= cntrl_WAIT_G_delay;
                        end if;

                    when cntrl_WAIT_G_delay =>
                        DIN     <= (others => '0');
                        LOAD_PG <= LOAD_G_CMD;
                        if cntrl_G_loading_predelay_count <= cntrl_G_loading_predelay then
                            cntrl_G_loading_predelay_count <= cntrl_G_loading_predelay_count + 1;
                        else
                            state <= cntrl_LOAD_G;
                        end if;

                    when cntrl_LOAD_G =>
                        DIN     <= (others => '0');
                        LOAD_PG <= LOAD_G_CMD;
                        if cntrl_G_array_index <= COLUMN_TOTAL * COLUMN_TOTAL - 1 then
                            DIN                 <= std_logic_vector(to_unsigned(cntlr_input_arr_G(cntrl_G_array_index), DATA_WIDTH));
                            cntrl_G_array_index <= cntrl_G_array_index + 1;
                        else
                            if LOADING_DONE = '1' then
                                state <= cntrl_WAIT_P_delay;
                            end if;
                        end if;

                    when cntrl_WAIT_P_delay =>
                        DIN     <= (others => '0');
                        LOAD_PG <= LOAD_P_CMD;
                        if cntrl_P_loading_predelay_count <= cntrl_P_loading_predelay then
                            cntrl_P_loading_predelay_count <= cntrl_P_loading_predelay_count + 1;
                        else
                            state <= cntrl_LOAD_P;
                        end if;

                    when cntrl_LOAD_P =>
                        if cntrl_P_array_index <= COLUMN_TOTAL * COLUMN_TOTAL - 1 then
                            DIN                 <= std_logic_vector(to_unsigned(cntlr_input_arr_P(cntrl_P_array_index), DATA_WIDTH));
                            cntrl_P_array_index <= cntrl_P_array_index + 1;
                        else
                            if LOADING_DONE = '1' then
                                state <= cntrl_READ_NEXT_CMD;
                            end if;
                        end if;

                    when cntrl_READ_NEXT_CMD =>
                        if cmd_next_command = cmd_unload then
                            state    <= cntrl_WAIT_UNLOAD;
                            LOAD_PG  <= "11";
                            Bank_sel <= '1';
                            UN_LOAD  <= '1';
                        else
                            state    <= cntrl_WAIT_UNLOAD; --TODO: tell to go in calculation state instead
                            LOAD_PG  <= "11";
                            Bank_sel <= '1';
                            UN_LOAD  <= '1';
                        end if;

                    when cntrl_WAIT_UNLOAD =>
                        if loading_done = '1' then
                            state <= cntrl_UNLOAD;
                        end if;

                    when cntrl_UNLOAD =>
                        if READY = '1' then
                            if cntrl_R_array_index <= N_of_EL - 1 then
                                cntlr_output_arr_R(cntrl_R_array_index) <= to_integer(unsigned(DOUT));
                                cntrl_R_array_index                     <= cntrl_R_array_index + 1;
                            else
                                state               <= cntrl_WRITE_RESULTS;
                                cntrl_R_array_index <= 0;
                            end if;
                        end if;

                    when cntrl_WRITE_RESULTS =>
                        if RDEN = '1' and RDADDR = DOUT_SLV_REG1_ADRR then
                            cntrl_R_array_index <= cntrl_R_array_index + 1;
                        end if;
                        if cntrl_R_array_index >= N_of_EL then
                            state <= cntrl_FINISHED;
                        end if;

                    when cntrl_CALCULTE =>
                        null;
                    when cntrl_FINISHED =>
                        null;
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
