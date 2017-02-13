set origin /home/tsotne/ownCloud/git/ETSE_GDSP

#How to run
  #correct line 1
  #launch VIVADO
  #source this script
  #finishes in 10 min.

#What it does and what you have to do:
  #creates project
  #adds necessary IPs, including one that was generated through src/tcl/build_ip_ETSE_GDSP.tcl
  #generates bitstream
  #launches Xilinx SDK, where you should :
    #create new project from Helloworld template
    # remove helloworld.c
    #add sources:
      # src/app-baremetal/mylib.h
      # src/app-baremetal/ETSE_GDSP_DMA/ETSE_GDSP_DMA.c or src/app-baremetal/ETSE_GDSP_DMA_ETHERNET/*
    #program FPGA with
      # src/tcl/program_fpga_BITSTREAM_ARM-APPLICATION.tcl or manually from SDK gui
############################


close_project -quiet
#crteate project
create_project ETSE_GDSP_DMA_ETHERNET ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET -part xc7z020clg484-1 -force
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property target_language VHDL [current_project]
set_property  ip_repo_paths  ${origin}/tmp/ip_repo [current_project]
update_ip_catalog


#create block design and add files
create_bd_design "design_1"
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
set_property -dict [list CONFIG.c_include_sg {0}] [get_bd_cells axi_dma_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 axis_data_fifo_0
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 axis_data_fifo_1
create_bd_cell -type ip -vlnv user.org:user:ETSE_GDSP:1.0 ETSE_GDSP_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0
endgroup


#constant value to shut tstrb warning up
#startgroup
#create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
#set_property -dict [list CONFIG.CONST_WIDTH {4}] [get_bd_cells xlconstant_0]
#set_property location {3 572 122} [get_bd_cells xlconstant_0]
#connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins ETSE_GDSP_0/s00_axis_tstrb]
#endgroup



#zynq block automation, enable HP port for DMA and enable interrupt
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]
set_property -dict [list CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]
endgroup


#zynq AXIS and AXI connections
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins ETSE_GDSP_0/s00_axi]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/axi_dma_0/M_AXI_MM2S" Clk "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Slave "/processing_system7_0/S_AXI_HP0" Clk "Auto" }  [get_bd_intf_pins axi_dma_0/M_AXI_S2MM]
endgroup


#Manually Connecting stuff
startgroup
#axis
connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins ETSE_GDSP_0/S00_AXIS]
connect_bd_intf_net [get_bd_intf_pins ETSE_GDSP_0/M00_AXIS] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins axis_data_fifo_1/M_AXIS] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]
connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]

#irq
connect_bd_net [get_bd_pins axi_dma_0/mm2s_introut] [get_bd_pins xlconcat_0/In0]
connect_bd_net [get_bd_pins axi_dma_0/s2mm_introut] [get_bd_pins xlconcat_0/In1]
connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins processing_system7_0/IRQ_F2P]

#clk
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins ETSE_GDSP_0/m00_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins ETSE_GDSP_0/s00_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]

#rst
connect_bd_net [get_bd_pins ETSE_GDSP_0/s00_axi_aresetn] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]
connect_bd_net -net [get_bd_nets rst_processing_system7_0_100M_peripheral_aresetn] [get_bd_pins ETSE_GDSP_0/m00_axis_aresetn] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]
connect_bd_net -net [get_bd_nets rst_processing_system7_0_100M_peripheral_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]
connect_bd_net -net [get_bd_nets rst_processing_system7_0_100M_peripheral_aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]
endgroup


#save, validate, regenerate, save.
save_bd_design
validate_bd_design
regenerate_bd_layout
save_bd_design


#create hdl wrapper
make_wrapper -files [get_files ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1


#Generate bitstriam and wait until it finishes
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1


#export design to SDK and launch it
file mkdir ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk
file copy -force ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.runs/impl_1/design_1_wrapper.sysdef ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/design_1_wrapper.hdf
launch_sdk -workspace ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk -hwspec ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/design_1_wrapper.hdf
