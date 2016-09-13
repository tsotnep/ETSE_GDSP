#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xaxidma.h"
#include "xil_types.h"
#include "mylib.h"
#include "sleep.h"
#include "xil_cache.h"

//DDR address map: http://dl.dropbox.com/u/65113214/16-09-07_13%3A33%3A13_Selection.png
//DMA register offsets: http://dl.dropbox.com/u/65113214/16-09-01_19%3A12%3A31_Selection.png
//_MM2S / _S2MM control reg: http://dl.dropbox.com/u/65113214/16-09-01_19%3A15%3A25_Selection.png
//_MM2S / _S2MM status reg: http://dl.dropbox.com/u/65113214/16-09-01_19%3A16%3A26_Selection.png

//MM 2 S Register offsets
#define c_MM2S 0x00 //control reg
#define s_MM2S 0x04 //status reg
#define sa_MM2S 0x18 //source address
#define tl_MM2S 0x28 //transfer length

//S to MM Register offsets
#define c_S2MM 0x30 //control reg
#define s_S2MM 0x34 //status reg
#define da_S2MM 0x48 //destination address
#define bl_S2MM 0x58 //buffer length

//Data
#define Number_Of_Bytes		40
//#define Number_Of_Bytes			0x007FFFFF

#define TX_BUFFER_BASE		(XPAR_PS7_DDR_0_S_AXI_BASEADDR)
u32 *TxBufferPtr = (u32 *) TX_BUFFER_BASE;

#define RX_BUFFER_BASE		(XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x00800000)
u32 *RxBufferPtr = (u32 *) RX_BUFFER_BASE;

//functions
static int init_dma(void);
static int execute_dma_transfer(void);
void static test();
void static print_arr(void);

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

//CMD2
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

//Others
#define DOUT_slv_reg1_addr 1
#define pbreak xil_printf("Command Completed Successfully \r\n"); break;
#define McolSz 3

u32 inputNumber();
void save_g_or_p();
void printManual();
void unload_g();

int main() {
	enable_DMA_soft_reset();

	TxBufferPtr[0] = 11;
	TxBufferPtr[1] = 12;
	TxBufferPtr[2] = 13;
	TxBufferPtr[3] = 21;
	TxBufferPtr[4] = 22;
	TxBufferPtr[5] = 23;
	TxBufferPtr[6] = 31;
	TxBufferPtr[7] = 32;
	TxBufferPtr[8] = 33;

	u32 status;
	status = check_DMA_normal_mode();
	status = init_dma();
	Xil_DCacheDisable();

    status = execute_dma_transfer();



	u32 userIn;
	printManual();
	while (1) {
		userIn = inputNumber();
		xil_printf("Command Received : %d \r\n",userIn);
		switch (userIn) {
		case 0:
			printManual();
			pbreak;
		case 1:
			save_g_or_p();
			pbreak;
		case 2:
			AXI_2_write(cmd_LOAD_G, cmd_NULL, 0);
			pbreak;
		case 3:
			AXI_2_write(cmd_LOAD_P, cmd_NULL, 0);
			pbreak;
		case 4:
			AXI_2_write(cmd_CALCULTE, cmd_CALCULATE_PG_HIGHER, 0); //TODO: complete this
			pbreak;
		case 5:
			AXI_2_write(cmd_P_to_G, cmd_P_HIGHER_to_G, 0); //TODO: complete this also
			pbreak;
		case 6:
			unload_g();
			pbreak;
		case 11:
			AXI_2_write(cmd_RESET_MMULT_IP, cmd_NULL, 0);
			pbreak;
		case 12:
			AXI_2_write(cmd_RESET_MMULT_CNTRL, cmd_NULL, 0);
			pbreak;
		default:
			xil_printf("Unknown Command\r\n");
		}
	}
	return 0;
}
//11 12 13 21 22 23 31 32 33


/*
 * command construction (total 32 bits)
 *
 * 6bits   4bits     4bits     18bits
 * 31:26   25:22     21:18     17:0
 * 000000  0000      0000      00 00000000 00000000
 *         |cmd2|    |cmd|     |data              |
 *         (details) (command)
 */

