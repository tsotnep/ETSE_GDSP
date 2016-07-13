// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Tue Jul 12 14:11:45 2016
// Host        : Tsotne-PC running 64-bit Linux Mint 17.3 Rosa
// Command     : write_verilog -force -mode synth_stub /home/tsotne/git/ETSE_GDSP/src/ip/vivado/BRAM18x1k/BRAM18x1k_stub.v
// Design      : BRAM18x1k
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_2,Vivado 2015.2" *)
module BRAM18x1k(clka, wea, addra, dina, clkb, rstb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[9:0],dina[17:0],clkb,rstb,addrb[9:0],doutb[17:0]" */;
  input clka;
  input [0:0]wea;
  input [9:0]addra;
  input [17:0]dina;
  input clkb;
  input rstb;
  input [9:0]addrb;
  output [17:0]doutb;
endmodule
