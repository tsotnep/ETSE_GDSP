#original
setws workspace
createhw -name hw_0 -hwspec <path-to-HDF>
createapp -name fsbl -app {Zynq MP FSBL} -proc psu_cortexa53_0 -hwproject hw_0 -os standalone
projects -build
closehw <path-to-HDF>




# default
set dir /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/
set src /home/tsotne/ownCloud/git/ETSE_GDSP/src/app/MMULT_AXI_2_DDR3/src/




# XSCT
source /cad/x_16/SDK/2016.1/settings64.sh
xsdk -batch


set dir /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/
setws $dir
createhw -name hw_0 -hwspec ./design_1_wrapper.hdf



# SDK
set origin /home/tsotne/ownCloud/git/ETSE_GDSP
file copy -force ${origin}/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.runs/impl_1/design_1_wrapper.sysdef ${origin}/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/design_1_wrapper.hdf
launch_sdk -workspace ${origin}/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk -hwspec ${origin}/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/design_1_wrapper.hdf -verbose



# OPEN PROJECT
cd ~/ownCloud/git/ETSE_GDSP/src/tcl/
vivado  ../../tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.xpr



# COMPILE LIB
compile_simlib -language vhdl -dir {/home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP/ETSE_GDSP.cache/compile_simlib} -simulator questa -simulator_exec_path {/cad/eda/mentor/2015-16/RHELx86/AMS_15.3.1/questasim/v10.4c_1/bin} -library all -family  all -no_ip_compile -force




#environment
export LC_ALL="en_US.UTF-8"
source /cad/x_16/SDK/2016.1/settings64.sh
export MYVIVAO=/home/tsotne/Downloads/xsct
xsct

setenv LC_ALL en_US.UTF-8
source /cad/x_16/SDK/2016.1/settings64.csh
setenv MYVIVADO /home/tsotne/Downloads/xsct
xsct


source /cad/x_16/SDK/2016.1/settings64.sh
xsct


set SDK_WORKSPACE /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/
set HW_DEF ./design_1_wrapper.hdf
set HW_PROJ bd_wrapper_hw
set SA_BSP_PROJ standalone_bsp
set APP_PROJ app_standalone

# set the SDK workspace
sdk set_workspace $SDK_WORKSPACE
# create the hardware outputs in SDK
sdk create_hw_project -name HWPROJ -hwspec $HW_DEF
# create the standalone BSP
sdk create_bsp_project -name $SA_BSP_PROJ -hwproject $HW_PROJ -proc microblaze_0 -os standalone
# create application
sdk create_app_project -name $APP_PROJ -hwproject $HW_PROJ -proc microblaze_0 -bsp $SA_BSP_PROJ
# build the application
sdk build_project
exit
