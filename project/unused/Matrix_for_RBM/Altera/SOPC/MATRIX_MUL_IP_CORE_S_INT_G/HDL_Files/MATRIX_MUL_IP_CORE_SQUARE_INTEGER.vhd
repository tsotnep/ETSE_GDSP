library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

USE work.MATRIX_MUL_IP_CORE_LIBRARY.all;

entity MATRIX_MUL_IP_CORE_SQUARE_INTEGER is
--generic( 
--		AVALON_DATA_WIDTH: natural:=32; 
--		NUM_OF_8_BIT_REGISTERS : natural:=16;
--		WRITE_DATA_CAPTURE_CYCLE: natural:=1; -- number of cycles before write data is saved in register
--		--ADDR_WIDTH: natural:=32;
--		COLUMN_TOTAL    : integer := 26;
--		OPCODE_WIDTH    : integer := 3;
--		ADDR_WIDTH      : integer := 7;
--		DATA_WIDTH      : integer := 18;
--		DATA_WIDE_WIDTH : integer := 48
--);
---------------General Signals--------------
port(	clock_50 		: in std_logic;
	KEY			: in std_logic_vector(0 downto 0);
	LEDR			: out std_logic_vector(7 downto 0);
	LEDG			: out std_logic_vector(7 downto 0)--;
--	HEX0			: out std_logic_vector(0 to 6);
--	HEX1			: out std_logic_vector(0 to 6)
-----------------------------------------------	

);
end entity;


Architecture Behav of MATRIX_MUL_IP_CORE_SQUARE_INTEGER is

    component system_configuration is
        port (
            clk_clk            : in  std_logic                    := 'X'; -- clk
            resetn_reset_n     : in  std_logic                    := 'X'; -- reset_n
            ledr_status_export : out std_logic_vector(7 downto 0);        -- export
            ledg_config_export : out std_logic_vector(7 downto 0)--;        -- export
				--to_hex_export      : out std_logic_vector(5 downto 0)   
        );
    end component system_configuration;
	 
--	 COMPONENT hex7seg IS
--	PORT ( hex : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
--		display : OUT STD_LOGIC_VECTOR(0 TO 6)
--		);
--		END COMPONENT hex7seg;
	 
--	 signal s_HEX0, s_HEX1 : std_logic_vector(3 downto 0);
--	 signal s_to_HEX: std_logic_vector(5 downto 0);
	 
Begin
    
	 
--	 s_HEX0 <= std_logic_vector(to_unsigned(to_integer(unsigned(s_to_HEX)) mod 10,4));
--	 
--	 s_HEX1 <= std_logic_vector(to_unsigned(to_integer(unsigned(s_to_HEX)) / 10,4));
	 
	 u0 : component system_configuration
        port map (
            clk_clk            => clock_50,            --         clk.clk
            resetn_reset_n     => KEY(0),     --      resetn.reset_n
            ledr_status_export => LEDR, -- ledr_status.export
            ledg_config_export => LEDG  -- ledg_config.export
				 --to_hex_export =>  s_to_HEX
        );
		  
--		h0: hex7seg PORT MAP (s_HEX0, HEX0);
--		h1: hex7seg PORT MAP (s_HEX1, HEX1);



End Behav;