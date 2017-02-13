# ETSE_GDSP
Repository for DSP matrix multiplier IP core.


<br />
<br />
<br />
**Directory structure**: 

Documentation : interface of IP core

src :

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; app-baremetal : C applications for ARM core, that provides interactive interface with the IP core.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff-hdsim-matlab : this folder contains files that demonstrate the difference of IP core and matlab results.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdl : VHDL sources of IP

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcl : TCL scripts for vivado for creating IP, creating project, programming FPGA. 



<br />
<br />
<br />
**Where to start**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; generate IP and project from scripts in folder src/tcl

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create baremetal application project in SDK and import sources from app-baremetal

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test it out on FPGA, with UART


<br />
<br />
<br />
**Hardware and toolchain setup**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hardware: Zedboard Zynq 7000, connected TWO uart cable, one for programming, one for Interfacing with ARM core

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Software: Xilinx Vivado 2016.1, tested on linux, should work on windows.


<br />
<br />
<br />
**how IP core works** : http://ieeexplore.ieee.org/document/7426414/
