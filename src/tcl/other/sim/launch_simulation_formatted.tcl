#tested on Xilinx vivado 2015.2, linux
#this script simulates opened design once, launches XSIM simulator GUI with specified waveform in argument "-view"
source ../generics.tcl

#workflow: go to project directory, compile vhdl sources, execute simulation, go back to script directory.
# if it faces any kind of error during this workflow, it catches error, prints log, goes back to script directory.
    if { \
      [catch { \
      cd $PROJECTLOCATION; \
      set i $m; \
      exec xelab -mt auto -log ./generated/log/LOG_XELAB_${i}.log -generic_top "COLUMN_TOTAL=$i" -prj  $PROJECTLOCATION/${PROJECTNAME}.sim/sim_1/behav/TB_MATRIX_MUL_IP_CORE_${PROJECTNAME}_vhdl.prj -debug typical xil_defaultlib.TB_MATRIX_MUL_IP_CORE_${PROJECTNAME} -s ${i}; \
      exec xsim ${i} -gui -log ./generated/log/LOG_XSIM_${i}.log -tclbatch $TCLDIR/tclbatch_for_sim.tcl -wdb ./generated/wdb/${i} -view $ORIGIN/src/tb/all_waves_in_groups_S_INT_G.wcfg; \
      cd $TCLDIR } \
      err] } { \
        cd $TCLDIR; \
        puts "\n\n**********BAD. THERE WAS AN ERROR WHILE TRYING TO SIMULATE**********\n LOG : \n"; \
        puts $err \
    } else { \
      puts "\n\n**********GOOD. SIMULATION WAS SUCCESSFUL**********\n\n" \
    }
