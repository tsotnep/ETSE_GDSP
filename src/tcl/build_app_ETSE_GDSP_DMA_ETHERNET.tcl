set origin /home/tsotne/ownCloud/git/ETSE_GDSP
# source /cad/x_16/Vivado/2016.1/settings64.sh
# xsct -eval source /home/tsotne/ownCloud/git/ETSE_GDSP/src/tcl/build_app_ETSE_GDSP_DMA_ETHERNET.tcl

#How to run
  #correct line 1:3
  #launch XSDK -batch
  #source this script
  #finishes in 10 sec

#What it does and what you have to do:
  #compiles baremetal application out of sources located in src/app-baremetal/ETSE_GDSP_DMA_ETHERNET
  #stores executable in ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/ETSE_GDSP_DMA_ETHERNET/Debug/ETSE_GDSP_DMA_ETHERNET.elf
  #Note that if you then modify C application in SDK you have to manually CLEAN and BUILD it, since it does not do rebuild automatically

cd ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/
file delete -force hw_2
file delete -force .metadata
file delete -force ETSE_GDSP_DMA_ETHERNET
file delete -force ETSE_GDSP_DMA_ETHERNET_bsp

setws ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/
createhw -name hw_2 -hwspec ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/design_1_wrapper.hdf
createapp -os standalone -proc ps7_cortexa9_0 -app {lwIP Echo Server} -name ETSE_GDSP_DMA_ETHERNET -hwproject hw_2
# file copy -force $origin/src/app-baremetal/mylib.h ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/ETSE_GDSP_DMA_ETHERNET/src/
# file copy -force $origin/src/app-baremetal/ETSE_GDSP_DMA/ETSE_GDSP_DMA.c ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/ETSE_GDSP_DMA_ETHERNET/src/
# file delete ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/ETSE_GDSP_DMA/src/helloworld.c
projects -build
exit
