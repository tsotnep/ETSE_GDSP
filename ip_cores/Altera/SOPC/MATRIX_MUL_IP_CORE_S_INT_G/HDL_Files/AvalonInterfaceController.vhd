Library IEEE;
Use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

USE work.MATRIX_MUL_IP_CORE_LIBRARY.all;

entity AvalonInterfaceController is
generic( 
		AVALON_DATA_WIDTH: natural:=32; 
		NUM_OF_8_BIT_REGISTERS : natural:=16;
		WRITE_DATA_CAPTURE_CYCLE: natural:=1; -- number of cycles before write data is saved in register
		--ADDR_WIDTH: natural:=32;
		COLUMN_TOTAL    : integer := 10;
		OPCODE_WIDTH    : integer := 3;
		ADDR_WIDTH      : integer := 5;
		DATA_WIDTH      : integer := 18;
		DATA_WIDE_WIDTH : integer := 48
);
port(
	---------------General Signals--------------
	clk 		: in std_logic;
	rst			: in std_logic;
	--cmd			: in std_logic_vector(7 downto 0);	

	-----IP Core Signals, Flags Control and Communication-----
	status		: out rt_Status;
	--------To Avalon Interconnect-----------------
	waitrequest	: out std_logic;
	--to_Bus_WrAck	: out std_logic;
	--readdatavalid : out std_logic;
	--response		: out std_logic;
	--byteenable : in std_logic_vector(NUM_OF_8_BIT_REGISTERS-1 downto 0);
	read 		: in std_logic;
	write		: in std_logic;
	readdata	: out std_logic_vector(AVALON_DATA_WIDTH-1 downto 0);
	writedata	: in std_logic_vector(AVALON_DATA_WIDTH-1 downto 0);
	address		: in std_logic_vector(1 downto 0);
	
	----------------------------------------------
	chip_select: in std_logic;
	byteenable : in std_logic_vector((AVALON_DATA_WIDTH/8)-1 DOWNTO 0);
	
	q_status : out std_logic_vector(7 downto 0);
	q_config : out std_logic_vector(7 downto 0)
	--d_out	: out std_logic_vector(5 downto 0)
	
	-----------------------------------------------	
);
end entity;

Architecture Behave of AvalonInterfaceController is
	
type state_type is (IDLE,LOAD_G,LOAD_P,UN_LOAD_P,P_G);
signal current_state, next_state: state_type:=IDLE; 
--signal s_reg_flags: std_logic_vector(7 downto 0);
--signal timing_counter: integer range 0 to 20:=0;
--signal start_count: boolean:="false";

-------------------Registers---------------------------------
signal r_DIN, r_DOUT : std_logic_vector(AVALON_DATA_WIDTH-1 downto 0);
signal r_Config, r_Status: std_logic_vector(7 downto 0);

---------------------Internal Flags-------------------------

signal rf_DIN_latched: boolean:=false;
signal rf_trigger_read_data_valid: boolean:= false;
signal rf_IP_has_Ack_Read: boolean:= false;
signal rf_s_counter_overflow: boolean:=false;
--signal f_bus_write_is_still_asserted : boolean:= true;
signal f_reset_counter2: boolean:= false;
signal f_pause_counter2: boolean:= false;

signal f_status_ready: std_logic:='0';
signal f_status_busy : std_logic:= '1';

------------------------Counters---------------------------
signal s_counter : integer range 0 to 3:=0;
signal s_counter2: integer range 0 to 3:=0;
------------------------Signals-----------------------------

--------------------Internal enable signals--------------------------
signal cb_DIN_en: std_logic:='0';

------------------ IP  signals------------------
signal s_to_IP_WrCE	: STD_LOGIC:='0';
signal s_to_IP_RdCE	: STD_LOGIC:='0';

signal s_waitrequest	: STD_LOGIC:='0';
signal s_readdatavalid		: STD_LOGIC:='0';
signal s_from_IP_WrAck	: STD_LOGIC;
signal s_from_IP_RdAck	: STD_LOGIC;
signal s_from_IP_WrEn_R_DOUT: STD_LOGIC;
signal r_s_from_IP_WrEn_R_DOUT: STD_LOGIC;
signal r_s_data_ready, s_data_has_been_read : STD_LOGIC;
--signal rf_s_from_IP_WrAck: std_logic;
--signal pf_s_from_IP_WrAck: std_logic;
signal s_r_DOUT			: std_logic_vector(DATA_WIDTH-1 downto 0);
signal s_r_DIN			: std_logic_vector(DATA_WIDTH-1 downto 0);

