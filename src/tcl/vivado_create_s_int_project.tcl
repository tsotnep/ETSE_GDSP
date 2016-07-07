set PROJECTNAME=S_INT
set ORIGIN=/ORIGIN/tsotne/git/ETSE_GDSP
set PROJECTLOCATION=$ORIGIN/project/vivado/$PROJECTNAME

create_project $PROJECTNAME $PROJECTLOCATION -part xc7z020clg484-1 -f
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property target_language VHDL [current_project]


#add hdl sources
    add_files -norecurse -scan_for_includes {
        $ORIGIN/src/hdl/BRAM_WRAPPER_V2.vhd
        $ORIGIN/src/hdl/CONTROL_UNIT_S_INT.vhd
        $ORIGIN/src/hdl/STANDARD_RAM.vhd
        $ORIGIN/src/hdl/MATRIX_MUL_IP_CORE_S_INT.vhd
        $ORIGIN/src/lib/txt_util.vhd
        $ORIGIN/src/lib/MATRIX_MUL_IP_CORE_LIBRARY_Syn.vhd
        $ORIGIN/src/lib/MATRIX_MUL_IP_CORE_LIBRARY_Sim.vhd}

#add IP
    add_files -norecurse $ORIGIN/src/ip/vivado/DSC_INPUT_C/DSC_INPUT_C.xci
    add_files -norecurse $ORIGIN/src/ip/vivado/BRAM18x1k/BRAM18x1k.xci

#update sources
    update_compile_order -fileset sources_1

#start_gui
