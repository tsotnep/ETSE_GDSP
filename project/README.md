readme for dir: ETSE_GDSP/project/

Open any of the project:

for Xilinx ISE:

    ETSE_GDSP/project/ISE/*.xsise

for Xilinx Vivado:

    ETSE_GDSP/project/Vivado/*.xpr

and then run the simulation. if the simulation is successful, it will print out the result of the IP core
on the console. It will also create two text files bearing the name of the project but one of the files will have CSV
appended to it. The CSV version is for convenience in case you need to import the results to another application for further analysis. Those files will be created in directory:

    ETSE_GDSP/src/io/

If you run the simulation and it does not print out the result on the console window then do the following.

1. stop the simulation
2. Change the simulation time from 1000 ns to at least 11000 ns.
3. run the simulation again.

If it still does not run properly then probably a file is missing in the **ETSE_GDSP/src/lib/** (1) or in **ETSE_GDSP/src/io/** (2) directories, this directories hold following important files that the Test benches of the project use for simulation

(1):
- MATRIX_MUL_IP_CORE_LIBRARY_Sim.vhd
- MATRIX_MUL_IP_CORE_LIBRARY_Syn.vhd
- txt_util.vhd


(2):
- Gdata.txt
- Pdata.txt
- Real_Gdata.txt
- Real_Pdata.txt

Make sure these files are present in the correct place. To see their purpose, check their README in corresponding folder
