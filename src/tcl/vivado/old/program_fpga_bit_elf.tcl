#Description:
#Reset connection with FPGA, then connect and Reset FPGA
#Program FPGA with bitstream
#Initialize ZYNQ processing system with default script
#Program FPGA with FSBL
#Program FPGA with custom Baremetal APP
#Run APP
############################


xdisconnect -cable
connect arm hw
rst -srst
fpga -f /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/design_1_wrapper_hw_platform_0/design_1_wrapper.bit
source /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/design_1_wrapper_hw_platform_0/ps7_init.tcl
ps7_init
ps7_post_config
dow /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/simple_transfer_3/Debug/simple_transfer_3.elf
run

#rst -processor
