#this script is executed during simulation, it defines stop statement and exits simulation

#tell simulator when to stop
    add_condition -name StoppingCondition1 {/TB_MATRIX_MUL_IP_CORE_S_INT/when_to_stop_simulation_flag == 1 } {
        puts "Condition when_to_stop_simulation_flag==1 was encountered at [current_time]. Stopping simulation."
        close_sim}



#run forever until the condition above
    run -all


#TODO: TB_MATRIX_MUL_IP_CORE_S_INT can NOT be set into proper varying value
#1. sourcing generics and then : TB_MATRIX_MUL_IP_CORE_${PROJECTNAME}
#2. by : set TB_TOP TB_MATRIX_MUL_IP_CORE_S_INT
# this: puts [pwd] ->>>/home/tsotne/git/ETSE_GDSP/src/tcl/vivado
#i don't know solution yet.
#even if this problem will be fixed, for example, add multiple conditions simultaneously, and any of them will be correct, TB*.vhd files are not fixed yet.
