/*
 * MMULTAXI2.h
 *
 *  Created on: 10 Aug 2016
 *      Author: tsotne
 */

#ifndef MMULTAXI2_H_
#define MMULTAXI2_H_

#include "xparameters.h"
#include "xbasic_types.h"
#include "xil_io.h"
#include "sleep.h"
#include "MMULT_AXI_2.h"


#define cmd_RESET_CNTRL 31
#define cmd_SAVE_G 1
#define cmd_SAVE_P 2
#define cmd_LOAD_IN_MMULT 3
#define cmd_take_next_command 4
#define cmd_UNLOAD 5
#define cmd_CALCULTE_PG 6
#define cmd_NULL 7

#define DOUT_slv_reg1_addr 1

/*
 * command construction (total 32 bits)
 * 6bits   4bits     4bits     18bits
 * 31:26   25:22     21:18     17:0
 * 000000  0000      0000      00 00000000 00000000
 *         |cmd2|    |cmd|     |data              |
 *         (nextcmd) (currcmd)
 */


/*
 * 1. reset
 * 2. write G
 * 3. write P
 * 4. write next command
 * 5. write current command
 * 6. read data
 *
	constant cmd_RESET_CNTRL       : std_logic_vector := "1111"; 31
    constant cmd_SAVE_G            : std_logic_vector := "0001"; 1
    constant cmd_SAVE_P            : std_logic_vector := "0010"; 2
    constant cmd_LOAD_IN_MMULT     : std_logic_vector := "0011"; 3
    constant cmd_take_next_command : std_logic_vector := "0100"; 4
    constant cmd_UNLOAD            : std_logic_vector := "0101"; 5
    constant cmd_CALCULTE_PG       : std_logic_vector := "0110"; 6
    constant cmd_NULL              : std_logic_vector := "0111"; 7
 *
 */


void printInBinary(u32 n){
	xil_printf("Bin value of %d is : \n\r ", n);
	int shiftSZ, shifted;
	for (shiftSZ = 31; shiftSZ>= 0; shiftSZ--){
		shifted = n >> shiftSZ;
	    if (shifted & 1)
	    	xil_printf("1");
	    else
	    	xil_printf("0");
	}
	xil_printf("\n\r");
}

void AXI_2_write(u32 cmd2, u32 cmd, u32 data){
	u32 unified = (cmd2<<22 | cmd<<18 | data);
//	printInBinary(unified);
	MMULT_AXI_2_mWriteReg(XPAR_MMULT_AXI_2_0_S00_AXI_BASEADDR, MMULT_AXI_2_S00_AXI_SLV_REG0_OFFSET, unified);
}

void AXI_2_read_print(u32 addr){
	u32 val = MMULT_AXI_2_mReadReg(XPAR_MMULT_AXI_2_0_S00_AXI_BASEADDR, addr*4);
	xil_printf("from slv_reg%d, value = %d\n\r",addr,val);
}

void test_MMULT_AXI_2(){
	// available commands for AXI_2
	//	cmd_RESET_CNTRL
	//	cmd_SAVE_G
	//	cmd_SAVE_P
	//	cmd_LOAD_IN_MMULT
	//	cmd_take_next_command
	//	cmd_UNLOAD
	//	cmd_CALCULTE_PG
	//	cmd_NULL

		AXI_2_write(cmd_NULL, cmd_RESET_CNTRL, 0);

		xil_printf("start_writing G and P\n\r");
		AXI_2_write(cmd_NULL, cmd_SAVE_G, 1);
		AXI_2_write(cmd_NULL, cmd_SAVE_G, 2);
		AXI_2_write(cmd_NULL, cmd_SAVE_G, 3);
		AXI_2_write(cmd_NULL, cmd_SAVE_G, 4);
		AXI_2_write(cmd_NULL, cmd_SAVE_G, 5);
		AXI_2_write(cmd_NULL, cmd_SAVE_G, 6);
		AXI_2_write(cmd_NULL, cmd_SAVE_G, 7);
		AXI_2_write(cmd_NULL, cmd_SAVE_G, 8);
		AXI_2_write(cmd_NULL, cmd_SAVE_G, 9);


		AXI_2_write(cmd_NULL, cmd_SAVE_P, 11);
		AXI_2_write(cmd_NULL, cmd_SAVE_P, 12);
		AXI_2_write(cmd_NULL, cmd_SAVE_P, 13);
		AXI_2_write(cmd_NULL, cmd_SAVE_P, 14);
		AXI_2_write(cmd_NULL, cmd_SAVE_P, 15);
		AXI_2_write(cmd_NULL, cmd_SAVE_P, 16);
		AXI_2_write(cmd_NULL, cmd_SAVE_P, 17);
		AXI_2_write(cmd_NULL, cmd_SAVE_P, 18);
		AXI_2_write(cmd_NULL, cmd_SAVE_P, 19);

		AXI_2_write(cmd_UNLOAD, cmd_take_next_command, 0);
		AXI_2_write(cmd_NULL, cmd_LOAD_IN_MMULT, 0);
		sleep(1);

		xil_printf("start reading result\n\r");
		AXI_2_read_print(DOUT_slv_reg1_addr);
		AXI_2_read_print(DOUT_slv_reg1_addr);
		AXI_2_read_print(DOUT_slv_reg1_addr);
		AXI_2_read_print(DOUT_slv_reg1_addr);
		AXI_2_read_print(DOUT_slv_reg1_addr);
		AXI_2_read_print(DOUT_slv_reg1_addr);
		AXI_2_read_print(DOUT_slv_reg1_addr);
		AXI_2_read_print(DOUT_slv_reg1_addr);
		AXI_2_read_print(DOUT_slv_reg1_addr);
}

#endif /* MMULTAXI2_H_ */
