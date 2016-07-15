#tested on Xilinx vivado 2015.2, linux
#this script creates a loop, increments COLUMN_TOTAL and compiles *.vhd files for each size
source ../generics.tcl

#go into the project directory and create folders for logs
    cd $PROJECTLOCATION
    file mkdir generated
    file mkdir generated/log
    file mkdir generated/wdb


#open the project
    close_project -quiet
    open_project $PROJECTLOCATION/$PROJECTNAME.xpr

#loop for compiling TB_MATRIX_MUL_IP_CORE_${PROJECTNAME}.vhd file with generic parameter COLUMN_TOTAL varying in range specified on next line. manual for Xelab - http://www.xilinx.com/support/documentation/sw_manuals/xilinx2012_2/ug900-vivado-logic-simulation.pdf
    for {set i $m} {$i < $M + 1} {incr i} {
        exec xelab -mt auto -log ./generated/log/LOG_XELAB_${i}.log -generic_top "COLUMN_TOTAL=$i" -prj  $PROJECTLOCATION/${PROJECTNAME}.sim/sim_1/behav/TB_MATRIX_MUL_IP_CORE_${PROJECTNAME}_vhdl.prj -debug typical xil_defaultlib.TB_MATRIX_MUL_IP_CORE_${PROJECTNAME} -s ${i}
        xsim ${i} -log ./generated/log/LOG_XSIM_${i}.log -onfinish quit -tclbatch $TCLDIR/tclbatch_for_sim.tcl -wdb ./generated/wdb/${i}
    }

#close the project, otherwise, if you rerun the script, it tells you to close the project
    close_project -quiet
    #close_sim -force -quiet

#go back to original directory:
    cd $TCLDIR
