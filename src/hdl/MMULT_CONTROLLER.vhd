library IEEE;                           ---
use IEEE.STD_LOGIC_1164.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

USE ieee.numeric_std.ALL;

entity MMULT_CONTROLLER is
    generic(C_SLV_DWIDTH : integer := 32;
            COLUMN_TOTAL : integer := 2
    );
    Port(CLK                    : in  STD_LOGIC; --connected to axi clock
         cntlr_RST_in           : in  STD_LOGIC; --connected to axi reset
         cntlr_save_G_values_in : in  STD_LOGIC; --slv_reg29
         cntlr_save_P_values_in : in  STD_LOGIC; --slv_reg30
         cntlr_send_result_in   : in  STD_LOGIC; --slv_reg31

         LOAD_PG_in             : in  STD_LOGIC_VECTOR(1 downto 0); --slv_reg20
         UN_LOAD_in             : in  STD_LOGIC; --slv_reg21
         P_in                   : in  STD_LOGIC; --slv_reg22
         G_in                   : in  STD_LOGIC; --slv_reg23
         Bank_sel_in            : in  STD_LOGIC; --slv_reg24

         slv_reg0               : in  std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg1               : in  std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg2               : in  std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg3               : in  std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg4               : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg5               : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg6               : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg7               : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg8               : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg9               : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg10              : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg11              : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg12              : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg13              : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg14              : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg15              : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg16              : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);

         READY_out              : out std_logic; --slv_reg25
         OP_DONE_out            : out std_logic; --slv_reg26
         LOADING_DONE_out       : out std_logic; --slv_reg27
         UN_LOADING_DONE_out    : out std_logic --slv_reg28
    );
end MMULT_CONTROLLER;

