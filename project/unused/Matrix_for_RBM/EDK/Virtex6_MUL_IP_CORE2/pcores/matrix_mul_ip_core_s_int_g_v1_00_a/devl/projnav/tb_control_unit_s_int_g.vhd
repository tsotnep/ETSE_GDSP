--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:25:14 08/12/2015
-- Design Name:   
-- Module Name:   C:/FPGA/Internship_Jobs/Codes/ETSE_GDSP/Matrix_for_RBM/EDK/Virtex6_MUL_IP_CORE/pcores/matrix_mul_ip_core_s_int_g_v1_00_a/devl/projnav/tb_control_unit_s_int.vhd
-- Project Name:  matrix_mul_ip_core_s_int_g
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL_UNIT_S_INT_G
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

use ieee.math_real.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY tb_control_unit_s_int_g IS
generic(
		ADDR_WIDTH   : integer := 10;
		DATA_WIDTH	 :integer:=18;
		OPCODE_WIDTH : integer := 3;
		COLUMN_TOTAL : integer := 4);
END tb_control_unit_s_int_g;
 
ARCHITECTURE behavior OF tb_control_unit_s_int_g IS 
 
   --Inputs
   signal AXI_Bus2IP_WrCE : std_logic := '0';
   signal AXI_Bus2IP_RdCE : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal LOAD_PG : std_logic_vector(1 downto 0) := (others => '0');
   signal UN_LOAD : std_logic := '0';
   signal P : std_logic := '0';
   signal G : std_logic := '0';

 	--Outputs
   signal AXI_IP2Bus_RdAck : std_logic;
   signal AXI_IP2Bus_WrAck : std_logic;
   signal WE : std_logic;
   signal CSEL : std_logic_vector(COLUMN_TOTAL -1 downto 0);
   signal Read_ADDR : std_logic_vector(8 downto 0);
   signal Write_ADDR : std_logic_vector(8 downto 0);
   signal Read_SHFT : std_logic;
   signal Write_SHFT : std_logic;
   signal OPCODE : std_logic_vector(OPCODE_WIDTH-1 downto 0);
   signal G_ROW : std_logic_vector(9 downto 0);
   signal G_COLUMN : std_logic_vector(COLUMN_TOTAL-1 downto 0);
   signal G_WE : std_logic;
   signal G_EN : std_logic;
   signal READY : std_logic;
   signal OP_DONE : std_logic;
   signal LOADING_DONE : std_logic;
   signal UN_LOADING_DONE : std_logic;
   signal CONTROL_A_INPUT_OF_DSP : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut:entity work.CONTROL_UNIT_S_INT_G
	generic map(
		ADDR_WIDTH  => ADDR_WIDTH,
		DATA_WIDTH	=> DATA_WIDTH,
		OPCODE_WIDTH => OPCODE_WIDTH,
		COLUMN_TOTAL => COLUMN_TOTAL
		)
	
	PORT MAP (
          AXI_Bus2IP_WrCE => AXI_Bus2IP_WrCE,
          AXI_Bus2IP_RdCE => AXI_Bus2IP_RdCE,
          AXI_IP2Bus_RdAck => AXI_IP2Bus_RdAck,
          AXI_IP2Bus_WrAck => AXI_IP2Bus_WrAck,
          CLK => CLK,
          RST => RST,
          LOAD_PG => LOAD_PG,
          UN_LOAD => UN_LOAD,
          P => P,
          G => G,
          WE => WE,
          CSEL => CSEL,
          Read_ADDR => Read_ADDR,
          Write_ADDR => Write_ADDR,
          Read_SHFT => Read_SHFT,
          Write_SHFT => Write_SHFT,
          OPCODE => OPCODE,
          G_ROW => G_ROW,
          G_COLUMN => G_COLUMN,
          G_WE => G_WE,
          G_EN => G_EN,
          READY => READY,
          OP_DONE => OP_DONE,
          LOADING_DONE => LOADING_DONE,
          UN_LOADING_DONE => UN_LOADING_DONE,
          CONTROL_A_INPUT_OF_DSP => CONTROL_A_INPUT_OF_DSP
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;
	
	
	
	AXI_write_enable_process: process(CLK) is
	 variable AXI_busy_counter :integer range 0 to 100:=0;
	 variable seed1, seed2: positive;               -- seed values for random generator
    variable rand: real;   -- random real-number value in range 0 to 1.0  
    variable range_of_rand : real := 10.0;    -- the range of random values created will be 0 to +1000.
    variable rand_num: integer;
	begin
		if rising_edge(CLK) then
			AXI_busy_counter := AXI_busy_counter + 1;
		end if;
		
		uniform(seed1, seed2, rand);   -- generate random number
    	--rand_num := integer(rand*range_of_rand);  -- rescale to 0..1000, convert integer part 
		
		if AXI_busy_counter mod (integer(rand*range_of_rand) + 1)= 0 then
			if AXI_IP2Bus_WrAck = '1' then
			 	AXI_Bus2IP_WrCE <= '0';
			else
				AXI_Bus2IP_WrCE <= '1';
			end if;
		else
			if AXI_IP2Bus_WrAck = '1' then
			 	AXI_Bus2IP_WrCE <= '0';
			end if;
		end if;
		
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '1';
      LOAD_PG <= "00";
      UN_LOAD <= '0';
      P <= '0';
      G <= '0';
      wait for clk_period * 3;
      rst <= '0';
      
      wait until READY = '1';
      
--       AXI_Bus2IP_WrCE <= '1';   
      
     					
		
		---wait for clk_period*2;--					
		wait for clk_period*2; --wait until READY = '1';-- wait unitl MEMARRAY_V3 sends ready signal.					
		for i in 1 to COLUMN_TOTAL loop
			for j in 1 to COLUMN_TOTAL loop
				--DIN <= std_logic_vector(to_signed(x,DATA_WIDTH));				
				wait for CLK_period;
			end loop;
		end loop;
		
      
      wait until loading_done = '1';
      
       LOAD_PG <= "01";
       wait until READY = '1';
      	
      	wait for clk_period*2; --wait until READY = '1';-- wait unitl MEMARRAY_V3 sends ready signal.					
		for i in 1 to COLUMN_TOTAL loop
			for j in 1 to COLUMN_TOTAL loop
				--DIN <= std_logic_vector(to_signed(x,DATA_WIDTH));				
				wait for CLK_period;
			end loop;
		end loop;
		

      -- insert stimulus here 

      wait;
   end process;

END;