/* step by step
 *
 * 1. reset
 * 2. write G
 * 3. write P
 * 4. write next command
 * 5. write current command
 * 6. read data
 *
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


void printManual() {
	xil_printf("\r\n\r\nPlease Enter New Command Number : \r\n");
	xil_printf(":0) To print this Commands\r\n");
	xil_printf(":1) SAVE_G_or_P\r\n");
	xil_printf(":2) LOAD_G\r\n");
	xil_printf(":3) LOAD_P\r\n");
	xil_printf(":4) CALCULTE\r\n");
	xil_printf(":5) P_to_G\r\n");
	xil_printf(":6) UNLOAD_G\r\n");
	xil_printf(":11) RESET_MMULT_IP\r\n");
	xil_printf(":12) RESET_MMULT_CNTRL\r\n");
}

void save_g_or_p() {
	AXI_2_write(cmd_SAVE_G_or_P, cmd_NULL, 0);

	xil_printf("input G matrix, %d elements, separated with space\r\n",
			McolSz * McolSz);
	u32 i;
	for (i = 0; i < McolSz * McolSz; i++) {
		AXI_2_write(cmd_SAVE_G, cmd_NULL, inputNumber());
	}

	xil_printf("input P matrix, %d elements, separated with space\r\n",
			McolSz * McolSz);
	for (i = 0; i < McolSz * McolSz; i++) {
		AXI_2_write(cmd_SAVE_P, cmd_NULL, inputNumber());
	}
	AXI_2_write(cmd_FINISH_SAVING_G_P, cmd_NULL, 0);
}

void unload_g() {
	u32 i;
	AXI_2_write(cmd_UNLOAD_G, cmd_NULL, 0);
	for (i = 0; i < McolSz * McolSz; i++) {
		AXI_2_read_print(DOUT_slv_reg1_addr);
	}
}

u32 inputNumber() {
	u32 number = 0;
	char mychar = '0';
	while (mychar != ' ' && mychar != '\n') {
		number *= 10;
		number += mychar - '0';
		mychar = inbyte();
	}
	return number;
}



void static print_arr(void){
	xil_printf("TxBufferPtr = %08x \n\r", (TxBufferPtr));
	xil_printf("TxBufferPtr[0] = %x \n\r", (TxBufferPtr[0]));
	xil_printf("TxBufferPtr[1] = %x \n\r", (TxBufferPtr[1]));
	xil_printf("TxBufferPtr[2] = %x \n\r", (TxBufferPtr[2]));
	xil_printf("TxBufferPtr[3] = %x \n\r", (TxBufferPtr[3]));
	xil_printf("RxBufferPtr = %08x \n\r", (RxBufferPtr));
	xil_printf("RxBufferPtr[0] = %x \n\r", (RxBufferPtr[0]));
	xil_printf("RxBufferPtr[1] = %x \n\r", (RxBufferPtr[1]));
	xil_printf("RxBufferPtr[2] = %x \n\r", (RxBufferPtr[2]));
	xil_printf("RxBufferPtr[3] = %x \n\r", (RxBufferPtr[3]));
}


int static init_dma(void) {

//	write(XPAR_AXI_DMA_0_BASEADDR, c_MM2S, 0);
//	write(XPAR_AXI_DMA_0_BASEADDR, c_S2MM, 0);
//	prread(XPAR_AXI_DMA_0_BASEADDR, c_MM2S); //read if its written
//	prread(XPAR_AXI_DMA_0_BASEADDR, c_S2MM); //read if its written

	set(XPAR_AXI_DMA_0_BASEADDR, c_MM2S, 0); //start _MM2S channel
	set(XPAR_AXI_DMA_0_BASEADDR, c_S2MM, 0); //start _S2MM channel
	//	prread(XPAR_AXI_DMA_0_BASEADDR, c_MM2S); //read if its written
	//	prread(XPAR_AXI_DMA_0_BASEADDR, c_S2MM); //read if its written

	xil_printf(
			"reading DMA channels enable bits in control reg(1=enabled): \n\r");
	prrd(XPAR_AXI_DMA_0_BASEADDR, c_MM2S, 0); //read status if running
	prrd(XPAR_AXI_DMA_0_BASEADDR, c_S2MM, 0); //read status if running

	xil_printf(
			"reading DMA channels enable bits in status reg(0=running): \n\r");
	prrd(XPAR_AXI_DMA_0_BASEADDR, s_MM2S, 0); //read status if running
	prrd(XPAR_AXI_DMA_0_BASEADDR, s_S2MM, 0); //read status if running
	return XST_SUCCESS;
}

int static execute_dma_transfer(void) {
//	print("exeuting DMA transfer\n\r");
	write(XPAR_AXI_DMA_0_BASEADDR, da_S2MM, (u32) RxBufferPtr); //specify destination address
	write(XPAR_AXI_DMA_0_BASEADDR, sa_MM2S, (u32) TxBufferPtr); //specify source address

	write(XPAR_AXI_DMA_0_BASEADDR, bl_S2MM, (u32) Number_Of_Bytes); //specify transfer length in bytes
	write(XPAR_AXI_DMA_0_BASEADDR, tl_MM2S, (u32) Number_Of_Bytes); //specify transfer length in bytes

	xil_printf("reading transfer addresses\n\r");
	prread(XPAR_AXI_DMA_0_BASEADDR, sa_MM2S); //read source address
	prread(XPAR_AXI_DMA_0_BASEADDR, da_S2MM); //read destination address

	xil_printf("reading transfer lengths\n\r");
	prread(XPAR_AXI_DMA_0_BASEADDR, tl_MM2S); //read destination address
	prread(XPAR_AXI_DMA_0_BASEADDR, bl_S2MM); //read source address
	return XST_SUCCESS;
}

void static test() {
	u32 val = 0;
	u8 bit_ind = 0;

	val = 0;
	bit_ind = 0;
	val = val | 1 << bit_ind;
	xil_printf("ind-%d, %x \n\r", bit_ind, val);

	val = 0;
	bit_ind = 1;
	val = val | 1 << bit_ind;
	xil_printf("ind-%d, %x \n\r", bit_ind, val);

}
