#Description:
#open project
#generate FSBL
#TODO: this can be done with xsdk -batch -source script.tcl
############################

#Variables:
set PROJ_PATH       /home/tsotne/workspaceVivado
set PROJ_NAME       MMULT_with_cortex_2
set BLOCK_DESIGN    design_1
set FSBL_NAME       fsbl_2
############################


#open design
open_hw_design ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${BLOCK_DESIGN}_wrapper.hdf

#generate FSBL
set v0 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${FSBL_NAME}
generate_app -os standalone -proc ps7_cortexa9_0 -app zynq_fsbl -compile -sw ${FSBL_NAME} -dir ${v0}
file rename ${v0}/executable.elf ${v0}/${FSBL_NAME}.elf

#generate FSBL_bsp (but it is generated: https://forums.xilinx.com/t5/Embedded-Development-Tools/SDK-Baremetal-FSBL-multiple-BSP/td-p/723243)
open_sw_design ${v0}/zynq_fsbl_bsp/system.mss
generate_bsp -os standalone -proc ps7_cortexa9_0 -compile -dir ${v0}_bsp
############################
