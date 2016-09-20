#Description:
#sources tcl to upgrade IPs, regenerate bitstream and export to SDK
############################

#Variables:
source Generics
############################

GO_BACK=`pwd`

source ${VIVADO_SOURCE}

#touch log/regen_all.log
#touch log/regen_filtered.log
#tail -f log/regen_all.log |  grep -iE "error|warning" > log/regen_filtered.log &

#tail -f log/regen_all.log | grep -iE "ERROR|WARNING|INFO"

echo "TSOTNE: starting vivado tcl mode"

#\vivado -nolog -nojournal -mode tcl -source ${SCRIPTS_LOC}/tcl/upgrade_ip_export_sdk.tcl ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.xpr >> log/regen_all.log

\vivado -nolog -nojournal -mode tcl -source ${SCRIPTS_LOC}/tcl/upgrade_ip_export_sdk.tcl ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.xpr 2>&1 | egrep --color "\b(^ERROR|^WARNING|^TSOTNE|invalid|couldn't)\b|$"

# \vivado -nolog -nojournal -mode tcl -source ${SCRIPTS_LOC}/tcl/upgrade_ip_export_sdk.tcl ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.xpr
#| grep -iE "^ERROR|^WARNING|^TSOTNE|^couldn't"


#problem with this, is that it executes those greps in order, not in simultaneously
# tee >(grep -i info > log/regen_info.log) >(grep -i warning > log/regen_warning.log) >(grep -i error > log/regen_error.log) > log/regen_all.log

cd ${GO_BACK}
############################
