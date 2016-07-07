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
		ADDR_WIDTH   : integer := 10;
		DATA_WIDTH	 :integer:=18;
		OPCODE_WIDTH : integer := 3;
		COLUMN_TOTAL : integer := 3);
	Port(
		AXI_Bus2IP_WrCE : in std_logic;
		AXI_Bus2IP_RdCE : in std_logic;
		AXI_IP2Bus_RdAck: out std_logic;
		AXI_IP2Bus_WrAck: out std_logic;		
		 CLK          	: in  STD_LOGIC;
		 RST          	: in  STD_LOGIC;
		 LOAD_PG      	: in  STD_LOGIC_VECTOR(1 downto 0);
		 UN_LOAD	  		: in STD_LOGIC;			
		 P            	: in  STD_LOGIC;
		 G            	: in  STD_LOGIC;
		 WE           	: out std_logic;		 
		 CSEL				:out std_logic_vector(COLUMN_TOTAL-1 downto 0);
		 Read_ADDR		: out STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
		 Write_ADDR		: out STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
		 Read_SHFT     : out STD_LOGIC;
		 Write_SHFT		: out std_logic;		 
		 OPCODE       	: out STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 downto 0);
		 G_ROW        	: out STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
		 G_COLUMN     	: out STD_LOGIC_VECTOR(COLUMN_TOTAL - 1 downto 0);
		 G_WE				: out std_logic;
		 G_EN				: out STD_LOGIC;
		 READY		  	: out std_logic;	
		 OP_DONE      	: out std_logic;
		 LOADING_DONE 	: out std_logic;
		 UN_LOADING_DONE : out std_logic;
		 CONTROL_A_INPUT_OF_DSP: out std_logic_vector(1 downto 0));
end CONTROL_UNIT_S_INT_G;

architecture Behavioral of CONTROL_UNIT_S_INT_G is

constant PIPELINE_DELAY: integer:= 10;

	
signal i_addr_cnt,i_row_cnt,i_col_cnt: integer range 0 to COLUMN_TOTAL;
 signal s_CSEL: std_logic_vector(COLUMN_TOTAL-1 downto 0);

type state_type is (START,LOAD_G,LOAD_P,LOAD_DONE,PG,PtG,PGt,PtGt,DONE,UNLOAD);--,UNLOAD_DONE);
signal current_state,next_state: state_type;
--signal s_P_ADDR : STD_LOGIC_VECTOR(ADDR_WIDTH - 2 downto 0);
signal cnt_delay_ready: integer range 0 to (PIPELINE_DELAY + 1 + COLUMN_TOTAL*COLUMN_TOTAL);-- The counter should be able to count up to square of TOTAL_NUM_OF_COLUMNS + 1 +Pipeline delay
--signal write_ack_count: integer range 0 to (COLUMN_TOTAL * COLUMN_TOTAL);
signal s_G_WE, s_WE: std_logic;

--dubug sigals
signal s_a, s_b: integer:=0;
--signal count : boolean:=false;
signal s_READY : std_logic;
signal s_AXI_IP2Bus_RdAck : std_logic;
signal s_LOADING_DONE,s_v_LOADING_DONE : std_logic;
signal s_UN_LOADING_DONE : std_logic;
signal s_Wr_Ack : std_logic;
signal s_flag_WrData_Complete : boolean;
--signal s_AXI_IP2Bus_WrAck : std_logic;
--signal s_fsm_generate_address : boolean:=true;

begin


READY <= s_READY;
G_WE <= s_G_WE;
WE <= s_WE;
LOADING_DONE <= s_LOADING_DONE;
UN_LOADING_DONE <= s_UN_LOADING_DONE;

FLAGS_and_Current_state_update:process (CLK, RST)
-- This Counter variable is used to create a delay for the appropriate time to set the READY signal.
-- The READY signal is used to alert the user to know when the FSM has setteled in the START state and is ready to start receiving input data
-- for storage in BRAM. The current value is set to 4 but it can be changed accordingly to allow enough time for the READY signal to trigger,
-- and user to Respond. Typically this value could be set to 3 instead of 4 to give the user 1 clock cycle to react. But for simulation
-- Purpose the value 4 is ok. 
	variable v_cnt_delay_ready: integer range 0 to ((PIPELINE_DELAY + 1)  + COLUMN_TOTAL*COLUMN_TOTAL);
	variable write_ack_count: integer range 0 to (COLUMN_TOTAL * COLUMN_TOTAL);
	variable count : boolean:=false;
