#Description:
#Crosscompiles the Baremetal Application for ARM architecture (generates .elf file)
############################

#Variables:
source Generics
############################

GO_BACK=`pwd`

cd $PROJ_PATH/${PROJ_NAME}/${PROJ_NAME}.sdk/${APP_NAME}/Debug/
export PATH=$PATH:${SDK_BINARIES}
make clean all | egrep -i --color "\b(error|warning|elf)\b"
make all | egrep -i --color "(error|warning)|$" 

#"\b(error)\b|#" - for separate words

cd ${GO_BACK}
############################
