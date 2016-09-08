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
//#define Number_Of_Bytes		16
#define Number_Of_Bytes		0x0000FFFF

#define TX_BUFFER_BASE		(XPAR_PS7_DDR_0_S_AXI_BASEADDR)
u32 *TxBufferPtr = (u32 *) TX_BUFFER_BASE;

#define RX_BUFFER_BASE		(XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x00010000)
u32 *RxBufferPtr = (u32 *) RX_BUFFER_BASE;

//functions
static int init_dma(void);
static int execute_dma_transfer(void);
void static test();

int main() {
	init_platform();
	print("Start of Main\n\r");
	enable_DMA_soft_reset();

	TxBufferPtr[0] = 1;
	TxBufferPtr[1] = 2;
	TxBufferPtr[2] = 4;
	TxBufferPtr[3] = 8;

	RxBufferPtr[0] = 0;
	RxBufferPtr[1] = 0;
	RxBufferPtr[2] = 0;
	RxBufferPtr[3] = 0;

//	if (check_DMA_normal_mode() != XST_SUCCESS) {
//		return XST_FAILURE;
//	}

	u32 status;
	status = check_DMA_normal_mode();
	status = check_DMA_irq_disabled();
	status = enable_DMA_irq();
	status = check_DMA_irq_disabled();

	status = init_dma();
	status = check_DMA_irq_event();
	status = execute_dma_transfer();
	while (check_DMA_idle() != XST_SUCCESS) {
	}
	status = check_DMA_irq_event();

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
//	test();
	xil_printf("End main\n\r\n\r\n\r\n\r ");

	cleanup_platform();
	return XST_SUCCESS;
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
	//solution 1:
	//		Xil_DCacheDisable();

	//solution 2:
	Xil_DCacheFlushRange((u32) TxBufferPtr, Number_Of_Bytes);
	Xil_DCacheInvalidateRange((u32) RxBufferPtr, Number_Of_Bytes);

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