begin
if rising_edge(CLK) then
		if(RST='1') then
			current_state<=START;
			AXI_IP2Bus_RdAck <= AXI_Bus2IP_RdCE;
			AXI_IP2Bus_WrAck <= AXI_Bus2IP_WrCE;
			v_cnt_delay_ready := 0;
			write_ack_count := 0;
			s_READY <= '0';
			s_LOADING_DONE <= '0';
			s_UN_LOADING_DONE <= '0';
			OP_DONE <= '0';
			s_flag_WrData_Complete <= false;		
		else
			current_state <= next_state;   --state change.
			if current_state = LOAD_G then
				
				if write_ack_count >= COLUMN_TOTAL*COLUMN_TOTAL then--or s_READY = '0' then --if (s_G_WE or s_WE)= '1' or s_READY = '0' then--
					if v_cnt_delay_ready < PIPELINE_DELAY+1 then
						v_cnt_delay_ready := v_cnt_delay_ready + 1;						
					else
						s_LOADING_DONE <= '1';
					end if;				
				end if;	
				
				AXI_IP2Bus_RdAck <= AXI_Bus2IP_RdCE;
				
				--if v_cnt_delay_ready >= 8 then
					s_READY <= '1';					
				--end if;
				
				if AXI_Bus2IP_WrCE = '1' then
					AXI_IP2Bus_WrAck <= '1';
					write_ack_count := write_ack_count + 1;
					count := true;
					if write_ack_count >= COLUMN_TOTAL*COLUMN_TOTAL then
						s_flag_WrData_Complete <= true;
					else
						s_flag_WrData_Complete <= false;
					end if;					
				else
					AXI_IP2Bus_WrAck <= '0';
					count := false;
				end if;

			elsif current_state = LOAD_P then
--				if count = true or s_READY = '0' then
--					v_cnt_delay_ready := v_cnt_delay_ready + 1;
--				end if;
---- Note if DIN input to DSP block is delayed from GRAM (3 stage Pipeline) instead of using the 2 stage Pipeline in MEMARRY then this value should be 1 otherwise set it to 4.				
--				if v_cnt_delay_ready >= 4 then
--					s_READY <= '1';
--				end if;
--				AXI_IP2Bus_RdAck <= AXI_Bus2IP_RdCE;
--				if v_cnt_delay_ready = (PIPELINE_DELAY + 1 + COLUMN_TOTAL*COLUMN_TOTAL) then
--					s_LOADING_DONE <= '1';
--				end if;
--				
--				if s_LOADING_DONE = '1' then
--					AXI_IP2Bus_WrAck <= AXI_Bus2IP_WrCE;
--				else
--					AXI_IP2Bus_WrAck <= s_G_WE or s_WE;--s_Wr_Ack or s_G_WE or s_WE;
--				end if;

				if write_ack_count >= COLUMN_TOTAL*COLUMN_TOTAL then--or s_READY = '0' then --if (s_G_WE or s_WE)= '1' or s_READY = '0' then--
					if v_cnt_delay_ready < PIPELINE_DELAY+1 then
						v_cnt_delay_ready := v_cnt_delay_ready + 1;						
					else
						s_LOADING_DONE <= '1';
					end if;				
				end if;	
				
				AXI_IP2Bus_RdAck <= AXI_Bus2IP_RdCE;
				
				--if v_cnt_delay_ready >= 8 then
					s_READY <= '1';					
				--end if;
				
				if AXI_Bus2IP_WrCE = '1' then
					AXI_IP2Bus_WrAck <= '1';
					write_ack_count := write_ack_count + 1;
					count := true;
					if write_ack_count >= COLUMN_TOTAL*COLUMN_TOTAL then
						s_flag_WrData_Complete <= true;
					else
						s_flag_WrData_Complete <= false;
					end if;					
				else
					AXI_IP2Bus_WrAck <= '0';
					count := false;
				end if;
				
			elsif current_state = UNLOAD then
