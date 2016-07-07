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
           ROW : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           COL : in  STD_LOGIC_VECTOR  (ADDR_WIDTH-1 downto 0);--(COLUMN_TOTAL-1 downto 0);
           DIN : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           WE : in  STD_LOGIC;
           OE : in  STD_LOGIC);
end STANDARD_RAM;
 

architecture Behavioral of STANDARD_RAM is
--type column is array (0 to 2**ADDR_WIDTH) of std_logic_vector (DATA_WIDTH-1 downto 0);
type column is array (0 to COLUMN_TOTAL-1) of std_logic_vector (DATA_WIDTH-1 downto 0);
type ram is array (0 to COLUMN_TOTAL-1) of column;
signal datamem: ram;
signal i_DOUT,ii_DOUT:std_logic_vector (DATA_WIDTH-1 downto 0); 
begin
process(CLK)-- (CLK,DIN,COL,ROW)
begin
if rising_edge(CLK) then
	if (WE='1') then
		datamem (to_integer(unsigned(COL)))(to_integer(unsigned(ROW)))<=DIN;
	end if; 
	if (OE='1') then
--			i_DOUT<=datamem (to_integer(unsigned(COL)))(to_integer(unsigned(ROW)));
		i_DOUT<=datamem (to_integer(unsigned(ROW)))(to_integer(unsigned(COL)));
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