signal cmd_ip_RST		    :std_logic;
signal cmd_LOAD_PG         :std_logic_vector(1 downto 0);
signal cmd_UN_LOAD         :std_logic;
signal cmd_P               :std_logic;
signal cmd_G		        :std_logic;
signal cmd_Bank_sel_in		: std_logic;
--alias alias_cmd_Bank_sel_in		: std_logic is r_config(3);


signal f_ip_READY		    :std_logic;
signal f_ip_OP_DONE        :std_logic;
signal f_ip_LOADING_DONE   :std_logic;
signal f_ip_UN_LOADING_DONE	:std_logic;




--------------------General Signals-------------------------

----------------Bus Acknowledge signals---------------------
--signal s_waitrequest : STD_LOGIC:='0';

-------------------Gated Bus Signals-----------------------
signal write_gated: std_logic;
signal read_gated: std_logic;
--signal i_write: std_logic; --internal global signal for all circuits that use write to eliminate inconsistency.
alias alias_write: std_logic is write_gated;
alias alias_read: std_logic is read_gated;
signal s_wait_condition : std_logic;
signal s_write_condition : std_logic;
signal s_read_condition	: std_logic;
signal s_readdatavalid2 : std_logic;
-----------------------------------------------------------

begin
	
-----------------------------------Concurrent Statements------------------------------------------------

write_gated <= '1' when write = '1' else '0';-- for gating write and introducing delay.
read_gated <= '1' when read = '1' else '0';-- for gating read and introducing delay.

--q_status(6 downto 0) <= r_status(6 downto 0);
--q_status(7) <= s_waitrequest;

q_status <= std_logic_vector(to_unsigned(g_cnt_delay_ready,8));

--d_out <= r_DOUT(5 downto 0);

q_config(6 downto 0) <= r_config(6 downto 0);
q_config(7) <= s_readdatavalid2;


-------------------------------------Avalon Interface to IP-----------------------------
--s_from_IP_WrAck <= from_IP_WrAck;
--to_IP_WrCE <= s_to_IP_WrCE;
--DOUT <= r_DIN(17 downto 0);

s_to_IP_WrCE <= '0' when s_from_IP_WrAck = '1' else '1' when (cb_DIN_en = '0') and (rf_DIN_latched = true) else '0';

s_to_IP_RdCE <= '0' when s_from_IP_RdAck = '1' else '1' when (s_read_condition = '1' and address = "11") and (s_counter = 0 and rf_s_counter_overflow = false) else '0';

s_r_DIN <= r_DIN(17 downto 0);

-------------------------------Avalon Interface to Interconnect-----------------------
s_readdatavalid <= '1' when s_from_IP_WrEn_R_DOUT = '0' and rf_trigger_read_data_valid = true and s_read_condition = '1' else '0';--else '1' when alias_read = '1' and s_read_condition = '1' else '0';
--readdatavalid <= s_readdatavalid2;

--waitrequest <= '1' when rst = '1' else '0' when  (s_from_IP_WrAck = '1' or s_from_IP_WrEn_R_DOUT = '1' or rf_IP_has_Ack_Read = true)  else '1' when alias_write = '1' or alias_read = '1' else '0';

--waitrequest <= '0' when s_from_IP_WrAck = '1' or (s_from_IP_WrEn_R_DOUT = '1' or s_readdatavalid = '1') else '1' when alias_write = '1' or alias_read = '1';

--waitrequest <= '0' when s_from_IP_WrAck = '1' or s_from_IP_WrEn_R_DOUT = '1' else '1' when alias_write = '1' or alias_read = '1';

s_wait_condition <= (s_from_IP_WrAck  or s_from_IP_WrEn_R_DOUT);

s_write_condition <= chip_select and alias_write;
s_read_condition <= chip_select and alias_read;
waitrequest <= s_waitrequest;


