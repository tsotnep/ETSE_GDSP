#Description:
#creates Zynq FSBL if it's not created yet
############################

#Variables:
source Generics
############################

GO_BACK=`pwd`

source ${VIVADO_SOURCE}
hsi -source ${SCRIPTS_LOC}/tcl/build_zynq_fsbl_hsi.tcl | egrep --color "\b(^ERROR|^WARNING|^TSOTNE|invalid|couldn't)\b|$"

cd ${GO_BACK}
############################
