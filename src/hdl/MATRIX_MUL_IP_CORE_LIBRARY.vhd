library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.txt_util.all;
use ieee.numeric_std.all;

package MATRIX_MUL_IP_CORE_LIBRARY is

--------------------------------CONSTANTS GENERICS--------------------------------------------------
CONSTANT COLUMN_TOTAL   : integer:=3;
CONSTANT DATA_WIDTH     : integer:=18;
-- CONSTANT ADDR_WIDTH      : integer:=10;
-- CONSTANT DATA_WIDE_WIDTH: integer:=48;
-- CONSTANT OPCODE_WIDTH    : integer:=3;
-----------------------------END OF GENERIC CONSTANTS-------------------------------------------------

---------------------------------------CONSTANT SIGNALS-----------------------------------------------

-------------------------------These are use in CONTROL_UNIT_S_G.vhd and TB_MATRIX_MUL_IP_CORE-----------------------------------
-- constant LOAD_P_CMD: std_logic_vector(1 downto 0):="01";
-- constant LOAD_G_CMD: std_logic_vector(1 downto 0):="00";
-------------------------------------END OF CONSTANT SIGNALS------------------------------------------

-------------------------------CUSTOM TYPES------------------------------------------------
-- type t_BRAM_DATA is array (0 to COLUMN_TOTAL-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
-- signal v_BRAM_DATA : t_BRAM_DATA;
-----------------------------END OF CUSTOM TYPES-------------------------------------------

-------------------------------GLOBAL SIGNALS----------------------------------------------
    type t_BRAM_DATA is array (0 to COLUMN_TOTAL - 1) of std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal BRAM_DATA : t_BRAM_DATA;

    --------------PACKAGEDECLARATION OPERATE_CMD
    constant LOAD_P_CMD  : std_logic_vector(1 downto 0) := "01";
    constant LOAD_G_CMD  : std_logic_vector(1 downto 0) := "00";
    constant IDLE_CMD    : std_logic_vector(1 downto 0) := "10";
    constant OPERATE_CMD : std_logic_vector(1 downto 0) := "11";

    signal g_cnt_delay_ready: integer:=0;
--signal g_DSP_P_OUT: std_logic_vector(47 downto 0);
--------------------------------END OF GLOBAL SIGNALS--------------------------------------


end package MATRIX_MUL_IP_CORE_LIBRARY;

package body MATRIX_MUL_IP_CORE_LIBRARY is

end package body MATRIX_MUL_IP_CORE_LIBRARY;
