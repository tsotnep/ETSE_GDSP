source ../generics.tcl

create_project $PROJECTNAME $PROJECTLOCATION -part xc7z020clg484-1 -f
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property target_language VHDL [current_project]


#add hdl sources
    add_files -norecurse -scan_for_includes $ORIGIN/src/hdl/CONTROL_UNIT_S_INT.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/hdl/BRAM_WRAPPER_V2.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/hdl/STANDARD_RAM.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/hdl/MATRIX_MUL_IP_CORE_S_INT.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/lib/txt_util.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/lib/MATRIX_MUL_IP_CORE_LIBRARY_Syn.vhd
    add_files -norecurse -scan_for_includes $ORIGIN/src/lib/MATRIX_MUL_IP_CORE_LIBRARY_Sim.vhd
    add_files -fileset sim_1 -norecurse -scan_for_includes /home/tsotne/git/ETSE_GDSP/src/tb/TB_MATRIX_MUL_IP_CORE_S_INT.vhd

#add IP
    add_files -norecurse $ORIGIN/src/ip/vivado/DSP_INPUT_C/DSP_INPUT_C.xci
    add_files -norecurse $ORIGIN/src/ip/vivado/BRAM18x1k/BRAM18x1k.xci

#update sources
    update_compile_order -fileset sources_1

#launch vivado GUI
    start_gui

#set MATRIX_MUL_IP_CORE_S_INT as top module
    set_property top MATRIX_MUL_IP_CORE_S_INT [current_fileset]

#launch simulatino
    launch_simulation

#open waveform
    open_wave_config {/home/tsotne/git/ETSE_GDSP/src/tb/TB_MATRIX_MUL_IP_CORE_S_INT.wcfg}
