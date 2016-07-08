open_project S_INT/S_INT.xpr


xelab -prj S_INT/S_INT.sim/sim_1/behav/TB_MATRIX_MUL_IP_CORE_S_INT_vhdl.prj



xvhdl file2.vhd

xelab -debug typical top -s top_sim

xsim top_sim -gui -t xsim_run.tcl
