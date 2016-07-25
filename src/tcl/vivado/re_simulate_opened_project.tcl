#tested on Xilinx vivado 2015.2, linux
#this script simulates opened design once.
source ../generics.tcl

#open the project
    cd $PROJECTLOCATION

    set i $m
    exec xelab -mt auto -log ./generated/log/LOG_XELAB_${i}.log -generic_top "COLUMN_TOTAL=$i" -prj  $PROJECTLOCATION/${PROJECTNAME}.sim/sim_1/behav/TB_MATRIX_MUL_IP_CORE_${PROJECTNAME}_vhdl.prj -debug typical xil_defaultlib.TB_MATRIX_MUL_IP_CORE_${PROJECTNAME} -s ${i}

    xsim ${i} -log ./generated/log/LOG_XSIM_${i}.log -onfinish quit -tclbatch $TCLDIR/tclbatch_for_sim.tcl -wdb ./generated/wdb/${i}

#go back to original directory:
    cd $TCLDIR



    if { [catch
        {
                add_condition -name StoppingCondition0 {/TB_MATRIX_MUL_IP_CORE_S_INT/when_to_stop_simulation_flag == 1}{
                puts "Condition when_to_stop_simulation_flag==1 was encountered at [current_time]. Stopping simulation."
                close_sim}
        } err]
        }
        {puts ""}
    else { puts "\n\n**********SIMULATION WAS SUCCESSFUL**********\n\n" }
