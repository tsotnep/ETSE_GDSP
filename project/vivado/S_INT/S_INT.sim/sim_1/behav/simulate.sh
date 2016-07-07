#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2015.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim TB_MATRIX_MUL_IP_CORE_S_INT_behav -key {Behavioral:sim_1:Functional:TB_MATRIX_MUL_IP_CORE_S_INT} -tclbatch TB_MATRIX_MUL_IP_CORE_S_INT.tcl -log simulate.log
