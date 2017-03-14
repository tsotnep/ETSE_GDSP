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

**how IP core works**

http://ieeexplore.ieee.org/document/7426414/




<br />
<br />
<br />

-Always work in bash shell, no need to use cshell, u can give cshell scripts as an argument to the tools, from bash shell.


<br />
<br />
<br />

-Connect one micro-usb into UART, another one into PROG ports of zedboard zynq 7000.


<br />
<br />
<br />

-Before doing anything, in each script in folder src/tcl/ manually change "origin" variable on LINE 1, and location of xilinx tools "settings64.sh" on LINE 2


<br />
<br />
<br />

-Exact commands on how to execute each script is written in THE script, LINES 2 and 3.


<br />
<br />
<br />

-No need to worry from which directory you execute the script.


<br />
<br />
<br />

-order of scripts to execute to program and interface with FPGA:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.src/tcl/build_ip_ETSE_GDSP.tcl

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.src/tcl/build_project_ETSE_GDSP_DMA_ETHERNET.tcl

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.src/tcl/build_app_ETSE_GDSP_DMA

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.connect to UART by (to exit: ctrl+x+q): \picocom -e x -b 115200 /dev/ttyACM0

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.src/tcl/program_fpga_BITSTREAM_APP.tcl

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.enter "33" in picocom terminal, that will send specific command to MMULT IP. or enter "0" for IP manual.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.for next calculation, start from step 5.






<br />
<br />
<br />

-IF xsct/sdk does not launch after 60 seconds and gives you error on that, type:

  for bash shell:
  
    export SWT_GTK3=0 && export LC_ALL=en_US.UTF-8



<br />
<br />
<br />

-IF you get this error while: programming the fpga:

  "Error :: ERROR:
          Failed to claim JTAG Device 1 for debug. Check if it's
          in use by other client for debug"
          
          
  Then execute:
  
    killall hw_server


<br />
<br />
<br />

-IF you get this error while: simulating design:

    "[Simtcl 6-50] Simulation engine failed to start: Cannot create simulation database file.
    Please see the Tcl Console or the Messages for details."
    
 Then some directories or files are missing (when it tries to create files inside or read it).




<br />
<br />
<br />

**Terminal Log after using IP in zynq on linux** 

```bash
picocom v1.7
port is        : /dev/ttyACM0
flowcontrol    : none
baudrate is    : 115200
parity is      : none
databits are   : 8
escape is      : C-x
local echo is  : no
noinit is      : no
noreset is     : no
nolock is      : no
send_cmd is    : sz -vv
receive_cmd is : rz -vv
imap is        : 
omap is        : 
emap is        : crcrlf,delbs,

Terminal ready





>>>>>>>>>> ENTERING MAIN <<<<<<<<<<<
DMA MM2S and S2MM reset bits set
DMA Normal mode is enabled
DMA interrupts are disabled


Please Enter New Command Number (enter '0' for info, '36' for simple test 
 that should print: 18,18,18, 45,45,45, 72,72,72) : 
Command Received : 0 


Please Enter New Command Number : 
:0) Print this list of Commands
:2) load G matrix from memory via stream interface
:3) load P matrix from memory via stream interface

:4)  perform calculation of P-lower  and G and store in P-s other bank
:41) perform calculation of P-higher and G and store in P-s other bank
:42) perform calculation of P-lower  and Gt and store in P-s other bank
:43) perform calculation of P-higher and Gt and store in P-s other bank
:44) perform calculation of Pt-lower  and G and store in P-s other bank
:45) perform calculation of Pt-higher and G and store in P-s other bank
:46) perform calculation of Pt-lower  and Gt and store in P-s other bank
:47) perform calculation of Pt-higher and Gt and store in P-s other bank

:5)  transfer data from P-lower to G 
:51) transfer data from P-higher to G
:6)  transfer data from G to DDR3 via DMA 

:7) print Tx Buffer
:8) print Rx buffer
:11) reset multiplier IP only
:12) reset multiplier IP and it's controller
:13) send multiplier IP's controller in idle state 

:21) execute DMA transfer routine 1: identity matrix - 1s on diagonal 
:22) execute DMA transfer routine 1s: all values are 1 
:23) execute DMA transfer routine 1-9: values from 1 to 9 
:24) execute DMA transfer routine 11-33: 11,12,13; 21,22.. 

:33) perform bundle 1: commands: 24, 3, 24, 2, 4, 51,  6, 8
:34) perform bundle 2: commands: 23, 3, 23, 2, 4, 51,  6, 8
:35) perform bundle 3: commands: 24, 3, 21, 2, 4, 51,  6, 8
:36) perform bundle 4: commands: 23, 3, 22, 2, 4, 41, 5, 6, 8
Command Completed Successfully 
Command Received : 36 
This example, loads P and G matrixes, then executes calculation of P-lower * G, 
 and stores it in P-higher, then executes calculation of P-higher to G, 
 and stores it in P-lower, and then loads that into G ram and unloads it into DDR3 and prints on UART
DMA is busy
DMA transfer scheduled...
1 2 3 
4 5 6 
7 8 9 
DMA transfer scheduled...
1 1 1 
1 1 1 
1 1 1 
Data written from DMA to DDR3:
18 18 18 
45 45 45 
72 72 72 
Command Completed Successfully 

```