--				if count = true then
--					v_cnt_delay_ready := v_cnt_delay_ready + 1;
--				end if;
--				if v_cnt_delay_ready >= PIPELINE_DELAY then
--					s_READY <= '1';
--				end if;
--				
--				AXI_IP2Bus_WrAck <= AXI_Bus2IP_WrCE;
--				
--				if v_cnt_delay_ready >= (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then
--					s_UN_LOADING_DONE <= '1';
--				end if;
--				
--				if s_UN_LOADING_DONE = '1' then
--					AXI_IP2Bus_RdAck <= AXI_Bus2IP_RdCE;
--				else
--					AXI_IP2Bus_RdAck <= s_AXI_IP2Bus_RdAck;
--				end if;
				if write_ack_count >= COLUMN_TOTAL*COLUMN_TOTAL then--or s_READY = '0' then --if (s_G_WE or s_WE)= '1' or s_READY = '0' then--
					if v_cnt_delay_ready < PIPELINE_DELAY+4 then
						v_cnt_delay_ready := v_cnt_delay_ready + 1;						
					else
						s_UN_LOADING_DONE <= '1';
					end if;	
				else
					if v_cnt_delay_ready <= 3 then
						v_cnt_delay_ready := v_cnt_delay_ready + 1;
					end if;			
				end if;	
				
				AXI_IP2Bus_WrAck <= AXI_Bus2IP_WrCE;
				
				--if v_cnt_delay_ready >= 8 then
					s_READY <= '1';					
				--end if;
				
				if AXI_Bus2IP_RdCE = '1' then
					AXI_IP2Bus_RdAck <= '1';
					write_ack_count := write_ack_count + 1;
					count := true;
					if write_ack_count >= COLUMN_TOTAL*COLUMN_TOTAL then
						s_flag_WrData_Complete <= true;
					else
						s_flag_WrData_Complete <= false;
					end if;					
				else
					AXI_IP2Bus_RdAck <= '0';
					count := false;
				end if;
			elsif current_state = PG or current_state = PGt or current_state = PtG or current_state = PtGt then
				v_cnt_delay_ready := v_cnt_delay_ready + 1;
				if v_cnt_delay_ready >= (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then
					OP_DONE <= '1';
				end if;
				write_ack_count := 0;
				s_flag_WrData_Complete <= false;
				AXI_IP2Bus_RdAck <= AXI_Bus2IP_RdCE;
				AXI_IP2Bus_WrAck <= AXI_Bus2IP_WrCE;		
			else
				write_ack_count := 0;
				s_flag_WrData_Complete <= false;
				AXI_IP2Bus_RdAck <= AXI_Bus2IP_RdCE;
				AXI_IP2Bus_WrAck <= AXI_Bus2IP_WrCE;
				s_READY <= '0';
				s_LOADING_DONE <= '0';
				s_UN_LOADING_DONE <= '0';
				OP_DONE <= '0';
				v_cnt_delay_ready := 0;
			end if;
		end if;
end if;
cnt_delay_ready <= v_cnt_delay_ready;
g_cnt_delay_ready <= v_cnt_delay_ready;--write to global variable
end process;
-----------------------------------------------------------
process(CLK,s_flag_WrData_Complete)
variable i,j,v_load_count: integer range 0 to COLUMN_TOTAL;
variable v_CSEL : std_logic_vector(COLUMN_TOTAL-1 downto 0);
variable v_OPCODE: std_logic_vector(OPCODE_WIDTH-1 downto 0);
variable v_WE,v_WrAck: std_logic;
variable v_LOADING_DONE, v_OP_DONE, v_UNLOAD_DONE: std_logic:='0';
variable v_i_addr_cnt: integer range 0 to COLUMN_TOTAL;
variable proceed : boolean:=false;

begin
if (rising_edge(CLK)) then
	case current_state is
	
	when START =>
			i_row_cnt<=0;
			i_col_cnt<=0;
			i_addr_cnt <= 1;
		 	--count <= true;
			--AXI_IP2Bus_RdAck <= '1';
			G_EN <= '0';
			s_G_WE <= '0';
			s_WE <= '0';
			s_Wr_Ack <= '0';
			s_AXI_IP2Bus_RdAck <= '0';			
			--OP_DONE<='0';--reset the done signal
			v_OP_DONE := '0';--reset the done signal
			v_LOADING_DONE:='0';
			proceed := false;
			v_UNLOAD_DONE := '1';-- This is supposed to be set to '0' but it is ok because it is reset in the LOAD_DONE state. It was necessary to set it to '1' to prevent synthesis tool from optimizing it.
			CONTROL_A_INPUT_OF_DSP <= "00";--'0';
			i:=0;
			j:=0;
			Read_SHFT <='0';
			Write_SHFT <= '0';			
			OPCODE <= (others => '0');
			s_CSEL <= (others => '0'); 
			next_state<=LOAD_DONE; --next_state<=current_state;		
--				IF LOAD_PG = LOAD_G_CMD then
--					next_state<=LOAD_G;
--				ELSIF LOAD_PG = LOAD_P_CMD then
--					next_state <= LOAD_P;				
--				ELSE
--					next_state<=LOAD_DONE;
--				END IF;
					-----------------------------------
		when LOAD_G =>
			--AXI_IP2Bus_RdAck <= '1';
			if s_flag_WrData_Complete = false then--if v_LOADING_DONE = '0' then				
				v_WrAck := '0';
				if AXI_Bus2IP_WrCE = '1' then -- If AXI bus is signalling a write command then execute this. enable GRAM write enable.
					v_WE := '1';
					--count <= true;
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
					--count <= false;
				end if;			
			else				
--				if v_LOADING_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then -- wait until data gets to GRAM. 
--					proceed := true;					--count <= false;																	
--				end if;

				if  cnt_delay_ready = (PIPELINE_DELAY + 1) then -- wait until data gets to GRAM. 
					proceed := true;					--count <= false;																	
				end if;
				
				v_WrAck := '1';
				if proceed = true then
					if LOAD_PG = LOAD_G_CMD then
						next_state <= LOAD_G;--remain here untilt signal changes from load_g to load_p or something else.
					else
						next_state <= LOAD_DONE;
					end if;	
				end if;				
				v_WE := '0';
			end if;
			s_G_WE <= v_WE;
			s_Wr_Ack <= v_WrAck;
			i_row_cnt <= i-1;
			i_col_cnt <= j;
			s_v_LOADING_DONE <= v_LOADING_DONE;
			s_a <= i;
			s_b <= j;		
		when LOAD_P =>
				--AXI_IP2Bus_RdAck <= '1';
				OPCODE <="000";	-- Set DSP output to A input, the Data passes through DSP so we do not want to perform any operation on the data since we are just saving it on block RAM. (P = A)			
				if s_flag_WrData_Complete = false then --if v_LOADING_DONE = '0' then					
					v_LOADING_DONE := '0';
					v_WrAck := '0';
					if AXI_Bus2IP_WrCE = '1' then -- If AXI bus is signalling a write command then execute this. enable GRAM write enable.
						v_WE := '1';
						--count <= true;					
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
						--count <= false;
						v_WE := '0';
					end if;
				else
					
--					if v_LOADING_DONE = '1' and cnt_delay_ready = (PIPELINE_DELAY + COLUMN_TOTAL*COLUMN_TOTAL) then -- wait until gets to BRAM. 
--						--count <= false;
--						proceed := true;
--					end if;
					if  cnt_delay_ready = (PIPELINE_DELAY + 1) then -- wait until data gets to GRAM. 
						proceed := true;					--count <= false;																	
					end if;
					v_WrAck := '1';
					if proceed = true then
						if LOAD_PG = LOAD_P_CMD then
							next_state <= LOAD_P;--remain here untilt signal changes from load_g to load_p or something else.
						else
							next_state <= LOAD_DONE;
						end if;	
					end if;	
					
				end if;
				i_addr_cnt <= j;
				s_CSEL <= v_CSEL;
				s_WE <= v_WE;
				s_Wr_Ack <= v_WrAck;								
		when LOAD_DONE =>
				--AXI_IP2Bus_RdAck <= '1';
				i:=0;
				j:=0;
				--count <= true;
				s_WE <= '0';
				Write_SHFT <= '0';
				v_UNLOAD_DONE := '0';
				v_LOADING_DONE := '0';
				proceed := false;							
				s_CSEL <= (others => '1');--Enble BRAM for Saving multiplication result.		
				IF LOAD_PG = LOAD_G_CMD then
					next_state <= LOAD_G;
				elsif LOAD_PG = LOAD_P_CMD then					
					next_state <= LOAD_P;
				elsif LOAD_PG = IDLE_CMD then
					if UN_LOAD = '1' then
						next_state <= UNLOAD;
					else
						next_state <= LOAD_DONE;
					end if;
				else
					Write_SHFT <= '1';					
						G_EN <= '1'; -- Enable GRAM
						CONTROL_A_INPUT_OF_DSP <= "11";
						v_UNLOAD_DONE := '0';
						if (P='0') then
							if G='0' then
								next_state<=PG;
								i_addr_cnt<=COLUMN_TOTAL-1;
								i_row_cnt<=1;
								i_col_cnt<=0;
								Read_SHFT <='1';							
								OPCODE<="001";
							else
								next_state<=PGt;
								Read_SHFT <='1';							
								i_addr_cnt<=COLUMN_TOTAL-1;
								i_row_cnt<=0;
								i_col_cnt<=1;
								OPCODE<="001";
							end if;
						else
							if G='0' then
								next_state<=PtG;
								Read_SHFT <='0';							
								i_addr_cnt<=1;
								i_row_cnt<=1;
								i_col_cnt<=0;
								OPCODE<="001";
							else
								next_state<=PtGt;
								Read_SHFT <='0';
								i_addr_cnt<=1;
								i_row_cnt<=0;
								i_col_cnt<=1;
								OPCODE<="001";
							end if;
						end if;
					end if;
		when PG =>
					v_OPCODE :="011";
					s_WE <='0';					
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
							i_row_cnt <= 1 + j;	-- nwzr G Row
							
							if j = COLUMN_TOTAL then -- Check G Col
								i_col_cnt<=j-1;
							end if;
							if ((i_row_cnt+1)>=COLUMN_TOTAL-1) then		-- G row
								i_row_cnt<=0;
							end if;
							i_addr_cnt<=COLUMN_TOTAL-1-j;
							i:=0;
							v_OPCODE := "001";
						else
							i:=i+1;
							if i = COLUMN_TOTAL-1 then
								s_WE<='1';								
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
							next_state<=DONE;
							v_OPCODE := "111";
						end if;
					end if;
					OPCODE<= v_OPCODE; --"111";
			when PGt=>
					v_OPCODE :="011";
					s_WE <='0';					
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
							i_col_cnt <= 1 + j;	--  G Col
							i_row_cnt<=i_row_cnt+1;			-- next G row
							if j = COLUMN_TOTAL then -- Check G Row
								i_row_cnt<=j-1;
							end if;
							if ((i_col_cnt+1)>=COLUMN_TOTAL-1) then		-- G Column
								i_col_cnt<=0;
							end if;
							i_addr_cnt<=COLUMN_TOTAL-1-j;
							i:=0;
							v_OPCODE := "001";
						else
							i:=i+1;
							if i = COLUMN_TOTAL-1 then
								s_WE<='1';								
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
							next_state<=DONE;
							v_OPCODE := "111";
						end if;
					end if;
					OPCODE<= v_OPCODE; --"111";
			when PtG=>
					v_OPCODE :="011";
					s_WE <='0';					
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
							i_row_cnt <= 1 + j;	-- G Row
							if j = COLUMN_TOTAL then -- Check G Col
								i_col_cnt<=j-1;
							end if;
							if ((i_row_cnt+1)>=COLUMN_TOTAL-1) then		-- G row
								i_row_cnt<=0;
							end if;
							if j=COLUMN_TOTAL-1 then									--- P addr
								i_addr_cnt<=0;
							else
								i_addr_cnt<=j+1;
							end if;
							i:=0;
							v_OPCODE := "001";
						else
							i:=i+1;
							if i = COLUMN_TOTAL-1 then
								s_WE<='1';								
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
							next_state<=DONE;
							v_OPCODE := "111";
						end if;
					end if;
					OPCODE<= v_OPCODE; --"111";
			when PtGt =>
					v_OPCODE :="011";
					s_WE <='0';					
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
								s_WE<='1';								
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
							next_state<=DONE;
							v_OPCODE := "111";
						end if;
					end if;
					OPCODE<= v_OPCODE; --"111";
			when DONE =>
					G_EN <= '0';
					s_WE<='0';
					Read_SHFT <= '0';					
					--OP_DONE<='0';
--					v_OP_DONE := '0';
--					v_UNLOAD_DONE := '0';	
					i:=0;
					j:=0;
					if LOAD_PG = PG_CMD then
						next_state <= DONE;
					else
						next_state <= LOAD_DONE;
					end if;

			when others =>				
				--s_fsm_generate_address <= true;
				if s_flag_WrData_Complete = false then--if v_UNLOAD_DONE = '0' then
					CONTROL_A_INPUT_OF_DSP <= "01";--'1';
					if AXI_Bus2IP_RdCE = '1' then
						--count <= true;
						if j > COLUMN_TOTAL then -- J = 0 initially.
							v_UNLOAD_DONE := '1';
							v_OP_DONE := '1';
							v_OPCODE := "111"; --Do nothing.
						else
							if i = 0 then
								v_OPCODE := "101";-- P = B*A. Note A = 1 so P = B.
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
						s_AXI_IP2Bus_RdAck <= '1';
					else
						--count <= false;
						s_AXI_IP2Bus_RdAck <= '0';
					end if;					
				else
					CONTROL_A_INPUT_OF_DSP <= "00";--'0';
					v_OP_DONE := '0';
					v_OPCODE := "111";
					v_UNLOAD_DONE := '1';
					--count <= false;
					if UN_LOAD = '1' then
						next_state <= UNLOAD;
					else
						next_state <= LOAD_DONE;
					end if;
				end if;
				OPCODE<= v_OPCODE;
				i_addr_cnt <= j-1;											
	end case;
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
				G_COLUMN<=std_logic_vector(to_unsigned(i_col_cnt,COLUMN_TOTAL));
				CSEL <= s_CSEL;



							
-----------------------------------------------------------
end Behavioral;

