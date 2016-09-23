library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

entity GRAM_ADDRESS_GENERATOR is
    generic(
        COLUMN_TOTAL : integer := 3;
        ADDR_WIDTH   : integer := 10
    );
    port(
        G_COL_ADDR_out      : out std_logic_vector(ADDR_WIDTH - 1 downto 0);
        G_ROW_ADDR_out      : out std_logic_vector(ADDR_WIDTH - 1 downto 0);

        --when reading from AXI Stream
        AXIS_READ_ENABLE    : in  std_logic;

        --when copying from P to G
        P_to_G_Write_Enable : in  std_logic;

        clk                 : in  std_logic;
        rst                 : in  std_logic
    );
end entity GRAM_ADDRESS_GENERATOR;
architecture RTL of GRAM_ADDRESS_GENERATOR is
    signal G_COL_ADDR, G_ROW_ADDR : std_logic_vector(ADDR_WIDTH - 1 downto 0);
begin

    G_COL_ADDR_out <= G_COL_ADDR;
    G_ROW_ADDR_out <= (std_logic_vector(to_unsigned(COLUMN_TOTAL - 1 - to_integer(unsigned(G_ROW_ADDR)),ADDR_WIDTH))) when P_to_G_Write_Enable = '1' else G_ROW_ADDR;
    GaddressGenerator : process(clk, RST) is
    begin
        if rst = '1' then
            G_COL_ADDR <= (others => '0');
            G_ROW_ADDR <= (others => '0');
        elsif rising_edge(clk) then
            --P to G
            if P_to_G_Write_Enable = '1' then
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
            --G to AXI addressing
            elsif AXIS_READ_ENABLE = '1' then
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
    end process GaddressGenerator;

end architecture RTL;
