----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Taras Iakymchuk
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity STANDARD_RAM_1_DIM is
generic(
		G_ROW_TOTAL: integer:=3;		-- num columns in ram
      ADDR_WIDTH: integer:=10;		-- log2 of rows
      DATA_WIDTH:integer:=18			--
   );
    Port ( CLK : in  STD_LOGIC;
           ROW : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
--           COL : in  STD_LOGIC_VECTOR (COLUMN_TOTAL-1 downto 0);
           DIN : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           WE : in  STD_LOGIC;
           OE : in  STD_LOGIC);
end STANDARD_RAM_1_DIM;
 

architecture Behavioral of STANDARD_RAM_1_DIM is

--type column is array (0 to G_ROW_TOTAL-1) of std_logic_vector (DATA_WIDTH-1 downto 0);
--type ram is array (0 to G_ROW_TOTAL-1) of column;

type ram is array (0 to G_ROW_TOTAL-1) of std_logic_vector (DATA_WIDTH-1 downto 0);

signal datamem: ram;
signal i_DOUT,ii_DOUT:std_logic_vector (DATA_WIDTH-1 downto 0); 
begin
process (CLK)
begin
if rising_edge(CLK) then
	if (WE='1') then
		datamem (to_integer(unsigned(ROW)))<=DIN;
	end if; 
	if (OE='1') then
--			i_DOUT<=datamem (to_integer(unsigned(COL)))(to_integer(unsigned(ROW)));
		i_DOUT<=datamem (to_integer(unsigned(ROW)));
	else
			i_DOUT<=(others=>'0');
	end if;
	DOUT<=i_DOUT;
	ii_DOUT <= i_DOUT;
	DOUT <= ii_DOUT;--3 clk_cycle pipeline.
end if;
end process;

--DOUT<=i_DOUT;
end Behavioral;

