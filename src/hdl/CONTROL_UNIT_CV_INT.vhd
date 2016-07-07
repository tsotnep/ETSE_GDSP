----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:35 03/02/2015 
-- Design Name: 
-- Module Name:    ADDR_GEN_FSM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MATRIX_MUL_IP_CORE_LIBRARY.all;

entity CONTROL_UNIT_CV_INT is
	generic(
		ADDR_WIDTH   : integer := 10;
		DATA_WIDTH	 :integer:=18;
		OPCODE_WIDTH : integer := 3;
		G_ROW_TOTAL : integer := 3);
	Port(CLK          : in  STD_LOGIC;
		 RST          : in  STD_LOGIC;
		 LOAD         : in  STD_LOGIC;
		 UN_LOAD	  : in STD_LOGIC;			
		 P            : in  STD_LOGIC;
		 WE           : out std_logic;
		 CSEL			:out std_logic_vector(G_ROW_TOTAL-1 downto 0);
		 Read_ADDR		: out STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
		 Write_ADDR		: out STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
		 Read_SHFT       : out STD_LOGIC;
		 --Write_SHFT		: out std_logic;		 
		 OPCODE       : out STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 downto 0);
		 G_ROW        : out STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
		 G_COLUMN     : out STD_LOGIC_VECTOR(G_ROW_TOTAL - 1 downto 0);
		 G_EN		: out STD_LOGIC;
		 READY		  : out std_logic;	
		 OP_DONE      : out std_logic;
		 LOADING_DONE : out std_logic;
		 UN_LOADING_DONE : out std_logic;
		 CONTROL_A_INPUT_OF_DSP: out std_logic);
end CONTROL_UNIT_CV_INT;

architecture Behavioral of CONTROL_UNIT_CV_INT is

constant PIPELINE_DELAY: integer:= 10;
	
signal i_addr_cnt,i_row_cnt,i_col_cnt: integer range 0 to G_ROW_TOTAL;
 signal s_CSEL: std_logic_vector(G_ROW_TOTAL-1 downto 0);

type state_type is (START,LOADING,LOAD_DONE,PG,PtG,DONE,UNLOAD);--,UNLOAD_DONE);
signal state: state_type;
--signal current_state,next_state: state_type;
--signal s_P_ADDR : STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
signal cnt_delay_ready: integer range 0 to (PIPELINE_DELAY + 1 + G_ROW_TOTAL*G_ROW_TOTAL);-- The counter should be able to count up to square of TOTAL_NUM_OF_COLUMNS + 1 +Pipeline delay


--dubug sigals
signal s_a, s_b: integer:=0;
--signal s_fsm_generate_address : boolean:=true;

begin




FLAGS_and_Current_state_update:process (CLK)
-- This Counter variable is used to create a delay for the appropriate time to set the READY signal.
-- The READY signal is used to alert the user to know when the FSM has setteled in the START state and is ready to start receiving input data
-- for storage in BRAM. The current value is set to 4 but it can be changed accordingly to allow enough time for the READY signal to trigger,
-- and user to Respond. Typically this value could be set to 3 instead of 4 to give the user 1 clock cycle to react. But for simulation
-- Purpose the value 4 is ok. 
	variable v_cnt_delay_ready: integer range 0 to ((PIPELINE_DELAY + 1)  + G_ROW_TOTAL*G_ROW_TOTAL);
begin
if rising_edge(CLK) then
		if(RST='1') then
			--state<=START;
			v_cnt_delay_ready := 0;
			READY <= '0';
			LOADING_DONE <= '0';
			UN_LOADING_DONE <= '0';
			OP_DONE <= '0';			
		else
			--state <= state;   --state change.
			if state = Loading then
				v_cnt_delay_ready := v_cnt_delay_ready + 1;
-- Note if DIN input to DSP block is delayed from GRAM (3 stage Pipeline) instead of using the 2 stage Pipeline in MEMARRY then this value should be 1 otherwise set it to 4.				
				if v_cnt_delay_ready >= 4 then
					READY <= '1';
				end if;
				
				if v_cnt_delay_ready = (PIPELINE_DELAY + 1 + G_ROW_TOTAL*G_ROW_TOTAL) then
					LOADING_DONE <= '1';
				end if;
				
			elsif state = UNLOAD then
				v_cnt_delay_ready := v_cnt_delay_ready + 1;
				if v_cnt_delay_ready >= PIPELINE_DELAY then
					READY <= '1';
				end if;
				
				if v_cnt_delay_ready >= (PIPELINE_DELAY + G_ROW_TOTAL*G_ROW_TOTAL) then
					UN_LOADING_DONE <= '1';
				end if;
			elsif state = PG or state = PtG then
				v_cnt_delay_ready := v_cnt_delay_ready + 1;
				if v_cnt_delay_ready >= (PIPELINE_DELAY + G_ROW_TOTAL) then
					OP_DONE <= '1';
				end if;			
			else
				READY <= '0';
				LOADING_DONE <= '0';
				UN_LOADING_DONE <= '0';
				OP_DONE <= '0';
				v_cnt_delay_ready := 0;
			end if;
		end if;
