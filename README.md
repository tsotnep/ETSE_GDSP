readme for dir: ETSE_GDSP/

## Readmes in this repo:

* [./Readme.md](https://github.com/tsotnep/ETSE_GDSP)
* [./Documentation/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/Documentation)
* [./ip_cores/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/ip_cores)
* [./project/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/project)
* [./src/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/src)
* [./src/matlab/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/src/matlab)
* [./src/tcl/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/src/tcl)



## List of Content

    -Documentation  -technical documentation of the ETSE_GDSP IP
    -ip_cores       -ip cores that can be used/imported in any Xilinx ISE or Xilinx Vivado project.
    -project        -project files for Xilinx ISE and Xilinx Vivado, that perform the behavioral simulation
    -src            -source files for the ip. it contains:
        -hdl/ *.vhd VHDL source files
        -ip/ DSP and BRAM ip cores that are used in ISE and Vivado projects
        -lib/ *.vhd VHDL libraries, that are used for simulation OR synthesis
        -matlab/ *.m matlab files that are used for generating Input matrix P and G data (stored in ./p ./g and results in ./r)
        -results/ *.txt files, results of vhdl simulation, performed by Xsim. normal and CSV format of matrix
        -tb/ *.vhd and *.wcfg VHDL and Waveform files for simulation
        -tcl/ *.tcl files for TCL scripts


**Please note that you should not change any name existing in the project. everything is connected.**


TODO:

    ip_cores/ise        -check
    ip_cores/vivado     -create
    project/ise         -create
    in src/tcl/vivado/create_new_project.tcl
    in src/tcl/vivado/tclbatch_for_sim.tcl
