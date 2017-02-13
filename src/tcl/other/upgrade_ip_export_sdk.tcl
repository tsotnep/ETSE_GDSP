#Description:
#open project, check status and upgrade all IPs - if they've changed
#generate bitstream
#export design to SDK. design_1_wrapper_hw_platform_# -folder is built automatically when SDK is launched/running. bitstream and other necessary files are inside that folder.
############################

#Variables:
set SCRIPTS_LOC /home/tsotne/workspaceVivado/scripts
source ${SCRIPTS_LOC}/Genericstcl
############################

#Script, Don't Change

puts "TSOTNE: opening project"
#open project if its not already open
open_project -quiet ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.xpr
puts "TSOTNE: opened project"

#upgrade all IPs
puts "TSOTNE: updating IPs"
set v001 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.tmp/${IP_NAME}_v1_0_project
set v002 ${IP_LOC}/${IP_NAME}_1.0/component.xml

report_ip_status
update_ip_catalog -rebuild -scan_changes
upgrade_ip [get_ips -all]
report_ip_status
puts "TSOTNE: updated IPs"

#check if bitstream needs to be regenerated
set st1 [get_property STATUS [get_runs synth_1]]
set st2 [get_property STATUS [get_runs impl_1]]
set pr1 [get_property PROGRESS [get_runs synth_1]]
set pr2 [get_property PROGRESS [get_runs synth_1]]
set ref1 [get_property needs_refresh [get_runs synth_1]]
set ref2 [get_property needs_refresh [get_runs impl_1]]
puts $st1
puts $st2
puts $pr1
puts $pr2
puts $ref1
puts $ref2

if { $ref1 == 0 && $ref2 == 0 && $pr1 == "100%" && $pr2 == "100%" && $st1=="synth_design Complete!" && $st2=="write_bitstream Complete!"} {
    puts "TSOTNE: no need to Regenerate bitstream"
} else {
    puts "TSOTNE: sources changed, bitstream needs to be regenerated"

#generate .bit
#synthesis

#reset_run synth_1
#open_run synth_1
if { [file exists ${PROJ_PATH}/${PROJ_NAME}/checkpoint_synth_1.dcp] == 1 } {
    open_run synth_1
    read_checkpoint -incremental ${PROJ_PATH}/${PROJ_NAME}/checkpoint_synth_1.dcp
} else {
    reset_run synth_1
    launch_runs synth_1
    wait_on_run synth_1
}
open_run synth_1
#TODO: if it is successful
exec touch ${PROJ_PATH}/${PROJ_NAME}/checkpoint_synth_1.dcp
write_checkpoint ${PROJ_PATH}/${PROJ_NAME}/checkpoint_synth_1.dcp -force
close_design

#implementation
#reset_run impl_1
#open_run impl_1
if { [file exists ${PROJ_PATH}/${PROJ_NAME}/checkpoint_impl_1.dcp] == 1 } {
    open_run impl_1
    read_checkpoint -incremental ${PROJ_PATH}/${PROJ_NAME}/checkpoint_impl_1.dcp
} else {
    reset_run impl_1
    launch_runs impl_1
    wait_on_run impl_1
}
open_run impl_1
#TODO: if it is successful
exec touch ${PROJ_PATH}/${PROJ_NAME}/checkpoint_impl_1.dcp
write_checkpoint ${PROJ_PATH}/${PROJ_NAME}/checkpoint_impl_1.dcp -force
close_design

#bitstream
write_bitstream ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.runs/impl_1/${BLOCK_DESIGN}_wrapper.bit -force

#reset_run synth_1
#launch_runs impl_1 -to_step write_bitstream -jobs 1
#wait_on_run impl_1

puts "TSOTNE: generated bitstream"
write_checkpoint ${PROJ_PATH}/${PROJ_NAME}/incremental_compile.dcp -force
puts "TSOTNE: checkpoint written"
}

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
puts "TSOTNE: exported to sdk"

#launch SDK and exit vivado
set v6 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk
set v7 ${PROJ_PATH}/${PROJ_NAME}/${PROJ_NAME}.sdk/${BLOCK_DESIGN}_wrapper.hdf

if { [file exists ${v5_1}] == 0 } {
    puts "TSOTNE: launching sdk to automatically create specific folder called: ${HW_PLATFORM_N}"
    launch_sdk -workspace ${v6} -hwspec ${v7} } else { puts "TSOTNE: no need to launch SDK"
}
puts "TSOTNE: exiting vivado"
exit
############################
