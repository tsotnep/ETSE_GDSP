set origin /home/tsotne/ownCloud/git/ETSE_GDSP
set SIM $origin/tmp/projects/ETSE_GDSP/ETSE_GDSP.sim/sim_2
set m 3
set M 20
# source /cad/x_16/Vivado/2016.1/settings64.sh
# vivado -mode tcl -source /home/tsotne/ownCloud/git/ETSE_GDSP/src/tcl/simulate_ip_ETSE_GDSP.tcl

#How to run

#What it does and what you have to do:
############################

close_project -quiet
open_project $origin/tmp/projects/ETSE_GDSP/ETSE_GDSP.xpr
current_fileset -simset [ get_filesets sim_2 ]

file mkdir $origin/src/diff-hdlsim-matlab/hdlsim/
file mkdir $origin/src/diff-hdlsim-matlab/hdlsim/r
file mkdir $origin/src/diff-hdlsim-matlab/hdlsim/rCSV

generate_target {instantiation_template} [get_files ${origin}/projects/vivado/S_INT_G/S_INT_G.srcs/sources_1/ip/DSP_INPUT_C/DSP_INPUT_C.xci]
generate_target {instantiation_template} [get_files ${origin}/projects/vivado/S_INT_G/S_INT_G.srcs/sources_1/ip/BRAM18x1k/BRAM18x1k.xci]



for {set i $m} {$i < $M + 1} {incr i} {
  set_property generic COLUMN_TOTAL=$i [get_filesets sim_2]
  launch_simulation
  if { [catch { add_condition -name StoppingCondition1 {/sim_TB_MATRIX_MUL_IP_CORE_S_INT_G/when_to_stop_simulation_flag == 1 } {
    puts "Condition when_to_stop_simulation_flag==1 was encountered at [current_time]. Stopping simulation."
    close_sim \
  } } err] } {puts ""} \
  else { \
    puts "\n\n**********GOOD. STOPPING CONDITION ADDED**********\n\n" \
  }
  run -all
  close_sim
}


exit
