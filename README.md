readme for dir: ETSE_GDSP/

## Readmes in this repo:

* [./Readme.md](https://github.com/tsotnep/ETSE_GDSP)
* [./Documentation/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/Documentation)
* [./ip_cores/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/ip_cores)
* [./project/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/project)
* [./src/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/src)
* [./src/diff/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/src/diff)
* [./src/matlab/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/src/matlab)
* [./src/tcl/README.md](https://github.com/tsotnep/ETSE_GDSP/tree/master/src/tcl)



## List of Content

    -Documentation  -technical documentation of the ETSE_GDSP IP
    -ip_cores       -ip cores that can be used/imported in any Xilinx ISE or Xilinx Vivado project.
    -project        -project files for Xilinx ISE and Xilinx Vivado, that perform the behavioral simulation
    -src            -all kind of source files for the ip.

**Please note that you should not change any name existing in the project. everything is connected.**


TODO:

    start working on AXI bus implementation
    python script should read directories manually and compare all results automatically
    what if i want to simulate two designs in separate shells?
    nicely print matrix from compare_matlab_vhdl_results.py
    ip_cores/ise        -check
    ip_cores/vivado     -create
    project/ise         -create
    in src/tcl/vivado/create_new_project.tcl

DONE:

    src/tcl/vivado/tclbatch_for_sim.tcl
    write script for comparison of results/r/* with matlab/r/*
    fixed input reading problem in tesbench by modifying DSP, now it works accurately.
    finished marjor part of scripting, simulation can be done as many times as written in generics.tcl
