create_project ETSE_GDSP_DMA /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA -part xc7z020clg484-1
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property target_language VHDL [current_project]
set_property  ip_repo_paths  {/home/tsotne/ownCloud/git/ETSE_GDSP/tmp/ip_repo} [current_project]
update_ip_catalog


create_bd_design "design_1"

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
startgroup
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
endgroup
set_property -dict [list CONFIG.c_sg_include_stscntrl_strm {0}] [get_bd_cells axi_dma_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 axis_data_fifo_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 axis_data_fifo_1
endgroup
startgroup
create_bd_cell -type ip -vlnv user.org:user:ETSE_GDSP:1.0 ETSE_GDSP_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
endgroup

set_property -dict [list CONFIG.CONST_WIDTH {4}] [get_bd_cells xlconstant_0]
set_property location {2 285 292} [get_bd_cells axis_data_fifo_0]
set_property location {2 229 280} [get_bd_cells axis_data_fifo_0]
set_property location {3 659 509} [get_bd_cells axi_dma_0]
set_property location {4 1087 290} [get_bd_cells axis_data_fifo_1]
set_property location {2 422 494} [get_bd_cells axi_dma_0]
set_property location {1.5 114 477} [get_bd_cells axi_dma_0]
connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins ETSE_GDSP_0/S00_AXIS]
connect_bd_intf_net [get_bd_intf_pins ETSE_GDSP_0/M00_AXIS] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_1/M_AXIS] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]
connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
set_property location {3 628 518} [get_bd_cells xlconcat_0]
connect_bd_net [get_bd_pins axi_dma_0/mm2s_introut] [get_bd_pins xlconcat_0/In0]
connect_bd_net [get_bd_pins axi_dma_0/s2mm_introut] [get_bd_pins xlconcat_0/In1]
set_property location {3 572 122} [get_bd_cells xlconstant_0]
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins ETSE_GDSP_0/s00_axis_tstrb]
save_bd_design
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/axi_dma_0/M_AXI_SG" Clk "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins ETSE_GDSP_0/S00_AXI]
endgroup
connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins processing_system7_0/IRQ_F2P]
save_bd_design
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Slave "/processing_system7_0/S_AXI_HP0" Clk "Auto" }  [get_bd_intf_pins axi_dma_0/M_AXI_MM2S]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Slave "/processing_system7_0/S_AXI_HP0" Clk "Auto" }  [get_bd_intf_pins axi_dma_0/M_AXI_S2MM]
endgroup
save_bd_design
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
startgroup
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]
endgroup
delete_bd_objs [get_bd_nets xlconcat_0_dout]
connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins processing_system7_0/IRQ_F2P]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/axi_dma_0/M_AXI_SG" Clk "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
save_bd_design
connect_bd_net -net [get_bd_nets rst_processing_system7_0_50M_peripheral_aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins ETSE_GDSP_0/m00_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins ETSE_GDSP_0/s00_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net [get_bd_pins ETSE_GDSP_0/s00_axi_aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]
connect_bd_net -net [get_bd_nets rst_processing_system7_0_50M_peripheral_aresetn] [get_bd_pins ETSE_GDSP_0/m00_axis_aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets rst_processing_system7_0_50M_peripheral_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]

save_bd_design
validate_bd_design
regenerate_bd_layout
save_bd_design

make_wrapper -files [get_files /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1


launch_runs impl_1 -to_step write_bitstream

wait_on_run impl_1


file mkdir /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk
file copy -force /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.runs/impl_1/design_1_wrapper.sysdef /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/design_1_wrapper.hdf

launch_sdk -workspace /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk -hwspec /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/design_1_wrapper.hdf

#-data /home/tsotne/workspaceVivado/Project_Name/Project_Name.sdk -vmargs -Dcom.xilinx.sdk.args.hwspec=/home/tsotne/workspaceVivado/Project_Name/Project_Name.sdk/Block_Design_wrapper.hdf -Xms64m -Xmx512m