architecture Behavioral of MMULT_CONTROLLER is
    type t_BRAM_DATA_integer is array (0 to COLUMN_TOTAL * COLUMN_TOTAL - 1) of integer;
    type t_BRAM_DATA_integer_big is array (0 to COLUMN_TOTAL * COLUMN_TOTAL * 3 - 1) of integer;
    type mmult_cntrl_state is (
        cntrl_RESET_MMULT, cntrl_IDLE,
        cntrl_WAIT_RESET, cntrl_WAIT_P_delay, cntrl_WAIT_G_delay, cntrl_WAIT_UNLOAD,
        cntrl_SAVE_G_P,
        cntrl_LOAD_G, cntrl_LOAD_P,
        cntrl_CALCULTE, cntrl_UNLOAD, cntrl_WRITE_RESULTS
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
    signal cntlr_input_arr_G              : t_BRAM_DATA_integer := (0, 0, 0, 0);
    signal cntlr_input_arr_P              : t_BRAM_DATA_integer := (0, 0, 0, 0);
    signal cntlr_output_arr_R             : t_BRAM_DATA_integer := (others => 0);

    signal cntrl_G_array_index            : integer             := 0;
    signal cntrl_P_array_index            : integer             := 0;
    signal cntrl_R_array_index            : integer             := 0;

    signal cntrl_P_saved                  : std_logic;
    signal cntrl_G_saved                  : std_logic;
    signal cntrl_G_loaded                 : std_logic;
    signal cntrl_P_loaded                 : std_logic;
    signal cntrl_G_loading                : std_logic;
    signal cntrl_P_loading                : std_logic;

    signal cntrl_state                    : mmult_cntrl_state;

    signal cntrl_reset_length_count       : integer             := 0;
    signal cntrl_P_loading_predelay_count : integer             := 0;
    signal cntrl_G_loading_predelay_count : integer             := 0;

    constant cntrl_P_loading_predelay     : integer             := 4;
    constant cntrl_G_loading_predelay     : integer             := 0;
    constant cntrl_reset_length           : integer             := 2;

--controller signals
    signal cntlr_save_G_values_in_old : std_logic;
    signal cntlr_save_P_values_in_old : std_logic;

begin
    cntrl_FSM : process(clk) is
    begin
        if rising_edge(clk) then
            cntlr_save_G_values_in_old <= cntlr_save_G_values_in;
            cntlr_save_P_values_in_old <= cntlr_save_P_values_in;
            
            if cntlr_RST_in = '1' then
                cntrl_state              <= cntrl_RESET_MMULT;

                cntrl_reset_length_count <= 0;
                cntrl_P_loading_predelay_count <= 0;
                cntrl_G_loading_predelay_count <= 0;

                cntrl_G_array_index <= 0;
                cntrl_P_array_index <= 0;
                cntrl_R_array_index <= 0;

                cntlr_input_arr_G        <= (others => 0);
                cntlr_input_arr_P        <= (others => 0);
                cntlr_output_arr_R        <= (others => 0);



                cntrl_P_saved        <= '0';
                cntrl_G_saved        <= '0';
                cntrl_G_loaded       <= '0';
                cntrl_P_loaded       <= '0';
                cntrl_G_loading      <= '0';
                cntrl_P_loading      <= '0';





            else
                case cntrl_state is

                    when cntrl_RESET_MMULT =>
                        --reset MMULT
                        Bank_sel    <= '0';
                        rst         <= '1';
                        LOAD_PG     <= (others => '1');
                        UN_LOAD     <= '0';
                        P           <= '0';
                        G           <= '0';
                        Bank_sel    <= '0';
                        DIN         <= (others => '0');
                        --reset MMULT
                        cntrl_state <= cntrl_SAVE_G_P;


                    when cntrl_SAVE_G_P =>
                        if cntrl_P_saved = '1' and cntrl_G_saved = '1' and cntlr_send_result_in = '1' then
                            cntrl_state <= cntrl_WAIT_RESET;
                        end if;
--                        if cntlr_save_P_values_in = '1' then
                            if cntlr_save_P_values_in_old = '0' and cntlr_save_P_values_in = '1' then
--                         if rising_edge(cntlr_save_P_values_in) then
                            cntlr_input_arr_P(0) <= to_integer(unsigned(slv_reg0));
                            cntlr_input_arr_P(1) <= to_integer(unsigned(slv_reg1));
                            cntlr_input_arr_P(2) <= to_integer(unsigned(slv_reg2));
                            cntlr_input_arr_P(3) <= to_integer(unsigned(slv_reg3));
                            cntrl_P_saved        <= '1';
                        end if;
--                        if cntlr_save_G_values_in = '1' then
                            if cntlr_save_G_values_in_old = '0' and cntlr_save_G_values_in = '1' then
--                         if rising_edge(cntlr_save_G_values_in) then
                            cntlr_input_arr_G(0) <= to_integer(unsigned(slv_reg0));
                            cntlr_input_arr_G(1) <= to_integer(unsigned(slv_reg1));
                            cntlr_input_arr_G(2) <= to_integer(unsigned(slv_reg2));
                            cntlr_input_arr_G(3) <= to_integer(unsigned(slv_reg3));
                            cntrl_G_saved        <= '1';
                        end if;

                    when cntrl_WAIT_RESET =>
                        --wait until the IP is resetted, 2 clock cycles
                        rst     <= '0';
                        LOAD_PG <= (others => '1');
                        cntrl_P_saved <= '0';
                        cntrl_G_saved <= '0';
                        if cntrl_reset_length_count < cntrl_reset_length - 1 then
                            cntrl_reset_length_count <= cntrl_reset_length_count + 1;
                        else
                            cntrl_state <= cntrl_WAIT_G_delay;
                        end if;


                    when cntrl_WAIT_G_delay =>
                        DIN     <= (others => '0');
                        LOAD_PG <= LOAD_G_CMD;
                        if cntrl_G_loading_predelay_count <= cntrl_G_loading_predelay then
                            cntrl_G_loading_predelay_count <= cntrl_G_loading_predelay_count + 1;
                        else
                            cntrl_state <= cntrl_LOAD_G;
                        end if;




                    when cntrl_LOAD_G =>
                        DIN     <= (others => '0');
                        LOAD_PG <= LOAD_G_CMD;
                        if cntrl_G_array_index <= COLUMN_TOTAL * COLUMN_TOTAL - 1 then
                            DIN                 <= std_logic_vector(to_unsigned(cntlr_input_arr_G(cntrl_G_array_index), DATA_WIDTH));
                            cntrl_G_array_index <= cntrl_G_array_index + 1;
                        else
                            if LOADING_DONE = '1' then
                                --                                    cntrl_state <= cntrl_LOAD_P;cntrl_WAIT_P_delay
                                cntrl_state <= cntrl_WAIT_P_delay;
                            end if;
                        end if;


                    when cntrl_WAIT_P_delay =>
                        DIN     <= (others => '0');
                        LOAD_PG <= LOAD_P_CMD;
                        if cntrl_P_loading_predelay_count <= cntrl_P_loading_predelay then
                            cntrl_P_loading_predelay_count <= cntrl_P_loading_predelay_count + 1;
                        else
                            cntrl_state <= cntrl_LOAD_P;
                        end if;



                    when cntrl_LOAD_P =>
                        if cntrl_P_array_index <= COLUMN_TOTAL * COLUMN_TOTAL - 1 then
                            DIN                 <= std_logic_vector(to_unsigned(cntlr_input_arr_P(cntrl_P_array_index), DATA_WIDTH));
                            cntrl_P_array_index <= cntrl_P_array_index + 1;
                        else
                            if LOADING_DONE = '1' then
                                cntrl_state <= cntrl_IDLE;
                            end if;
                        end if;


                    when cntrl_IDLE =>
--                        rst <= '0';
--                        if LOAD_PG_in = "11" then  
                            --TODO: here, LOAD_PG_in should be set(from user perspective) before it comes here, because it should not wait
                            cntrl_state <= cntrl_WAIT_UNLOAD;
                            LOAD_PG     <= "11";
                            Bank_sel    <= '1';
                            UN_LOAD     <= '1';
--                        end if;


                    when cntrl_WAIT_UNLOAD =>
                        if loading_done = '1' then
                            cntrl_state <= cntrl_UNLOAD;
                        end if;



                    when cntrl_UNLOAD =>
                        if READY = '1' then
                            if cntrl_R_array_index <= COLUMN_TOTAL * COLUMN_TOTAL - 1 then
                                cntlr_output_arr_R(cntrl_R_array_index) <= to_integer(unsigned(DOUT));
                                cntrl_R_array_index                     <= cntrl_R_array_index + 1;
                            else
                                cntrl_state <= cntrl_WRITE_RESULTS;
                            end if;
                        end if;


                    when cntrl_WRITE_RESULTS =>
                        slv_reg4 <= std_logic_vector(to_unsigned(cntlr_output_arr_R(0), C_SLV_DWIDTH));
                        slv_reg5 <= std_logic_vector(to_unsigned(cntlr_output_arr_R(1), C_SLV_DWIDTH));
                        slv_reg6 <= std_logic_vector(to_unsigned(cntlr_output_arr_R(2), C_SLV_DWIDTH));
                        slv_reg7 <= std_logic_vector(to_unsigned(cntlr_output_arr_R(3), C_SLV_DWIDTH));
                        cntrl_state <= cntrl_RESET_MMULT;

                    when cntrl_CALCULTE =>
                        null;

                end case;

            end if;
        end if;
    end process cntrl_FSM;



    MATRIX_MUL_IP_CORE_S_INT_G_inst : entity work.MATRIX_MUL_IP_CORE_S_INT_G
        generic map(
            COLUMN_TOTAL    => COLUMN_TOTAL,
            OPCODE_WIDTH    => 3,
            ADDR_WIDTH      => 10,
            DATA_WIDTH      => 18,
            DATA_WIDE_WIDTH => 48
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
