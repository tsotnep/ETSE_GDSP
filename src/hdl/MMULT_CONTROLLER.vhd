library IEEE;                           ---
use IEEE.STD_LOGIC_1164.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

USE ieee.numeric_std.ALL;

entity mmult_controller is
    generic(C_SLV_DWIDTH : integer := 32;
            COLUMN_TOTAL : integer := 2
    );
    Port(CLK              : in  STD_LOGIC; --connected to axi clock
         RST              : in  STD_LOGIC; --connected to axi reset

         LOAD_PG          : in  STD_LOGIC_VECTOR(1 downto 0); --slv_reg20
         UN_LOAD          : in  STD_LOGIC; --slv_reg21
         P                : in  STD_LOGIC; --slv_reg22
         G                : in  STD_LOGIC; --slv_reg23
         Bank_sel_in      : in  STD_LOGIC; --slv_reg24

         save_G_values    : in  STD_LOGIC; --slv_reg29
         save_P_values    : in  STD_LOGIC; --slv_reg30
         clear_P_G_arrays : in  STD_LOGIC; --slv_reg30

         slv_reg0         : in  std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg1         : in  std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg2         : in  std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg3         : in  std_logic_vector(C_SLV_DWIDTH - 1 downto 0);

         slv_reg4         : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg5         : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg6         : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg7         : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg8         : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg9         : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg10        : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg11        : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg12        : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg13        : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg14        : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
         slv_reg15        : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);

         slv_reg16        : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);

         READY_out            : out std_logic; --slv_reg25
         OP_DONE_out          : out std_logic; --slv_reg26
         LOADING_DONE_out     : out std_logic; --slv_reg27
         UN_LOADING_DONE_out  : out std_logic --slv_reg28
    );
end mmult_controller;

architecture Behavioral of mmult_controller is
    type t_BRAM_DATA_integer is array (0 to COLUMN_TOTAL * COLUMN_TOTAL - 1) of integer;
    signal input_arr_G : t_BRAM_DATA_integer := (0, 0, 0, 0);
    signal input_arr_P : t_BRAM_DATA_integer := (0, 0, 0, 0);

    type t_BRAM_DATA_integer_big is array (0 to COLUMN_TOTAL * COLUMN_TOTAL * 3 - 1) of integer;
    signal input_arr_R : t_BRAM_DATA_integer_big := (others => 0);

    type mmult_state is (LOAD_G_P, calculate);
    signal state : mmult_state;
    signal flag_wait_2_clk           : std_logic;
    signal flag_wait_2_clk_delayed_1 : std_logic;
    signal flag_wait_2_clk_delayed_2 : std_logic;
    signal dataDIN, DIN              : std_logic_vector(DATA_WIDTH - 1 downto 0);

    signal Bank_sel_in_ip : std_logic;
    signal start_loading_P : std_logic;
    signal LOADING_DONE : std_logic;
    signal UN_LOADING_DONE : std_logic;

    signal i : integer := 0;

begin
    --    IP : entity work.MATRIX_MUL_IP_CORE_S_INT_G
    --        generic map(
    --            COLUMN_TOTAL    => COLUMN_TOTAL,
    --            OPCODE_WIDTH    => OPCODE_WIDTH,
    --            ADDR_WIDTH      => ADDR_WIDTH,
    --            DATA_WIDTH      => DATA_WIDTH,
    --            DATA_WIDE_WIDTH => DATA_WIDE_WIDTH
    --        )
    --        Port map(
    --            CLK             => CLK,
    --            RST             => RST,
    --            LOAD_PG         => LOAD_PG,
    --            UN_LOAD         => cmd_UN_LOAD,
    --            P               => cmd_P,
    --            G               => cmd_G,
    --            Bank_sel_in     => Bank_sel_in,
    --            DIN             => DIN,
    --            DOUT            => DOUT,
    --            READY           => f_ip_READY,
    --            OP_DONE         => f_ip_OP_DONE,
    --            LOADING_DONE    => f_ip_LOADING_DONE,
    --            UN_LOADING_DONE => f_ip_UN_LOADING_DONE
    --        );

    saving_values : process(clk) is
    begin
        if rising_edge(clk) then
            if clear_P_G_arrays = '1' then
                input_arr_G <= (others => 0);
                input_arr_P <= (others => 0);
            else
                if save_P_values = '1' then
                    input_arr_P(0) <= to_integer(unsigned(slv_reg0));
                    input_arr_P(1) <= to_integer(unsigned(slv_reg1));
                    input_arr_P(2) <= to_integer(unsigned(slv_reg2));
                    input_arr_P(3) <= to_integer(unsigned(slv_reg3));
                elsif save_G_values = '1' then
                    input_arr_G(0) <= to_integer(unsigned(slv_reg0));
                    input_arr_G(1) <= to_integer(unsigned(slv_reg1));
                    input_arr_G(2) <= to_integer(unsigned(slv_reg2));
                    input_arr_G(3) <= to_integer(unsigned(slv_reg3));
                end if;
            end if;
        end if;
    end process saving_values;

    providing_values : process(clk) is
    begin
        if rising_edge(clk) then
            flag_wait_2_clk <= '0';
            dataDIN         <= (others => '0');

            if rst = '1' then
                flag_wait_2_clk           <= '1';
                Bank_sel_in_ip            <= '0';
                i                         <= 0;
                flag_wait_2_clk_delayed_1 <= '0';
                flag_wait_2_clk_delayed_2 <= '0';
            else
                flag_wait_2_clk_delayed_1 <= flag_wait_2_clk or flag_wait_2_clk_delayed_1;

                if flag_wait_2_clk_delayed_1 = '1' then
                    DIN     <= dataDIN;
                    dataDIN <= std_logic_vector(to_unsigned(input_arr_G(i), DATA_WIDTH));
                    if i < COLUMN_TOTAL * COLUMN_TOTAL -1 then
                        i <= i + 1;
                    end if;
                    if LOADING_DONE = '1'then
                        start_loading_P <= '1';
                    end if;
                end if;

            end if;
        end if;
    end process providing_values;

end Behavioral;
