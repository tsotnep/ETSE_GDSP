readme for dir: ETSE_GDSP/src/tcl


## List of Content

* generics.tcl  -this file is used in all other tcl scripts, it should be changed on each computer, according to the location of the root folder of the project. it holds the variable values, for:
    * project name
    * project root location
    * minimum and maximum number of matrix column size, that is used in loop


* vivado/:
    * create_new_project.tcl    -this script creates new project with a name specified in generics.tcl into a folder: ETSE_GDSP/project/vivado/$PROJECTNAME, adds sources to it and creates *.prj file, that is used in simulate_created_project.tcl file
    * simulate_created_project.tcl  -this script automatically simulates the design with a variable number of times that is specified in generics.tcl
    * ip_creation_script.tcl    -in case you want to change DSP and BRAM configuration, then you can use this script as helper. currently those xilinx IPs are already generated and added to the repository. this file also uses generics.tcl P.S. I could have included that into create_new_project.tcl but generation takes time, so I prefered to have generated xilinx IP cores in repo.


## How to Run:

* in linux, launch the terminal, and source the vivado:
    * source /opt/Xilinx/SDK/2015.2/settings64.sh
* then go into the directory folder ETSE_GDSP/src/tcl/vivado:
    * cd ~/git/ETSE_GDSP/src/tcl/vivado
* launch the vivado in tcl mode, without log and journal (~ 50 sec):
    * vivado -mode tcl -nolog -nojournal
* create the new project from tcl (~ 125 sec):
    * source create_new_project.tcl
* simulate the design with range of column size specified in generics.tcl file. (3:3 ~ 28sec; 3:4 ~ 55 sec; 3:5 ~ 80 sec)
    * source simulate_created_project.tcl



## Simulation Times

according to matrix size (rest of the time is for opening and closing vivado tools):

* 3x3   =  5845 ns
* 4x4   =  7385 ns
* 5x5   =  9365 ns
* 6x6   = 11785 ns
* 7x7   = 14645 ns
* 8x8   = 17945 ns
* 9x9   = 21685 ns
* 10x10 = 25865 ns


## When NOT to worry:

* when running simulation script, it gives you a warning that "close_sim" is not supported in conditional statement, but dont worry, it still works.
