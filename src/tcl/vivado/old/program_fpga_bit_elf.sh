#Description:
#Reset connection with FPGA, then connect and Reset FPGA
#Program FPGA with bitstream
#Initialize ZYNQ processing system with default script
#Program FPGA with custom Baremetal APP
#Run APP
############################

source /cad/x_16/SDK/2016.1/settings64.sh

cd /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/
mkdir ETSE_GDS_APP
cd ETSE_GDS_APP

export PATH=$PATH:/cad/x_16/SDK/2016.1/gnu/arm/lin/bin

make clean 2>&1 | egrep -i --color "\b(error|warning)\b"
make all 2>&1| egrep -i --color "\b(error|warning)\b"


xmd -tcl /home/tsotne/ownCloud/git/ETSE_GDSP/src/tcl/vivado/old/program_fpga_bit_elf.tcl



set dir /home/tsotne/ownCloud/git/ETSE_GDSP/tmp/projects/ETSE_GDSP_DMA/ETSE_GDSP_DMA.sdk/
set src /home/tsotne/ownCloud/git/ETSE_GDSP/src/app/MMULT_AXI_2_DDR3/src/


#generate app in hsi
open_hw_design  $dir/design_1_wrapper.hdf
generate_app -os standalone -proc ps7_cortexa9_0 -app empty_application -sw AppName -dir ./ #it does not use AppName anyway.
file copy -force $src/main.c  ./empty_application_bsp/ps7_cortexa9_0/code/
file copy -force $src/mylib.h  ./empty_application_bsp/ps7_cortexa9_0/code/


#then in bash terminal:
source /cad/x_16/SDK/2016.1/settings64.sh
export PATH=$PATH:/cad/x_16/SDK/2016.1/gnu/arm/lin/bin
make all

#generate_app -os standalone -proc ps7_cortexa9_0 -app hello_world -sw ETSE_GDS_APP -dir ./  -compile
#generate_app -os standalone -proc ps7_cortexa9_0 -app zynq_fsbl -sw ETSE_GDS_APP -dir ./  -compile



generate_app -compile


--------
xsdk -batch
setw ./
createhw -name hw1 -hwspec system.hdf
