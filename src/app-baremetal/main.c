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


//Data
#define Number_Of_Bytes		36 //number of bytes for DMA to send/receive
#define McolSz 3 //size of column of square matix

//functions
static int DMA_execute_transfer_routine_19(void);
static int DMA_execute_transfer_routine_1(void);
static int DMA_execute_transfer_routine_2(void);
static int DMA_execute_transfer_routine_3(void);
static int DMA_execute_transfer_routine_11_33(void);
static int DMA_execute_transfer_routine_4(void);

void static bundle_1();
void static bundle_2();
void static bundle_3();
void static bundle_4();
void static test(void);


u32 P=1, P_to_G_processed=0; //TODO
u32 status;
u32 userIn;

void save_g_or_p();
void printManual();
void unload_g();

int main() {

    xil_printf("\n\n\n\n\n>>>>>>>>>> ENTERING MAIN <<<<<<<<<<<\r\n");



	Xil_DCacheDisable();
	status = DMA_soft_reset();
	status = DMA_check_normal_mode();
	status = DMA_check_irq_disabled();
	status = DMA_check_idle();
	status = DMA_init();




	xil_printf("\n\nPlease Enter New Command Number (enter '0' for info) : \r\n");
	while (1) {
        // P_to_G_processed = 0;
		userIn = UART_inputNumber();
		xil_printf("Command Received : %d \r\n",userIn);
		switch (userIn) {
		case 0:
			printManual();
			pbreak;
		case 1:
			save_g_or_p();
			pbreak;
		case 2:
			write_cmd(cmd_LOAD_G, cmd_NULL, 0);
			pbreak;
		case 3:
			write_cmd(cmd_LOAD_P, cmd_NULL, 0);
			pbreak;

		case 4:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_LOWER, 0); //TODO: complete this
			pbreak;
		case 41:
			write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_HIGHER, 0); //TODO: complete this
			pbreak;

		case 5:
			write_cmd(cmd_P_to_G, cmd_P_LOWER_to_G, 0);

            pbreak;
		case 51:
			write_cmd(cmd_P_to_G, cmd_P_HIGHER_to_G, 0);

			pbreak;

		case 6:
			unload_g();
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
		case 29:
			status=DMA_execute_transfer_routine_19();
			pbreak;
		case 21:
			status=DMA_execute_transfer_routine_1();
			pbreak;
		case 22:
			status=DMA_execute_transfer_routine_2();
			pbreak;
		case 23:
			status=DMA_execute_transfer_routine_3();
			pbreak;
		case 25:
			status=DMA_execute_transfer_routine_11_33();
			pbreak;
		case 26:
			status=DMA_execute_transfer_routine_4();
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

void test (){
	clr(XPAR_AXI_DMA_0_BASEADDR, c_MM2S, 0);
	rd_print(XPAR_AXI_DMA_0_BASEADDR, 0x00, 12);
	xil_printf("%d", status);
	status = DMA_check_irq_event();
	status = DMA_enable_irq();
	xil_printf("Value read from: ");read_print(XPAR_ETSE_GDSP_0_BASEADDR, 1*4);
}

void printManual() {
	xil_printf("\n\nPlease Enter New Command Number : \r\n");
	xil_printf(":0) Print this list of Commands\r\n");
	xil_printf(":1) enter both matrices from UART\r\n");
	xil_printf(":2) load G matrix from memory via stream interface\r\n");
	xil_printf(":3) load P matrix from memory via stream interface\r\n");
	xil_printf(":7) print Tx Buffer\r\n");
	xil_printf(":8) print Rx buffer \r\n");
	xil_printf("\r\n");
	xil_printf(":4)  perform calculation of P-higher and G and store in P-s second bank\r\n");
	xil_printf(":41) perform calculation of P-lower and G and store in P-s second bank\r\n");
	xil_printf("\r\n");
	xil_printf(":5)  transfer data from P-lower to G\r\n");
	xil_printf(":51) transfer data from P-higher to G\r\n");
	xil_printf(":6)  transfer data from G to DDR3 via DMA \r\n");
	xil_printf("\r\n");
	xil_printf(":11) reset multiplier IP only\r\n");
	xil_printf(":12) reset multiplier IP and it's controller\r\n");
	xil_printf(":13) send multiplier IP's controller in idle state \r\n");
	xil_printf("\r\n");
	xil_printf(":21) execute DMA transfer routine 1 \r\n");
	xil_printf(":22) execute DMA transfer routine 2 \r\n");
	xil_printf(":23) execute DMA transfer routine 3 \r\n");
	xil_printf(":25) execute DMA transfer routine 11-33 \r\n");
	xil_printf(":26) execute DMA transfer routine 4 small numbers \r\n");
  xil_printf(":29) execute DMA transfer routine 1-9\r\n");
  xil_printf("\r\n");
  xil_printf(":33) perform bundle 1: commands: 25, 3, 25, 2, 4,  5, 6 \r\n");
  xil_printf(":34) perform bundle 2: commands: 25, 3, 25, 2, 41, 5, 6 \r\n");
  xil_printf(":35) perform bundle 1: commands: 25, 3, 25, 2, 4,  51, 6 \r\n");
  xil_printf(":36) perform bundle 2: commands: 25, 3, 25, 2, 41, 51, 6 \r\n");
}


void static bundle_1(){

// P matrix
	status=DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_P, cmd_NULL, 0);

// G matrix
	status=DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_G, cmd_NULL, 0);

