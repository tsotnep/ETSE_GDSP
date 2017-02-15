/*
 * mylib.c
 *	info:
 BA is Base ADdress.


 *  Created on: 6 Sep 2016
 *      Author: tsotne
 */

#ifndef MYLIB_C_
#define MYLIB_C_

#include "xil_types.h"
#include <stdbool.h>
#include "xaxidma.h"

//CMD
#define cmd_NULL               0
#define cmd_SAVE_G_or_P        1
#define cmd_LOAD_G             2
#define cmd_LOAD_P             3
#define cmd_CALCULTE           4
#define cmd_P_to_G             5
#define cmd_UNLOAD_G           6
#define cmd_RESET_MMULT_IP     11
#define cmd_RESET_MMULT_CNTRL  12
#define cmd_SAVE_G             13
#define cmd_SAVE_P             14
#define cmd_FINISH_SAVING_G_P  15

//CMD2. Lower means Lower bank of P block ram, and Upper means Upper bank of P block ram.
#define cmd_P_LOWER_to_G            11
#define cmd_P_HIGHER_to_G           15
#define cmd_CALCULATE_PG_LOWER      0
#define cmd_CALCULATE_PG_HIGHER     4
#define cmd_CALCULATE_PGt_LOWER     1
#define cmd_CALCULATE_PGt_HIGHER    5
#define cmd_CALCULATE_PtG_LOWER     2
#define cmd_CALCULATE_PtG_HIGHER    6
#define cmd_CALCULATE_PtGt_LOWER    3
#define cmd_CALCULATE_PtGt_HIGHER   7



//Memory 2 Stream Register offsets
#define c_MM2S 0x00 //control reg
#define s_MM2S 0x04 //status reg
#define sa_MM2S 0x18 //source address
#define tl_MM2S 0x28 //transfer length

//Stream to Memory Register offsets
#define c_S2MM 0x30 //control reg
#define s_S2MM 0x34 //status reg
#define da_S2MM 0x48 //destination address
#define bl_S2MM 0x58 //buffer length



#define pbreak xil_printf("Command Completed Successfully \r\n"); break;


#define TX_BUFFER_BASE		(XPAR_PS7_DDR_0_S_AXI_BASEADDR)
u32 *TxBufferPtr = (u32 *) TX_BUFFER_BASE;

#define RX_BUFFER_BASE		(XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x00800000)
u32 *RxBufferPtr = (u32 *) RX_BUFFER_BASE;


void static printTX(int McolSz){
	u32 i;
	for (i = 0; i < McolSz * McolSz; i++) {
		xil_printf("%d ", TxBufferPtr[i]);
        if ((i+1) % McolSz == 0) xil_printf("\r\n");
	}
}

void static printRX(int McolSz){
	u32 i;
	for (i = 0; i < McolSz * McolSz; i++) {
		xil_printf("%d ", RxBufferPtr[i]);
        if ((i+1) % McolSz == 0) xil_printf("\r\n");
	}
}



// BIT OPERATIONS
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
static void rd_print(u32 BA, u32 reg_offset, u8 bit_ind) {
	xil_printf("reg_%08x+%x[%d] = %x\r\n", BA, reg_offset, bit_ind, rd(BA,reg_offset,bit_ind));
}




// REGISTER OPERATIONS
//write a value in a register
static void write(u32 BA, u32 reg_offset, u32 val) {
	Xil_Out32(BA + reg_offset, val);
}

//read a value from a register
static u32 read(u32 BA, u32 reg_offset) {
	return Xil_In32(BA + reg_offset); //TODO: that should be + 4*reg_offset
}

//read and print a value from a register
static void read_print(u32 BA, u32 reg_offset) {
	xil_printf("reg_%08x+%x = %08x\r\n", BA, reg_offset, read(BA,reg_offset));
}






// DMA THINGS
//enables both channels
int static DMA_init(void) {
	set(XPAR_AXI_DMA_0_BASEADDR, c_MM2S, 0); //start _MM2S channel
	set(XPAR_AXI_DMA_0_BASEADDR, c_S2MM, 0); //start _S2MM channel
	return XST_SUCCESS;
}


