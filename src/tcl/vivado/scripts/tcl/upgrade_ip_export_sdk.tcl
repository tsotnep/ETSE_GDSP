#Description:
#open project, check status and upgrade all IPs - if they've changed
#generate bitstream
#export design to SDK. design_1_wrapper_hw_platform_# -folder is built automatically when SDK is launched/running. bitstream and other necessary files are inside that folder.
############################

#Variables:
set PROJ_PATH       /home/tsotne/workspaceVivado
set PROJ_NAME       MMULT_with_cortex_2
set BLOCK_DESIGN    design_1
set HW_PLATFORM_N   ${BLOCK_DESIGN}_wrapper_hw_platform_0
############################

#Script, Don't Change

#open project if its not already open
open_project -quiet ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.xpr

#upgrade all IPs
update_ip_catalog -rebuild -scan_changes
report_ip_status -name ip_status
upgrade_ip [get_ips -all]
report_ip_status -name ip_status

#generate .bit
reset_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 3
wait_on_run impl_1

#export to SDK
set v0 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.runs/synth_1/${BLOCK_DESIGN}.hwdef
write_hwdef -force -file ${v0}
set v1 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.runs/synth_1/${BLOCK_DESIGN}.hwdef
set v2 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.runs/impl_1/${BLOCK_DESIGN}_wrapper.bit
set v3 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.runs/impl_1/${BLOCK_DESIGN}_wrapper.sysdef
write_sysdef -force -hwdef ${v1} -bitfile ${v2} -file ${v3}
set v4 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.runs/impl_1/${BLOCK_DESIGN}_wrapper.sysdef
set v5 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${BLOCK_DESIGN}_wrapper.hdf
set v5_1 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${HW_PLATFORM_N}
file mkdir ${v5_1}
file copy -force ${v4} ${v5}
file copy -force ${v2} ${v5_1}/${BLOCK_DESIGN}_wrapper.bit


#launch SDK and exit vivado
set v6 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk
set v7 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/design_1_wrapper.hdf
#launch_sdk -workspace ${v6} -hwspec ${v7} #in case, you want to use GUI of SDK
exit
############################
