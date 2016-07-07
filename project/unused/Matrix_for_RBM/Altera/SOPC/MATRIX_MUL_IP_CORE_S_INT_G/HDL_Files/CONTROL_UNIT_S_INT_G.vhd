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

entity CONTROL_UNIT_S_INT_G is
	generic(
		BURST_ACCESS : boolean :=false;
		ADDR_WIDTH   : integer := 10;
		DATA_WIDTH	 :integer:=18;
		OPCODE_WIDTH : integer := 3;
		COLUMN_TOTAL : integer := 3);
	Port(CLK          : in  STD_LOGIC;
		 RST          : in  STD_LOGIC;
		 --------------------------------------------------
		 SingleWrCE		: in STD_LOGIC;
		 SingleWrAck	: out STD_LOGIC;
		 SingleRdCE 	: in STD_LOGIC;
		 SingleRdAck	: out STD_LOGIC;
		 WrEn_R_DOUT	: out STD_LOGIC;
--		 SingleRdValid : out STD_LOGIC;
		 
		 --------------------------------------------------
		 LOAD_PG         : in  STD_LOGIC_VECTOR(1 downto 0);
		 --LOAD_G			: in STD_LOGIC;
		 UN_LOAD	  : in STD_LOGIC;			
		 P            : in  STD_LOGIC;
		 G            : in  STD_LOGIC;
		 WE           : out std_logic;		 
		 CSEL			:out std_logic_vector(COLUMN_TOTAL-1 downto 0);
		 Read_ADDR		: out STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
		 Write_ADDR		: out STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
		 Read_SHFT       : out STD_LOGIC;
		 Write_SHFT		: out std_logic;		 
		 OPCODE       : out STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 downto 0);
		 G_ROW        : out STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
		 G_COLUMN     : out STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);--(COLUMN_TOTAL - 1 downto 0);
		 G_WE		: out std_logic;
		 G_EN		: out STD_LOGIC;
		 READY		  : out std_logic;	
		 OP_DONE      : out std_logic;
		 LOADING_DONE : out std_logic;
		 UN_LOADING_DONE : out std_logic;
		 CONTROL_A_INPUT_OF_DSP: out std_logic_vector(1 downto 0));
end CONTROL_UNIT_S_INT_G;

architecture Behavioral of CONTROL_UNIT_S_INT_G is

constant PIPELINE_DELAY: integer:= 10;
	
signal i_addr_cnt,i_row_cnt,i_col_cnt: integer range 0 to COLUMN_TOTAL;
 signal s_CSEL: std_logic_vector(COLUMN_TOTAL-1 downto 0);

type state_type is (START,LOAD_G,LOAD_P,LOAD_DONE,PG,PtG,PGt,PtGt,DONE,UNLOAD);--,UNLOAD_DONE);
signal State: state_type;
--signal next_state: state_type;
--signal s_P_ADDR : STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
signal cnt_delay_ready: integer range 0 to ((PIPELINE_DELAY + 1)  + COLUMN_TOTAL*COLUMN_TOTAL);--(PIPELINE_DELAY + 1 + COLUMN_TOTAL*COLUMN_TOTAL);-- The counter should be able to count up to square of TOTAL_NUM_OF_COLUMNS + 1 +Pipeline delay
signal s_counter_mini_round: integer range 0 to COLUMN_TOTAL+1;
signal s_counter_WrEn: integer range 0 to COLUMN_TOTAL + 1;
signal s_f_start_v_counter_WrEn: boolean:=false;
signal s_write_ack_count: integer range 0 to (COLUMN_TOTAL*COLUMN_TOTAL);

signal s_read_request_came: boolean:=false;


signal s_flag_WrData_Complete, s_flag_RdData_Complete : boolean;

--dubug sigals
signal s_a, s_b: integer:=0;
--signal s_fsm_generate_address : boolean:=true;
signal s_READY : std_logic;
signal s_READY2: std_logic;
--signal s_AXI_IP2Bus_RdAck : std_logic;
signal s_LOADING_DONE: std_logic;
--signal s_UN_LOADING_DONE : std_logic;
--signal s_Wr_Ack : std_logic;
--signal s_flag_WrData_Complete : boolean;

begin

READY <= s_READY2;--s_READY;
--G_WE <= s_G_WE;
--WE <= s_WE;
LOADING_DONE <= s_LOADING_DONE;
--UN_LOADING_DONE <= s_UN_LOADING_DONE;





FLAGS_and_Current_state_update:process (CLK)

	variable v_cnt_delay_ready: integer range 0 to ((PIPELINE_DELAY + 1)  + COLUMN_TOTAL*COLUMN_TOTAL);
	variable v_write_ack_count: integer range 0 to (COLUMN_TOTAL * COLUMN_TOTAL);
	variable v_f_start_pipe_line_delay_counter : boolean:=false;
	variable v_counter_mini_round: integer range 0 to COLUMN_TOTAL+1:=0;
	variable v_counter_WrEn: integer range 0 to COLUMN_TOTAL + 1:=0;
	variable v_read_request_came: boolean:=false;
	variable v_f_start_v_counter_WrEn: boolean:= false;
