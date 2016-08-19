/*
 * MMULT_AXI_2_GramUnload.h
 *
 *  Created on: 19 Aug 2016
 *      Author: tsotne
 */

#ifndef MMULT_AXI_2_GRAMUNLOAD_H_
#define MMULT_AXI_2_GRAMUNLOAD_H_

#include "xparameters.h"
#include "xbasic_types.h"
#include "xil_io.h"
#include "sleep.h"
#include "MMULT_AXI_2.h"
#include "string.h"

char ans[34];
void getBinary(int n){
    int shiftSZ, shifted;
	for (shiftSZ = 31; shiftSZ>= 0; shiftSZ--){
		shifted = n >> shiftSZ;
	    if (shifted & 1)
	    	ans[31-shiftSZ]=(char)'1';
	    else
	    	ans[31-shiftSZ]=(char)'0';
	}
}

void printbin()
{
	int i;
    for(i = 0; i < 32; i++)
    {
        xil_printf("%c",ans[i]);
    }
    xil_printf("\r\n");
}

void AXI_2_write(u32 cmd, u32 cmd2, u32 data){
	u32 unified = (cmd2<<22 | cmd<<18 | data);
	getBinary(unified);
	xil_printf("written on slv_reg0, bin value = "); printbin();
	MMULT_AXI_2_mWriteReg(XPAR_MMULT_AXI_2_0_S00_AXI_BASEADDR, MMULT_AXI_2_S00_AXI_SLV_REG0_OFFSET, unified);
}

void AXI_2_read_print(u32 addr){
	u32 val = MMULT_AXI_2_mReadReg(XPAR_MMULT_AXI_2_0_S00_AXI_BASEADDR, addr*4);
	xil_printf("from slv_reg%d, value = %d\n\r",addr,val);
}



#endif /* MMULT_AXI_2_GRAMUNLOAD_H_ */
