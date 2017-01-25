#Description:
#regenerate bitstream (update IPs, export to SDK)
#build zynq FSBL if necessary
#recompile baremetal application
#program FPGA with FSBL and baremetal APP
############################

#Variables:
#no variables
source Generics
############################


source regenerate_bit_export_sdk.sh
# source build_zynq_fsbl.sh
source chain_compile_app_program_fpga.sh
############################
