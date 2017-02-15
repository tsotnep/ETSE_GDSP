#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xaxidma.h"
#include "xil_types.h"
#include "mylib.h"
#include "sleep.h"
#include "xil_cache.h"

/*
 * step by step
 *
 * 1. reset
 * 2. generate G data, for example command 25
 * 3. load into G ram, command 3
 * 4. generate P data, for example command 25 (always saved into higher/upper bank of P, becase no need to implement this flexibility)
 * 5. load into P-upper ram, command 2
 * 6. calculate, command 41
 * 7. unload data from P lower or upper ram, command 5 or 51
 * 8. send data from IP to memory, command 6
 * 9. print data from memory to uart. command 8
 *
*/

//DDR address map: p742 https://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf
//DMA register offsets: p15 https://www.xilinx.com/support/documentation/ip_documentation/axi_dma/v7_1/pg021_axi_dma.pdf
//_MM2S / _S2MM control reg: p16 https://www.xilinx.com/support/documentation/ip_documentation/axi_dma/v7_1/pg021_axi_dma.pdf
//_MM2S / _S2MM status reg: p18 https://www.xilinx.com/support/documentation/ip_documentation/axi_dma/v7_1/pg021_axi_dma.pdf

//Data
#define Number_Of_Bytes 36 //number of bytes for DMA to send/receive
#define McolSz 3 //size of column of square matrix
u32 status; //used for containing return value of functions
u32 userIn; //used for inputting data from UART.

//those transfer routines write predefind(inside) data and execute DMA transfer
static int DMA_execute_transfer_routine_19(void);
static int DMA_execute_transfer_routine_1(void);
static int DMA_execute_transfer_routine_1s(void);
static int DMA_execute_transfer_routine_11_33(void);

//those bundles combine separate commands and complete this set of operations: load data, calculate, unload, print
void static bundle_1();
void static bundle_2();
void static bundle_3();
void static bundle_4();

void static test(void); //used for nothing, except removing warnings about unused commands
void printManual(); //prints HowTo



int main() {

	xil_printf("\n\n\n\n\n>>>>>>>>>> ENTERING MAIN <<<<<<<<<<<\r\n");

	Xil_DCacheDisable();
	status = DMA_soft_reset();
	status = DMA_check_normal_mode();
	status = DMA_check_irq_enabled();
	status = DMA_init();

	xil_printf(
			"\n\nPlease Enter New Command Number (enter '0' for info) : \r\n");
	while (1) {
		userIn = UART_inputNumber();
		xil_printf("Command Received : %d \r\n", userIn);
		switch (userIn) {
		case 0:
			printManual();
			pbreak;
		case 2:
			write_cmd(cmd_LOAD_G, cmd_NULL, 0);
			pbreak;
		case 3:
			write_cmd(cmd_LOAD_P, cmd_NULL, 0);
			pbreak;
		case 4:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_LOWER, 0);
			pbreak;
		case 41:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_HIGHER, 0);
			pbreak;
		case 42:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PGt_LOWER, 0);
			pbreak;
		case 43:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PGt_HIGHER, 0);
			pbreak;
		case 44:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PtG_LOWER, 0);
			pbreak;
		case 45:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PtG_HIGHER, 0);
			pbreak;
		case 46:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PtGt_LOWER, 0);
			pbreak;
		case 47:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PtGt_HIGHER, 0);
			pbreak;
		case 5:
			write_cmd(cmd_P_to_G, cmd_P_LOWER_to_G, 0);
			pbreak;
		case 51:
			write_cmd(cmd_P_to_G, cmd_P_HIGHER_to_G, 0);
			pbreak;
		case 6:
			write_cmd(cmd_UNLOAD_G, cmd_NULL, 0);
			pbreak;
		case 7:
			printTX(McolSz);
			pbreak;
		case 8:
			printRX(McolSz);
			pbreak;
		case 11:
			write_cmd(cmd_RESET_MMULT_IP, cmd_NULL, 0);
			pbreak;
		case 12:
			write_cmd(cmd_RESET_MMULT_CNTRL, cmd_NULL, 0);
			pbreak;
		case 13:
			write_cmd(cmd_NULL, cmd_NULL, 0);
			pbreak;


		case 21:
			status = DMA_execute_transfer_routine_1();
			pbreak;
		case 22:
			status = DMA_execute_transfer_routine_1s();
			pbreak;
		case 23:
			status = DMA_execute_transfer_routine_19();
			pbreak;
		case 24:
			status = DMA_execute_transfer_routine_11_33();
			pbreak;

		case 33:
			bundle_1();
			pbreak;
		case 34:
			bundle_2();
			pbreak;
		case 35:
			bundle_3();
			pbreak;
		case 36:
			bundle_4();
			pbreak;
		default:
			xil_printf("Unknown Command\r\n");
		}
	}
	test();
	return 0;
}

