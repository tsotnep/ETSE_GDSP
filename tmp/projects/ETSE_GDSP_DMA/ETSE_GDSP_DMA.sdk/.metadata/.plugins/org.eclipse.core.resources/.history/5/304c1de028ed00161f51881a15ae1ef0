/*
 * mylib.c
 *
 *  Created on: 6 Sep 2016
 *      Author: tsotne
 */

#ifndef MYLIB_C_
#define MYLIB_C_

#include "xil_types.h"
#include <stdbool.h>
#include "xaxidma.h"
#include "MMULT_AXI_STREAM.h"

//BA is Base ADdress.

//set one particular bit to value '1', in a register.
static void set(u32 BA, u32 reg_offset, u8 bit_ind) {
	Xil_Out32(BA + reg_offset, (Xil_In32(BA + reg_offset) | 1 << bit_ind));
}

//set one particular bit to value '0', in a register.
static void clr(u32 BA, u32 reg_offset, u8 bit_ind) {
	Xil_Out32(BA + reg_offset, Xil_In32(BA + reg_offset) & ~(1 << bit_ind));
}

//read one particular bit from a register.
static bool rd(u32 BA, u32 reg_offset, u8 bit_ind) {
	return (Xil_In32(BA + reg_offset) & (1 << bit_ind)) > 0;
}

//read and print one particular bit from a register.
static void prrd(u32 BA, u32 reg_offset, u8 bit_ind) {
	xil_printf("reg_%08x+%x[%d] = %x\r\n", BA, reg_offset, bit_ind, (Xil_In32(BA + reg_offset) & (1 << bit_ind)) > 0);
}

//write a value in a register
static void write(u32 BA, u32 reg_offset, u32 val) {
	Xil_Out32(BA + reg_offset, val);
}

//read a value from a register
static u32 read(u32 BA, u32 reg_offset) {
	return Xil_In32(BA + reg_offset);
}

//read and print a value from a register
static void prread(u32 BA, u32 reg_offset) {
	xil_printf("reg_%08x+%x = %08x\r\n", BA, reg_offset, Xil_In32(BA + reg_offset));
}

//convert decimal number into binary string/char array.
char ans[33];
char* getBinary(u32 n) {
	u32 i;
	for (i = 0; i <= 31; i++) {
		ans[31 - i] = (n & 1) == 1 ? '1' : '0';
		n = n >> 1;
	}
	ans[32] = '\0';
	return ans;
}


//returns XST_SUCCESS if DMA is configured in Normal Mode. returns XST_FAILURE if its SG mode
static int check_DMA_normal_mode() {
	if (rd(XPAR_AXI_DMA_0_BASEADDR, 0x04, 3) || rd(XPAR_AXI_DMA_0_BASEADDR, 0x34, 3)) {
		xil_printf("SG DMA mode is enabled\r\n");
		return XST_FAILURE;
	} else {
		xil_printf("Normal DMA mode is enabled\r\n");
		return XST_SUCCESS;
	}
}

//returns XST_SUCCESS if DMA interrupts are disabled
static int check_DMA_irq_disabled() {
	if (rd(XPAR_AXI_DMA_0_BASEADDR, 0x00, 12) && rd(XPAR_AXI_DMA_0_BASEADDR, 0x30, 12)) {
		xil_printf("DMA interrupts are enabled\r\n");
		return XST_SUCCESS;
	} else {
		xil_printf("DMA interrupts are disabled\r\n");
		return XST_FAILURE;
	}
}


//returns XST_SUCCESS if DMA it is idle
static int check_DMA_idle() {
	if (rd(XPAR_AXI_DMA_0_BASEADDR, 0x04, 1) && rd(XPAR_AXI_DMA_0_BASEADDR, 0x34, 1)) {
		xil_printf("DMA is idle\r\n");
		return XST_SUCCESS;
	} else {
		xil_printf("DMA is busy\r\n");
		return XST_FAILURE;
	}
}


//returns XST_SUCCESS if interrupt flag has been asserted.. polling
static int check_DMA_irq_event() {
	if (rd(XPAR_AXI_DMA_0_BASEADDR, 0x04, 12) && rd(XPAR_AXI_DMA_0_BASEADDR, 0x34, 12)) {
		xil_printf("DMA irq flag has been asserted\r\n");
		return XST_SUCCESS;
	} else {
		xil_printf("DMA irq flag has not been asserted\r\n");
		return XST_FAILURE;
	}

}

//enables interrupts in DMA
static int enable_DMA_irq() {
	set(XPAR_AXI_DMA_0_BASEADDR, 0x00, 12); //start MM2S channel
	set(XPAR_AXI_DMA_0_BASEADDR, 0x30, 12); //start S2MM channel
	return XST_SUCCESS;
}


//resets DMA by writing 1 into reset soft register
static int enable_DMA_soft_reset(void) {
	print("Resetting DMA\r\n");
    xil_printf("pass\r\n");
    set(XPAR_AXI_DMA_0_BASEADDR, 0x00, 2); //start MM2S channel
    xil_printf("pass\r\n");
	set(XPAR_AXI_DMA_0_BASEADDR, 0x30, 2); //start S2MM channel
    xil_printf("pass\r\n");
	return XST_SUCCESS;
}



void AXI_2_write(u32 cmd, u32 cmd2, u32 data){
	u32 unified = (cmd2<<22 | cmd<<18 | data);
	MMULT_AXI_STREAM_mWriteReg(XPAR_MMULT_AXI_STREAM_0_S00_AXI_BASEADDR, MMULT_AXI_STREAM_S00_AXI_SLV_REG0_OFFSET, unified);
//	xil_printf("written on slv_reg0, bin value = %s \r\n", getBinary(unified));
}

void AXI_2_read_print(u32 addr){
	xil_printf("from slv_reg%d, value = %d\r\n",addr,MMULT_AXI_STREAM_mReadReg(XPAR_MMULT_AXI_STREAM_0_S00_AXI_BASEADDR, addr*4));
}

#endif /* MYLIB_C_ */
