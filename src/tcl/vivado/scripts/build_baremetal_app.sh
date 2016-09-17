#Description:
#creates Zynq FSBL if it's not created yet
#TODO: create build_baremetal_app_hsi.tcl, that includes sources
############################

#Variables:
source Generics
############################

GO_BACK=`pwd`

source ${VIVADO_SOURCE}
hsi -source ${SCRIPTS_LOC}/tcl/build_baremetal_app_hsi.tcl

cd ${GO_BACK}
############################
