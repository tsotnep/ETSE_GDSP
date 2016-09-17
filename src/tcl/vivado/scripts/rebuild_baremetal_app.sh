#Description:
#Crosscompiles the Baremetal Application for ARM architecture (generates .elf file)
############################

#Variables:
PROJ_PATH=/home/tsotne/workspaceVivado
PROJ_NAME=MMULT_AXI_STREAM
APP_NAME=zapp_1
SDK_BINARIES=/opt/Xilinx/SDK/2015.2/gnu/arm/lin/bin
source Generics
############################

GO_BACK=`pwd`

cd $PROJ_PATH/${PROJ_NAME}/${PROJ_NAME}.sdk/${APP_NAME}/Debug/
export PATH=$PATH:${SDK_BINARIES}
make clean all
make all

cd ${GO_BACK}
############################
