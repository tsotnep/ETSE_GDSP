set origin /home/tsotne/ownCloud/git/ETSE_GDSP
# source /cad/x_16/Vivado/2016.1/settings64.sh
# xmd -tcl /home/tsotne/ownCloud/git/ETSE_GDSP/src/tcl/program_fpga_BITSTREAM_APP.tcl

#setting Hardware Design and Application names
  #if you are programming app: FSBL
  # set HW hw_0
  # set NAME FSBL

  #if you are programming app: ETSE_GDSP_DMA
  # set HW hw_1
  # set NAME ETSE_GDSP_DMA

  #if you are programming app: ETSE_GDSP_DMA_ETHERNET
  set HW hw_2
  set NAME ETSE_GDSP_DMA_ETHERNET

#How to run
  #correct line 1:15
  #launch XMD (either in SDK (Xilinx Tools > XMD console), or in linux terminal by sourcing xilinx's settings64.sh and then typing : xmd )

#What it does and what you have to do:
  #before you run this script, on your PC - you should listen to uart that is connected to zedboard zynq 7000 (note that another uart is for programming it)
    #in Linux : picocom -b 115200 /dev/ttyACM0
    #or in SDK, in SDK Terminal : add new connection to serial port with port name "/dev/ttyACM0" (in windows port name will be different)
    #if you run the script before reading previous two lines, rerun the script or type '0' in terminal
  #Reset connection with FPGA, then connect and Reset FPGA
  #Program FPGA with bitstream
  #Initialize ZYNQ processing system with default script
  #Program FPGA with custom Baremetal APP
  #Run APM
############################

xdisconnect -cable
connect arm hw
rst -srst
fpga -f $origin/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/$HW/design_1_wrapper.bit
source $origin/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/$HW/ps7_init.tcl
ps7_init
ps7_post_config
dow $origin/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/$NAME/Debug/$NAME.elf
run
