#Description:
#creates Zynq FSBL if it's not created yet
############################

#Variables:
SCRIPTS_LOC=/home/tsotne/workspaceVivado/scripts
VIVADO_SOURCE=/opt/Xilinx/SDK/2015.2/settings64.sh
PROJ_PATH=/home/tsotne/workspaceVivado
PROJ_NAME=MMULT_AXI_STREAM
BLOCK_DESIGN=design_1
FSBL_NAME=fsbl
source Generics
############################

GO_BACK=`pwd`

${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${FSBL_NAME}

source ${VIVADO_SOURCE}
hsi -source ${SCRIPTS_LOC}/tcl/build_zynq_fsbl_hsi.tcl

cd ${GO_BACK}
############################