readdatavalid_process: process(s_read_condition, address, read_gated, s_readdatavalid)
begin
	if s_read_condition = '1' then
		if address = "11" then			
				s_readdatavalid2 <= '1';			
		else
			s_readdatavalid2 <= '1';
		end if;
	else
		s_readdatavalid2 <= '0';
	end if;
end process;

--readdatavalid_process: process(clk)
--begin
--
----		s_readdatavalid2 <= '1';
--		if rising_edge(clk) then
--			if s_read_condition = '1' then
--				if address = "11" then
--					--if rf_trigger_read_data_valid = true then
--						s_readdatavalid2 <= '1';
--					--end if;
--				else
--					s_readdatavalid2 <= '1';
--				end if;
--			else
--				s_readdatavalid2 <= '0';
--			end if;
--		end if;
--
--end process;


wait_Request_Process: process(address, read_gated, rf_IP_has_Ack_Read, rst, s_wait_condition, write_gated)
begin

if rst = RESET_ACTIVE_LOGIC then
	s_waitrequest <= '1';
else
	if address = "10" then --r_DIN register
		if s_wait_condition = '1' or rf_IP_has_Ack_Read = true then
			s_waitrequest <= '0';
		elsif alias_write = '1' then
			s_waitrequest <= '1';
		else
			s_waitrequest <= '0';
		end if;
	elsif address = "11" then --r_DOUT register
		if s_wait_condition = '1' or rf_IP_has_Ack_Read = true then
			s_waitrequest <= '0';
		elsif alias_read = '1'  then
			s_waitrequest <= '1';
		else
			s_waitrequest <= '0';
		end if; 
	else
		s_waitrequest <= '0';
	end if;
end if;	
	
end process;

------------------------------------Avalon Status Flags---------------------------------------

	status.READY <= r_status(0);
	status.BUSY <= r_status(1);
	status.LOADING_DONE <= r_status(2);
	status.OP_DONE <= r_status(3);
	status.UN_LOADING_DONE <= r_status(4);
	
-----------------------------------Avalon Config Flags---------------------------------------

	cmd_Bank_sel_in	<= r_config(3);
	cmd_P 	<= r_config(4);
	cmd_G	<= r_config(5);
	


--------------------------------Special Avalon flags-----------------------------------


--special_flags_process: process(clk,alias_write)
--begin
--	if alias_write = '0' then -- to_bus_WrAck is configured as a register with asynchronous reset and synchronous enable signals.
--		to_Bus_WrAck <= '0';
--	elsif rising_edge(clk) then
--		if s_from_IP_WrAck = '1' then--pf_s_from_IP_WrAck = '1' then
--			to_Bus_WrAck <= '1';
--		end if;
--	end if;
--end process;

process(clk,s_to_IP_RdCE)--(clk,rst,s_to_IP_RdCE)
begin
		if  s_to_IP_RdCE = '1' then--if rst = RESET_ACTIVE_LOGIC or s_to_IP_RdCE = '1' then
			rf_IP_has_Ack_Read <= false;
		elsif rising_edge(clk) then
			if s_from_IP_WrEn_R_DOUT = '1' then
				rf_IP_has_Ack_Read <= true;
			end if;
		end if;
end process;
--------------------------------------------------------------------------------------
	

IP: entity work.MATRIX_MUL_IP_CORE_S_INT_G
	generic map(
		BURST_ACCESS => true,		
		COLUMN_TOTAL  => COLUMN_TOTAL,
		OPCODE_WIDTH => OPCODE_WIDTH,
		ADDR_WIDTH => ADDR_WIDTH,
		DATA_WIDTH => DATA_WIDTH,
		DATA_WIDE_WIDTH => DATA_WIDE_WIDTH
	)
	Port map(
		SingleWrCE	=> s_to_IP_WrCE,
		SingleWrAck => s_from_IP_WrAck,
		SingleRdCE	=> s_to_IP_RdCE,
		SingleRdAck	=> s_from_IP_RdAck,
		WrEn_R_DOUT => s_from_IP_WrEn_R_DOUT,
	     CLK   => CLK,
		 RST   => cmd_ip_RST,
		 LOAD_PG  => cmd_LOAD_PG,
		 UN_LOAD  => cmd_UN_LOAD,
		 P  => cmd_P,
		 G  => cmd_G,		 
		 Bank_sel_in => cmd_Bank_sel_in,		
		 DIN => s_r_DIN, --r_DIN,
		 DOUT => s_r_DOUT,
		 READY	=> f_ip_READY,		 
		 OP_DONE => f_ip_OP_DONE,
		 LOADING_DONE => f_ip_LOADING_DONE,
		 UN_LOADING_DONE => f_ip_UN_LOADING_DONE
	);
	
