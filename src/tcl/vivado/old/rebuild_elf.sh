cd /home/tsotne/ownCloud/git/ETSE_GDSP/src/app/DMA/simple_transfer/Debug
export PATH=$PATH:/cad/x_16/SDK/2016.1/gnu/arm/lin/bin

make clean 2>&1 | egrep -i --color "\b(error|warning)\b"
make all 2>&1| egrep -i --color "\b(error|warning)\b"