//enables interrupts in DMA
static int DMA_enable_irq() {
	set(XPAR_AXI_DMA_0_BASEADDR, 0x00, 12); //start MM2S channel
	set(XPAR_AXI_DMA_0_BASEADDR, 0x30, 12); //start S2MM channel
	return XST_SUCCESS;
}


//resets DMA by writing 1 into reset soft register
static int DMA_soft_reset(void) {
    set(XPAR_AXI_DMA_0_BASEADDR, 0x00, 2); //start MM2S channel
	set(XPAR_AXI_DMA_0_BASEADDR, 0x30, 2); //start S2MM channel
	print("DMA MM2S and S2MM reset bits set\r\n");
	return XST_SUCCESS;
}


//writes destination and source addresses of memory and then length of transfer
int static DMA_execute_transfer(u32 RxBufferPtr, u32 TxBufferPtr, u32 Number_Of_Bytes) {
	write(XPAR_AXI_DMA_0_BASEADDR, da_S2MM, RxBufferPtr); //specify destination address
	write(XPAR_AXI_DMA_0_BASEADDR, sa_MM2S, TxBufferPtr); //specify source address

	write(XPAR_AXI_DMA_0_BASEADDR, bl_S2MM, Number_Of_Bytes); //specify transfer length in bytes
	write(XPAR_AXI_DMA_0_BASEADDR, tl_MM2S, Number_Of_Bytes); //specify transfer length in bytes
	print("DMA transfer scheduled...\r\n");
	return XST_SUCCESS;
}

//returns XST_SUCCESS if DMA is configured in Normal Mode. returns XST_FAILURE if its SG mode
static int DMA_check_normal_mode() {
	if (rd(XPAR_AXI_DMA_0_BASEADDR, 0x04, 3) || rd(XPAR_AXI_DMA_0_BASEADDR, 0x34, 3)) {
		xil_printf("DMA SG mode is enabled\r\n");
		return XST_FAILURE;
	} else {
		xil_printf("DMA Normal mode is enabled\r\n");
		return XST_SUCCESS;
	}
}

//returns XST_SUCCESS if DMA interrupts are disabled
static int DMA_check_irq_enabled() {
	if (rd(XPAR_AXI_DMA_0_BASEADDR, 0x00, 12) && rd(XPAR_AXI_DMA_0_BASEADDR, 0x30, 12)) {
		xil_printf("DMA interrupts are enabled\r\n");
		return XST_SUCCESS;
	} else {
		xil_printf("DMA interrupts are disabled\r\n");
		return XST_FAILURE;
	}
}


//returns XST_SUCCESS if DMA it is idle
static int DMA_check_idle_MM2S() {
//	rd_print(XPAR_AXI_DMA_0_BASEADDR, 0x04, 1);
//	rd_print(XPAR_AXI_DMA_0_BASEADDR, 0x34, 1);
	if (rd(XPAR_AXI_DMA_0_BASEADDR, 0x04, 1)) { //&& rd(XPAR_AXI_DMA_0_BASEADDR, 0x34, 1) -this commented one is for S2MM status register. TODO: becuase it remains 0, where it should be 1, probably in MMULT i have to reset handshaking signals
		xil_printf("DMA is idle\r\n");
		return XST_SUCCESS;
	} else {
		xil_printf("DMA is busy\r\n");
		//TODO: For that reason, it is not 1 and prints BUSY when it is not. so i have to account that, for example, not execute this function prior to first transfer. from DMA manual on status registers: "Note: This bit is 0 when channel is halted (DMASR.Halted=1). This bit is also 0 prior to initial transfer when AXI DMA is configured for Direct Register Mode."
		return XST_FAILURE;
	}
}
static int DMA_check_idle_S2MM() {
//	rd_print(XPAR_AXI_DMA_0_BASEADDR, 0x04, 1);
//	rd_print(XPAR_AXI_DMA_0_BASEADDR, 0x34, 1);
	if (rd(XPAR_AXI_DMA_0_BASEADDR, 0x34, 1)) {
		xil_printf("DMA is idle\r\n");
		return XST_SUCCESS;
	} else {
		xil_printf("DMA is busy\r\n");
		return XST_FAILURE;
	}
}