Avalaon_Writable_Registers_Write_Process: process(clk)
begin
	if rising_edge(clk) then
		if rst = RESET_ACTIVE_LOGIC then
			r_DIN <= (others => '0');
			rf_DIN_latched <= false;
			r_Config <= (others => '0');
		else
			case address is
				when "00" =>
--					for byte_enable in 0 to 3 loop
--						if byteenable(byte_enable) = '1' then
--							r_Config(byte_enable*8+7 downto byte_enable*8) <= writedata(byte_enable*8+7 downto byte_enable*8);
--						end if;
--					end loop;
					if byteenable(0) = '1' and s_write_condition = '1'  then
						r_config <= writedata(7 downto 0);
					end if;
					
				when "10" =>
						---------------------------Data Input register--------------------------------------		
--			if rst = RESET_ACTIVE_LOGIC then
--				r_DIN <= (others => '0');
--				rf_DIN_latched <= false;--notify that a new data has not been captured yet into r_DIN register.
--					if cb_DIN_en = '1' then -- if enable is asserted then register the input data to r_DIN.
--						r_DIN <= writedata;
--						rf_DIN_latched <= true;--notify that valid GRAM data has been saved into r_DIN register.
--					elsif s_from_IP_WrAck = '1' then	-- if IP asserts acknowledge signal then reset the flag so it can be used for the next data capture in to r_DIN register.		
--						rf_DIN_latched <= false;--notify that a new data has not been captured yet into r_DIN register.
--					end if;
			
				for byte_enable in 0 to 3 loop
					if cb_DIN_en = '1' then
						if byteenable(byte_enable) = '1' and s_write_condition = '1' then
							r_DIN(byte_enable*8+7 downto byte_enable*8) <= writedata(byte_enable*8+7 downto byte_enable*8);
						end if;
					end if;					
				end loop;
				
				if cb_DIN_en = '1' then
					rf_DIN_latched <= true;--notify that valid GRAM data has been saved into r_DIN register.
				elsif s_from_IP_WrAck = '1' then
					rf_DIN_latched <= false;--notify that a new data has not been captured yet into r_DIN register.
				end if;
			
				when others =>
			-------------------------------Config register----------------------------------	
			
			
			end case;
		end if;
	end if;
end process;
	
	
Un_writable_Register_Write_Process: process(clk)
Begin
	if rising_edge(clk) then
--		if rst = RESET_ACTIVE_LOGIC then
--			r_DOUT<=(others => '0');
--			r_s_from_IP_WrEn_R_DOUT <= '0';
--			
--		else

------------------------Data Output register------------------------------------		
		
--			if rst = RESET_ACTIVE_LOGIC then
--				r_DOUT<=(others => '0');
--				r_s_from_IP_WrEn_R_DOUT <= '0';
--			else
				if s_from_IP_WrEn_R_DOUT = '1' then
					r_DOUT <= "00" & X"000" & s_r_DOUT;
				end if;
--			end if;
		
--			if s_read_condition = '0'  then
--				rf_trigger_read_data_valid <= false;
			if s_from_IP_WrEn_R_DOUT = '1' then
				rf_trigger_read_data_valid <= true;
			elsif s_readdatavalid = '1' then
--				rf_trigger_read_data_valid <= false;
			end if;
	
			if s_from_IP_WrEn_R_DOUT = '1' then
				r_s_data_ready <= '1';
			elsif s_to_IP_RdCE = '1' then
				r_s_data_ready <= '0';
			end if;

		
		-- r_s_from_IP_WrEn_R_DOUT is used as a trigger for readdatavalid. From the timing diagram of a read transaction
		---- r_s_from_IP_WrEn_R_DOUT should be asserted for one clock cycle immediately the read signal is de-asserted
		-- Since valid data will be captured in r_DOUT when s_from_IP_WrEn_R_DOUT is asserted, by registering s_from_IP_WrEn_R_DOUT
		-- we create a delay of 1 clock cycle which is can serve as readdatavalid signal.		
			r_s_from_IP_WrEn_R_DOUT <= s_from_IP_WrEn_R_DOUT; 

		
