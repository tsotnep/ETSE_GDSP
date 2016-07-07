----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Taras Iakymchuk
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GRAM_WRAPPER is
generic(
		--COLUMN_TOTAL: integer:=3;		-- num columns in ram
      ADDR_WIDTH: integer:=10;		-- log2 of rows
      DATA_WIDTH:integer:=18			--
   );
    Port ( CLK : in  STD_LOGIC;
           ROW : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           COL : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           DIN : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           WE : in  STD_LOGIC;
           OE : in  STD_LOGIC);
end GRAM_WRAPPER;
 

architecture Behavioral of GRAM_WRAPPER is
--type column is array (0 to 2**ADDR_WIDTH) of std_logic_vector (DATA_WIDTH-1 downto 0);
--type column is array (0 to COLUMN_TOTAL-1) of std_logic_vector (DATA_WIDTH-1 downto 0);
--type ram is array (0 to COLUMN_TOTAL-1) of column;
--signal datamem: ram;

signal i_DOUT,ii_DOUT:std_logic_vector (DATA_WIDTH-1 downto 0);
signal s_read_address, s_write_address: std_logic_vector(9 downto 0);

begin

s_read_address <= ROW(4 downto 0) & COL(4 downto 0);
s_write_address <= COL(4 downto 0) & ROW(4 downto 0);

process(CLK)
begin
	if rising_edge(CLK) then
		
		if (OE='1') then
			ii_DOUT<= i_DOUT;
		else
			ii_DOUT<=(others=>'0');
		end if;
		DOUT <= ii_DOUT;--3 clk_cycle pipeline.
	end if;
end process;



G_RAM_WRAPPER: ENTITY work.GRAM
	PORT map
	(
		clock	=> CLK,
		data	=> DIN,
		rdaddress => s_read_address,
		rden=> OE,
		wraddress => s_write_address,
		wren => WE,
		q	=> i_DOUT
	);

end Behavioral;

