#############################################################################################################################################
This directory contains separate IP cores in their own separate projects. 


1. MATRIX_MUL_IP_CORE_CV_INT -- This is a Matrix Multiplier IP core for multiplying an integer square matrix P, by an integer column vector G.
2. MATRIX_MUL_IP_CORE_CV_REAL-- This is a Matrix Multiplier IP core for multiplying a real square matrix P, by a real column vector G.
1. MATRIX_MUL_IP_CORE_S_INT -- This is a Matrix Multiplier IP core for multiplying an integer square matrix P, by an integer square matrix G.
2. MATRIX_MUL_IP_CORE_S_REAL-- This is a Matrix Multiplier IP core for multiplying a real square matrix P, by a real square matrix G..

Please note that most of the projects share some common files in the following directories

1. 	ETSE_GDSP->SharedLibraries
2.	ETSE_GDSP->IPCores
3.	ETSE_GDSO->TestingFiles

In order to run any of this project successfully, open with xilinx ise version 14.7, if you are using a lower
version of ISE then you may have to re-create the project and manually add the files.

Please also note that these projects use Xilinx BRAM and DSP48 IP cores and these cores have the .xco extension
as BRAM181k.xco (for Block RAM) and DSP_INPUT_C.xco (For DSP48 block). If you are recreating the project because
you have an older version of ISE then make sure to add these .xco files to the project 
using the following the path: ETSE_GDSP->IPCores->BRAM_and_DSP->ipcore_dir
#############################################################################################################################################

############HOW TO RUN THE PROJECT SIMULATION################################################################################################

Open any of the project select simulation then run. if the simulation is successful, it will print out the result of the IP core
on the console. It will also create two text files bearing the name of the project but one of the files will have CSV
appended to it. The CSV version is for convenience in case you need to import the results to another application for further analysis.

If you run the simulation and it does not print out the result on the console window then do the following.

1. stop the simulation
2. Change the simulation time from 1000 ns to atleast 11000 ns.
3. run the simulation again.

If it still does not run properly then probably a file is missing in the ETSE_GDSP->TestingFiles directory, this directory
holds four important files that the Test benches of the project use for simulation

1. Gdata.txt
2. Pdata.txt
3. Real_Gdata.txt
4. Real_Pdata.txt

Make sure these files are present in the directory.
###########################################################################################################################