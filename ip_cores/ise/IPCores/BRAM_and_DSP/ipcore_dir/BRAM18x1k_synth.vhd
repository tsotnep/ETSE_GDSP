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
--    (c) Copyright 1995-2015 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--    Generated from core with identifier: xilinx.com:ip:blk_mem_gen:7.2      --
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
-- Synthesized Netlist Wrapper
-- This file is provided to wrap around the synthesized netlist (if appropriate)

-- Interfaces:
--   CLK.ACLK
--     AXI4 Interconnect Clock Input
--   RST.ARESETN
--     AXI4 Interconnect Reset Input
--   AXI_SLAVE_S_AXI
--     AXI_SLAVE
--   AXILite_SLAVE_S_AXI
--     AXILite_SLAVE
--   BRAM_PORTA
--     BRAM_PORTA
--   BRAM_PORTB
--     BRAM_PORTB

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY XilinxCoreLib;

ENTITY BRAM18x1k IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    clkb : IN STD_LOGIC;
    rstb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END BRAM18x1k;

ARCHITECTURE virtex7 OF BRAM18x1k IS
-- synthesis translate_off
COMPONENT wrapped_BRAM18x1k
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    clkb : IN STD_LOGIC;
    rstb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_BRAM18x1k USE ENTITY XilinxCoreLib.blk_mem_gen_v7_2(behavioral)
    GENERIC MAP (
      c_addra_width => 10,
      c_addrb_width => 10,
      c_algorithm => 1,
      c_axi_id_width => 4,
      c_axi_slave_type => 0,
      c_axi_type => 1,
      c_byte_size => 9,
      c_common_clk => 1,
      c_default_data => "0",
      c_disable_warn_bhv_coll => 0,
      c_disable_warn_bhv_range => 0,
      c_enable_32bit_address => 0,
      c_family => "virtex7",
      c_has_axi_id => 0,
      c_has_ena => 0,
      c_has_enb => 0,
      c_has_injecterr => 0,
      c_has_mem_output_regs_a => 0,
      c_has_mem_output_regs_b => 1,
      c_has_mux_output_regs_a => 0,
      c_has_mux_output_regs_b => 0,
      c_has_regcea => 0,
      c_has_regceb => 0,
      c_has_rsta => 0,
      c_has_rstb => 1,
      c_has_softecc_input_regs_a => 0,
      c_has_softecc_output_regs_b => 0,
      c_init_file_name => "no_coe_file_loaded",
      c_inita_val => "0",
      c_initb_val => "1",
      c_interface_type => 0,
      c_load_init_file => 0,
      c_mem_type => 1,
      c_mux_pipeline_stages => 0,
      c_prim_type => 1,
      c_read_depth_a => 1024,
      c_read_depth_b => 1024,
      c_read_width_a => 18,
      c_read_width_b => 18,
      c_rst_priority_a => "CE",
      c_rst_priority_b => "CE",
      c_rst_type => "SYNC",
      c_rstram_a => 0,
      c_rstram_b => 0,
      c_sim_collision_check => "ALL",
      c_use_byte_wea => 0,
      c_use_byte_web => 0,
      c_use_default_data => 0,
      c_use_ecc => 0,
      c_use_softecc => 0,
      c_wea_width => 1,
      c_web_width => 1,
      c_write_depth_a => 1024,
      c_write_depth_b => 1024,
      c_write_mode_a => "READ_FIRST",
      c_write_mode_b => "READ_FIRST",
      c_write_width_a => 18,
      c_write_width_b => 18,
      c_xdevicefamily => "virtex7"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_BRAM18x1k
  PORT MAP (
    clka => clka,
    wea => wea,
    addra => addra,
    dina => dina,
    clkb => clkb,
    rstb => rstb,
    addrb => addrb,
    doutb => doutb
  );
-- synthesis translate_on

END virtex7;
