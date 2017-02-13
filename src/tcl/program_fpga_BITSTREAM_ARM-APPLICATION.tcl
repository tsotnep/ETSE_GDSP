set origin /home/tsotne/ownCloud/git/ETSE_GDSP

#How to run
  #correct line 1
  #launch XMD
  #source this script

#What it Does:
  #Reset connection with FPGA, then connect and Reset FPGA
  #Program FPGA with bitstream
  #Initialize ZYNQ processing system with default script
  #Program FPGA with custom Baremetal APP
  #Run APP
############################

xdisconnect -cable
connect arm hw
rst -srst
fpga -f $origin/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/design_1_wrapper_hw_platform_0/design_1_wrapper.bit
source $origin/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/design_1_wrapper_hw_platform_0/ps7_init.tcl
ps7_init
ps7_post_config
dow $origin/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/ether/Debug/ETSE_GDSP_DMA_ETHERNET.elf
run