--		 READY	=> f_ip_READY,		 
--		 OP_DONE => f_ip_OP_DONE,
--		 LOADING_DONE => f_ip_LOADING_DONE,
--		 UN_LOADING_DONE => f_ip_UN_LOADING_DONE

			r_status(0) <= f_status_ready;
			r_status(1) <= f_status_busy;
			
			r_status(2) <= f_ip_LOADING_DONE;
			r_status(3) <= f_ip_OP_DONE;		
			r_status(4) <= f_ip_UN_LOADING_DONE;
			r_status(5) <= r_s_data_ready;
			
			r_status(7 downto 6) <= (others => '0');
	--	end if;
	end if;
end process;


Avalon_Register_Read_Process: process(address, r_config, r_status, r_DIN, r_DOUT)
begin
	s_data_has_been_read <= '0';
	case address is
		when "00" =>
			readdata <= X"000000" & r_config;
		when "01" =>
			readdata <= X"000000" & r_status;			
		when "10" =>
			readdata <= r_DIN;
		when "11" =>
			readdata <= r_DOUT;
			s_data_has_been_read <= '1';
		when others =>
			readdata <= (others => '0');
	end case;
end process;


	
To_IP_Sequential_Process:process(clk)
begin
	
--	if rst = RESET_ACTIVE_LOGIC then
--		s_counter <= 0;
--		rf_s_counter_overflow <= false;
	if rising_edge(clk) then			
	
		if rst = RESET_ACTIVE_LOGIC then --Apart from whe the reset is asserted "f_s_counter_overflow <= false" will only be set to false when the "write" signal goes low. remember this.
			s_counter <= 0;
			rf_s_counter_overflow <= false;
		elsif alias_write = '1' then --elsif s_waitrequest = '1' then		
			if s_counter = 3 then
				s_counter <= 0;
				rf_s_counter_overflow <= true;
			else
				s_counter <= s_counter + 1;
			end if;
		elsif alias_read = '1' then			
			if s_counter = 3 then
				s_counter <= 0;
				rf_s_counter_overflow <= true;
			else
				s_counter <= s_counter + 1;
			end if;
		else
			s_counter <= 0;
			rf_s_counter_overflow <= false;
		end if;


		
		-- using "s_waitrequest" instead of "write" is thesame except that when "write" is 
		-- used, due to synchronization issues, the simulator does not notice a change of "write"
		-- from '1' to '0' if write changes within 1 clk cycle. Because of this "rf_s_from_IP_WrAck"
		-- remains at logic '1' and fails to reset to logic '0' when "write" changes to logic '0'.
		-- By using "s_waitrequest" which is dependent on "write" we solve this problem.
		-- "s_waitrequest" introduces propagation delay into the write signal it depends on so this
		-- delay is enough for the simulator to see the change and react even though the change is 
		-- within 1 clk cycle. Take note of this phenomenom.
--		if rst = RESET_ACTIVE_LOGIC or alias_write	 = '0' then --if rst = '1' or s_waitrequest = '0' then --if rst = '1' or write = '0' then
--			rf_s_from_IP_WrAck <= '0';
--		elsif s_from_IP_WrAck = '1' then
--			rf_s_from_IP_WrAck <= '1';
--		end if;
		
-----------------------Uncomment if you you want "s_to_IP_WrCE"	to be active for 2 clk cycles -------------------------	
--		if s_from_IP_WrAck = '1' then-- as soon as IP acknowledges, s_to_IP_WrCE is set to '0'.
--			s_to_IP_WrCE <= '0';	--signal "rf_DIN_latched" should also be set to false from above because of this same acknowledge. if not then race condition problem.
--		else						-- assuming everything is fine then signal s_to_IP_WrCE should reset to logic '0'.
--			if cb_DIN_en = '0' and rf_DIN_latched = true then -- fire WrCE to the IP because data is now ready for it. data is now present in r_DIN register.
--				s_to_IP_WrCE <= '1';					
--			else
--				s_to_IP_WrCE <= '0';
--			end if;
--		end if;
		
	end if;
end process;