end if;
cnt_delay_ready <= v_cnt_delay_ready;
g_cnt_delay_ready <= v_cnt_delay_ready;--write to global variable
end process;
-----------------------------------------------------------
process(CLK)
variable i,j,v_load_count: integer range 0 to G_ROW_TOTAL;
variable v_CSEL : std_logic_vector(G_ROW_TOTAL-1 downto 0);
variable v_OPCODE: std_logic_vector(OPCODE_WIDTH-1 downto 0);
variable v_WE: std_logic;
variable v_LOADING_DONE, v_OP_DONE, v_UNLOAD_DONE: std_logic:='0';
variable v_i_addr_cnt: integer range 0 to G_ROW_TOTAL;

begin
if (rising_edge(CLK)) then
	if rst = '1' then
		state<=START;
		i_row_cnt<=0;
		i_col_cnt<=0;
		i_addr_cnt <= 1;
		G_EN <= '0';		
		v_OP_DONE := '0';--reset the done signal
		v_LOADING_DONE:='0';
		v_UNLOAD_DONE := '1';-- This is supposed to be set to '0' but it is ok because it is reset in the LOAD_DONE state. It was necessary to set it to '1' to prevent synthesis tool from optimizing it.
		CONTROL_A_INPUT_OF_DSP <= '0';
		i:=0;
		j:=0;
		Read_SHFT <='0';
		--Write_SHFT <= '0';
		WE <= '0';
		OPCODE <= (others => '0');
		s_CSEL <= (others => '0'); 
	else
			case state is
			
			when START =>
							
						IF LOAD = '1' then
							state<=LOADING;					
						ELSE
							state<=LOAD_DONE;
						END IF;
							-----------------------------------
				when LOADING =>
						OPCODE <="000";	-- Set DSP output to A input, the Data passes through DSP so we do not want to perform any operation on the data since we are just saving it on block RAM. (P = A)			
						if v_LOADING_DONE = '0' then					
							v_LOADING_DONE := '0';
							v_WE := '1';					
							if i = G_ROW_TOTAL then -- check if we have finished a mini-round of data loading (for a 3by3 matrix this will be when i=3)
								
								if i = G_ROW_TOTAL and j = G_ROW_TOTAL-1 then -- if loading is complete set LOADING_DONE signal.
									v_LOADING_DONE := '1';
									v_WE := '0';
									v_CSEL := (others => '0');
								else							
									v_LOADING_DONE := '0';							
									j:= j+1;
									i:= 1;
									v_CSEL :=(CSEL'length-1 =>'1', others => '0');
									if j < G_ROW_TOTAL - 1 then -- check if we are still a column less than the total number of columns							
										v_CSEL := to_stdlogicvector(to_bitvector(v_CSEL) srl (G_ROW_TOTAL - j - 1));	-- This line of code will maintain the offset of the circulant matrix whenever we start a new mini-round.										
									else       
										v_CSEL := (v_CSEL'length-1 => '1', others => '0');-- This is the defualt starting value for the last mini-round.										
									end if; 
								end if;					
							else
								i:= i + 1;						
								if i = 1 and j = 0 then -- Preset v_CEL to "0000.......1" This value is only used once when we enter this state.
									v_CSEL := (0 => '1', others => '0');
								else
									v_CSEL := v_CSEL(v_CSEL'length - 2 downto 0) & v_CSEL(v_CSEL'length - 1); --rol 1 (shift one place left with roll over).
								end if;
							end if;
						else
							if v_LOADING_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + G_ROW_TOTAL*G_ROW_TOTAL) then -- wait until gets to BRAM. 
								state <= LOAD_DONE;
							end if;
						end if;				
						i_addr_cnt <= j;
						s_CSEL <= v_CSEL;
						WE <= v_WE;				
				when LOAD_DONE =>
						i:=0;
						j:=0;
						WE <= '0';
						--Write_SHFT <= '1';
						v_UNLOAD_DONE := '0';							
						s_CSEL <= (others => '1');--Enble BRAM for Saving multiplication result.		
						IF LOAD = '1' then					
							state <= LOAD_DONE;	
						elsif UN_LOAD = '1' then
							state <= UNLOAD;	
						else
						G_EN <= '1'; -- Enable GRAM
							if (P='0') then						
								state<=PG;
								i_addr_cnt<=G_ROW_TOTAL-1;
								i_row_cnt<=1;
								i_col_cnt<=0;
								Read_SHFT <='1';							
								OPCODE<="001";						
							else						
								state<=PtG;
								Read_SHFT <='0';							
								i_addr_cnt<=1;
								i_row_cnt<=1;
								i_col_cnt<=0;
								OPCODE<="001";						
							end if;
						end if;
				when PG =>
							v_OPCODE :="011";
							WE <='0';					
							if v_OP_DONE = '0' then
								if (i_row_cnt=G_ROW_TOTAL-1) then				---G row
									i_row_cnt<=0;
								else
									i_row_cnt<=i_row_cnt+1;
								end if;
								if i_addr_cnt=0 then									--- P addr
									i_addr_cnt<=G_ROW_TOTAL-1;
								else
									i_addr_cnt<=i_addr_cnt-1;
								end if;
								if i= G_ROW_TOTAL-1 then 		-- full round
									v_OP_DONE :='1';
									v_OPCODE :="111";
									j:=j+1;
									i_col_cnt<=i_col_cnt+1;			-- next G column
									i_row_cnt <= 1 + j;	-- nwzr G Row
									
									if j = G_ROW_TOTAL then -- Check G Col
										i_col_cnt<=j-1;
									end if;
									if ((i_row_cnt+1)>=G_ROW_TOTAL-1) then		-- G row
										i_row_cnt<=0;
									end if;
									i_addr_cnt<=G_ROW_TOTAL-1-j;
									i:=0;
									v_OPCODE := "001";
								else
									i:=i+1;
									if i = G_ROW_TOTAL-1 then
										WE<='1';								
									end if;
										v_OPCODE := "011";-- make parameterizable latter.
								end if;
							else
								if v_OP_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + G_ROW_TOTAL) then -- wait until the results are saved in BRAM.--then
									state<=DONE;
									v_OPCODE := "111";
								end if;
							end if;
							OPCODE<= v_OPCODE; --"111";
					when PtG=>
							v_OPCODE :="011";
							WE <='0';					
							if v_OP_DONE = '0' then
								if (i_row_cnt=G_ROW_TOTAL-1) then				---G row
									i_row_cnt<=0;
								else
									i_row_cnt<=i_row_cnt+1;
								end if;
								if i_addr_cnt=G_ROW_TOTAL-1 then									--- P addr
									i_addr_cnt<=0;
								else
									i_addr_cnt<=i_addr_cnt+1;
								end if;
								if i= G_ROW_TOTAL-1 then 		-- full round 
									v_OP_DONE :='1';
									v_OPCODE :="111";
									j:=j+1;
									i_col_cnt<=i_col_cnt+1;			-- next G column
									i_row_cnt <= 1 + j;	-- G Row
									if j = G_ROW_TOTAL then -- Check G Col
										i_col_cnt<=j-1;
									end if;
									if ((i_row_cnt+1)>=G_ROW_TOTAL-1) then		-- G row
										i_row_cnt<=0;
									end if;
									if j=G_ROW_TOTAL-1 then									--- P addr
										i_addr_cnt<=0;
									else
										i_addr_cnt<=j+1;
									end if;
									i:=0;
									v_OPCODE := "001";
								else
									i:=i+1;
									if i = G_ROW_TOTAL-1 then
										WE<='1';								
									end if;
										v_OPCODE := "011";-- make parameterizable latter.
								end if;
							else
								if v_OP_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + G_ROW_TOTAL) then -- wait until results are saved in BRAM.--then
									state<=DONE;
									v_OPCODE := "111";
								end if;
							end if;
							OPCODE<= v_OPCODE; --"111";
					when DONE =>
							G_EN <= '0';
							WE<='0';
							Read_SHFT <= '0';					
							--OP_DONE<='0';
							v_OP_DONE := '0';
							v_UNLOAD_DONE := '0';	
							i:=0;
							j:=0;
							if UN_LOAD = '1' then
							 state <= UNLOAD;
							end if;
					when others =>
		--				if v_UNLOAD_DONE = '0' then
		--					CONTROL_A_INPUT_OF_DSP <= '1';
		--						if i = 0 then
		--							v_OPCODE := "101";-- P = B*A. Note A = 1 so P = B.
		--							i:=i+1;
		--							j:= j+1;
		--						else
		--							v_OPCODE := "110";-- P = C.							
		--							i:=i+1;
		--							if i > G_ROW_TOTAL  then
		--								i:=0;
		--								v_UNLOAD_DONE := '1';
		--								v_OP_DONE := '1';
		--								v_OPCODE := "111"; --Do nothing.							
		--							end if;						
		--						end if;				
		--				else
		--					CONTROL_A_INPUT_OF_DSP <= '0';
		--					v_OP_DONE := '0';
		--					v_OPCODE := "111";
		--					v_UNLOAD_DONE := '1';
		--				end if;
		--				OPCODE<= v_OPCODE;				
		--				i_addr_cnt <= j-1;
									
						if v_UNLOAD_DONE = '0' then
							CONTROL_A_INPUT_OF_DSP <= '1';
							if j > G_ROW_TOTAL then -- J = 0 initially.
								v_UNLOAD_DONE := '1';
								v_OP_DONE := '1';
								v_OPCODE := "111"; --Do nothing.
							else
								if i = 0 then
									v_OPCODE := "101";-- P = B*A. Note A = 1 so P = B.
									if j = G_ROW_TOTAL then
										v_OPCODE := "111";-- End of main loop. send null command.
									end if;							
									i:=i+1;
									j:= j+1;
								else
									v_OPCODE := "110";-- P = C.							
									i:=i+1;
									if i = G_ROW_TOTAL  then
										i:=0;								
									end if;						
								end if;						
							end if;					
						else
							CONTROL_A_INPUT_OF_DSP <= '0';
							v_OP_DONE := '0';
							v_OPCODE := "111";
							v_UNLOAD_DONE := '1';
						end if;
						OPCODE<= v_OPCODE;				
						i_addr_cnt <= j-1;											
			end case;
	end if;