void test() {
	clr(XPAR_AXI_DMA_0_BASEADDR, c_MM2S, 0);
	rd_print(XPAR_AXI_DMA_0_BASEADDR, 0x00, 12);
	xil_printf("%d", status);
	status = DMA_check_irq_event();
	status = DMA_enable_irq();
	xil_printf("Value read from: ");
	read_print(XPAR_ETSE_GDSP_0_BASEADDR, 1 * 4);
}

void printManual() {
	xil_printf("\n\nPlease Enter New Command Number : \r\n");
	xil_printf(":0) Print this list of Commands\r\n");
	xil_printf(":2) load G matrix from memory via stream interface\r\n");
	xil_printf(":3) load P matrix from memory via stream interface\r\n");
	xil_printf(":7) print Tx Buffer\r\n");
	xil_printf(":8) print Rx buffer\r\n");
	xil_printf("\r\n");
  xil_printf(":4)  perform calculation of P-lower  and G and store in P-s other bank\r\n");
	xil_printf(":41) perform calculation of P-higher and G and store in P-s other bank\r\n");
  xil_printf(":42) perform calculation of P-lower  and Gt and store in P-s other bank\r\n");
	xil_printf(":43) perform calculation of P-higher and Gt and store in P-s other bank\r\n");
  xil_printf(":44) perform calculation of Pt-lower  and G and store in P-s other bank\r\n");
	xil_printf(":45) perform calculation of Pt-higher and G and store in P-s other bank\r\n");
  xil_printf(":46) perform calculation of Pt-lower  and Gt and store in P-s other bank\r\n");
	xil_printf(":47) perform calculation of Pt-higher and Gt and store in P-s other bank\r\n");
	xil_printf("\r\n");
	xil_printf(":5)  transfer data from P-lower to G \r\n");
	xil_printf(":51) transfer data from P-higher to G\r\n");
	xil_printf(":6)  transfer data from G to DDR3 via DMA \r\n");
	xil_printf("\r\n");
	xil_printf(":11) reset multiplier IP only\r\n");
	xil_printf(":12) reset multiplier IP and it's controller\r\n");
	xil_printf(":13) send multiplier IP's controller in idle state \r\n");
	xil_printf("\r\n");
	xil_printf(":21) execute DMA transfer routine 1: identity matrix - 1s on diagonal \r\n");
	xil_printf(":22) execute DMA transfer routine 1s: all values are 1 \r\n");
	xil_printf(":23) execute DMA transfer routine 1-9: values from 1 to 9 \r\n");
	xil_printf(":24) execute DMA transfer routine 11-33: 11,12,13; 21,22.. \r\n");
	xil_printf("\r\n");
	xil_printf(":33) perform bundle 2: commands: 24, 3, 24, 2, 41, 5,  6, 8\r\n");
	xil_printf(":34) perform bundle 2: commands: 23, 3, 23, 2, 41, 5,  6, 8\r\n");
	xil_printf(":35) perform bundle 2: commands: 24, 3, 21, 2, 41, 5,  6, 8\r\n");
	xil_printf(":36) perform bundle 2: commands: 23, 3, 21, 2, 41, 5,  6, 8\r\n");
}

void static bundle_1() {

	status = DMA_check_idle_MM2S(); //according to manual, until first transaction it shows busy, even though its not.

	// P matrix
	status = DMA_execute_transfer_routine_11_33();
	write_cmd(cmd_LOAD_P, cmd_NULL, 0);
	printTX(McolSz);

	// G matrix
	status = DMA_execute_transfer_routine_11_33();
	write_cmd(cmd_LOAD_G, cmd_NULL, 0);
	printTX(McolSz);

	// calc
	write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_LOWER, 0);

	// P to G
	write_cmd(cmd_P_to_G, cmd_P_HIGHER_to_G, 0);

	// G to DDR3
	write_cmd(cmd_UNLOAD_G, cmd_NULL, 0);


	// print DDR3
	printRX(McolSz);
}