begin
if rising_edge(CLK) then
	if(RST=RESET_ACTIVE_LOGIC) then
			v_counter_mini_round := COLUMN_TOTAL+1;
			v_counter_WrEn := COLUMN_TOTAL + 1;
			v_read_request_came:=false;
			WrEn_R_DOUT <= '0';
			v_cnt_delay_ready := 0;
			v_write_ack_count :=0;
			s_LOADING_DONE <= '0';
			UN_LOADING_DONE <= '0';
			OP_DONE <= '0';	
			s_flag_WrData_Complete <= false;		
		else

			if State = LOAD_G then
			--------------------------Default values of Un-used signals----------------------------------
				v_counter_mini_round := COLUMN_TOTAL+1;
				v_counter_WrEn := COLUMN_TOTAL + 1;
				v_read_request_came:=false;
			---------------------------------------------------------------------------------------------
					
					
								
				if v_write_ack_count >= COLUMN_TOTAL*COLUMN_TOTAL then --if (s_G_WE or s_WE)= '1' or s_READY = '0' then--
					s_LOADING_DONE <= '1';			
				end if;
				

				
				if SingleWrCE = '1' then
				
				-- during synthesis comment this block because it is not necessary. v_write_ack_count is a range integer which in reality will roll over when it goes beyond its boundary.
				-- However during simualation somehow this does not happen but in reality when the circuit is synthesized, because of the boundary imposed by the range specified
				-- for the signal, whenever there is an operation that makes this signal cross its boundary it should roll over.					
					
					if v_write_ack_count > (COLUMN_TOTAL*COLUMN_TOTAL)-1 then 
						v_write_ack_count := 0;
					else
						v_write_ack_count := v_write_ack_count + 1;						
					end if;
					
				
					if v_write_ack_count = COLUMN_TOTAL*COLUMN_TOTAL then
						s_flag_WrData_Complete <= true;
					else
						s_flag_WrData_Complete <= false;
					end if;	
				end if;			

				WrEn_R_DOUT <= '0';
				
			elsif State = LOAD_P then
			--------------------------Default values of Un-used signals----------------------------------
				v_counter_mini_round := COLUMN_TOTAL+1;
				v_counter_WrEn := COLUMN_TOTAL + 1;
				v_read_request_came:=false;
			---------------------------------------------------------------------------------------------
				
				if v_write_ack_count >= COLUMN_TOTAL*COLUMN_TOTAL then --if (s_G_WE or s_WE)= '1' or s_READY = '0' then--
					if v_cnt_delay_ready < PIPELINE_DELAY then--PIPELINE_DELAY+1 then
						v_cnt_delay_ready := v_cnt_delay_ready + 1;						
					else
						s_LOADING_DONE <= '1';
					end if;				
				end if;					

				if SingleWrCE = '1' then
				
			-- during synthesis comment this block because it is not necessary. v_write_ack_count is a range integer which in reality will roll over when it goes beyond its boundary.
			-- However during simualation somehow this does not happen but in reality when the circuit is synthesized, because of the boundary imposed by the range specified
			-- for the signal, whenever there is an operation that makes this signal cross its boundary it should roll over.					
					if v_write_ack_count > (COLUMN_TOTAL*COLUMN_TOTAL)-1 then 
						v_write_ack_count := 0;
					else
						v_write_ack_count := v_write_ack_count + 1;						
					end if;				
					
					
					
					if v_write_ack_count = COLUMN_TOTAL*COLUMN_TOTAL then
						s_flag_WrData_Complete <= true;
					else
						s_flag_WrData_Complete <= false;
					end if;	
				end if;
				
				
			elsif State = UNLOAD then
				
					
				if v_write_ack_count = (COLUMN_TOTAL*COLUMN_TOTAL)  then
					UN_LOADING_DONE <= '1';
				end if;

				if SingleRdCE = '1' then
					
					v_read_request_came:=true;
					
					if v_counter_mini_round = 1 then -- THis is a down counter which rolls over to 1 when count reaches the least value
						v_f_start_v_counter_WrEn := false;
						v_counter_mini_round := COLUMN_TOTAL; --4;
						v_counter_WrEn := COLUMN_TOTAL;--4; 			--Reset count to start from preset value;
					else								-- counter orignally is set to 5 so that after this line execute its final value should be 4.
						v_counter_mini_round := v_counter_mini_round - 1; -- THe first value used for this variable must start from 4.
					end if;
				
								
									
			-- during synthesis comment this block because it is not necessary. v_write_ack_count is a range integer which in reality will roll over when it goes beyond its boundary.
			-- However during simualation somehow this does not happen but in reality when the circuit is synthesized, because of the boundary imposed by the range specified
			-- for the signal, whenever there is an operation that makes this signal cross its boundary it should roll over.					
					if v_write_ack_count > (COLUMN_TOTAL*COLUMN_TOTAL)-1 then 
						v_write_ack_count := 0;
					else
						v_write_ack_count := v_write_ack_count + 1;						
					end if;
					
					v_f_start_pipe_line_delay_counter := true; -- start the pipeline delay counter so we can calculate when valid data will be at the output.
					
					if v_write_ack_count = COLUMN_TOTAL*COLUMN_TOTAL then
						s_flag_WrData_Complete <= true;
					else
						s_flag_WrData_Complete <= false;
					end if;
				end if; -- end of if statement for if SingleRdCE = '1' then
							
							
				
				if v_f_start_pipe_line_delay_counter = true and v_counter_mini_round = COLUMN_TOTAL  then -- if this flag is true then it means a read request came and
					if v_cnt_delay_ready = PIPELINE_DELAY + 1 then -- We count until data comes out of the pipeline and then we co
						v_cnt_delay_ready := 0;						-- reset the count to 0 then we set the "v_f_start_pipe_line_delay_counter" flag to false to disable the 
						v_f_start_pipe_line_delay_counter := false; -- SingleRdAck and WrEn_R_DOUT signals because they only have to be active for one clock cycle.
					else
						v_cnt_delay_ready := v_cnt_delay_ready + 1;	-- we need to count to know when a valid data will pop out from the pipeline.
					end if;
				else
					v_cnt_delay_ready := 0;
				end if;
				
				
			--------------------------------PLEASE README-----------------------------------------------------------------------------
			--When data is read for the first two times it takes exactly PIPELINE_DELAY clock cycles (10) for the valid data to pop out.
			--But, things get interesting After the 2nd read request. The architecture of the IP core is such that the output 'p' of each
			--DSP block is connected to the 'c' input of the next DSP block ahead of it. There is a single register between the 'c' input
			--of each DSP block and its output 'p'. What this means is that , the DSP blocks are connected in a ring of registers.
			--After the second read arrives the DSP blocks are configured to output their 'c' input (p = c) so this creates a loop back circular shift
			--register whereby all the outputs of the DSP block cycle around continously. The advantage of this is that any subsequent read after the 2nd read
			-- will not take up PIPELINE_DELAY (10) clock cycles before the data is ready because all the data are now avaible in the ring of registers
			-- connecting all the DSPs. The problem now is, how do you get the correct data out of this ring?
			--THe solution was to create a number of counters. One counter that keeps track of when each data is present at the output of the last DSP block in the ring
			--because it is the last DSP block that is connected to the output of the IP core. This is the purpose of the v_counter_WrEn counter.
			-- v_counter_mini_round keeps track of when a new round begins and when counter v_counter_WrEn should start counting.
			
			if v_cnt_delay_ready = PIPELINE_DELAY then
				 v_f_start_v_counter_WrEn := true;
			end if;
			
			if v_f_start_v_counter_WrEn = true then
				if v_counter_WrEn = 1 then
					v_counter_WrEn := COLUMN_TOTAL;--4;
				else
					v_counter_WrEn := v_counter_WrEn - 1;
				end if;
			else
				v_counter_WrEn := COLUMN_TOTAL + 1;
			end if;
			
			
			if v_counter_mini_round >= COLUMN_TOTAL then--if v_counter_mini_round >= COLUMN_TOTAL-1 then	
				
				if v_cnt_delay_ready = PIPELINE_DELAY  then  --or  v_cnt_delay_ready = PIPELINE_DELAY then --we set the enable signal 1 clock cycle before valid data comes in this is to ensure 
					WrEn_R_DOUT <= '1';						  -- that the data register will we notice the WrEn_R_DOUT signal and save the data.					
					v_read_request_came:=false;	
				elsif v_read_request_came = false then--v_cnt_delay_ready = PIPELINE_DELAY + 1 then
					--SingleRdAck <= '1';
					WrEn_R_DOUT <= '0';						
				else
					WrEn_R_DOUT <= '0';
				end if;
			else				
				if (v_counter_WrEn = v_counter_mini_round) and (v_read_request_came = true) then  -- we only enable the WrEn_R_DOUT when there a read request came in and
					WrEn_R_DOUT <= '1';	-- v_counter_WrEn is equal to v_counter_mini_round. At that time the valid data should be present at the output.		
					v_read_request_came := false;
				elsif v_read_request_came = false then--v_counter_WrEn < v_counter_mini_round then -- after one clock cycle disable write enable.
					WrEn_R_DOUT <= '0';			--has to be disable here to prevent the WrEn_R_DOUT signal from toggling forever.				
				else
					WrEn_R_DOUT <= '0';
				end if;
			end if;			
			
			
			

			elsif State = PG or State = PGt or State = PtG or State = PtGt then
			--------------------------Default values of Un-used signals----------------------------------
				v_counter_mini_round := COLUMN_TOTAL+1;
				v_counter_WrEn := COLUMN_TOTAL + 1;
				v_read_request_came:=false;
			---------------------------------------------------------------------------------------------
				if v_cnt_delay_ready /= (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then
					v_cnt_delay_ready := v_cnt_delay_ready + 1;
				end if;
				
				if v_cnt_delay_ready >= (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then
					OP_DONE <= '1';
				end if;	
				--OP_DONE <= '1';
				
				WrEn_R_DOUT <= '0';
			elsif State = DONE then
			--------------------------Default values of Un-used signals----------------------------------
				v_counter_mini_round := COLUMN_TOTAL+1;
				v_counter_WrEn := COLUMN_TOTAL + 1;
				v_read_request_came:=false;
			---------------------------------------------------------------------------------------------
				OP_DONE <= '1';
				v_cnt_delay_ready := 0;
			else
			--------------------------Default values of Un-used signals----------------------------------
				v_counter_mini_round := COLUMN_TOTAL+1;
				v_counter_WrEn := COLUMN_TOTAL + 1;
				v_read_request_came:=false;
			---------------------------------------------------------------------------------------------
				s_LOADING_DONE <= '0';
				UN_LOADING_DONE <= '0';
				OP_DONE <= '0';
				v_cnt_delay_ready := 0;
				s_flag_WrData_Complete <= false;
				WrEn_R_DOUT <= '0';	
			end if;
		end if;
end if;
g_cnt_delay_ready <= v_cnt_delay_ready;
cnt_delay_ready <= v_cnt_delay_ready;
--s_counter_mini_round <= v_counter_mini_round;
--s_counter_WrEn <= v_counter_WrEn;
--s_read_request_came <= v_read_request_came;
--s_write_ack_count <= v_write_ack_count;
--s_f_start_v_counter_WrEn <= v_f_start_v_counter_WrEn;
end process;
-----------------------------------------------------------
process(CLK)
variable i,j,v_load_count: integer range 0 to COLUMN_TOTAL+1;
variable v_CSEL : std_logic_vector(COLUMN_TOTAL-1 downto 0);
variable v_OPCODE: std_logic_vector(OPCODE_WIDTH-1 downto 0);
variable v_WE: std_logic;
variable v_LOADING_DONE, v_OP_DONE, v_UNLOAD_DONE: std_logic:='0';
variable v_i_addr_cnt: integer range 0 to COLUMN_TOTAL;
variable proceed : boolean:=false;

begin
if (rising_edge(CLK)) then
	
if rst = RESET_ACTIVE_LOGIC then
		State <= START;
			i_row_cnt<=0;
			i_col_cnt<=0;
			i_addr_cnt <= 1;
			G_EN <= '0';						
			s_READY2<='0';--reset the done signal
			SingleRdAck <= '0';
			SingleWrAck <= '0';
			G_WE <= '0';
			v_OP_DONE := '0';--reset the done signal
			v_LOADING_DONE:='0';
			proceed := false;
			v_UNLOAD_DONE := '1';-- This is supposed to be set to '0' but it is ok because it is reset in the LOAD_DONE state. It was necessary to set it to '1' to prevent synthesis tool from optimizing it.
			--next_state<=current_state;
			CONTROL_A_INPUT_OF_DSP <= "00";--'0';
			i:=0;
			j:=0;
			Read_SHFT <='0';
			Write_SHFT <= '0';
			WE <= '0';
			v_OPCODE := (others => '1');
			OPCODE <= (others => '1');
			s_CSEL <= (others => '0'); 	
else
	case State is
	
		when START =>
				
				IF LOAD_PG = LOAD_G_CMD then
					State<=LOAD_G;
				ELSIF LOAD_PG = LOAD_P_CMD then
					State <= LOAD_P;				
				ELSE
					State<=LOAD_DONE;
				END IF;
					-----------------------------------
		when LOAD_G =>
				s_READY2 <= '1';
			--if BURST_ACCESS = false then				
				if s_flag_WrData_Complete = false then --if v_LOADING_DONE = '0' then
					if SingleWrCE = '1' then
						v_WE := '1';
						SingleWrAck <= '1';
						if i = COLUMN_TOTAL then--if i_row_cnt = COLUMN_TOTAL-1 then							
							if i = COLUMN_TOTAL and j = COLUMN_TOTAL-1 then--if i_row_cnt = COLUMN_TOTAL-1 and i_col_cnt = COLUMN_TOTAL-1 then
								v_LOADING_DONE := '1';
								v_WE := '0';
							else
								v_LOADING_DONE := '0';							
								j:= j+1;
								i:= 1;
							end if;
						else
							i := i + 1;--i_row_cnt <= i_row_cnt + 1;								
						end if;
					else
						v_WE := '0';
						SingleWrAck <= '0';							
					end if;									
				else
					v_WE := '0';
					SingleWrAck <= '0';
					if  cnt_delay_ready = (PIPELINE_DELAY + 1) then--if v_LOADING_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then -- wait until data gets to GRAM. 
						proceed := true;													
					end if;
					
					if proceed = true then
						if LOAD_PG = LOAD_G_CMD then
							State <= LOAD_G;--remain here untilt signal changes from load_g to load_p or something else.
						else
							State <= LOAD_DONE;
						end if;	
					end if;					
				end if;
			G_WE <= v_WE;
			
			-- during synthesis comment this block because it is not necessary. i_row_cnt is a range integer which in reality will overflow when it goes beyond its boundary
			-- However during simualation somehow this does not happen but in reality when the circuit is synthesized, because of the boundary imposed by the range specified
			-- for the signal, whenever there is an operation that makes this signal cross its boundary it should roll over.
			if i = 0 then 
				i_row_cnt <= 0;
			else
				i_row_cnt <= i-1;
			end if;
			i_col_cnt <= j;			
			
--			else
--				v_WE := '0';
--			end if;

		when LOAD_P =>	
				s_READY2 <= '1';		
				OPCODE <="000";	-- Set DSP output to A input, the Data passes through DSP so we do not want to perform any operation on the data since we are just saving it on block RAM. (P = A)			
				--if BURST_ACCESS = false then							
					if s_flag_WrData_Complete = false then --if v_LOADING_DONE = '0' thenif v_LOADING_DONE = '0' then					
						if SingleWrCE = '1' then--v_LOADING_DONE := '0';
							v_WE := '1';
							SingleWrAck <= '1';				
							if i = COLUMN_TOTAL then -- check if we have finished a mini-round of data loading (for a 3by3 matrix this will be when i=3)
								
								if i = COLUMN_TOTAL and j = COLUMN_TOTAL-1 then -- if loading is complete set LOADING_DONE signal.
									v_LOADING_DONE := '1';
									v_WE := '0';
									v_CSEL := (others => '0');
								else							
									v_LOADING_DONE := '0';							
									j:= j+1;
									i:= 1;
									v_CSEL :=(CSEL'length-1 =>'1', others => '0');
									if j < COLUMN_TOTAL - 1 then -- check if we are still a column less than the total number of columns							
										v_CSEL := to_stdlogicvector(to_bitvector(v_CSEL) srl (COLUMN_TOTAL - j - 1));	-- This line of code will maintain the offset of the circulant matrix whenever we start a new mini-round.										
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
							v_WE := '0';
							SingleWrAck <= '0';							
						end if;								
					else
						v_WE := '0';
						SingleWrAck <= '0';
						if cnt_delay_ready = (PIPELINE_DELAY + 1) then -- wait until gets to BRAM. 
							proceed := true;
						end if;
						
						if proceed = true then
							if LOAD_PG = LOAD_P_CMD then
								State <= LOAD_P;--remain here until signal changes from load_g to load_p or something else.
							else
								State <= LOAD_DONE;
							end if;	
						end if;						
										
					end if;
					i_addr_cnt <= j;
					s_CSEL <= v_CSEL;
					WE <= v_WE;
--				else
--				end if;				
			when LOAD_DONE =>
				OPCODE <="111";
				SingleRdAck <= '0';
				SingleWrAck <= '0';			
				i:=0;
				j:=0;
				WE <= '0';
				Write_SHFT <= '0';
				v_UNLOAD_DONE := '0';
				v_LOADING_DONE := '0';
				proceed := false;
				s_READY2 <= '0';							
				s_CSEL <= (others => '1');--Enble BRAM for Saving multiplication result.		
				IF LOAD_PG = LOAD_G_CMD then
					State <= LOAD_G;
				elsif LOAD_PG = LOAD_P_CMD then					
					State <= LOAD_P;
				else
					Write_SHFT <= '1';
					if UN_LOAD = '1' then
						State <= UNLOAD;	
					else
						G_EN <= '1'; -- Enable GRAM
						CONTROL_A_INPUT_OF_DSP <= "11";
							if (P='0') then
									if G='0' then
										State<=PG;
										i_addr_cnt<=COLUMN_TOTAL-1;
										i_row_cnt<=1;
										i_col_cnt<=0;
										Read_SHFT <='1';							
										OPCODE<="001";
									else
										State<=PGt;
										Read_SHFT <='1';							
										i_addr_cnt<=COLUMN_TOTAL-1;
										i_row_cnt<=0;
										i_col_cnt<=1;
										OPCODE<="001";
									end if;
								else
									if G='0' then
										State<=PtG;
										Read_SHFT <='0';							
										i_addr_cnt<=1;
										i_row_cnt<=1;
										i_col_cnt<=0;
										OPCODE<="001";
									else
										State<=PtGt;
										Read_SHFT <='0';
										i_addr_cnt<=1;
										i_row_cnt<=0;
										i_col_cnt<=1;
										OPCODE<="001";
									end if;
								end if;
							end if;
						end if;
		when PG =>
					v_OPCODE :="011";
					WE <='0';					
					if v_OP_DONE = '0' then
						if (i_row_cnt=COLUMN_TOTAL-1) then				---G row
							i_row_cnt<=0;
						else
							i_row_cnt<=i_row_cnt+1;
						end if;
						if i_addr_cnt=0 then									--- P addr
							i_addr_cnt<=COLUMN_TOTAL-1;
						else
							i_addr_cnt<=i_addr_cnt-1;
						end if;
						if i= COLUMN_TOTAL-1 then 		-- full round
							j:=j+1;
							i_col_cnt<=i_col_cnt+1;			-- next G column
							
							if j < COLUMN_TOTAL then --i_row_cnt <= 1 + j;	-- G Row
							 i_row_cnt <= 1 + j;	--  G Row
							end if;
							
							if j = COLUMN_TOTAL then -- Check G Col
								i_col_cnt<=j-1;
							end if;
							if ((i_row_cnt+1)>=COLUMN_TOTAL-1) then		-- G row
								i_row_cnt<=0;
							end if;
							i_addr_cnt<= abs(COLUMN_TOTAL-1-j);
							i:=0;
							v_OPCODE := "001";
						else
							i:=i+1;
							if i = COLUMN_TOTAL-1 then
								WE<='1';								
							end if;
								v_OPCODE := "011";-- make parameterizable latter.
						end if;
						if j= COLUMN_TOTAL then --if j= COLUMN_TOTAL then 
							v_OP_DONE :='1';
							v_OPCODE :="111";							
						else
							v_OP_DONE :='0';						
						end if;
					else
						if v_OP_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then -- wait until the results are saved in BRAM.--then
							State<=DONE;
							v_OPCODE := "111";
						end if;
					end if;
					OPCODE<= v_OPCODE; --"111";
			when PGt=>
					v_OPCODE :="011";
					WE <='0';					
					if v_OP_DONE = '0' then
						if (i_col_cnt=COLUMN_TOTAL-1) then				---G col
							i_col_cnt<=0;
						else
							i_col_cnt<=i_col_cnt+1;
						end if;
						if i_addr_cnt=0 then									--- P addr
							i_addr_cnt<=COLUMN_TOTAL-1;
						else
							i_addr_cnt<=i_addr_cnt-1;
						end if;
						if i= COLUMN_TOTAL-1 then 		-- full round 
							j:=j+1;							
							
						  if J < COLUMN_TOTAL then --i_col_cnt <= 1 + j;	--  G Col
						      i_col_cnt <= 1 + j;	--  G Col
						  end if;	
							
							i_row_cnt<=i_row_cnt+1;			-- next G row
							if j = COLUMN_TOTAL then -- Check G Row
								i_row_cnt<=j-1;
							end if;
							if ((i_col_cnt+1)>=COLUMN_TOTAL-1) then		-- G Column
								i_col_cnt<=0;
							end if;
							i_addr_cnt<= abs(COLUMN_TOTAL-1-j);
							i:=0;
							v_OPCODE := "001";
						else
							i:=i+1;
							if i = COLUMN_TOTAL-1 then
								WE<='1';								
							end if;
							v_OPCODE := "011";-- make parameterizable latter.					
						end if;
						if j= COLUMN_TOTAL then 
							v_OP_DONE :='1';
							v_OPCODE :="111";							
						else
							v_OP_DONE :='0';
						end if;
					else
						if v_OP_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then -- wait until the results are saved in BRAM.--then
							State<=DONE;
							v_OPCODE := "111";
						end if;
					end if;
					OPCODE<= v_OPCODE; --"111";
			when PtG=>
					v_OPCODE :="011";
					WE <='0';					
					if v_OP_DONE = '0' then
						if (i_row_cnt=COLUMN_TOTAL-1) then				---G row
							i_row_cnt<=0;
						else
							i_row_cnt<=i_row_cnt+1;
						end if;
						if i_addr_cnt=COLUMN_TOTAL-1 then									--- P addr
							i_addr_cnt<=0;
						else
							i_addr_cnt<=i_addr_cnt+1;
						end if;
						if i= COLUMN_TOTAL-1 then 		-- full round 
							j:=j+1;
							i_col_cnt<=i_col_cnt+1;			-- next G column
							
							if j < COLUMN_TOTAL then --i_row_cnt <= 1 + j;	-- G Row
							 i_row_cnt <= 1 + j;	-- G Row
							end if;
							
							if j = COLUMN_TOTAL then -- Check G Col
								i_col_cnt<=j-1;
							end if;
							if ((i_row_cnt+1)>=COLUMN_TOTAL-1) then		-- G row
								i_row_cnt<=0;
							end if;
							if j=COLUMN_TOTAL-1 then									--- P addr
								i_addr_cnt<=0;
							else
								
								if j = COLUMN_TOTAL then
								  i_addr_cnt<= COLUMN_TOTAL-1;
								else
								  i_addr_cnt<=j+1;
								end if;
							end if;
							i:=0;
							v_OPCODE := "001";
						else
							i:=i+1;
							if i = COLUMN_TOTAL-1 then
								WE<='1';								
							end if;
								v_OPCODE := "011";-- make parameterizable latter.
						end if;
						if j= COLUMN_TOTAL then 
							v_OP_DONE :='1';
							v_OPCODE :="111";
						else
							v_OP_DONE :='0';
						end if;
					else
						if v_OP_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then -- wait until results are saved in BRAM.--then
							State<=DONE;
							v_OPCODE := "111";
						end if;
					end if;
					OPCODE<= v_OPCODE; --"111";
			when PtGt =>
					v_OPCODE :="011";
					WE <='0';					
					if v_OP_DONE = '0' then
						if (i_col_cnt=COLUMN_TOTAL-1) then---G col
							if i /= COLUMN_TOTAL-1 then
								i_col_cnt<=0;
							end if;
						else
							if i /= COLUMN_TOTAL-1 then
								i_col_cnt<=i_col_cnt+1;
							end if;
						end if;
						if i_addr_cnt=COLUMN_TOTAL-1 then -- P addr
							if i /= COLUMN_TOTAL-1 then -- Do not reset count if a sub-round is finished. A sub round is finished when the variable 'i' is the last address (i = COLUMN_TOTAL-1). For example if COLUMN_TOTAL = 3 then if the round address ended with 
								i_addr_cnt<=0;			-- the last address (COLUMN_TOTAl-1 => 2), like this 0,1,[2] the next round will continue from [2],0,1 instead of [0],1,2. So the address pattern is like this 1,2,0:0,1,2:2,0,1
							end if;						-- We begin a new round with the last address of the previous sub-round.
						else							
							if i /= COLUMN_TOTAL-1 then -- Increase count as long as the sub-round is not finished.				
								i_addr_cnt <= i_addr_cnt+1;
							end if;
						end if;
						if i= COLUMN_TOTAL-1 then-- full round 
							j:=j+1;
							i_row_cnt<=i_row_cnt+1;-- next G row
							if i_row_cnt = 0 then -- Check G Row
								i_row_cnt<=COLUMN_TOTAL-1;
							else
								i_row_cnt <= i_row_cnt-1;
							end if;
							i:=0;
							v_OPCODE := "001";
						else
							i:=i+1;
							if i = COLUMN_TOTAL-1 then
								WE<='1';								
							end if;
							v_OPCODE := "011";-- make parameterizable latter.					
						end if;
						if j= COLUMN_TOTAL then 
							v_OP_DONE :='1';
							v_OPCODE :="111";
						else
							v_OP_DONE :='0';
						end if;
					else
						if v_OP_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then -- wait until gets to BRAM.--then
							State<=DONE;
							v_OPCODE := "111";
						end if;
					end if;
					OPCODE<= v_OPCODE; --"111";
			when DONE =>
					G_EN <= '0';
					WE<='0';
					Read_SHFT <= '0';					
					v_OP_DONE := '0';
					v_UNLOAD_DONE := '0';	
					i:=0;
					j:=0;					
					if UN_LOAD = '1' then
					 State <= UNLOAD;
					end if;
			when others =>				
				--s_fsm_generate_address <= true;
				--if BURST_ACCESS = false then
					s_READY2 <= '1';
					if s_flag_RdData_Complete = false then--if v_UNLOAD_DONE = '0' then
						CONTROL_A_INPUT_OF_DSP <= "01";--'1';						
						if SingleRdCE = '1' then
							SingleRdAck <= '1';
							if j > COLUMN_TOTAL then -- J = 0 initially.
								v_UNLOAD_DONE := '1';
								v_OP_DONE := '1';
								v_OPCODE := "111"; --Do nothing.
							else
								if i = 0 then
									v_OPCODE := "001";--"101";-- P = B*A. Note A = 1 so P = B.
									if j = COLUMN_TOTAL then
										v_OPCODE := "111";-- End of main loop. send null command.
									end if;							
									i:=i+1;
									j:= j+1;
								else
									v_OPCODE := "110";-- P = C.							
									i:=i+1;
									if i = COLUMN_TOTAL  then
										i:=0;								
									end if;						
								end if;						
							end if;
						else
							v_OPCODE := "110";
							SingleRdAck <= '0';
						end	if;			
					else
						SingleRdAck <= '0';
						CONTROL_A_INPUT_OF_DSP <= "00";--'0';
						v_OP_DONE := '0';
						v_OPCODE := "111";
						v_UNLOAD_DONE := '1';
					end if;
					OPCODE<= v_OPCODE;
					
					--i_addr_cnt <= j-1; -- uncomment this during synthesis
					
					if j = 0 then -- comment this if block during synthesis
						i_addr_cnt <= 0;
					else				
						i_addr_cnt <= j-1;
					end if;
					
--			else
--				if v_UNLOAD_DONE = '0' then
--						CONTROL_A_INPUT_OF_DSP <= "01";--'1';
--						if j > COLUMN_TOTAL then -- J = 0 initially.
--							v_UNLOAD_DONE := '1';
--							v_OP_DONE := '1';
--							v_OPCODE := "111"; --Do nothing.
--						else
--							if i = 0 then
--								v_OPCODE := "001";--"101";-- P = B*A. Note A = 1 so P = B.
--								if j = COLUMN_TOTAL then
--									v_OPCODE := "111";-- End of main loop. send null command.
--								end if;							
--								i:=i+1;
--								j:= j+1;
--							else
--								v_OPCODE := "110";-- P = C.							
--								i:=i+1;
--								if i = COLUMN_TOTAL  then
--									i:=0;								
--								end if;						
--							end if;						
--						end if;					
--					else
--						CONTROL_A_INPUT_OF_DSP <= "00";--'0';
--						v_OP_DONE := '0';
--						v_OPCODE := "111";
--						v_UNLOAD_DONE := '1';
--					end if;
--					OPCODE<= v_OPCODE;
--					--s_P_ADDR <= std_logic_vector(to_unsigned(j-1, ADDR_WIDTH-1));
--					i_addr_cnt <= j-1;
--			end if;										
	end case;
end if;
end if;
end process;

ADDRESS_GENERATION: Process(LOAD_PG,i_addr_cnt, P)--(current_state, i_addr_cnt, s_P_ADDR, G, P)
begin
--	if s_fsm_generate_address = true then--current_state = LOADING or current_state = UNLOAD then
--		Write_ADDR <= s_P_ADDR;
--		Read_ADDR <= s_P_ADDR;
--	else
--		Write_ADDR <= std_logic_vector(to_unsigned(i_addr_cnt,ADDR_WIDTH-1));
		Read_ADDR <= std_logic_vector(to_unsigned(i_addr_cnt,ADDR_WIDTH-1));
		if P='1' and LOAD_PG /= LOAD_P_CMD then--(LOAD_PG = "10" or LOAD_PG = "11")  then --LOAD = '0' --if P='1' and G='1' then
			if i_addr_cnt = 0 then		 -- When the Read address is 0 the Write address is also 0 (see table below).
				Write_ADDR <= (others => '0');-- This line of Code Resets the Write address to 0. 
			else
				-- When Performing PtGt the last Read Address and the last Write address of each sub-round do not allign so the result in each sub-round does
				-- not save in the desired location of Memory. But we want the result to save in circulant format. To solve this problem
				-- we need to regenerate the Write address (ADDRA) from the Read Address (ADDRB) so that the proper Write Address will
				-- be generated and the Result will be saved in circulant format. Note that the actual Write Address (ADDRA) used to save data in Memory is the Last address of a sub-round so
				-- in other words the Write Address will be the last Address Read in a sub-round.
				-- Refer to the Table below for an example. 
				-- In the table below N represents the total number of columns. The Column contains the last address read from Memory.
				-- The Write Column represent the generated address that will be used to Write the Result to Memory.
				
				-- |    N=3   | |    N=4   | |    N=5   |  
				-- |__________| |__________| |__________|
				-- |Write|Read| |Write|Read| |Write|Read|
				-- |  0  |  0 | |  0  |  0 | |  0  |  0 |
				-- |  2  |  1 | |  3  |  1 | |  4  |  1 |
				-- |  1  |  2 | |  2  |  2 | |  3  |  2 |
				--            | |  1  |  3 | |  2  |  3 |
				--                           |  1  |  4 |
							    
			    Write_ADDR <= std_logic_vector(to_unsigned(COLUMN_TOTAL - i_addr_cnt, ADDR_WIDTH-1));--This line of code generates the Write address from the Read Address.
			end if;
		else
			Write_ADDR <= std_logic_vector(to_unsigned(i_addr_cnt,ADDR_WIDTH-1));
		end if;
	--end if;
end process;
						

				
				
				G_ROW<=std_logic_vector(to_unsigned(i_row_cnt,ADDR_WIDTH));
				G_COLUMN<=std_logic_vector(to_unsigned(i_col_cnt,ADDR_WIDTH));--std_logic_vector(to_unsigned(i_col_cnt,COLUMN_TOTAL));
				CSEL <= s_CSEL;



							
-----------------------------------------------------------
end Behavioral;