end if;
end process;

--ADDRESS_GENERATION: Process(LOAD,i_addr_cnt, P)
--begin
--
--		Read_ADDR <= std_logic_vector(to_unsigned(i_addr_cnt,ADDR_WIDTH-1));
--		if P='1' and LOAD = '0'  then --if P='1' and G='1' then
--			if i_addr_cnt = 0 then		 -- When the Read address is 0 the Write address is also 0 (see table below).
--				Write_ADDR <= (others => '0');-- This line of Code Resets the Write address to 0. 
--			else
--				-- When Performing PtGt the last Read Address and the last Write address of each sub-round do not allign so the result in each sub-round does
--				-- not save in the desired location of Memory. But we want the result to save in circulant format. To solve this problem
--				-- we need to regenerate the Write address (ADDRA) from the Read Address (ADDRB) so that the proper Write Address will
--				-- be generated and the Result will be saved in circulant format. Note that the actual Write Address (ADDRA) used to save data in Memory is the Last address of a sub-round so
--				-- in other words the Write Address will be the last Address Read in a sub-round.
--				-- Refer to the Table below for an example. 
--				-- In the table below N represents the total number of columns. The Column contains the last address read from Memory.
--				-- The Write Column represent the generated address that will be used to Write the Result to Memory.
--				
--				-- |    N=3   | |    N=4   | |    N=5   |  
--				-- |__________| |__________| |__________|
--				-- |Write|Read| |Write|Read| |Write|Read|
--				-- |  0  |  0 | |  0  |  0 | |  0  |  0 |
--				-- |  2  |  1 | |  3  |  1 | |  4  |  1 |
--				-- |  1  |  2 | |  2  |  2 | |  3  |  2 |
--				--            | |  1  |  3 | |  2  |  3 |
--				--                           |  1  |  4 |
--							    
--			    Write_ADDR <= std_logic_vector(to_unsigned(G_ROW_TOTAL - i_addr_cnt, ADDR_WIDTH-1));--This line of code generates the Write address from the Read Address.
--			end if;
--		else
--			Write_ADDR <= std_logic_vector(to_unsigned(i_addr_cnt,ADDR_WIDTH-1));
--		end if;
--end process;
						

Write_ADDR <= std_logic_vector(to_unsigned(i_addr_cnt,ADDR_WIDTH-1));
Read_ADDR <= std_logic_vector(to_unsigned(i_addr_cnt,ADDR_WIDTH-1));
				
G_ROW<=std_logic_vector(to_unsigned(i_row_cnt,ADDR_WIDTH));
G_COLUMN<=std_logic_vector(to_unsigned(i_col_cnt,G_ROW_TOTAL));
CSEL <= s_CSEL;



							
-----------------------------------------------------------
end Behavioral;