//returns XST_SUCCESS if interrupt flag has been asserted.. polling
static int DMA_check_irq_event() {
	if (rd(XPAR_AXI_DMA_0_BASEADDR, 0x04, 12) && rd(XPAR_AXI_DMA_0_BASEADDR, 0x34, 12)) {
		xil_printf("DMA irq flag has been asserted\r\n");
		return XST_SUCCESS;
	} else {
		xil_printf("DMA irq flag has not been asserted\r\n");
		return XST_FAILURE;
	}

}



// OTHER FUNCTIONS

// READ number from UART
u32 UART_inputNumber() {
	u32 number = 0;
	char mychar = '0';
	while (mychar != ' ' && mychar != '\r') {
		number *= 10;
		number += mychar - '0';
		mychar = inbyte();
	}
	return number;
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



// combine commands and data into one 32 bit data and write it into slv_reg0
void write_cmd(u32 cmd, u32 cmd2, u32 data){
	u32 unified = (cmd2<<22 | cmd<<18 | data);
	write(XPAR_ETSE_GDSP_0_BASEADDR, 0, unified);
//	xil_printf("written on slv_reg0, bin value = %s \r\n", getBinary(unified)); //for testing you can uncomment this to make sure command is constructed properly
}

/* CMD construction
 ----------------------------------------------------->>>
 --CMD:
 ------cmd that affect state transition, they are read inside state: cntrl_WAIT_FOR_CMD
 constant cmd_NULL              : std_logic_vector := std_logic_vector(to_unsigned(0, 4));
 constant cmd_SAVE_G_or_P       : std_logic_vector := std_logic_vector(to_unsigned(1, 4));
 constant cmd_LOAD_G            : std_logic_vector := std_logic_vector(to_unsigned(2, 4));
 constant cmd_LOAD_P            : std_logic_vector := std_logic_vector(to_unsigned(3, 4));
 constant cmd_CALCULTE          : std_logic_vector := std_logic_vector(to_unsigned(4, 4));
 constant cmd_P_to_G            : std_logic_vector := std_logic_vector(to_unsigned(5, 4));
 constant cmd_UNLOAD_G          : std_logic_vector := std_logic_vector(to_unsigned(6, 4));
 constant cmd_RESET_MMULT_IP    : std_logic_vector := std_logic_vector(to_unsigned(11, 4));
 constant cmd_RESET_MMULT_CNTRL : std_logic_vector := std_logic_vector(to_unsigned(12, 4));

 --------those cmd are used as state-specific commands, they are read in state: cntrl_SAVE_G_or_P
 constant cmd_SAVE_G            : std_logic_vector := std_logic_vector(to_unsigned(13, 4));
 constant cmd_SAVE_P            : std_logic_vector := std_logic_vector(to_unsigned(14, 4));
 constant cmd_FINISH_SAVING_G_P : std_logic_vector := std_logic_vector(to_unsigned(15, 4));

 ----------------------------------------------------->>>
 --CMD2:
 ------calculation or unload details
 constant cmd_P_LOWER_to_G  		   : std_logic_vector := "1011"; 11
 constant cmd_P_HIGHER_to_G         : std_logic_vector := "1111"; 15
 constant cmd_CALCULATE_PG_LOWER    : std_logic_vector := "0000"; 0
 constant cmd_CALCULATE_PG_HIGHER   : std_logic_vector := "0100"; 4
 constant cmd_CALCULATE_PGt_LOWER   : std_logic_vector := "0001"; 1
 constant cmd_CALCULATE_PGt_HIGHER  : std_logic_vector := "0101"; 5
 constant cmd_CALCULATE_PtG_LOWER   : std_logic_vector := "0010"; 2
 constant cmd_CALCULATE_PtG_HIGHER  : std_logic_vector := "0110"; 6
 constant cmd_CALCULATE_PtGt_LOWER  : std_logic_vector := "0011"; 3
 constant cmd_CALCULATE_PtGt_HIGHER : std_logic_vector := "0111"; 7
 *
 */


#endif /* MYLIB_C_ */
