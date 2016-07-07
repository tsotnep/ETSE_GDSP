library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use std.textio.all;
use work.txt_util.all;

USE work.MATRIX_MUL_IP_CORE_LIBRARY.all;

entity tb_AvalonInterfaceController is
	generic ( 
		AVALON_DATA_WIDTH: natural:=32; 
		NUM_OF_8_BIT_REGISTERS : natural:=16; 
		--ADDR_WIDTH: natural:=32;
		COLUMN_TOTAL    : integer :=4;
		OPCODE_WIDTH    : integer := 3;
		ADDR_WIDTH      : integer := 7;--10;
		DATA_WIDTH      : integer := 18;
		DATA_WIDE_WIDTH : integer := 48
);
end entity;


Architecture Behav of tb_AvalonInterfaceController is
constant CLK_period : time:= 10 ns;	

constant addr_r_config: std_logic_vector(1 downto 0):="00";

constant addr_r_status: std_logic_vector(1 downto 0):="01";

constant addr_r_DIN: std_logic_vector(1 downto 0):="10";

constant addr_r_DOUT: std_logic_vector(1 downto 0):="11";



signal s_write: std_logic:='0';
signal rst,clk: std_logic:='0';
signal s_writedata : std_logic_vector(AVALON_DATA_WIDTH-1 downto 0);
signal s_waitrequest: std_logic;
signal s_read: std_logic:='0';
signal s_readdatavalid: std_logic:='0';
signal s_readdata: std_logic_vector(AVALON_DATA_WIDTH-1 downto 0);
signal s_to_Bus_WrAck : std_logic;
signal s_to_IP_wrCE: std_logic:='0';
signal s_from_IP_WrAck: std_logic:='0';
signal s_DOUT : std_logic_vector(DATA_WIDTH-1 downto 0);
signal s_cmd	: std_logic_vector(7 downto 0);
signal s_status : rt_Status;
signal s_address : std_logic_vector(1 downto 0);


type t_BRAM_DATA is array (0 to COLUMN_TOTAL-1) of std_logic_vector(AVALON_DATA_WIDTH-1 downto 0);
signal BRAM_DATA : t_BRAM_DATA;
signal s_response : std_logic;
signal s_byteenable : std_logic_vector((AVALON_DATA_WIDTH/8)-1 downto 0);
signal s_chip_select : std_logic;

Begin


uut:entity work.AvalonInterfaceController
generic map(
		AVALON_DATA_WIDTH => AVALON_DATA_WIDTH, 
		NUM_OF_8_BIT_REGISTERS => NUM_OF_8_BIT_REGISTERS, 
		--ADDR_WIDTH => ADDR_WIDTH,
		COLUMN_TOTAL => COLUMN_TOTAL,
		OPCODE_WIDTH => OPCODE_WIDTH,
		ADDR_WIDTH => ADDR_WIDTH,
		DATA_WIDTH => DATA_WIDTH,
		DATA_WIDE_WIDTH => DATA_WIDE_WIDTH
)
port map(
	---------------General Signals--------------
	clk 		=> clk,
	rst			=> rst,
	--cmd			=> s_cmd,
	status		=> s_status,

	
	--------To Avalon Interconnect-----------------
	waitrequest	=> s_waitrequest,
	--to_Bus_WrAck	=> s_to_Bus_WrAck,
	readdatavalid => s_readdatavalid,
	--response	=> s_response,
	
	read 		=> s_read,
	write		=> s_write,
	readdata	=> s_readdata,
	writedata	=> s_writedata,
	address		=> s_address,	
	-----------------------------------------------	
	byteenable => s_byteenable,
	chip_select => s_chip_select
	

);



CLK_process :process
begin
	CLK <= '0';
	wait for CLK_period/2;
	CLK <= '1';
	wait for CLK_period/2;
end process;




stim: process
variable i,j,g,cnt: integer:=0;
file Result_file_pointer: text;
variable line_num: line;

Begin

s_byteenable <= (others => '1');
s_chip_select <= '1';	
	
--wait until s_status.READY = '1';
--cmd_Bank_sel_in	<= r_config(3);
--cmd_P 	<= r_config(4);
--cmd_G	<= r_config(5);
	
cnt := 1;	
rst <= RESET_ACTIVE_LOGIC;
wait for clk_period;
rst <= RESET_NOT_ACTIVE_LOGIC;
wait for clk_period/2;


