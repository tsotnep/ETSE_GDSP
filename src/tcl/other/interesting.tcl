setenv SWT_GTK3 0
setenv LC_ALL en_US.UTF-8
xsdk -batch


################ nice commands
#http://www.xilinx.com/support/answers/47491.html
get_property PROGRESS [get_runs synth_1]
100%

#http://www.xilinx.com/support/answers/47491.html
get_property NEEDS_REFRESH [get_runs synth_1]
1

list_property [get_runs synth_1]
CURRENT_STEP CLASS CONSTRSET DESCRIPTION DIRECTORY STATS.ELAPSED STATS.TNS STATS.THS STATS.WNS STATS.WHS STATS.TPWS STATS.FAILED_NETS FLOW IS_IMPLEMENTATION IS_SYNTHESIS NAME NEEDS_REFRESH PARENT PART PROGRESS SRCSET STATUS STRATEGY INCREMENTAL_CHECKPOINT STEPS.SYNTH_DESIGN.TCL.PRE STEPS.SYNTH_DESIGN.TCL.POST STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY STEPS.SYNTH_DESIGN.ARGS.GATED_CLOCK_CONVERSION STEPS.SYNTH_DESIGN.ARGS.BUFG STEPS.SYNTH_DESIGN.ARGS.FANOUT_LIMIT STEPS.SYNTH_DESIGN.ARGS.DIRECTIVE STEPS.SYNTH_DESIGN.ARGS.FSM_EXTRACTION STEPS.SYNTH_DESIGN.ARGS.KEEP_EQUIVALENT_REGISTERS STEPS.SYNTH_DESIGN.ARGS.RESOURCE_SHARING STEPS.SYNTH_DESIGN.ARGS.CONTROL_SET_OPT_THRESHOLD STEPS.SYNTH_DESIGN.ARGS.NO_LC STEPS.SYNTH_DESIGN.ARGS.SHREG_MIN_SIZE STEPS.SYNTH_DESIGN.ARGS.MAX_BRAM STEPS.SYNTH_DESIGN.ARGS.MAX_DSP STEPS.SYNTH_DESIGN.ARGS.CASCADE_DSP {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS}




################ MAIL
# somehow it doest not even go in spam, anymore.

set DATE [exec date]
set msg {From: VIVADO_BITSTREAM@tsotnep-pc.com}
append msg \n "To: "  [join tsotnep@gmail.com]
append msg \n "Subject: VIVADO_JOB_START"
append msg \n\n job start date : $DATE
exec /usr/lib/sendmail -oi -t << $msg






################ TIME
set compileTime [clock format [clock seconds] -format {32’h%y%m%d%H}]


################ EXISTence of file
puts {file exists interesting.tcl}





################  COMPILE LIB
compile_simlib -language vhdl -dir {/home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP/ETSE_GDSP.cache/compile_simlib} -simulator questa -simulator_exec_path {/cad/eda/mentor/2015-16/RHELx86/AMS_15.3.1/questasim/v10.4c_1/bin} -library all -family  all -no_ip_compile -force
