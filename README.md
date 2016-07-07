readme for dir: ETSE_GDSP/

This Repo contains following folders:
    -Documentation  -technical documentation of the ETSE_GDSP IP
    -ip_cores       -ip cores that can be used/imported in any Xilinx ISE or Xilinx Vivado project.
    -project        -project files for Xilinx ISE and Xilinx Vivado, that perform the behavioral simulation
    -src            -source files for the ip. it contains:
        -*.vhd VHDL source files
        -*.txt files for input and output for simulation
        - DSP and BRAM ip cores that are used in ISE and Vivado projects
        -*.vhd VHDL libraries, that are used for simulation OR synthesis
        -*.m matlab files that are used for generating Input Output data (stored in src/io/)
        -*.vhd and *.wcfg VHDL and Waveform files for simulation
        -*.tcl files for TCL scripts
each of the folder have their separate README.



Please note that all of the projects, existing in ETSE_GDSP/project/ share some common files that are located in the following directories
    ETSE_GDSP/src/lib
    ETSE_GDSP/src/io
    ETSE_GDSP/src/ip


TODO:
    ip_cores/vivado     -create
    ip_cores/ise        -check
    project/ise         -create
    project/vivado      -create
    src/README.md       -finish 
