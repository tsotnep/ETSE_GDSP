set origin /home/tsotne/ownCloud/git/ETSE_GDSP
# source /home/tsotne/ownCloud/git/ETSE_GDSP/src/tcl/create_baremetal_app.tcl

#How to run
  #correct line 1
  #launch XSDK -batch
  #source this script
  #finishes in 10 sec

#What it does and what you have to do:
  #compiles baremetal application out of sources located in src/app-baremetal/ETSE_GDSP_DMA
  #stores executable in ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/ETSE_GDSP_DMA/Debug/ETSE_GDSP_DMA.elf


file delete -force hw_0
file delete -force .metadata
file delete -force ETSE_GDSP_DMA
file delete -force ETSE_GDSP_DMA_bsp

setws ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/
createhw -name hw_0 -hwspec ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/design_1_wrapper.hdf
createapp -os standalone -proc ps7_cortexa9_0 -app {Hello World} -name ETSE_GDSP_DMA -hwproject hw_0
file copy -force $origin/src/app-baremetal/mylib.h ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/ETSE_GDSP_DMA/src/
file copy -force $origin/src/app-baremetal/ETSE_GDSP_DMA/ETSE_GDSP_DMA.c ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/ETSE_GDSP_DMA/src/
file delete ${origin}/tmp/projects/ETSE_GDSP_DMA_ETHERNET/ETSE_GDSP_DMA_ETHERNET.sdk/ETSE_GDSP_DMA/src/helloworld.c
projects -build
exit
