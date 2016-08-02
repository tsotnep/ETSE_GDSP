library IEEE;                           ---
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_MMULT_CONROLLER is
    generic(C_SLV_DWIDTH : integer := 32;
            COLUMN_TOTAL : integer := 2
    );
end entity TB_MMULT_CONROLLER;

architecture RTL of TB_MMULT_CONROLLER is
    constant period : time := 10 ns;
    signal clk      : std_logic;
    signal cntlr_RST_in   : std_logic;

    signal LOAD_PG_in  : STD_LOGIC_VECTOR(1 downto 0); --slv_reg20
    signal UN_LOAD_in  : STD_LOGIC;     --slv_reg21
    signal P_in        : STD_LOGIC;     --slv_reg22
    signal G_in        : STD_LOGIC;     --slv_reg23
    signal Bank_sel_in : STD_LOGIC;     --slv_reg24

    signal cntlr_save_G_values_in    : STD_LOGIC; --slv_reg29
    signal cntlr_save_P_values_in    : STD_LOGIC; --slv_reg30
    signal clear_P_G_arrays_in : STD_LOGIC; --slv_reg30

    signal slv_reg0 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg1 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg2 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg3 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);

    signal slv_reg4  : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg5  : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg6  : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg7  : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg8  : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg9  : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg10 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg11 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg12 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg13 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg14 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
    signal slv_reg15 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);

    signal slv_reg16 : std_logic_vector(C_SLV_DWIDTH - 1 downto 0);

    signal READY_out           : std_logic; --slv_reg25
    signal OP_DONE_out         : std_logic; --slv_reg26
    signal LOADING_DONE_out    : std_logic; --slv_reg27
    signal UN_LOADING_DONE_out : std_logic; --slv_reg28


begin
    clock_driver : process
    begin
        clk <= '0';
        wait for period / 2;
        clk <= '1';
        wait for period / 2;
    end process clock_driver;

MMULT_CONTROLLER_inst : entity work.MMULT_CONTROLLER
    generic map(
        C_SLV_DWIDTH => C_SLV_DWIDTH,
        COLUMN_TOTAL => COLUMN_TOTAL
    )
    port map(
        CLK                    => CLK,
        cntlr_RST_in           => cntlr_RST_in,
        cntlr_save_G_values_in => cntlr_save_G_values_in,
        cntlr_save_P_values_in => cntlr_save_P_values_in,
        LOAD_PG_in             => LOAD_PG_in,
        UN_LOAD_in             => UN_LOAD_in,
        P_in                   => P_in,
        G_in                   => G_in,
        Bank_sel_in            => Bank_sel_in,
        slv_reg0               => slv_reg0,
        slv_reg1               => slv_reg1,
        slv_reg2               => slv_reg2,
        slv_reg3               => slv_reg3,
        slv_reg4               => slv_reg4,
        slv_reg5               => slv_reg5,
        slv_reg6               => slv_reg6,
        slv_reg7               => slv_reg7,
        slv_reg8               => slv_reg8,
        slv_reg9               => slv_reg9,
        slv_reg10              => slv_reg10,
        slv_reg11              => slv_reg11,
        slv_reg12              => slv_reg12,
        slv_reg13              => slv_reg13,
        slv_reg14              => slv_reg14,
        slv_reg15              => slv_reg15,
        slv_reg16              => slv_reg16,
        READY_out              => READY_out,
        OP_DONE_out            => OP_DONE_out,
        LOADING_DONE_out       => LOADING_DONE_out,
        UN_LOADING_DONE_out    => UN_LOADING_DONE_out
    );
    stimul : process is
    begin
        slv_reg0         <= (others => '0');
        slv_reg1         <= (others => '0');
        slv_reg2         <= (others => '0');
        slv_reg3         <= (others => '0');
        cntlr_save_G_values_in <= '0';
        cntlr_save_P_values_in <= '0';
        cntlr_RST_in <= '1';
        cntlr_RST_in <= '0' after period;
        wait for period * 4;

        slv_reg0 <= std_logic_vector(to_unsigned(1, C_SLV_DWIDTH));
        slv_reg1 <= std_logic_vector(to_unsigned(2, C_SLV_DWIDTH));
        slv_reg2 <= std_logic_vector(to_unsigned(3, C_SLV_DWIDTH));
        slv_reg3 <= std_logic_vector(to_unsigned(4, C_SLV_DWIDTH));
        cntlr_save_G_values_in <= '1';
        cntlr_save_G_values_in <= '0' after period;
        wait for period;

        slv_reg0 <= std_logic_vector(to_unsigned(5, C_SLV_DWIDTH));
        slv_reg1 <= std_logic_vector(to_unsigned(6, C_SLV_DWIDTH));
        slv_reg2 <= std_logic_vector(to_unsigned(7, C_SLV_DWIDTH));
        slv_reg3 <= std_logic_vector(to_unsigned(8, C_SLV_DWIDTH));
        cntlr_save_P_values_in <= '1';
        cntlr_save_P_values_in <= '0' after period;
        wait for period;
        

        wait;

    end process stimul;

end architecture RTL;
