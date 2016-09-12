#Description:
#sources tcl to upgrade IPs, regenerate bitstream and export to SDK
############################

#Variables:
SCRIPTS_LOC=/home/tsotne/workspaceVivado/scripts
VIVADO_SOURCE=/opt/Xilinx/SDK/2015.2/settings64.sh
PROJ_PATH=/home/tsotne/workspaceVivado
PROJ_NAME=MMULT_with_cortex_2
############################

GO_BACK=`pwd`

source ${VIVADO_SOURCE}

\vivado -nolog -nojournal -mode tcl -source ${SCRIPTS_LOC}/tcl/upgrade_ip_export_sdk.tcl ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.xpr

cd ${GO_BACK}
############################
