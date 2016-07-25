#tested on Xilinx vivado 2015.2, linux
#this script is executed during simulation, it defines stop statement and exits simulation

#tell simulator when to stop

    if { [catch { add_condition -name StoppingCondition0 {/TB_MATRIX_MUL_IP_CORE_S_INT/when_to_stop_simulation_flag == 1 } {
            puts "Condition when_to_stop_simulation_flag==1 was encountered at [current_time]. Stopping simulation."
            close_sim} } err] } {puts ""} else { puts "\n\n**********GOOD. STOPPING CONDITION ADDED**********\n\n" }

    if { [catch { add_condition -name StoppingCondition1 {/TB_MATRIX_MUL_IP_CORE_S_INT_G/when_to_stop_simulation_flag == 1 } {
            puts "Condition when_to_stop_simulation_flag==1 was encountered at [current_time]. Stopping simulation."
            close_sim} } err] } {puts ""} else { puts "\n\n**********GOOD. STOPPING CONDITION ADDED**********\n\n" }

    if { [catch { add_condition -name StoppingCondition2 {/TB_MATRIX_MUL_IP_CORE_S_REAL/when_to_stop_simulation_flag == 1 } {
            puts "Condition when_to_stop_simulation_flag==1 was encountered at [current_time]. Stopping simulation."
            close_sim} } err] } {puts ""} else { puts "\n\n**********GOOD. STOPPING CONDITION ADDED**********\n\n" }

    if { [catch { add_condition -name StoppingCondition3 {/TB_MATRIX_MUL_IP_CORE_CV_INT/when_to_stop_simulation_flag == 1 } {
            puts "Condition when_to_stop_simulation_flag==1 was encountered at [current_time]. Stopping simulation."
            close_sim} } err] } {puts ""} else { puts "\n\n**********GOOD. STOPPING CONDITION ADDED**********\n\n" }

    if { [catch { add_condition -name StoppingCondition4 {/TB_MATRIX_MUL_IP_CORE_CV_REAL/when_to_stop_simulation_flag == 1 } {
            puts "Condition when_to_stop_simulation_flag==1 was encountered at [current_time]. Stopping simulation."
            close_sim} } err] } {puts ""} else { puts "\n\n**********GOOD. STOPPING CONDITION ADDED**********\n\n" }

#run forever until the condition above
    run -all
