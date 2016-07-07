--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2016 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--    Generated from core with identifier: xilinx.com:ip:blk_mem_gen:7.3      --
--                                                                            --
--    The Xilinx LogiCORE IP Block Memory Generator replaces the Dual Port    --
--    Block Memory and Single Port Block Memory LogiCOREs, but is not a       --
--    direct drop-in replacement.  It should be used in all new Xilinx        --
--    designs. The core supports RAM and ROM functions over a wide range of   --
--    widths and depths. Use this core to generate block memories with        --
--    symmetric or asymmetric read and write port widths, as well as cores    --
--    which can perform simultaneous write operations to separate             --
--    locations, and simultaneous read operations from the same location.     --
--    For more information on differences in interface and feature support    --
--    between this core and the Dual Port Block Memory and Single Port        --
--    Block Memory LogiCOREs, please consult the data sheet.                  --
--------------------------------------------------------------------------------
-- Source Code Wrapper
-- This file is provided to wrap around the source code (if appropriate)
-- and is designed for use with XST

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY blk_mem_gen_v7_3;
USE blk_mem_gen_v7_3.blk_mem_gen_v7_3;

ENTITY GRAM IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END GRAM;

ARCHITECTURE virtex7 OF GRAM IS

  COMPONENT blk_mem_gen_v7_3 IS
    GENERIC (
      c_family : STRING;
      c_xdevicefamily : STRING;
      c_elaboration_dir : STRING;
      c_interface_type : INTEGER;
      c_axi_type : INTEGER;
      c_axi_slave_type : INTEGER;
      c_has_axi_id : INTEGER;
      c_axi_id_width : INTEGER;
      c_mem_type : INTEGER;
      c_byte_size : INTEGER;
      c_algorithm : INTEGER;
      c_prim_type : INTEGER;
      c_load_init_file : INTEGER;
      c_init_file_name : STRING;
      c_init_file : STRING;
      c_use_default_data : INTEGER;
      c_default_data : STRING;
      c_rst_type : STRING;
      c_has_rsta : INTEGER;
      c_rst_priority_a : STRING;
      c_rstram_a : INTEGER;
      c_inita_val : STRING;
      c_has_ena : INTEGER;
      c_has_regcea : INTEGER;
      c_use_byte_wea : INTEGER;
      c_wea_width : INTEGER;
      c_write_mode_a : STRING;
      c_write_width_a : INTEGER;
      c_read_width_a : INTEGER;
      c_write_depth_a : INTEGER;
      c_read_depth_a : INTEGER;
      c_addra_width : INTEGER;
      c_has_rstb : INTEGER;
      c_rst_priority_b : STRING;
      c_rstram_b : INTEGER;
      c_initb_val : STRING;
      c_has_enb : INTEGER;
      c_has_regceb : INTEGER;
      c_use_byte_web : INTEGER;
      c_web_width : INTEGER;
      c_write_mode_b : STRING;
      c_write_width_b : INTEGER;
      c_read_width_b : INTEGER;
      c_write_depth_b : INTEGER;
      c_read_depth_b : INTEGER;
      c_addrb_width : INTEGER;
      c_has_mem_output_regs_a : INTEGER;
      c_has_mem_output_regs_b : INTEGER;
      c_has_mux_output_regs_a : INTEGER;
      c_has_mux_output_regs_b : INTEGER;
      c_mux_pipeline_stages : INTEGER;
      c_has_softecc_input_regs_a : INTEGER;
      c_has_softecc_output_regs_b : INTEGER;
      c_use_softecc : INTEGER;
      c_use_ecc : INTEGER;
      c_has_injecterr : INTEGER;
      c_sim_collision_check : STRING;
      c_common_clk : INTEGER;
      c_enable_32bit_address : INTEGER;
      c_disable_warn_bhv_coll : INTEGER;
      c_disable_warn_bhv_range : INTEGER;
      c_use_bram_block : INTEGER
    );
    PORT (
      clka : IN STD_LOGIC;
      ena : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
    );
  END COMPONENT blk_mem_gen_v7_3;

  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF virtex7 : ARCHITECTURE IS "blk_mem_gen_v7_3, Xilinx CORE Generator 14.7";

  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF virtex7 : ARCHITECTURE IS "GRAM,blk_mem_gen_v7_3,{}";

  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF virtex7 : ARCHITECTURE IS "GRAM,blk_mem_gen_v7_3,{c_addra_width=20,c_addrb_width=20,c_algorithm=1,c_axi_id_width=4,c_axi_slave_type=0,c_axi_type=1,c_byte_size=9,c_common_clk=0,c_default_data=0,c_disable_warn_bhv_coll=0,c_disable_warn_bhv_range=0,c_elaboration_dir=/home/tsotne/git/ETSE_GDSP/Matrix_for_RBM/MATRIX_MUL_IP_CORE_S_INT/ipcore_dir/tmp/_cg/,c_enable_32bit_address=0,c_family=virtex7,c_has_axi_id=0,c_has_ena=1,c_has_enb=0,c_has_injecterr=0,c_has_mem_output_regs_a=0,c_has_mem_output_regs_b=0,c_has_mux_output_regs_a=0,c_has_mux_output_regs_b=0,c_has_regcea=0,c_has_regceb=0,c_has_rsta=0,c_has_rstb=0,c_has_softecc_input_regs_a=0,c_has_softecc_output_regs_b=0,c_init_file=BlankString,c_init_file_name=no_coe_file_loaded,c_inita_val=0,c_initb_val=0,c_interface_type=0,c_load_init_file=0,c_mem_type=0,c_mux_pipeline_stages=0,c_prim_type=1,c_read_depth_a=1048576,c_read_depth_b=1048576,c_read_width_a=18,c_read_width_b=18,c_rst_priority_a=CE,c_rst_priority_b=CE,c_rst_type=SYNC,c_rstram_a=0,c_rstram_b=0,c_sim_collision_check=ALL,c_use_bram_block=0,c_use_byte_wea=0,c_use_byte_web=0,c_use_default_data=0,c_use_ecc=0,c_use_softecc=0,c_wea_width=1,c_web_width=1,c_write_depth_a=1048576,c_write_depth_b=1048576,c_write_mode_a=WRITE_FIRST,c_write_mode_b=WRITE_FIRST,c_write_width_a=18,c_write_width_b=18,c_xdevicefamily=virtex7}";

