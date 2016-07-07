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
ExecStep $xv_path/bin/xelab -wto ac035f28dc8c49b7a4c515461ee0ff18 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L blk_mem_gen_v8_2 -L xbip_dsp48_wrapper_v3_0 -L xbip_utils_v3_0 -L xbip_pipe_v3_0 -L xbip_dsp48_macro_v3_0 -L secureip --snapshot TB_MATRIX_MUL_IP_CORE_S_INT_behav xil_defaultlib.TB_MATRIX_MUL_IP_CORE_S_INT -log elaborate.log