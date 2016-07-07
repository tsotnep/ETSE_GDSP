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
echo "xvhdl -m64 --relax -prj TB_MATRIX_MUL_IP_CORE_S_INT_vhdl.prj"
ExecStep $xv_path/bin/xvhdl -m64 --relax -prj TB_MATRIX_MUL_IP_CORE_S_INT_vhdl.prj 2>&1 | tee -a compile.log
