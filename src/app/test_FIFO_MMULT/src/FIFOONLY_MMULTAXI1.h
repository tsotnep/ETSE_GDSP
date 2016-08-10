/*
 * FIFOONLY_MMULTAXI1.h
 *
 *  Created on: 10 Aug 2016
 *      Author: tsotne
 */

#ifndef FIFOONLY_MMULTAXI1_H_
#define FIFOONLY_MMULTAXI1_H_
#include "xparameters.h"
#include "xbasic_types.h"
#include "xil_io.h"
#include "sleep.h"
#include "MMULT_AXI_1.h"
#include "testing_FIFO.h"


void ResetCntrl(){

	//load-unload command
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG20_OFFSET, 0);

	//cntlr_save_G_values_in
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG29_OFFSET, 0);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG30_OFFSET, 0);

	//matrix data input regs
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG0_OFFSET, 0);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG1_OFFSET, 0);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG2_OFFSET, 0);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG3_OFFSET, 0);



	//cntrl_rst_in
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG17_OFFSET, 1);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG17_OFFSET, 0);

}

void LoadVals(int a0, int a1, int a2, int a3, int a4, int a5, int a6, int a7){
	//prepare values on proper regs
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG0_OFFSET, a0);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG1_OFFSET, a1);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG2_OFFSET, a2);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG3_OFFSET, a3);

	//cntlr_save_G_values_in
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG29_OFFSET, 1);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG29_OFFSET, 0);
	xil_printf("G matrix loaded\n\r");


	//prepare values on proper regs
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG0_OFFSET, a4);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG1_OFFSET, a5);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG2_OFFSET, a6);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG3_OFFSET, a7);

	//cntlr_save_P_values_in
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG30_OFFSET, 1);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG30_OFFSET, 0);

	//continue to next state
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG31_OFFSET, 1);
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG31_OFFSET, 0);
	xil_printf("P matrix loaded\n\n\r");
}

void UnloadVals(){

	//load-unload command
	MMULT_AXI_1_mWriteReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG20_OFFSET, 3);
	sleep(1);

	u32 r0 = MMULT_AXI_1_mReadReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG4_OFFSET);
	u32 r1 = MMULT_AXI_1_mReadReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG5_OFFSET);
	u32 r2 = MMULT_AXI_1_mReadReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG6_OFFSET);
	u32 r3 = MMULT_AXI_1_mReadReg(XPAR_MMULT_AXI_1_0_S00_AXI_BASEADDR, MMULT_AXI_1_S00_AXI_SLV_REG7_OFFSET);

	xil_printf("Unload start:\n\r");
	xil_printf(" %d \n\r", r0);
	xil_printf(" %d \n\r", r1);
	xil_printf(" %d \n\r", r2);
	xil_printf(" %d \n\r", r3);
	xil_printf("Unload Content end:\n\n\r");
}

/////////////////////////////////////////test FIFO
void ReadTestFIFOVals(){
	u32 r0 = TESTING_FIFO_mReadReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG0_OFFSET);
	u32 r1 = TESTING_FIFO_mReadReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG1_OFFSET);
	u32 r2 = TESTING_FIFO_mReadReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG2_OFFSET);
	u32 r3 = TESTING_FIFO_mReadReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG3_OFFSET);
	u32 r4 = TESTING_FIFO_mReadReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG4_OFFSET);
	u32 r5 = TESTING_FIFO_mReadReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG5_OFFSET);
	u32 r6 = TESTING_FIFO_mReadReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG6_OFFSET);
	u32 r7 = TESTING_FIFO_mReadReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG7_OFFSET);
	u32 r8 = TESTING_FIFO_mReadReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG8_OFFSET);

	xil_printf("TestFIFO Reading start:\n\r");
	xil_printf(" %d \n\r", r0);
	xil_printf(" %d \n\r", r1);
	xil_printf(" %d \n\r", r2);
	xil_printf(" %d \n\r", r3);
	xil_printf(" %d \n\r", r4);
	xil_printf(" %d \n\r", r5);
	xil_printf(" %d \n\r", r6);
	xil_printf(" %d \n\r", r7);
	xil_printf(" %d \n\r", r8);
	xil_printf("TestFIFO Reading end:\n\n\r");
}

void WriteTestFIFOVals(u32 x){
	TESTING_FIFO_mWriteReg(XPAR_TESTING_FIFO_0_S00_AXI_BASEADDR, TESTING_FIFO_S00_AXI_SLV_REG0_OFFSET, x);
	xil_printf("TestFIFO value %d written:\n\n\r", x);
}


void test_testingFIFO(){
	ReadTestFIFOVals();
	WriteTestFIFOVals(1);


	ReadTestFIFOVals();
	WriteTestFIFOVals(2);


	ReadTestFIFOVals();
	WriteTestFIFOVals(3);

	ReadTestFIFOVals();
	WriteTestFIFOVals(4);


	ReadTestFIFOVals();
	WriteTestFIFOVals(5);


	ReadTestFIFOVals();
	WriteTestFIFOVals(6);
}

void test_MMULT_AXI_1(){

	//test data 1
		//reset MMULTs
		ResetCntrl();
		//load data
		LoadVals(1,2,3,4, 1,2,3,4);
		//wait a while, later i will add irq
		sleep(2);
		//unload
		UnloadVals();

	//wait
		sleep(2);

	//test data 2
		//reset MMULTs
		ResetCntrl();
		//load data
		LoadVals(1,2,3,4, 5,6,7,8);
		//wait a while, later i will add irq
		sleep(2);
		//unload
		UnloadVals();

}



#endif /* FIFOONLY_MMULTAXI1_H_ */
