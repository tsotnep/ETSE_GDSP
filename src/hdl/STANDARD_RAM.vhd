----------------------------------------------------------------------------------
-- Company:
-- Engineer: Taras Iakymchuk
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity STANDARD_RAM is
generic(
		COLUMN_TOTAL: integer:=3;		-- num columns in ram
      ADDR_WIDTH: integer:=10;		-- log2 of rows
      DATA_WIDTH:integer:=18			--
   );
    Port ( CLK : in  STD_LOGIC;
           ROW_in : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           COL_in : in  STD_LOGIC_VECTOR  (ADDR_WIDTH-1 downto 0);--(COLUMN_TOTAL-1 downto 0);
           DIN_in : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DOUT_out : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           WE_in : in  STD_LOGIC;
           OE_in : in  STD_LOGIC);
end STANDARD_RAM;


architecture Behavioral of STANDARD_RAM is
--type column is array (0 to 2**ADDR_WIDTH) of std_logic_vector (DATA_WIDTH-1 downto 0);
type column is array (0 to COLUMN_TOTAL-1) of std_logic_vector (DATA_WIDTH-1 downto 0);
type ram is array (0 to COLUMN_TOTAL-1) of column;
signal datamem: ram;
signal i_DOUT,ii_DOUT:std_logic_vector (DATA_WIDTH-1 downto 0);

--for simulation
signal i_DIN,ii_DIN:std_logic_vector (DATA_WIDTH-1 downto 0);
signal i_ROW, ii_ROW, i_COL, ii_COL : STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
signal i_WE, ii_WE : std_logic;
begin
process(CLK)-- (CLK,DIN,COL,ROW)
begin
if rising_edge(CLK) then
--    for simulation
--    i_COL <= COL;
--    ii_COL <= i_COL;
--    i_ROW <= ROW;
--    ii_ROW <= i_ROW;
--    i_WE <= WE;
--    ii_WE <= i_WE;
--    if (ii_WE='1') then
--        datamem (to_integer(unsigned(ii_COL)))(to_integer(unsigned(ii_ROW)))<=DIN;
--    end if;
    
-- for synthesis
	if (WE_in='1') then
		datamem (to_integer(unsigned(COL_in)))(to_integer(unsigned(ROW_in)))<=DIN_in;
	end if;
	if (OE_in='1') then
--			i_DOUT<=datamem (to_integer(unsigned(COL)))(to_integer(unsigned(ROW)));
		i_DOUT<=datamem (to_integer(unsigned(ROW_in)))(to_integer(unsigned(COL_in)));
	else
			i_DOUT<=(others=>'0');
	end if;
	DOUT_out<=i_DOUT;
	ii_DOUT <= i_DOUT;
	DOUT_out <= ii_DOUT;--3 clk_cycle pipeline.
end if;
end process;

--DOUT<=i_DOUT;
end Behavioral;
--
--
--
--TTT
