#Description:
#uses existing scripts to:
#Built/compile the baremetal project
#source vivado tools and
#Program FPGA with Bitstream, fsbl and Baremetal APP
############################

#Variables:
SCRIPTS_LOC=/home/tsotne/workspaceVivado/scripts
VIVADO_SOURCE=/opt/Xilinx/SDK/2015.2/settings64.sh
############################

GO_BACK=`pwd`

source rebuild_baremetal_app.sh
source ${VIVADO_SOURCE}
xmd -tcl ${SCRIPTS_LOC}/tcl/program_fpga_bit_elf_xmd.tcl

cd ${GO_BACK}
############################
