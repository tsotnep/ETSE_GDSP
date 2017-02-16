set origin /home/tsotne/ownCloud/git/ETSE_GDSP
# source /cad/x_16/Vivado/2016.1/settings64.sh
# vivado -mode tcl -source /home/tsotne/ownCloud/git/ETSE_GDSP/src/tcl/build_ip_ETSE_GDSP.tcl

#How to run
  #correct line 1:3
  #launch VIVADO
  #source this script
  #finishes in 20 sec

#What it does and what you have to do:
  #creates new project
  #adds necessary sources_1
  #packages the project and builds the IP, that will be used in script : src/tcl/build_project_ETSE_GDSP_DMA_ETHERNET.tcl
  #launches and closes simulation, we need that to generate *_vhdl.prj file, that is used in simulation
  #exits
  #after that you should execute the script : src/tcl/build_project_ETSE_GDSP_DMA_ETHERNET.tcl
############################

close_project -quiet
#crteate project
create_project ETSE_GDSP ${origin}/tmp/projects/ETSE_GDSP -part xc7z020clg484-1 -force
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property target_language VHDL [current_project]


#add vhd files for synthesis
add_files -norecurse -scan_for_includes ${origin}/src/hdl/txt_util.vhd
add_files -norecurse -scan_for_includes ${origin}/src/hdl/MATRIX_MUL_IP_CORE_LIBRARY.vhd
add_files -norecurse -scan_for_includes ${origin}/src/hdl/STANDARD_RAM.vhd
add_files -norecurse -scan_for_includes ${origin}/src/hdl/BRAM_WRAPPER_V2.vhd
add_files -norecurse -scan_for_includes ${origin}/src/hdl/GRAM_address_generator.vhd
add_files -norecurse -scan_for_includes ${origin}/src/hdl/CONTROL_UNIT_S_INT_G.vhd
add_files -norecurse -scan_for_includes ${origin}/src/hdl/MATRIX_MUL_IP_CORE_S_INT_G.vhd
add_files -norecurse -scan_for_includes ${origin}/src/hdl/MMULT_CONTROLLER_2.vhd
add_files -norecurse -scan_for_includes ${origin}/src/hdl/ETSE_GDSP_AXI.vhd
add_files -norecurse -scan_for_includes ${origin}/src/hdl/ETSE_GDSP.vhd


#add vhd files for simulation
add_files -fileset sim_1 -norecurse -scan_for_includes ${origin}/src/hdl/tb/tb_axi_stream_simulation_master.vhd
add_files -fileset sim_1 -norecurse -scan_for_includes ${origin}/src/hdl/tb/tb_axi_stream_simulation_slave.vhd
add_files -fileset sim_1 -norecurse -scan_for_includes ${origin}/src/hdl/tb/TB_MMULT_CONTROLLER_2.vhd
add_files -fileset sim_1 -norecurse -scan_for_includes ${origin}/src/hdl/tb/waveform.wcfg
set_property top TB_MMULT_CONROLLER_2 [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]
update_compile_order -fileset sim_1
#disable those files, won't be synthesized. not even needs to be disabbled.
#set_property is_enabled false [get_files  ${origin}/src/hdl/tb/waveform.wcfg]
#set_property is_enabled false [get_files  ${origin}/src/hdl/tb/TB_MMULT_CONTROLLER_2.vhd]
#set_property is_enabled false [get_files  ${origin}/src/hdl/tb/tb_axi_stream_simulation_master.vhd]
#set_property is_enabled false [get_files  ${origin}/src/hdl/tb/tb_axi_stream_simulation_slave.vhd]
#set_property top ETSE_GDSP [get_filesets sim_1]
#set_property top_lib xil_defaultlib [get_filesets sim_1]



#add dsp and blockram xilinx ips
create_ip -name xbip_dsp48_macro -vendor xilinx.com -library ip -version 3.0 -module_name DSP_INPUT_C
    set_property -dict [list CONFIG.instruction1 {A} CONFIG.instruction2 {A*B} CONFIG.instruction3 {A*B+P} CONFIG.instruction4 {A*B+C} CONFIG.instruction5 {A*B+P>>17} CONFIG.instruction6 {B*A} CONFIG.instruction7 {C} CONFIG.pipeline_options {Expert} CONFIG.creg_1 {false} CONFIG.creg_2 {false} CONFIG.creg_3 {false} CONFIG.creg_4 {false} CONFIG.creg_5 {false} CONFIG.areg_1 {true} CONFIG.areg_2 {true} CONFIG.areg_3 {true} CONFIG.areg_4 {true} CONFIG.breg_1 {true} CONFIG.breg_2 {true} CONFIG.breg_3 {true} CONFIG.breg_4 {true} CONFIG.opreg_1 {true} CONFIG.opreg_2 {true} CONFIG.opreg_3 {true} CONFIG.opreg_4 {true} CONFIG.opreg_5 {true} CONFIG.mreg_5 {true} CONFIG.preg_6 {true} CONFIG.d_width {18} CONFIG.a_width {18} CONFIG.a_binarywidth {0} CONFIG.b_width {18} CONFIG.b_binarywidth {0} CONFIG.concat_width {48} CONFIG.concat_binarywidth {0} CONFIG.c_width {48} CONFIG.c_binarywidth {0} CONFIG.pcin_binarywidth {0} CONFIG.p_full_width {48} CONFIG.p_width {48} CONFIG.p_binarywidth {0}] [get_ips DSP_INPUT_C]
    #generate_target {instantiation_template} [get_files ${origin}/projects/vivado/S_INT_G/S_INT_G.srcs/sources_1/ip/DSP_INPUT_C/DSP_INPUT_C.xci]
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.3 -module_name BRAM18x1k
    set_property -dict [list CONFIG.Memory_Type {Simple_Dual_Port_RAM} CONFIG.Write_Width_A {18} CONFIG.Write_Depth_A {1024} CONFIG.Enable_A {Always_Enabled} CONFIG.Enable_B {Always_Enabled} CONFIG.Use_RSTB_Pin {true} CONFIG.Reset_Memory_Latch_B {true} CONFIG.Output_Reset_Value_B {1} CONFIG.Read_Width_A {18} CONFIG.Operating_Mode_A {NO_CHANGE} CONFIG.Write_Width_B {18} CONFIG.Read_Width_B {18} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100}] [get_ips BRAM18x1k]
    #generate_target {instantiation_template} [get_files ${origin}/projects/vivado/S_INT_G/S_INT_G.srcs/sources_1/ip/BRAM18x1k/BRAM18x1k.xci]


#package this project
  ipx::package_project -root_dir ${origin}/tmp/ip_repo/ETSE_GDSP -vendor user.org -library user -taxonomy /UserIP -import_files -set_current false
ipx::unload_core ${origin}/tmp/ip_repo/ETSE_GDSP/component.xml
ipx::edit_ip_in_project -upgrade true -name tmp_edit_project -directory ${origin}/tmp/ip_repo/ETSE_GDSP ${origin}/tmp/ip_repo/ETSE_GDSP/component.xml
update_compile_order -fileset sources_1
current_project ETSE_GDSP
current_project tmp_edit_project
update_compile_order -fileset sim_1
set_property core_revision 2 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
close_project -delete
set_property  ip_repo_paths  ${origin}/tmp/ip_repo/ETSE_GDSP [current_project]
update_ip_catalog

#simulation to get *.prj file
launch_simulation
close_sim

close_project -quiet
puts "SUCCESSFULLY Generated IP. Now, modify and : source $origin/src/tcl/build_project_ETSE_GDSP_DMA_ETHERNET.tcl"
exit