s_address <= addr_r_config;
s_writedata <= std_logic_vector(to_unsigned(0,32));
s_write <= '1';
wait for clk_period;

s_write <= '0';
wait for clk_period;

s_write <= '1';
s_writedata <= std_logic_vector(to_unsigned(1,32));--LOAD_G
wait until s_status.BUSY = '0'; 

s_write <= '0';
wait for clk_period;

s_address <= addr_r_DIN; -- data in address;
wait for clk_period;

	for i in 1 to COLUMN_TOTAL loop
		for j in 1 to COLUMN_TOTAL loop			
			
			s_writedata <= "00" & X"000" & std_logic_vector(to_signed(cnt,DATA_WIDTH));
			s_write <= '1';
			wait for clk_period;--remove this later to see the effect		
			wait until s_waitrequest = '0';
			wait for clk_period;--live write asserted for 1 extra clk cycle.
			s_write <= '0';-- reset write.
			wait for clk_period;
			cnt := cnt + 1;
		end loop;
	end loop;


wait until s_status.LOADING_DONE = '1';
cnt := 1; -- reset back to 1.	

s_write <= '1';
s_address <= addr_r_config;
s_writedata <= std_logic_vector(to_unsigned(0,32));

wait until s_status.READY = '1';
s_write <= '0';
wait for clk_period;

s_write <= '1';
s_writedata <= std_logic_vector(to_unsigned(2,32));--LOAD_P
wait until s_status.BUSY = '0';

s_write <= '0';
wait for clk_period;

s_address <= addr_r_DIN;--set address to r_DIN register.
wait for clk_period;

for i in 1 to COLUMN_TOTAL loop
		for j in 1 to COLUMN_TOTAL loop			
			s_writedata <= "00" & X"000" & std_logic_vector(to_signed(cnt,DATA_WIDTH));
			s_write <= '1';
			wait for clk_period;--remove this later to see the effect		
			wait until s_waitrequest = '0';
			wait for clk_period;--live write asserted for 1 extra clk cycle.
			s_write <= '0';-- reset write.
			wait for clk_period;
			cnt := cnt + 1;
		end loop;
	end loop;

wait until s_status.LOADING_DONE = '1';



--s_cmd <= std_logic_vector(to_unsigned(0,8));
--wait for clk_period*2;
--
--s_cmd <= std_logic_vector(to_unsigned(12,8)); --UN_LOAD_P
--wait until s_status.OP_DONE = '1';

s_write <= '1';
s_address <= addr_r_config;
s_writedata <= std_logic_vector(to_unsigned(0,32));
wait for clk_period*2;
s_write <= '0';
wait for clk_period;


s_write <= '1';
s_writedata <= std_logic_vector(to_unsigned(12,32)); --P_G
wait until s_status.OP_DONE = '1';
s_write <= '0';
wait for clk_period;

	
cnt := 1; -- reset back to 1.
s_write <= '1';
s_address <= addr_r_config;
s_writedata <= std_logic_vector(to_unsigned(0,32));
wait for clk_period*2;

s_write <= '0';
wait for clk_period;

s_write <= '1';
s_writedata <= std_logic_vector(to_unsigned(11,32)); --UN_LOAD_P
wait for clk_period*3;--wait until s_status.READY = '1';
s_write <= '0';
wait for clk_period;

s_address <= addr_r_DOUT;
wait for clk_period;

for i in 1 to COLUMN_TOTAL loop
		for j in 1 to COLUMN_TOTAL loop			
			
			s_read <= '1';
			wait for clk_period;--remove this later to see the effect		
			--wait until s_waitrequest = '0';
			wait until s_readdatavalid = '1';
			wait for clk_period*2;
			s_read <= '0';
			BRAM_DATA(g) <= s_readdata;
			wait for clk_period;--live read de-asserted for 1 extra clk cycle.
			
--			write(line_num,str(to_integer(unsigned(BRAM_DATA(g)))),LEFT,10);
--			writeline(output, line_num);	
			
			g := g + 1;
			if g = COLUMN_TOTAL then
					for k in 0 to COLUMN_TOTAL-1 loop
						write(line_num,str(to_integer(unsigned(BRAM_DATA(COLUMN_TOTAL-1-k)))),LEFT,10);						
					end loop;
					writeline(output, line_num);
					--writeline(Result_file_pointer,line_num);					
					g:=0;
			end if;
			
		end loop;
	end loop;

wait;
end process;

end Behav;