library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

entity GRAM_ADDRESS_GENERATOR is
    generic(
        COLUMN_TOTAL : integer := 4;
        ADDR_WIDTH   : integer := 10
    );
    port(
        G_COL_ADDR_out           : out std_logic_vector(ADDR_WIDTH - 1 downto 0);
        G_ROW_ADDR_out           : out std_logic_vector(ADDR_WIDTH - 1 downto 0);

        --when reading from AXI
        RDEN_internal            : in  std_logic;

        --when copying from P to G
        UN_LOAD                  : in  std_logic;
        READY_internal           : in  std_logic;
        LOAD_PG                  : in  STD_LOGIC_VECTOR(1 downto 0);
        UN_LOADING_DONE_internal : in  std_logic;

        clk                      : in  std_logic;
        rst                      : in  std_logic
    );
end entity GRAM_ADDRESS_GENERATOR;
architecture RTL of GRAM_ADDRESS_GENERATOR is
    signal G_COL_ADDR, G_ROW_ADDR : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal READY_internal_i, READY_internal_ii        : std_logic; --introduce 1 clock cycle delay, to write on G(0,0);
begin
    G_COL_ADDR_out <= G_COL_ADDR;
    G_ROW_ADDR_out <= G_ROW_ADDR;
    GaddressGenerator : process(clk, RST) is
    begin
        if rst = '1' then
            G_COL_ADDR <= (others => '0');
            G_ROW_ADDR <= (others => '0');
        elsif rising_edge(clk) then
            --P to G
            READY_internal_i <= READY_internal;
            READY_internal_ii <= READY_internal_i;
            if UN_LOAD = '1' and READY_internal = '1' and LOAD_PG = OPERATE_CMD and UN_LOADING_DONE_internal = '0' then
                --P to G addressing
                if unsigned(G_ROW_ADDR) < COLUMN_TOTAL - 1 then
                    G_ROW_ADDR <= STD_LOGIC_VECTOR(unsigned(G_ROW_ADDR) + 1);
                else
                    G_ROW_ADDR <= (others => '0');
                    if unsigned(G_COL_ADDR) < COLUMN_TOTAL - 1 then
                        G_COL_ADDR <= STD_LOGIC_VECTOR(unsigned(G_COL_ADDR) + 1);
                    else
                        G_COL_ADDR <= (others => '0');
                    end if;
                end if;

            elsif LOAD_PG = IDLE_CMD then
                --G to AXI addressing
                if RDEN_internal = '1' then
                    if unsigned(G_COL_ADDR) < COLUMN_TOTAL - 1 then
                        G_COL_ADDR <= STD_LOGIC_VECTOR(unsigned(G_COL_ADDR) + 1);
                    else
                        G_COL_ADDR <= (others => '0');
                        if unsigned(G_ROW_ADDR) < COLUMN_TOTAL - 1 then
                            G_ROW_ADDR <= STD_LOGIC_VECTOR(unsigned(G_ROW_ADDR) + 1);
                        else
                            G_ROW_ADDR <= (others => '0');
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process GaddressGenerator;

end architecture RTL;