void static bundle_2() {
	status = DMA_check_idle_MM2S(); //according to manual, until first transaction it shows busy, even though its not.

	// P matrix
	status = DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_P, cmd_NULL, 0);
	printTX(McolSz);

	// G matrix
	status = DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_G, cmd_NULL, 0);
	printTX(McolSz);

	// calc
	write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_LOWER, 0);

	// P to G
	write_cmd(cmd_P_to_G, cmd_P_HIGHER_to_G, 0);

	// G to DDR3
	write_cmd(cmd_UNLOAD_G, cmd_NULL, 0);


	// print DDR3
	printRX(McolSz);
}

void static bundle_3() {

	status = DMA_check_idle_MM2S(); //according to manual, until first transaction it shows busy, even though its not.

	// P matrix
	status = DMA_execute_transfer_routine_11_33();
	write_cmd(cmd_LOAD_P, cmd_NULL, 0);
	printTX(McolSz);

	// G matrix
	status = DMA_execute_transfer_routine_1();
	write_cmd(cmd_LOAD_G, cmd_NULL, 0);
	printTX(McolSz);

	// calc
	write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_LOWER, 0);

	// P to G
	write_cmd(cmd_P_to_G, cmd_P_HIGHER_to_G, 0);

	// G to DDR3
	write_cmd(cmd_UNLOAD_G, cmd_NULL, 0);


	// print DDR3
	printRX(McolSz);
}

void static bundle_4() {

	status = DMA_check_idle_MM2S(); //according to manual, until first transaction it shows busy, even though its not.

	// P matrix
	status = DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_P, cmd_NULL, 0);
	printTX(McolSz);

	// G matrix
	status = DMA_execute_transfer_routine_1s();
	write_cmd(cmd_LOAD_G, cmd_NULL, 0);
	printTX(McolSz);

	// calc
	write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_LOWER, 0);

	// P to G
	write_cmd(cmd_P_to_G, cmd_P_HIGHER_to_G, 0);

	// G to DDR3
	write_cmd(cmd_UNLOAD_G, cmd_NULL, 0);


	// print DDR3
	printRX(McolSz);
}

int static DMA_execute_transfer_routine_19(void) {
	TxBufferPtr[0] = 1;
	TxBufferPtr[1] = 2;
	TxBufferPtr[2] = 3;
	TxBufferPtr[3] = 4;
	TxBufferPtr[4] = 5;
	TxBufferPtr[5] = 6;
	TxBufferPtr[6] = 7;
	TxBufferPtr[7] = 8;
	TxBufferPtr[8] = 9;
	status = DMA_execute_transfer((u32) RxBufferPtr, (u32) TxBufferPtr, Number_Of_Bytes);
	return XST_SUCCESS;

}

int static DMA_execute_transfer_routine_1(void) {
	TxBufferPtr[0] = 1;
	TxBufferPtr[1] = 0;
	TxBufferPtr[2] = 0;
	TxBufferPtr[3] = 0;
	TxBufferPtr[4] = 1;
	TxBufferPtr[5] = 0;
	TxBufferPtr[6] = 0;
	TxBufferPtr[7] = 0;
	TxBufferPtr[8] = 1;
	status = DMA_execute_transfer((u32) RxBufferPtr, (u32) TxBufferPtr, Number_Of_Bytes);
	return XST_SUCCESS;
}

int static DMA_execute_transfer_routine_11_33(void) {
	TxBufferPtr[0] = 11;
	TxBufferPtr[1] = 12;
	TxBufferPtr[2] = 13;
	TxBufferPtr[3] = 21;
	TxBufferPtr[4] = 22;
	TxBufferPtr[5] = 23;
	TxBufferPtr[6] = 31;
	TxBufferPtr[7] = 32;
	TxBufferPtr[8] = 33;
	status = DMA_execute_transfer((u32) RxBufferPtr, (u32) TxBufferPtr, Number_Of_Bytes);
	return XST_SUCCESS;
}

int static DMA_execute_transfer_routine_1s(void) {
	TxBufferPtr[0] = 1;
	TxBufferPtr[1] = 1;
	TxBufferPtr[2] = 1;
	TxBufferPtr[3] = 1;
	TxBufferPtr[4] = 1;
	TxBufferPtr[5] = 1;
	TxBufferPtr[6] = 1;
	TxBufferPtr[7] = 1;
	TxBufferPtr[8] = 1;
	status = DMA_execute_transfer((u32) RxBufferPtr, (u32) TxBufferPtr, Number_Of_Bytes);
	return XST_SUCCESS;
}
