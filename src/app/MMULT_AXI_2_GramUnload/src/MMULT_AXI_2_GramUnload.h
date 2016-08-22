/*
 * MMULT_AXI_2_GramUnload.h
 *
 *  Created on: 19 Aug 2016
 *      Author: tsotne
 */

#ifndef MMULT_AXI_2_GRAMUNLOAD_H_
#define MMULT_AXI_2_GRAMUNLOAD_H_

#include "xparameters.h"
#include "xil_io.h"
#include "MMULT_AXI_2.h"

char ans[32]; //i can't return address of local variable. so i made it global

char* getBinary(u32 n){
    u32 i;
	for (i = 0; i<32; i++){
		n = n >> 1;
		ans[31-i]=(n&1)==1?'1':'0';
	}
	ans[32]='\0'; //n won't fill 32 bits anyway.
	return ans;
}

void AXI_2_write(u32 cmd, u32 cmd2, u32 data){
	u32 unified = (cmd2<<22 | cmd<<18 | data);
	MMULT_AXI_2_mWriteReg(XPAR_MMULT_AXI_2_0_S00_AXI_BASEADDR, MMULT_AXI_2_S00_AXI_SLV_REG0_OFFSET, unified);
	xil_printf("written on slv_reg0, bin value = %s \r\n", getBinary(unified));
}

void AXI_2_read_print(u32 addr){
	xil_printf("from slv_reg%d, value = %d\n\r",addr,MMULT_AXI_2_mReadReg(XPAR_MMULT_AXI_2_0_S00_AXI_BASEADDR, addr*4));
}



#endif /* MMULT_AXI_2_GRAMUNLOAD_H_ */
