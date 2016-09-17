#Description:
#Reset connection with FPGA, then connect and Reset FPGA
#Program FPGA with bitstream
#Initialize ZYNQ processing system with default script
#Program FPGA with FSBL
#Program FPGA with custom Baremetal APP
#Run APP
############################

#Variables:
set SCRIPTS_LOC /home/tsotne/workspaceVivado/scripts
source ${SCRIPTS_LOC}/Genericstcl
############################


xdisconnect -cable
connect arm hw
rst -srst
#fpga -f ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.runs/impl_1/${BLOCK_DESIGN}_wrapper.bit #if bit stream is not exported to sdk
fpga -f ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${HW_PLATFORM_N}/${BLOCK_DESIGN}_wrapper.bit
source ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${HW_PLATFORM_N}/ps7_init.tcl
ps7_init
ps7_post_config
dow ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${FSBL_NAME}/Debug/${FSBL_NAME}.elf
dow ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${APP_NAME}/Debug/${APP_NAME}.elf
run

#rst -processor
