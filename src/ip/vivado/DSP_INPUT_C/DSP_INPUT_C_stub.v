// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Thu Jul 14 13:23:56 2016
// Host        : Tsotne-PC running 64-bit Linux Mint 17.3 Rosa
// Command     : write_verilog -force -mode synth_stub
//               /home/tsotne/git/ETSE_GDSP/src/ip/vivado/DSP_INPUT_C/DSP_INPUT_C_stub.v
// Design      : DSP_INPUT_C
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_dsp48_macro_v3_0,Vivado 2015.2" *)
module DSP_INPUT_C(CLK, SEL, A, B, C, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,SEL[2:0],A[17:0],B[17:0],C[47:0],P[47:0]" */;
  input CLK;
  input [2:0]SEL;
  input [17:0]A;
  input [17:0]B;
  input [47:0]C;
  output [47:0]P;
endmodule
