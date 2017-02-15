set origin /home/tsotne/ownCloud/git/ETSE_GDSP
# source ${origin}/src/tcl/build_zynq_fsbl.tcl

#How to run
  #correct line 1
  #launch XSDK -batch
  #source this script
  #finishes in 10 sec

#What it does and what you have to do:
  #creates FSBL in ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/FSBL/Debug/FSBL.elf


file delete -force hw_1
file delete -force .metadata
file delete -force FSBL
file delete -force FSBL_bsp

setws ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/
createhw -name hw_1 -hwspec ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/design_1_wrapper.hdf
createapp -os standalone -proc ps7_cortexa9_0 -app {Zynq FSBL} -name FSBL -hwproject hw_1
projects -build
exit
