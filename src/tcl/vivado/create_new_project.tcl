#tested on Xilinx vivado 2015.2, linux
#this script creates a new project, that later can be used for simulations

source ../generics.tcl

#close any project if it's open already
    close_project -quiet
    #close_sim -force -quiet
    #TODO: investigate what happens if close_sim is commented, takes lots of time, side effects must be observed, baybe none, or maybe it remains in memory?

#create new project
    create_project $PROJECTNAME $PROJECTLOCATION -part xc7z020clg484-1 -force
    set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
    set_property target_language VHDL [current_project]

#add hdl sources
    add_files -norecurse -scan_for_includes $ORIGIN/src/hdl/CONTROL_UNIT_${PROJECTNAME}.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/hdl/BRAM_WRAPPER_V2.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/hdl/STANDARD_RAM.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/hdl/MATRIX_MUL_IP_CORE_${PROJECTNAME}.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/lib/txt_util.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/lib/MATRIX_MUL_IP_CORE_LIBRARY.vhd
    add_files -fileset sim_1 -norecurse -scan_for_includes /home/tsotne/git/ETSE_GDSP/src/tb/TB_MATRIX_MUL_IP_CORE_${PROJECTNAME}.vhd

#add IP
    add_files -norecurse $ORIGIN/src/ip/vivado/DSP_INPUT_C/DSP_INPUT_C.xci
    add_files -norecurse $ORIGIN/src/ip/vivado/BRAM18x1k/BRAM18x1k.xci

#update sources
    update_compile_order -fileset sources_1

#set MATRIX_MUL_IP_CORE_${PROJECTNAME} as top module
    set_property top MATRIX_MUL_IP_CORE_${PROJECTNAME} [current_fileset]

#set TB_MATRIX_MUL_IP_CORE_${PROJECTNAME} as top module for simulation
    set_property top TB_MATRIX_MUL_IP_CORE_${PROJECTNAME} [get_filesets sim_1]

#we launch simulation in order to create *.prj file, that will be used for simulations in loop
    launch_simulation


#close the project
    close_project
