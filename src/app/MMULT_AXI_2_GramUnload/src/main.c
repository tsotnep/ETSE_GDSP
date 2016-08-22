#include <stdio.h>
#include "platform.h"
#include "MMULT_AXI_2_GramUnload.h"
#include "sleep.h"
//screenshot of this implementation result on Zedboard:
// http://dl.dropbox.com/u/65113214/16-08-19_11%3A35%3A27_Selection.png

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
