#original
setws workspace
createhw -name hw_0 -hwspec <path-to-HDF>
createapp -name fsbl -app {Zynq MP FSBL} -proc psu_cortexa53_0 -hwproject hw_0 -os standalone
projects -build
closehw <path-to-HDF>




# default
set dir /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/
set src /home/tsotne/ownCloud/git/ETSE_GDSP/src/app/MMULT_AXI_2_DDR3/src/




#what i did
setws workspace
set dir /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/
createhw -name hw_0 -hwspec $dir/design_1_wrapper.hdf
