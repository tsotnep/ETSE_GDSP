#Description:
#creates Zynq FSBL if it's not created yet
#TODO: create build_baremetal_app_hsi.tcl, that includes sources
############################

#Variables:
SCRIPTS_LOC=/home/tsotne/workspaceVivado/scripts
VIVADO_SOURCE=/opt/Xilinx/SDK/2015.2/settings64.sh
PROJ_PATH=/home/tsotne/workspaceVivado
PROJ_NAME=MMULT_AXI_STREAM
source Generics
############################

GO_BACK=`pwd`

source ${VIVADO_SOURCE}
hsi -source ${SCRIPTS_LOC}/tcl/build_baremetal_app_hsi.tcl

cd ${GO_BACK}
############################