--To_Bus_Sequential_Process: process(clk)
--begin
--	if rising_edge(clk) then
----------------------------Registered flags or signals. Here I am just taking advantage of the clock in the process instead of creating a new process------------
--		pf_s_from_IP_WrAck <= s_from_IP_WrAck; -- THis is just to delay the IP acknowledge for 1 clk cycle.
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--		
--	
--	end if;
--end process;


Internal_Combinational_Process: Process(alias_write,s_counter,rf_DIN_latched, address)
begin
	
	cb_DIN_en <= '0';
	if alias_write = '1' and address = "10" then--if write = '1' then
		if s_counter = WRITE_DATA_CAPTURE_CYCLE and rf_DIN_latched = false then--if r_DIN has not be written to then enable write access.
			cb_DIN_en <= '1'; -- THis line of code will not run if data has been saved in register.
		end if;				-- utimatly further writing to the register will be disabled beacause.
	end if;			-- of the rf_DIN_latched flag which will be true when DIN receives data.
end process;


	
--To_Bus_Combinational_Process:process(alias_write,alias_read,s_from_IP_WrAck,rf_IP_has_Ack_Read,s_from_IP_WrEn_R_DOUT)-- process(alias_write,rf_s_from_IP_WrAck)
--
--begin
--	
--	
--	if alias_write = '1' then--if write = '1' then
--		-- use the unregistered flag "s_from_IP_WrAck" for normal bus write signal but if you cannot gaurantee the bus write signals
--		--or you do not trust that the timing is fixed then use the registered flag "rf_s_from_IP_WrAck". This will ensure that the
--		--Avalon interface will keep the IP idle until the write signal is de-asserted and asserted again.
--		if s_from_IP_WrAck = '1' then --if rf_s_from_IP_WrAck = '1' then --
--			s_waitrequest <= '0';
--		else
--			s_waitrequest <= '1';
--		end if;
--	elsif alias_read = '1' then
--		if s_from_IP_WrEn_R_DOUT = '1' or rf_IP_has_Ack_Read = true then --if s_from_IP_WrEn_R_DOUT = '1' then
--			s_waitrequest <= '0';
--		else
--			s_waitrequest <= '1';
--		end if;
--	else
--		s_waitrequest <= '0';
--	end if;
--	
--end process;


fsm_process_sequential: process(clk,rst)
begin
	if rising_edge(clk) then
		if rst = RESET_ACTIVE_LOGIC then
			current_state <= IDLE;
		else --rising_edge(clk) then
			current_state <= next_state;
		end if;
	end if;
end process;


fsm_process_combinational:process(current_state,r_Config)
variable v_cmd: std_logic_vector(2 downto 0):="000";
begin
	v_cmd := r_Config(2 downto 0);
	case current_state is
		when IDLE =>			
			if v_cmd = "000" then
				next_state <= IDLE;
			elsif v_cmd = "001" then
				next_state <= LOAD_G;
			elsif v_cmd = "010" then
				next_state <= LOAD_P;
			elsif v_cmd = "011" then
				next_state <= UN_LOAD_P;
			else
				next_state <= P_G;
			end if;
		when LOAD_G =>
			if v_cmd = "000" then
				next_state <= IDLE;
			else
				next_state <= LOAD_G;
			end if;
		when LOAD_P => 
			if v_cmd = "000" then
				next_state <= IDLE;
			else
				next_state <= LOAD_P;
			end if;
		when UN_LOAD_P =>
			if v_cmd = "000" then
				next_state <= IDLE;
			else
				next_state <= UN_LOAD_P;
			end if;
		when others =>
			if v_cmd = "000" then
				next_state <= IDLE;
			else
				next_state <= P_G;
			end if;
	end case;
end process;


counter_2: process(clk, f_reset_counter2) 
begin 

	if f_reset_counter2 = true then -- if f_reset_counter2 = true or s_counter2 = 4 then -- try if this will work
			s_counter2 <= 0;
	elsif rising_edge(clk) then
		if s_counter2 = 3 then
			s_counter2 <= 0;
		else
			if f_pause_counter2 = false then -- if f_pause_coubter2 is true then the count will pause
				s_counter2 <= s_counter2 + 1;
			end if;
		end if;
	end if;
end process;

process(current_state,s_counter2,f_ip_READY)
	variable v_has_cmd_executed: boolean:=false;