// calc
	write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_LOWER, 0);

// P to G
	write_cmd(cmd_P_to_G, cmd_P_LOWER_to_G, 0);

// G to DDR3
	unload_g();

// print DDR3
	printRX(McolSz);
}


void static bundle_2(){

// P matrix
	status=DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_P, cmd_NULL, 0);

// G matrix
	status=DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_G, cmd_NULL, 0);

// calc
	write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_LOWER, 0);

// P to G
	write_cmd(cmd_P_to_G, cmd_P_HIGHER_to_G, 0);

// G to DDR3
	unload_g();

// print DDR3
	printRX(McolSz);
}


void static bundle_3(){

// P matrix
	status=DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_P, cmd_NULL, 0);

// G matrix
	status=DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_G, cmd_NULL, 0);

// calc
	write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_HIGHER, 0);

// P to G
	write_cmd(cmd_P_to_G, cmd_P_LOWER_to_G, 0);

// G to DDR3
	unload_g();

// print DDR3
	printRX(McolSz);
}


void static bundle_4(){

// P matrix
	status=DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_P, cmd_NULL, 0);

// G matrix
	status=DMA_execute_transfer_routine_19();
	write_cmd(cmd_LOAD_G, cmd_NULL, 0);

// calc
	write_cmd(cmd_CALCULTE, cmd_CALCULATE_PG_HIGHER, 0);

// P to G
	write_cmd(cmd_P_to_G, cmd_P_HIGHER_to_G, 0);

// G to DDR3
	unload_g();

// print DDR3
	printRX(McolSz);
}


void save_g_or_p() {
	write_cmd(cmd_SAVE_G_or_P, cmd_NULL, 0);

	xil_printf("input G matrix, %d elements, separated with space\r\n",
			McolSz * McolSz);
	u32 i;
	for (i = 0; i < McolSz * McolSz; i++) {
		write_cmd(cmd_SAVE_G, cmd_NULL, UART_inputNumber());
	}

	xil_printf("input P matrix, %d elements, separated with space\r\n",
			McolSz * McolSz);
	for (i = 0; i < McolSz * McolSz; i++) {
		write_cmd(cmd_SAVE_P, cmd_NULL, UART_inputNumber());
	}
	write_cmd(cmd_FINISH_SAVING_G_P, cmd_NULL, 0);
}

void unload_g() {
	write_cmd(cmd_UNLOAD_G, cmd_NULL, 0);
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
    status = DMA_execute_transfer((u32)RxBufferPtr, (u32)TxBufferPtr, Number_Of_Bytes);
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
    status = DMA_execute_transfer((u32)RxBufferPtr, (u32)TxBufferPtr, Number_Of_Bytes);
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
    status = DMA_execute_transfer((u32)RxBufferPtr, (u32)TxBufferPtr, Number_Of_Bytes);
    return XST_SUCCESS;
}

int static DMA_execute_transfer_routine_2(void) {
	TxBufferPtr[0] = 2;
	TxBufferPtr[1] = 2;
	TxBufferPtr[2] = 2;
	TxBufferPtr[3] = 2;
	TxBufferPtr[4] = 2;
	TxBufferPtr[5] = 2;
	TxBufferPtr[6] = 2;
	TxBufferPtr[7] = 2;
	TxBufferPtr[8] = 2;
    status = DMA_execute_transfer((u32)RxBufferPtr, (u32)TxBufferPtr, Number_Of_Bytes);
    return XST_SUCCESS;
}

int static DMA_execute_transfer_routine_3(void) {
	TxBufferPtr[0] = 3;
	TxBufferPtr[1] = 3;
	TxBufferPtr[2] = 3;
	TxBufferPtr[3] = 3;
	TxBufferPtr[4] = 3;
	TxBufferPtr[5] = 3;
	TxBufferPtr[6] = 3;
	TxBufferPtr[7] = 3;
	TxBufferPtr[8] = 3;
    status = DMA_execute_transfer((u32)RxBufferPtr, (u32)TxBufferPtr, Number_Of_Bytes);
    return XST_SUCCESS;
}

int static DMA_execute_transfer_routine_4(void) {
	TxBufferPtr[0] = 1;
	TxBufferPtr[1] = 1;
	TxBufferPtr[2] = 1;
	TxBufferPtr[3] = 2;
	TxBufferPtr[4] = 2;
	TxBufferPtr[5] = 2;
	TxBufferPtr[6] = 3;
	TxBufferPtr[7] = 3;
	TxBufferPtr[8] = 3;
    status = DMA_execute_transfer((u32)RxBufferPtr, (u32)TxBufferPtr, Number_Of_Bytes);
    return XST_SUCCESS;
}


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
