----------------------------------------------------------------------------------
-- Company: GPDS ETSE UV
-- Engineer: Taras Iakymchuk
-- 
-- Create Date:    17:12:37 02/18/2015 
-- Design Name: 	 matrix multiplier V2
-- Module Name:    BRAM_WRAPPER - Behavioral 
-- Wrapper for Circulant access to a matrix column
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BRAM_WRAPPER_V2 is
 generic(
		COLUMN_NUMBER: integer:=3;	-- The number of given column, ordinal
		NUM_COLUMNS: integer:=9;   -- total number of columns
      ADDR_WIDTH: integer:=10;   -- bitwidth of addr input, MUST match addr_width is syntesized bram
      DATA_WIDTH:integer:=18		-- bitwidth of data input, MUST match data_width is syntesized bram
		);
    Port ( CLK : in  STD_LOGIC;
           Write_ADDR : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);	-- in both addresses, highest bit defines the memory bank
           DINA : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);	-- mem is divided into upper and lower halfs
			Read_ADDR : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);	-- thus normal addressing is in 0..2^ADDR_WIDTH-2
           DOUTB : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- circulant access is only for half-mem
			  Read_SHFT: in STD_logic;
		   Write_SHFT: in std_logic;
           WEA : in  STD_LOGIC);
           --OEB : in  STD_LOGIC);
end BRAM_WRAPPER_V2;

architecture Behavioral of BRAM_WRAPPER_V2 is
COMPONENT BRAM18x1k
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
    clkb : IN STD_LOGIC;
    rstb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0)
  );
END COMPONENT;

----------------------------------------------------------------
--signal i_rst,i_OE: std_logic;
signal i_wea: std_logic;--signal i_wea: std_logic_vector(0 downto 0);
signal i_write_addr, i_Read_addr:STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
signal i_dina: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
begin
process (CLK)-- (CLK,P,G)
variable addr_a_reg,addr_b_reg: integer range 0 to 2**ADDR_WIDTH;
begin
	if rising_edge(CLK) then 		
			if Write_SHFT ='0'  then 											
				addr_a_reg:=to_integer(unsigned(Write_ADDR(ADDR_WIDTH-2 downto 0))); 
			else 
				if (unsigned(unsigned(Write_ADDR(ADDR_WIDTH-2 downto 0))+COLUMN_NUMBER)>NUM_COLUMNS-1) then
					addr_a_reg:=to_integer(unsigned(unsigned(Write_ADDR(ADDR_WIDTH-2 downto 0))+COLUMN_NUMBER-NUM_COLUMNS)); 
				else
					addr_a_reg:=to_integer(unsigned(unsigned(Write_ADDR(ADDR_WIDTH-2 downto 0))+COLUMN_NUMBER)); 
				end if;
			end if;
		
		
		if Read_SHFT = '0' then		
			addr_b_reg:=to_integer(unsigned(Read_ADDR(ADDR_WIDTH-2 downto 0)));   -- upper bit - bank sel
		else
			if (unsigned(unsigned(Read_ADDR(ADDR_WIDTH-2 downto 0))+COLUMN_NUMBER)>NUM_COLUMNS-1) then				
				addr_b_reg:=to_integer(unsigned(unsigned(Read_ADDR(ADDR_WIDTH-2 downto 0))+COLUMN_NUMBER-NUM_COLUMNS)); 
			else
				addr_b_reg:=to_integer(unsigned(unsigned(Read_ADDR(ADDR_WIDTH-2 downto 0))+COLUMN_NUMBER)); 
			end if;
		end if;
		
	  i_wea <= WEA; --- for compatibility with columnwise write--i_wea(0)<=WEA; --- for compatibility with columnwise write
	  --i_RST<= not OEB;
	  --i_OE<=OEB;
	  i_dina<=DINA;
	  i_write_addr<=Write_ADDR(ADDR_WIDTH-1) & std_logic_vector(to_unsigned(addr_a_reg,ADDR_WIDTH-1));	-- add top bit
	  i_Read_addr<=Read_ADDR(ADDR_WIDTH-1) & std_logic_vector(to_unsigned(addr_b_reg,ADDR_WIDTH-1));  -- add top bit
	end if;
end process;

BMG_PORT: entity work.BRAM18 PORT MAP ( 
      --Port A
      wren        => i_wea,
      wraddress   => i_write_addr,--wraddress   => i_write_addr(6 downto 0),
      data        => i_dina,
      clock       => CLK,
      --Port B
      rdaddress   => i_Read_addr,--rdaddress   => i_Read_addr(6 downto 0),
      q  => DOUTB
     
    );	 
	 


end Behavioral;