BEGIN

  U0 : blk_mem_gen_v7_3
    GENERIC MAP (
      c_addra_width => 20,
      c_addrb_width => 20,
      c_algorithm => 1,
      c_axi_id_width => 4,
      c_axi_slave_type => 0,
      c_axi_type => 1,
      c_byte_size => 9,
      c_common_clk => 0,
      c_default_data => "0",
      c_disable_warn_bhv_coll => 0,
      c_disable_warn_bhv_range => 0,
      c_elaboration_dir => "/home/tsotne/git/ETSE_GDSP/Matrix_for_RBM/MATRIX_MUL_IP_CORE_S_INT/ipcore_dir/tmp/_cg/",
      c_enable_32bit_address => 0,
      c_family => "virtex7",
      c_has_axi_id => 0,
      c_has_ena => 1,
      c_has_enb => 0,
      c_has_injecterr => 0,
      c_has_mem_output_regs_a => 0,
      c_has_mem_output_regs_b => 0,
      c_has_mux_output_regs_a => 0,
      c_has_mux_output_regs_b => 0,
      c_has_regcea => 0,
      c_has_regceb => 0,
      c_has_rsta => 0,
      c_has_rstb => 0,
      c_has_softecc_input_regs_a => 0,
      c_has_softecc_output_regs_b => 0,
      c_init_file => "BlankString",
      c_init_file_name => "no_coe_file_loaded",
      c_inita_val => "0",
      c_initb_val => "0",
      c_interface_type => 0,
      c_load_init_file => 0,
      c_mem_type => 0,
      c_mux_pipeline_stages => 0,
      c_prim_type => 1,
      c_read_depth_a => 1048576,
      c_read_depth_b => 1048576,
      c_read_width_a => 18,
      c_read_width_b => 18,
      c_rst_priority_a => "CE",
      c_rst_priority_b => "CE",
      c_rst_type => "SYNC",
      c_rstram_a => 0,
      c_rstram_b => 0,
      c_sim_collision_check => "ALL",
      c_use_bram_block => 0,
      c_use_byte_wea => 0,
      c_use_byte_web => 0,
      c_use_default_data => 0,
      c_use_ecc => 0,
      c_use_softecc => 0,
      c_wea_width => 1,
      c_web_width => 1,
      c_write_depth_a => 1048576,
      c_write_depth_b => 1048576,
      c_write_mode_a => "WRITE_FIRST",
      c_write_mode_b => "WRITE_FIRST",
      c_write_width_a => 18,
      c_write_width_b => 18,
      c_xdevicefamily => "virtex7"
    )
    PORT MAP (
      clka => clka,
      ena => ena,
      wea => wea,
      addra => addra,
      dina => dina,
      douta => douta
    );

END virtex7;
