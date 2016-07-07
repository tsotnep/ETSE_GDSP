////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: DSP_INPUT_C.v
// /___/   /\     Timestamp: Fri Aug 14 10:23:50 2015
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/FPGA/Internship_Jobs/Codes/Virtex6_MUL_IP_CORE2/pcores/matrix_mul_ip_core_s_int_g_v1_00_a/hdl/ipcores/tmp/_cg/DSP_INPUT_C.ngc C:/FPGA/Internship_Jobs/Codes/Virtex6_MUL_IP_CORE2/pcores/matrix_mul_ip_core_s_int_g_v1_00_a/hdl/ipcores/tmp/_cg/DSP_INPUT_C.v 
// Device	: 6vlx240tff1156-1
// Input file	: C:/FPGA/Internship_Jobs/Codes/Virtex6_MUL_IP_CORE2/pcores/matrix_mul_ip_core_s_int_g_v1_00_a/hdl/ipcores/tmp/_cg/DSP_INPUT_C.ngc
// Output file	: C:/FPGA/Internship_Jobs/Codes/Virtex6_MUL_IP_CORE2/pcores/matrix_mul_ip_core_s_int_g_v1_00_a/hdl/ipcores/tmp/_cg/DSP_INPUT_C.v
// # of Modules	: 1
// Design Name	: DSP_INPUT_C
// Xilinx        : C:\Xilinx\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module DSP_INPUT_C (
  clk, sel, a, b, c, p
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input [2 : 0] sel;
  input [17 : 0] a;
  input [17 : 0] b;
  input [47 : 0] c;
  output [47 : 0] p;
  
  // synthesis translate_off
  
  wire \blk00000001/sig000001bd ;
  wire \blk00000001/sig000001bc ;
  wire \blk00000001/sig000001bb ;
  wire \blk00000001/sig000001ba ;
  wire \blk00000001/sig000001b9 ;
  wire \blk00000001/sig000001b8 ;
  wire \blk00000001/sig000001b7 ;
  wire \blk00000001/sig000001b6 ;
  wire \blk00000001/sig000001b5 ;
  wire \blk00000001/sig000001b4 ;
  wire \blk00000001/sig000001b3 ;
  wire \blk00000001/sig000001b2 ;
  wire \blk00000001/sig000001b1 ;
  wire \blk00000001/sig000001b0 ;
  wire \blk00000001/sig000001af ;
  wire \blk00000001/sig000001ae ;
  wire \blk00000001/sig000001ad ;
  wire \blk00000001/sig000001ac ;
  wire \blk00000001/sig000001ab ;
  wire \blk00000001/sig000001aa ;
  wire \blk00000001/sig000001a9 ;
  wire \blk00000001/sig000001a8 ;
  wire \blk00000001/sig000001a7 ;
  wire \blk00000001/sig000001a6 ;
  wire \blk00000001/sig000001a5 ;
  wire \blk00000001/sig000001a4 ;
  wire \blk00000001/sig000001a3 ;
  wire \blk00000001/sig000001a2 ;
  wire \blk00000001/sig000001a1 ;
  wire \blk00000001/sig000001a0 ;
  wire \blk00000001/sig0000019f ;
  wire \blk00000001/sig0000019e ;
  wire \blk00000001/sig0000019d ;
  wire \blk00000001/sig0000019c ;
  wire \blk00000001/sig0000019b ;
  wire \blk00000001/sig0000019a ;
  wire \blk00000001/sig00000199 ;
  wire \blk00000001/sig00000198 ;
  wire \blk00000001/sig00000197 ;
  wire \blk00000001/sig00000196 ;
  wire \blk00000001/sig00000195 ;
  wire \blk00000001/sig00000194 ;
  wire \blk00000001/sig00000193 ;
  wire \blk00000001/sig00000192 ;
  wire \blk00000001/sig00000191 ;
  wire \blk00000001/sig00000190 ;
  wire \blk00000001/sig0000018f ;
  wire \blk00000001/sig0000018e ;
  wire \blk00000001/sig0000018d ;
  wire \blk00000001/sig0000018c ;
  wire \blk00000001/sig0000018b ;
  wire \blk00000001/sig0000018a ;
  wire \blk00000001/sig00000189 ;
  wire \blk00000001/sig00000188 ;
  wire \blk00000001/sig00000187 ;
  wire \blk00000001/sig00000186 ;
  wire \blk00000001/sig00000185 ;
  wire \blk00000001/sig00000184 ;
  wire \blk00000001/sig00000183 ;
  wire \blk00000001/sig00000182 ;
  wire \blk00000001/sig00000181 ;
  wire \blk00000001/sig00000180 ;
  wire \blk00000001/sig0000017f ;
  wire \blk00000001/sig0000017e ;
  wire \blk00000001/sig0000017d ;
  wire \blk00000001/sig0000017c ;
  wire \blk00000001/sig0000017b ;
  wire \blk00000001/sig0000017a ;
  wire \blk00000001/sig00000179 ;
  wire \blk00000001/sig00000178 ;
  wire \blk00000001/sig00000177 ;
  wire \blk00000001/sig00000176 ;
  wire \blk00000001/sig00000175 ;
  wire \blk00000001/sig00000174 ;
  wire \blk00000001/sig00000173 ;
  wire \blk00000001/sig00000172 ;
  wire \blk00000001/sig00000171 ;
  wire \blk00000001/sig00000170 ;
  wire \blk00000001/sig0000016f ;
  wire \blk00000001/sig0000016e ;
  wire \blk00000001/sig0000016d ;
  wire \blk00000001/sig0000016c ;
  wire \blk00000001/sig0000016b ;
  wire \blk00000001/sig0000016a ;
  wire \blk00000001/sig00000169 ;
  wire \blk00000001/sig00000168 ;
  wire \blk00000001/sig00000167 ;
  wire \blk00000001/sig00000166 ;
  wire \blk00000001/sig00000165 ;
  wire \blk00000001/sig00000164 ;
  wire \blk00000001/sig00000163 ;
  wire \blk00000001/sig00000162 ;
  wire \blk00000001/sig00000161 ;
  wire \blk00000001/sig00000160 ;
  wire \blk00000001/sig0000015f ;
  wire \blk00000001/sig0000015e ;
  wire \blk00000001/sig0000015d ;
  wire \blk00000001/sig0000015c ;
  wire \blk00000001/sig0000015b ;
  wire \blk00000001/sig0000015a ;
  wire \blk00000001/sig00000159 ;
  wire \blk00000001/sig00000158 ;
  wire \blk00000001/sig00000157 ;
  wire \blk00000001/sig00000156 ;
  wire \blk00000001/sig00000155 ;
  wire \blk00000001/sig00000154 ;
  wire \blk00000001/sig00000153 ;
  wire \blk00000001/sig00000152 ;
  wire \blk00000001/sig00000151 ;
  wire \blk00000001/sig00000150 ;
  wire \blk00000001/sig0000014f ;
  wire \blk00000001/sig0000014e ;
  wire \blk00000001/sig0000014d ;
  wire \blk00000001/sig0000014c ;
  wire \blk00000001/sig0000014b ;
  wire \blk00000001/sig0000014a ;
  wire \blk00000001/sig00000149 ;
  wire \blk00000001/sig00000148 ;
  wire \blk00000001/sig00000147 ;
  wire \blk00000001/sig00000146 ;
  wire \blk00000001/sig00000145 ;
  wire \blk00000001/sig00000144 ;
  wire \blk00000001/sig00000143 ;
  wire \blk00000001/sig00000142 ;
  wire \blk00000001/sig00000141 ;
  wire \blk00000001/sig00000140 ;
  wire \blk00000001/sig0000013f ;
  wire \blk00000001/sig0000013e ;
  wire \blk00000001/sig0000013d ;
  wire \blk00000001/sig0000013c ;
  wire \blk00000001/sig0000013b ;
  wire \blk00000001/sig0000013a ;
  wire \blk00000001/sig00000139 ;
  wire \blk00000001/sig00000138 ;
  wire \blk00000001/sig00000137 ;
  wire \blk00000001/sig00000136 ;
  wire \blk00000001/sig00000135 ;
  wire \blk00000001/sig00000134 ;
  wire \blk00000001/sig00000133 ;
  wire \blk00000001/sig00000132 ;
  wire \blk00000001/sig00000131 ;
  wire \blk00000001/sig00000130 ;
  wire \blk00000001/sig0000012f ;
  wire \blk00000001/sig0000012e ;
  wire \blk00000001/sig0000012d ;
  wire \blk00000001/sig0000012c ;
  wire \blk00000001/sig0000012b ;
  wire \blk00000001/sig0000012a ;
  wire \blk00000001/sig00000129 ;
  wire \blk00000001/sig00000128 ;
  wire \blk00000001/sig00000127 ;
  wire \blk00000001/sig00000126 ;
  wire \blk00000001/sig00000125 ;
  wire \blk00000001/sig00000124 ;
  wire \blk00000001/sig00000123 ;
  wire \blk00000001/sig00000122 ;
  wire \blk00000001/sig00000121 ;
  wire \blk00000001/sig00000120 ;
  wire \blk00000001/sig0000011f ;
  wire \blk00000001/sig0000011e ;
  wire \blk00000001/sig0000011d ;
  wire \blk00000001/sig0000011c ;
  wire \blk00000001/sig0000011b ;
  wire \blk00000001/sig0000011a ;
  wire \blk00000001/sig00000119 ;
  wire \blk00000001/sig00000118 ;
  wire \blk00000001/sig00000117 ;
  wire \blk00000001/sig00000116 ;
  wire \blk00000001/sig00000115 ;
  wire \blk00000001/sig00000114 ;
  wire \blk00000001/sig00000113 ;
  wire \blk00000001/sig00000112 ;
  wire \blk00000001/sig00000111 ;
  wire \blk00000001/sig00000110 ;
  wire \blk00000001/sig0000010f ;
  wire \blk00000001/sig0000010e ;
  wire \blk00000001/sig0000010d ;
  wire \blk00000001/sig0000010c ;
  wire \blk00000001/sig0000010b ;
  wire \blk00000001/sig0000010a ;
  wire \blk00000001/sig00000109 ;
  wire \blk00000001/sig00000108 ;
  wire \blk00000001/sig00000107 ;
  wire \blk00000001/sig00000106 ;
  wire \blk00000001/sig00000105 ;
  wire \blk00000001/sig00000104 ;
  wire \blk00000001/sig00000103 ;
  wire \blk00000001/sig00000102 ;
  wire \blk00000001/sig00000101 ;
  wire \blk00000001/sig00000100 ;
  wire \blk00000001/sig000000ff ;
  wire \blk00000001/sig000000fe ;
  wire \blk00000001/sig000000fd ;
  wire \blk00000001/sig000000fc ;
  wire \blk00000001/sig000000fb ;
  wire \blk00000001/sig000000fa ;
  wire \blk00000001/sig000000f9 ;
  wire \blk00000001/sig000000f8 ;
  wire \blk00000001/sig000000f7 ;
  wire \blk00000001/sig000000f6 ;
  wire \blk00000001/sig000000f5 ;
  wire \blk00000001/sig000000f4 ;
  wire \blk00000001/sig000000f3 ;
  wire \blk00000001/sig000000f2 ;
  wire \blk00000001/sig000000f1 ;
  wire \blk00000001/sig000000f0 ;
  wire \blk00000001/sig000000ef ;
  wire \blk00000001/sig000000ee ;
  wire \blk00000001/sig000000ed ;
  wire \blk00000001/sig000000ec ;
  wire \blk00000001/sig000000eb ;
  wire \blk00000001/sig000000ea ;
  wire \blk00000001/sig000000e9 ;
  wire \blk00000001/sig000000b8 ;
  wire \blk00000001/sig000000b7 ;
  wire \blk00000001/sig000000b6 ;
  wire \blk00000001/sig000000b5 ;
  wire \blk00000001/sig000000b4 ;
  wire \blk00000001/sig000000b3 ;
  wire \blk00000001/sig000000b2 ;
  wire \blk00000001/sig000000b1 ;
  wire \blk00000001/sig000000b0 ;
  wire \blk00000001/sig000000af ;
  wire \blk00000001/sig000000ae ;
  wire \blk00000001/sig000000ad ;
  wire \blk00000001/sig000000ac ;
  wire \blk00000001/sig000000ab ;
  wire \blk00000001/sig000000aa ;
  wire \blk00000001/sig000000a9 ;
  wire \blk00000001/sig000000a8 ;
  wire \blk00000001/sig000000a7 ;
  wire \blk00000001/sig000000a6 ;
  wire \blk00000001/sig000000a5 ;
  wire \blk00000001/sig000000a4 ;
  wire \blk00000001/sig000000a3 ;
  wire \blk00000001/sig000000a2 ;
  wire \blk00000001/sig000000a1 ;
  wire \blk00000001/sig000000a0 ;
  wire \blk00000001/sig0000009f ;
  wire \blk00000001/sig0000009e ;
  wire \blk00000001/sig0000009d ;
  wire \blk00000001/sig0000009c ;
  wire \blk00000001/sig0000009b ;
  wire \blk00000001/sig0000009a ;
  wire \blk00000001/sig00000099 ;
  wire \blk00000001/sig00000098 ;
  wire \blk00000001/sig00000097 ;
  wire \blk00000001/sig00000096 ;
  wire \blk00000001/sig00000095 ;
  wire \blk00000001/sig00000094 ;
  wire \blk00000001/sig00000093 ;
  wire \blk00000001/sig00000092 ;
  wire \blk00000001/sig00000091 ;
  wire \blk00000001/sig00000090 ;
  wire \blk00000001/sig0000008f ;
  wire \blk00000001/sig0000008e ;
  wire \blk00000001/sig0000008d ;
  wire \blk00000001/sig0000008c ;
  wire \blk00000001/sig0000008b ;
  wire \blk00000001/sig0000008a ;
  wire \blk00000001/sig00000089 ;
  wire \blk00000001/sig00000088 ;
  wire \blk00000001/sig00000087 ;
  wire \blk00000001/sig00000086 ;
  wire \blk00000001/sig00000085 ;
  wire \blk00000001/sig00000084 ;
  wire \blk00000001/sig00000083 ;
  wire \blk00000001/sig00000082 ;
  wire \blk00000001/sig00000081 ;
  wire \blk00000001/sig00000080 ;
  wire \blk00000001/sig0000007f ;
  wire \blk00000001/sig0000007e ;
  wire \blk00000001/sig0000007d ;
  wire \blk00000001/sig0000007c ;
  wire \blk00000001/sig0000007b ;
  wire \blk00000001/sig0000007a ;
  wire \blk00000001/sig00000079 ;
  wire \blk00000001/sig00000078 ;
  wire \blk00000001/sig00000077 ;
  wire \blk00000001/sig00000076 ;
  wire \blk00000001/sig00000075 ;
  wire \blk00000001/sig00000074 ;
  wire \blk00000001/sig00000073 ;
  wire \blk00000001/sig00000072 ;
  wire \blk00000001/sig00000071 ;
  wire \blk00000001/sig00000070 ;
  wire \blk00000001/sig0000006f ;
  wire \blk00000001/sig0000006e ;
  wire \blk00000001/sig0000006d ;
  wire \blk00000001/sig0000006c ;
  wire \blk00000001/sig0000006b ;
  wire \blk00000001/sig0000006a ;
  wire \blk00000001/sig00000069 ;
  wire \blk00000001/sig00000068 ;
  wire \blk00000001/sig00000067 ;
  wire \blk00000001/sig00000066 ;
  wire \blk00000001/sig00000065 ;
  wire \blk00000001/sig00000064 ;
  wire \blk00000001/sig00000063 ;
  wire \blk00000001/sig00000062 ;
  wire \blk00000001/sig00000061 ;
  wire \blk00000001/sig00000060 ;
  wire \blk00000001/sig0000005f ;
  wire \blk00000001/sig0000005e ;
  wire \blk00000001/sig0000005d ;
  wire \blk00000001/sig0000005c ;
  wire \blk00000001/sig0000005b ;
  wire \blk00000001/sig0000005a ;
  wire \blk00000001/sig00000059 ;
  wire \NLW_blk00000001/blk0000008c_PATTERNBDETECT_UNCONNECTED ;
  wire \NLW_blk00000001/blk0000008c_MULTSIGNOUT_UNCONNECTED ;
  wire \NLW_blk00000001/blk0000008c_UNDERFLOW_UNCONNECTED ;
  wire \NLW_blk00000001/blk0000008c_PATTERNDETECT_UNCONNECTED ;
  wire \NLW_blk00000001/blk0000008c_OVERFLOW_UNCONNECTED ;
  wire \NLW_blk00000001/blk0000008c_CARRYOUT<2>_UNCONNECTED ;
  wire \NLW_blk00000001/blk0000008c_CARRYOUT<1>_UNCONNECTED ;
  wire \NLW_blk00000001/blk0000008c_CARRYOUT<0>_UNCONNECTED ;
  LUT3 #(
    .INIT ( 8'h01 ))
  \blk00000001/blk000000d5  (
    .I0(sel[0]),
    .I1(sel[1]),
    .I2(sel[2]),
    .O(\blk00000001/sig000000f2 )
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  \blk00000001/blk000000d4  (
    .I0(sel[1]),
    .I1(sel[2]),
    .O(\blk00000001/sig000000f1 )
  );
  LUT3 #(
    .INIT ( 8'h7F ))
  \blk00000001/blk000000d3  (
    .I0(sel[0]),
    .I1(sel[2]),
    .I2(sel[1]),
    .O(\blk00000001/sig000000f0 )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \blk00000001/blk000000d2  (
    .I0(sel[2]),
    .I1(sel[1]),
    .I2(sel[0]),
    .O(\blk00000001/sig000000ef )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \blk00000001/blk000000d1  (
    .I0(sel[0]),
    .I1(sel[1]),
    .I2(sel[2]),
    .O(\blk00000001/sig000000ee )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000d0  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig0000019b ),
    .O(\blk00000001/sig000000fc )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000cf  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig0000019a ),
    .O(\blk00000001/sig000000fb )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000ce  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig00000199 ),
    .O(\blk00000001/sig000000fa )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000cd  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig00000198 ),
    .O(\blk00000001/sig000000f9 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000cc  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig00000197 ),
    .O(\blk00000001/sig000000f8 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000cb  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig00000196 ),
    .O(\blk00000001/sig000000f7 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000ca  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig00000195 ),
    .O(\blk00000001/sig000000f6 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c9  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig00000194 ),
    .O(\blk00000001/sig000000f5 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c8  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig00000193 ),
    .O(\blk00000001/sig000000f4 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c7  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig000001a3 ),
    .O(\blk00000001/sig00000104 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c6  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig000001a2 ),
    .O(\blk00000001/sig00000103 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c5  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig000001a1 ),
    .O(\blk00000001/sig00000102 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c4  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig000001a0 ),
    .O(\blk00000001/sig00000101 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c3  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig0000019f ),
    .O(\blk00000001/sig00000100 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c2  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig0000019e ),
    .O(\blk00000001/sig000000ff )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c1  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig0000019d ),
    .O(\blk00000001/sig000000fe )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \blk00000001/blk000000c0  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig0000019c ),
    .O(\blk00000001/sig000000fd )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \blk00000001/blk000000bf  (
    .I0(\blk00000001/sig0000013d ),
    .I1(\blk00000001/sig00000192 ),
    .O(\blk00000001/sig000000f3 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000be  (
    .I0(c[9]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000147 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000bd  (
    .I0(c[8]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000146 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000bc  (
    .I0(c[7]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000145 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000bb  (
    .I0(c[6]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000144 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000ba  (
    .I0(c[5]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000143 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b9  (
    .I0(c[4]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000142 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b8  (
    .I0(c[47]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000016d )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b7  (
    .I0(c[46]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000016c )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b6  (
    .I0(c[45]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000016b )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b5  (
    .I0(c[44]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000016a )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b4  (
    .I0(c[43]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000169 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b3  (
    .I0(c[42]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000168 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b2  (
    .I0(c[41]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000167 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b1  (
    .I0(c[40]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000166 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000b0  (
    .I0(c[3]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000141 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000af  (
    .I0(c[39]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000165 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000ae  (
    .I0(c[38]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000164 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000ad  (
    .I0(c[37]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000163 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000ac  (
    .I0(c[36]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000162 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000ab  (
    .I0(c[35]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000161 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000aa  (
    .I0(c[34]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000160 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a9  (
    .I0(c[33]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000015f )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a8  (
    .I0(c[32]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000015e )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a7  (
    .I0(c[31]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000015d )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a6  (
    .I0(c[30]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000015c )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a5  (
    .I0(c[2]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000140 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a4  (
    .I0(c[29]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000015b )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a3  (
    .I0(c[28]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000015a )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a2  (
    .I0(c[27]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000159 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a1  (
    .I0(c[26]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000158 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk000000a0  (
    .I0(c[25]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000157 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk0000009f  (
    .I0(c[24]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000156 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk0000009e  (
    .I0(c[23]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000155 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk0000009d  (
    .I0(c[22]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000154 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk0000009c  (
    .I0(c[21]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000153 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk0000009b  (
    .I0(c[20]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000152 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk0000009a  (
    .I0(c[1]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000013f )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000099  (
    .I0(c[19]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000151 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000098  (
    .I0(c[18]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000150 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000097  (
    .I0(c[17]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000014f )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000096  (
    .I0(c[16]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000014e )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000095  (
    .I0(c[15]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000014d )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000094  (
    .I0(c[14]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000014c )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000093  (
    .I0(c[13]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000014b )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000092  (
    .I0(c[12]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000014a )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000091  (
    .I0(c[11]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000149 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk00000090  (
    .I0(c[10]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig00000148 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \blk00000001/blk0000008f  (
    .I0(c[0]),
    .I1(\blk00000001/sig00000122 ),
    .O(\blk00000001/sig0000013e )
  );
  LUT3 #(
    .INIT ( 8'h04 ))
  \blk00000001/blk0000008e  (
    .I0(sel[1]),
    .I1(sel[2]),
    .I2(sel[0]),
    .O(\blk00000001/sig000000ec )
  );
  LUT3 #(
    .INIT ( 8'h26 ))
  \blk00000001/blk0000008d  (
    .I0(sel[1]),
    .I1(sel[2]),
    .I2(sel[0]),
    .O(\blk00000001/sig000000ed )
  );
  DSP48E1 #(
    .ACASCREG ( 2 ),
    .ADREG ( 0 ),
    .ALUMODEREG ( 1 ),
    .AREG ( 2 ),
    .AUTORESET_PATDET ( "NO_RESET" ),
    .A_INPUT ( "DIRECT" ),
    .BCASCREG ( 2 ),
    .BREG ( 2 ),
    .B_INPUT ( "DIRECT" ),
    .CARRYINREG ( 0 ),
    .CARRYINSELREG ( 1 ),
    .CREG ( 0 ),
    .DREG ( 0 ),
    .INMODEREG ( 1 ),
    .MASK ( 48'h3FFFFFFFFFFF ),
    .MREG ( 1 ),
    .OPMODEREG ( 1 ),
    .PATTERN ( 48'h000000000000 ),
    .PREG ( 1 ),
    .SEL_MASK ( "MASK" ),
    .SEL_PATTERN ( "PATTERN" ),
    .USE_DPORT ( "FALSE" ),
    .USE_MULT ( "MULTIPLY" ),
    .USE_PATTERN_DETECT ( "NO_PATDET" ),
    .USE_SIMD ( "ONE48" ))
  \blk00000001/blk0000008c  (
    .PATTERNBDETECT(\NLW_blk00000001/blk0000008c_PATTERNBDETECT_UNCONNECTED ),
    .RSTC(\blk00000001/sig0000013c ),
    .CEB1(\blk00000001/sig000000eb ),
    .CEAD(\blk00000001/sig0000013c ),
    .MULTSIGNOUT(\NLW_blk00000001/blk0000008c_MULTSIGNOUT_UNCONNECTED ),
    .CEC(\blk00000001/sig0000013c ),
    .RSTM(\blk00000001/sig0000013c ),
    .MULTSIGNIN(\blk00000001/sig0000013c ),
    .CEB2(\blk00000001/sig000000eb ),
    .RSTCTRL(\blk00000001/sig0000013c ),
    .CEP(\blk00000001/sig000000eb ),
    .CARRYCASCOUT(\blk00000001/sig000000ea ),
    .RSTA(\blk00000001/sig0000013c ),
    .CECARRYIN(\blk00000001/sig0000013c ),
    .UNDERFLOW(\NLW_blk00000001/blk0000008c_UNDERFLOW_UNCONNECTED ),
    .PATTERNDETECT(\NLW_blk00000001/blk0000008c_PATTERNDETECT_UNCONNECTED ),
    .RSTALUMODE(\blk00000001/sig0000013c ),
    .RSTALLCARRYIN(\blk00000001/sig0000013c ),
    .CED(\blk00000001/sig0000013c ),
    .RSTD(\blk00000001/sig0000013c ),
    .CEALUMODE(\blk00000001/sig000000eb ),
    .CEA2(\blk00000001/sig000000eb ),
    .CLK(clk),
    .CEA1(\blk00000001/sig000000eb ),
    .RSTB(\blk00000001/sig0000013c ),
    .OVERFLOW(\NLW_blk00000001/blk0000008c_OVERFLOW_UNCONNECTED ),
    .CECTRL(\blk00000001/sig000000eb ),
    .CEM(\blk00000001/sig000000eb ),
    .CARRYIN(\blk00000001/sig0000013c ),
    .CARRYCASCIN(\blk00000001/sig0000013c ),
    .RSTINMODE(\blk00000001/sig0000013c ),
    .CEINMODE(\blk00000001/sig000000eb ),
    .RSTP(\blk00000001/sig0000013c ),
    .ACOUT({\blk00000001/sig00000059 , \blk00000001/sig0000005a , \blk00000001/sig0000005b , \blk00000001/sig0000005c , \blk00000001/sig0000005d , 
\blk00000001/sig0000005e , \blk00000001/sig0000005f , \blk00000001/sig00000060 , \blk00000001/sig00000061 , \blk00000001/sig00000062 , 
\blk00000001/sig00000063 , \blk00000001/sig00000064 , \blk00000001/sig00000065 , \blk00000001/sig00000066 , \blk00000001/sig00000067 , 
\blk00000001/sig00000068 , \blk00000001/sig00000069 , \blk00000001/sig0000006a , \blk00000001/sig0000006b , \blk00000001/sig0000006c , 
\blk00000001/sig0000006d , \blk00000001/sig0000006e , \blk00000001/sig0000006f , \blk00000001/sig00000070 , \blk00000001/sig00000071 , 
\blk00000001/sig00000072 , \blk00000001/sig00000073 , \blk00000001/sig00000074 , \blk00000001/sig00000075 , \blk00000001/sig00000076 }),
    .OPMODE({\blk00000001/sig0000010e , \blk00000001/sig0000010d , \blk00000001/sig0000010c , \blk00000001/sig0000010b , \blk00000001/sig0000010a , 
\blk00000001/sig00000109 , \blk00000001/sig00000108 }),
    .PCIN({\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c }),
    .ALUMODE({\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000010f , \blk00000001/sig0000010f }),
    .C({\blk00000001/sig0000016d , \blk00000001/sig0000016c , \blk00000001/sig0000016b , \blk00000001/sig0000016a , \blk00000001/sig00000169 , 
\blk00000001/sig00000168 , \blk00000001/sig00000167 , \blk00000001/sig00000166 , \blk00000001/sig00000165 , \blk00000001/sig00000164 , 
\blk00000001/sig00000163 , \blk00000001/sig00000162 , \blk00000001/sig00000161 , \blk00000001/sig00000160 , \blk00000001/sig0000015f , 
\blk00000001/sig0000015e , \blk00000001/sig0000015d , \blk00000001/sig0000015c , \blk00000001/sig0000015b , \blk00000001/sig0000015a , 
\blk00000001/sig00000159 , \blk00000001/sig00000158 , \blk00000001/sig00000157 , \blk00000001/sig00000156 , \blk00000001/sig00000155 , 
\blk00000001/sig00000154 , \blk00000001/sig00000153 , \blk00000001/sig00000152 , \blk00000001/sig00000151 , \blk00000001/sig00000150 , 
\blk00000001/sig0000014f , \blk00000001/sig0000014e , \blk00000001/sig0000014d , \blk00000001/sig0000014c , \blk00000001/sig0000014b , 
\blk00000001/sig0000014a , \blk00000001/sig00000149 , \blk00000001/sig00000148 , \blk00000001/sig00000147 , \blk00000001/sig00000146 , 
\blk00000001/sig00000145 , \blk00000001/sig00000144 , \blk00000001/sig00000143 , \blk00000001/sig00000142 , \blk00000001/sig00000141 , 
\blk00000001/sig00000140 , \blk00000001/sig0000013f , \blk00000001/sig0000013e }),
    .CARRYOUT({\blk00000001/sig000000e9 , \NLW_blk00000001/blk0000008c_CARRYOUT<2>_UNCONNECTED , \NLW_blk00000001/blk0000008c_CARRYOUT<1>_UNCONNECTED 
, \NLW_blk00000001/blk0000008c_CARRYOUT<0>_UNCONNECTED }),
    .INMODE({\blk00000001/sig00000128 , \blk00000001/sig00000127 , \blk00000001/sig00000126 , \blk00000001/sig00000125 , \blk00000001/sig00000124 }),
    .BCIN({\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c }),
    .B({\blk00000001/sig0000017f , \blk00000001/sig0000017e , \blk00000001/sig0000017d , \blk00000001/sig0000017c , \blk00000001/sig0000017b , 
\blk00000001/sig0000017a , \blk00000001/sig00000179 , \blk00000001/sig00000178 , \blk00000001/sig00000177 , \blk00000001/sig00000176 , 
\blk00000001/sig00000175 , \blk00000001/sig00000174 , \blk00000001/sig00000173 , \blk00000001/sig00000172 , \blk00000001/sig00000171 , 
\blk00000001/sig00000170 , \blk00000001/sig0000016f , \blk00000001/sig0000016e }),
    .BCOUT({\blk00000001/sig00000077 , \blk00000001/sig00000078 , \blk00000001/sig00000079 , \blk00000001/sig0000007a , \blk00000001/sig0000007b , 
\blk00000001/sig0000007c , \blk00000001/sig0000007d , \blk00000001/sig0000007e , \blk00000001/sig0000007f , \blk00000001/sig00000080 , 
\blk00000001/sig00000081 , \blk00000001/sig00000082 , \blk00000001/sig00000083 , \blk00000001/sig00000084 , \blk00000001/sig00000085 , 
\blk00000001/sig00000086 , \blk00000001/sig00000087 , \blk00000001/sig00000088 }),
    .D({\blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , 
\blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , 
\blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , 
\blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , 
\blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb , \blk00000001/sig000000eb }),
    .P({p[47], p[46], p[45], p[44], p[43], p[42], p[41], p[40], p[39], p[38], p[37], p[36], p[35], p[34], p[33], p[32], p[31], p[30], p[29], p[28], 
p[27], p[26], p[25], p[24], p[23], p[22], p[21], p[20], p[19], p[18], p[17], p[16], p[15], p[14], p[13], p[12], p[11], p[10], p[9], p[8], p[7], p[6], 
p[5], p[4], p[3], p[2], p[1], p[0]}),
    .A({\blk00000001/sig00000191 , \blk00000001/sig00000191 , \blk00000001/sig00000191 , \blk00000001/sig00000191 , \blk00000001/sig00000191 , 
\blk00000001/sig00000191 , \blk00000001/sig00000191 , \blk00000001/sig00000191 , \blk00000001/sig00000191 , \blk00000001/sig00000191 , 
\blk00000001/sig00000191 , \blk00000001/sig00000191 , \blk00000001/sig00000191 , \blk00000001/sig00000190 , \blk00000001/sig0000018f , 
\blk00000001/sig0000018e , \blk00000001/sig0000018d , \blk00000001/sig0000018c , \blk00000001/sig0000018b , \blk00000001/sig0000018a , 
\blk00000001/sig00000189 , \blk00000001/sig00000188 , \blk00000001/sig00000187 , \blk00000001/sig00000186 , \blk00000001/sig00000185 , 
\blk00000001/sig00000184 , \blk00000001/sig00000183 , \blk00000001/sig00000182 , \blk00000001/sig00000181 , \blk00000001/sig00000180 }),
    .PCOUT({\blk00000001/sig00000089 , \blk00000001/sig0000008a , \blk00000001/sig0000008b , \blk00000001/sig0000008c , \blk00000001/sig0000008d , 
\blk00000001/sig0000008e , \blk00000001/sig0000008f , \blk00000001/sig00000090 , \blk00000001/sig00000091 , \blk00000001/sig00000092 , 
\blk00000001/sig00000093 , \blk00000001/sig00000094 , \blk00000001/sig00000095 , \blk00000001/sig00000096 , \blk00000001/sig00000097 , 
\blk00000001/sig00000098 , \blk00000001/sig00000099 , \blk00000001/sig0000009a , \blk00000001/sig0000009b , \blk00000001/sig0000009c , 
\blk00000001/sig0000009d , \blk00000001/sig0000009e , \blk00000001/sig0000009f , \blk00000001/sig000000a0 , \blk00000001/sig000000a1 , 
\blk00000001/sig000000a2 , \blk00000001/sig000000a3 , \blk00000001/sig000000a4 , \blk00000001/sig000000a5 , \blk00000001/sig000000a6 , 
\blk00000001/sig000000a7 , \blk00000001/sig000000a8 , \blk00000001/sig000000a9 , \blk00000001/sig000000aa , \blk00000001/sig000000ab , 
\blk00000001/sig000000ac , \blk00000001/sig000000ad , \blk00000001/sig000000ae , \blk00000001/sig000000af , \blk00000001/sig000000b0 , 
\blk00000001/sig000000b1 , \blk00000001/sig000000b2 , \blk00000001/sig000000b3 , \blk00000001/sig000000b4 , \blk00000001/sig000000b5 , 
\blk00000001/sig000000b6 , \blk00000001/sig000000b7 , \blk00000001/sig000000b8 }),
    .ACIN({\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , 
\blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c , \blk00000001/sig0000013c }),
    .CARRYINSEL({\blk00000001/sig00000107 , \blk00000001/sig00000106 , \blk00000001/sig00000105 })
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000008b  (
    .C(clk),
    .D(\blk00000001/sig000000f2 ),
    .Q(\blk00000001/sig0000013d )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000008a  (
    .C(clk),
    .D(\blk00000001/sig000000f1 ),
    .Q(\blk00000001/sig00000136 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000089  (
    .C(clk),
    .D(\blk00000001/sig000000f0 ),
    .Q(\blk00000001/sig00000137 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000088  (
    .C(clk),
    .D(\blk00000001/sig000000ef ),
    .Q(\blk00000001/sig00000138 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000087  (
    .C(clk),
    .D(\blk00000001/sig000000ee ),
    .Q(\blk00000001/sig00000139 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000086  (
    .C(clk),
    .D(\blk00000001/sig000000ed ),
    .Q(\blk00000001/sig0000013a )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000085  (
    .C(clk),
    .D(\blk00000001/sig000000ec ),
    .Q(\blk00000001/sig0000013b )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000084  (
    .C(clk),
    .D(\blk00000001/sig0000013d ),
    .Q(\blk00000001/sig00000123 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000083  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000124 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000082  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000125 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000081  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000126 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000080  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000127 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000007f  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000128 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000007e  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000129 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000007d  (
    .C(clk),
    .D(\blk00000001/sig00000136 ),
    .Q(\blk00000001/sig0000012a )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000007c  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig0000012b )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000007b  (
    .C(clk),
    .D(\blk00000001/sig00000137 ),
    .Q(\blk00000001/sig0000012c )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000007a  (
    .C(clk),
    .D(\blk00000001/sig00000138 ),
    .Q(\blk00000001/sig0000012d )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000079  (
    .C(clk),
    .D(\blk00000001/sig00000139 ),
    .Q(\blk00000001/sig0000012e )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000078  (
    .C(clk),
    .D(\blk00000001/sig0000013a ),
    .Q(\blk00000001/sig0000012f )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000077  (
    .C(clk),
    .D(\blk00000001/sig0000013b ),
    .Q(\blk00000001/sig00000130 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000076  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000131 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000075  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000132 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000074  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000133 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000073  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000134 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000072  (
    .C(clk),
    .D(\blk00000001/sig0000013c ),
    .Q(\blk00000001/sig00000135 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000071  (
    .C(clk),
    .D(\blk00000001/sig00000123 ),
    .Q(\blk00000001/sig00000110 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000070  (
    .C(clk),
    .D(\blk00000001/sig00000124 ),
    .Q(\blk00000001/sig00000111 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000006f  (
    .C(clk),
    .D(\blk00000001/sig00000125 ),
    .Q(\blk00000001/sig00000112 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000006e  (
    .C(clk),
    .D(\blk00000001/sig00000126 ),
    .Q(\blk00000001/sig00000113 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000006d  (
    .C(clk),
    .D(\blk00000001/sig00000127 ),
    .Q(\blk00000001/sig00000114 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000006c  (
    .C(clk),
    .D(\blk00000001/sig00000128 ),
    .Q(\blk00000001/sig00000115 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000006b  (
    .C(clk),
    .D(\blk00000001/sig00000129 ),
    .Q(\blk00000001/sig00000122 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000006a  (
    .C(clk),
    .D(\blk00000001/sig0000012a ),
    .Q(\blk00000001/sig00000116 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000069  (
    .C(clk),
    .D(\blk00000001/sig0000012b ),
    .Q(\blk00000001/sig00000117 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000068  (
    .C(clk),
    .D(\blk00000001/sig0000012c ),
    .Q(\blk00000001/sig00000118 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000067  (
    .C(clk),
    .D(\blk00000001/sig0000012d ),
    .Q(\blk00000001/sig00000119 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000066  (
    .C(clk),
    .D(\blk00000001/sig0000012e ),
    .Q(\blk00000001/sig0000011a )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000065  (
    .C(clk),
    .D(\blk00000001/sig0000012f ),
    .Q(\blk00000001/sig0000011b )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000064  (
    .C(clk),
    .D(\blk00000001/sig00000130 ),
    .Q(\blk00000001/sig0000011c )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000063  (
    .C(clk),
    .D(\blk00000001/sig00000131 ),
    .Q(\blk00000001/sig0000011d )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000062  (
    .C(clk),
    .D(\blk00000001/sig00000132 ),
    .Q(\blk00000001/sig0000011e )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000061  (
    .C(clk),
    .D(\blk00000001/sig00000133 ),
    .Q(\blk00000001/sig0000011f )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000060  (
    .C(clk),
    .D(\blk00000001/sig00000134 ),
    .Q(\blk00000001/sig00000120 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000005f  (
    .C(clk),
    .D(\blk00000001/sig00000135 ),
    .Q(\blk00000001/sig00000121 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000005e  (
    .C(clk),
    .D(\blk00000001/sig00000110 ),
    .Q(\blk00000001/sig000001b6 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000005d  (
    .C(clk),
    .D(\blk00000001/sig00000111 ),
    .Q(\blk00000001/sig000001b7 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000005c  (
    .C(clk),
    .D(\blk00000001/sig00000112 ),
    .Q(\blk00000001/sig000001b8 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000005b  (
    .C(clk),
    .D(\blk00000001/sig00000113 ),
    .Q(\blk00000001/sig000001b9 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000005a  (
    .C(clk),
    .D(\blk00000001/sig00000114 ),
    .Q(\blk00000001/sig000001ba )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000059  (
    .C(clk),
    .D(\blk00000001/sig00000115 ),
    .Q(\blk00000001/sig000001bb )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000058  (
    .C(clk),
    .D(\blk00000001/sig00000122 ),
    .Q(\blk00000001/sig000001bc )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000057  (
    .C(clk),
    .D(\blk00000001/sig00000116 ),
    .Q(\blk00000001/sig00000108 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000056  (
    .C(clk),
    .D(\blk00000001/sig00000117 ),
    .Q(\blk00000001/sig00000109 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000055  (
    .C(clk),
    .D(\blk00000001/sig00000118 ),
    .Q(\blk00000001/sig0000010a )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000054  (
    .C(clk),
    .D(\blk00000001/sig00000119 ),
    .Q(\blk00000001/sig0000010b )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000053  (
    .C(clk),
    .D(\blk00000001/sig0000011a ),
    .Q(\blk00000001/sig0000010c )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000052  (
    .C(clk),
    .D(\blk00000001/sig0000011b ),
    .Q(\blk00000001/sig0000010d )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000051  (
    .C(clk),
    .D(\blk00000001/sig0000011c ),
    .Q(\blk00000001/sig0000010e )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000050  (
    .C(clk),
    .D(\blk00000001/sig0000011d ),
    .Q(\blk00000001/sig0000010f )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000004f  (
    .C(clk),
    .D(\blk00000001/sig0000011e ),
    .Q(\blk00000001/sig000001bd )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000004e  (
    .C(clk),
    .D(\blk00000001/sig0000011f ),
    .Q(\blk00000001/sig00000105 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000004d  (
    .C(clk),
    .D(\blk00000001/sig00000120 ),
    .Q(\blk00000001/sig00000106 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000004c  (
    .C(clk),
    .D(\blk00000001/sig00000121 ),
    .Q(\blk00000001/sig00000107 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000004b  (
    .C(clk),
    .D(a[0]),
    .Q(\blk00000001/sig000001a4 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000004a  (
    .C(clk),
    .D(a[1]),
    .Q(\blk00000001/sig000001a5 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000049  (
    .C(clk),
    .D(a[2]),
    .Q(\blk00000001/sig000001a6 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000048  (
    .C(clk),
    .D(a[3]),
    .Q(\blk00000001/sig000001a7 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000047  (
    .C(clk),
    .D(a[4]),
    .Q(\blk00000001/sig000001a8 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000046  (
    .C(clk),
    .D(a[5]),
    .Q(\blk00000001/sig000001a9 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000045  (
    .C(clk),
    .D(a[6]),
    .Q(\blk00000001/sig000001aa )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000044  (
    .C(clk),
    .D(a[7]),
    .Q(\blk00000001/sig000001ab )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000043  (
    .C(clk),
    .D(a[8]),
    .Q(\blk00000001/sig000001ac )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000042  (
    .C(clk),
    .D(a[9]),
    .Q(\blk00000001/sig000001ad )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000041  (
    .C(clk),
    .D(a[10]),
    .Q(\blk00000001/sig000001ae )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000040  (
    .C(clk),
    .D(a[11]),
    .Q(\blk00000001/sig000001af )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000003f  (
    .C(clk),
    .D(a[12]),
    .Q(\blk00000001/sig000001b0 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000003e  (
    .C(clk),
    .D(a[13]),
    .Q(\blk00000001/sig000001b1 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000003d  (
    .C(clk),
    .D(a[14]),
    .Q(\blk00000001/sig000001b2 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000003c  (
    .C(clk),
    .D(a[15]),
    .Q(\blk00000001/sig000001b3 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000003b  (
    .C(clk),
    .D(a[16]),
    .Q(\blk00000001/sig000001b4 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000003a  (
    .C(clk),
    .D(a[17]),
    .Q(\blk00000001/sig000001b5 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000039  (
    .C(clk),
    .D(b[0]),
    .Q(\blk00000001/sig00000192 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000038  (
    .C(clk),
    .D(b[1]),
    .Q(\blk00000001/sig00000193 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000037  (
    .C(clk),
    .D(b[2]),
    .Q(\blk00000001/sig00000194 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000036  (
    .C(clk),
    .D(b[3]),
    .Q(\blk00000001/sig00000195 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000035  (
    .C(clk),
    .D(b[4]),
    .Q(\blk00000001/sig00000196 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000034  (
    .C(clk),
    .D(b[5]),
    .Q(\blk00000001/sig00000197 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000033  (
    .C(clk),
    .D(b[6]),
    .Q(\blk00000001/sig00000198 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000032  (
    .C(clk),
    .D(b[7]),
    .Q(\blk00000001/sig00000199 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000031  (
    .C(clk),
    .D(b[8]),
    .Q(\blk00000001/sig0000019a )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000030  (
    .C(clk),
    .D(b[9]),
    .Q(\blk00000001/sig0000019b )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002f  (
    .C(clk),
    .D(b[10]),
    .Q(\blk00000001/sig0000019c )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002e  (
    .C(clk),
    .D(b[11]),
    .Q(\blk00000001/sig0000019d )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002d  (
    .C(clk),
    .D(b[12]),
    .Q(\blk00000001/sig0000019e )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002c  (
    .C(clk),
    .D(b[13]),
    .Q(\blk00000001/sig0000019f )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002b  (
    .C(clk),
    .D(b[14]),
    .Q(\blk00000001/sig000001a0 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002a  (
    .C(clk),
    .D(b[15]),
    .Q(\blk00000001/sig000001a1 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000029  (
    .C(clk),
    .D(b[16]),
    .Q(\blk00000001/sig000001a2 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000028  (
    .C(clk),
    .D(b[17]),
    .Q(\blk00000001/sig000001a3 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000027  (
    .C(clk),
    .D(\blk00000001/sig000001a4 ),
    .Q(\blk00000001/sig00000180 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000026  (
    .C(clk),
    .D(\blk00000001/sig000001a5 ),
    .Q(\blk00000001/sig00000181 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000025  (
    .C(clk),
    .D(\blk00000001/sig000001a6 ),
    .Q(\blk00000001/sig00000182 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000024  (
    .C(clk),
    .D(\blk00000001/sig000001a7 ),
    .Q(\blk00000001/sig00000183 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000023  (
    .C(clk),
    .D(\blk00000001/sig000001a8 ),
    .Q(\blk00000001/sig00000184 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000022  (
    .C(clk),
    .D(\blk00000001/sig000001a9 ),
    .Q(\blk00000001/sig00000185 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000021  (
    .C(clk),
    .D(\blk00000001/sig000001aa ),
    .Q(\blk00000001/sig00000186 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000020  (
    .C(clk),
    .D(\blk00000001/sig000001ab ),
    .Q(\blk00000001/sig00000187 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001f  (
    .C(clk),
    .D(\blk00000001/sig000001ac ),
    .Q(\blk00000001/sig00000188 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001e  (
    .C(clk),
    .D(\blk00000001/sig000001ad ),
    .Q(\blk00000001/sig00000189 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001d  (
    .C(clk),
    .D(\blk00000001/sig000001ae ),
    .Q(\blk00000001/sig0000018a )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001c  (
    .C(clk),
    .D(\blk00000001/sig000001af ),
    .Q(\blk00000001/sig0000018b )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001b  (
    .C(clk),
    .D(\blk00000001/sig000001b0 ),
    .Q(\blk00000001/sig0000018c )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001a  (
    .C(clk),
    .D(\blk00000001/sig000001b1 ),
    .Q(\blk00000001/sig0000018d )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000019  (
    .C(clk),
    .D(\blk00000001/sig000001b2 ),
    .Q(\blk00000001/sig0000018e )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000018  (
    .C(clk),
    .D(\blk00000001/sig000001b3 ),
    .Q(\blk00000001/sig0000018f )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000017  (
    .C(clk),
    .D(\blk00000001/sig000001b4 ),
    .Q(\blk00000001/sig00000190 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000016  (
    .C(clk),
    .D(\blk00000001/sig000001b5 ),
    .Q(\blk00000001/sig00000191 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000015  (
    .C(clk),
    .D(\blk00000001/sig000000f3 ),
    .Q(\blk00000001/sig0000016e )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000014  (
    .C(clk),
    .D(\blk00000001/sig000000f4 ),
    .Q(\blk00000001/sig0000016f )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000013  (
    .C(clk),
    .D(\blk00000001/sig000000f5 ),
    .Q(\blk00000001/sig00000170 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000012  (
    .C(clk),
    .D(\blk00000001/sig000000f6 ),
    .Q(\blk00000001/sig00000171 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000011  (
    .C(clk),
    .D(\blk00000001/sig000000f7 ),
    .Q(\blk00000001/sig00000172 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000010  (
    .C(clk),
    .D(\blk00000001/sig000000f8 ),
    .Q(\blk00000001/sig00000173 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000f  (
    .C(clk),
    .D(\blk00000001/sig000000f9 ),
    .Q(\blk00000001/sig00000174 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000e  (
    .C(clk),
    .D(\blk00000001/sig000000fa ),
    .Q(\blk00000001/sig00000175 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000d  (
    .C(clk),
    .D(\blk00000001/sig000000fb ),
    .Q(\blk00000001/sig00000176 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000c  (
    .C(clk),
    .D(\blk00000001/sig000000fc ),
    .Q(\blk00000001/sig00000177 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000b  (
    .C(clk),
    .D(\blk00000001/sig000000fd ),
    .Q(\blk00000001/sig00000178 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000a  (
    .C(clk),
    .D(\blk00000001/sig000000fe ),
    .Q(\blk00000001/sig00000179 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000009  (
    .C(clk),
    .D(\blk00000001/sig000000ff ),
    .Q(\blk00000001/sig0000017a )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000008  (
    .C(clk),
    .D(\blk00000001/sig00000100 ),
    .Q(\blk00000001/sig0000017b )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000007  (
    .C(clk),
    .D(\blk00000001/sig00000101 ),
    .Q(\blk00000001/sig0000017c )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000006  (
    .C(clk),
    .D(\blk00000001/sig00000102 ),
    .Q(\blk00000001/sig0000017d )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000005  (
    .C(clk),
    .D(\blk00000001/sig00000103 ),
    .Q(\blk00000001/sig0000017e )
  );
  FD #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000004  (
    .C(clk),
    .D(\blk00000001/sig00000104 ),
    .Q(\blk00000001/sig0000017f )
  );
  GND   \blk00000001/blk00000003  (
    .G(\blk00000001/sig0000013c )
  );
  VCC   \blk00000001/blk00000002  (
    .P(\blk00000001/sig000000eb )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