Begin
	-----------Defualt values--------------
		f_reset_counter2 <= true;
		f_status_ready <= '0';-- Avalon IP by default will not be ready in any other state except the IDLE state.
		--f_status_busy <= '1';
		cmd_ip_rst <= RESET_ACTIVE_LOGIC; -- reset the IP
		cmd_LOAD_PG <= LOAD_NOTHING;
		cmd_UN_LOAD <= '0';
	--------------------------------------
	
	case current_state is		

		
		when IDLE =>
			f_status_ready <= '1';
			f_status_busy <= not(f_ip_READY);
			v_has_cmd_executed := false;
			f_reset_counter2 <= true;
			f_pause_counter2 <= false;
			cmd_ip_rst <= RESET_ACTIVE_LOGIC;--'1'; -- reset the IP
			cmd_LOAD_PG <= LOAD_NOTHING;
			cmd_UN_LOAD <= '0';
		when LOAD_G =>
			--The Avalon busy-flag is set to busy (logic '1') until Matrix_mul_IP asserts its busy Ready signal	
					
			f_status_busy <= not(f_ip_READY); -- when Matrix_mul_IP is ready then the busy flag is cleared
			f_reset_counter2 <= false;
			cmd_LOAD_PG <= LOAD_G_CMD;
			cmd_UN_LOAD <= '0';
			cmd_ip_rst <= RESET_NOT_ACTIVE_LOGIC;
--			if s_counter2 = 1 then --After 2 clock circles release the reset button
--				f_pause_counter2 <= true;--pause the counter so that it remains at 2, this will ensure that this logic remains valid until the state changes.
--				cmd_ip_rst <= RESET_NOT_ACTIVE_LOGIC;--release the MATRIX_MUL_IP_CORE reset.
--			else
--				f_pause_counter2 <= false;
--				cmd_ip_rst <= RESET_ACTIVE_LOGIC;--keep reset active for 2 clock cycles
--			end if;
			
		when LOAD_P =>
			f_status_busy <= not(f_ip_READY); -- when Matrix_mul_IP is ready then the busy flag is cleared
			f_reset_counter2 <= false;
			cmd_LOAD_PG <= LOAD_P_CMD;
			cmd_UN_LOAD <= '0';
			cmd_ip_rst <= RESET_NOT_ACTIVE_LOGIC;
--			if s_counter2 = 1 then --After 2 clock circles release the reset button
--				f_pause_counter2 <= true;--pause the counter so that it remains at 2, this will ensure that this logic remains valid until the state changes.
--				cmd_ip_rst <= RESET_NOT_ACTIVE_LOGIC;--release the MATRIX_MUL_IP_CORE reset.
--			else
--				f_pause_counter2 <= false;
--				cmd_ip_rst <= RESET_ACTIVE_LOGIC;--keep reset active for 2 clock cycles
--			end if;
		when UN_LOAD_P =>
			f_status_busy <= not(f_ip_READY); -- when Matrix_mul_IP is ready then the busy flag is cleared
			f_reset_counter2 <= false;
			cmd_LOAD_PG <= LOAD_NOTHING; --disable loading.
			cmd_UN_LOAD <= '1';--enable un_load mode.
			cmd_ip_rst <= RESET_NOT_ACTIVE_LOGIC;--keep reset active for 2 clock cycles
		when others =>
			f_status_busy <= not(f_ip_READY); -- when Matrix_mul_IP is ready then the busy flag is cleared
			f_reset_counter2 <= false;
			cmd_LOAD_PG <= LOAD_NOTHING;
			cmd_UN_LOAD <= '0';
			cmd_ip_rst <= RESET_NOT_ACTIVE_LOGIC;
--			if s_counter2 = 2 then --After 2 clock circles release the reset button
--				f_pause_counter2 <= true;--pause the counter so that it remains at 2, this will ensure that this logic remains valid until the state changes.
--				cmd_ip_rst <= RESET_NOT_ACTIVE_LOGIC;--release the MATRIX_MUL_IP_CORE reset.
--			else
--				f_pause_counter2 <= false;
--				cmd_ip_rst <= RESET_ACTIVE_LOGIC;--keep reset active for 2 clock cycles
--			end if;
		 
	end case;
	
end process;

end Behave;
