#Description:
#Crosscompiles the Baremetal Application for ARM architecture (generates .elf file)
############################

#Variables:
source Generics
############################

GO_BACK=`pwd`

cd $PROJ_PATH/${PROJ_NAME}/${PROJ_NAME}.sdk/${APP_NAME}/Debug/
export PATH=$PATH:${SDK_BINARIES}
make clean all
make all

cd ${GO_BACK}
############################
