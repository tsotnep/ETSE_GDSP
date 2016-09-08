//#include <stdio.h>
//#include "platform.h"
//#include "xparameters.h"
//#include "xaxidma.h"
//#include "xil_types.h"
//#include "mylib.h"
//#include "sleep.h"
//#include "myip_stream_control.h"
//#include "myip_simple_lite.h"
//#include "myip_simple_lite_S00.h"
//#include "myip_lite_slave_stream.h"
//#include "myip_lite_slave_master_stream.h"
//
////DDR address map: http://dl.dropbox.com/u/65113214/16-09-07_13%3A33%3A13_Selection.png
////DMA register offsets: http://dl.dropbox.com/u/65113214/16-09-01_19%3A12%3A31_Selection.png
////MM2S / S2MM control reg: http://dl.dropbox.com/u/65113214/16-09-01_19%3A15%3A25_Selection.png
////MM2S / S2MM status reg: http://dl.dropbox.com/u/65113214/16-09-01_19%3A16%3A26_Selection.png
//
////MM 2 S Register offsets
//#define cMM2S 0x00 //control reg
//#define sMM2S 0x04 //status reg
//#define saMM2S 0x18 //source address
//#define tlMM2S 0x28 //transfer length
//
////S to MM Register offsets
//#define cS2MM 0x30 //control reg
//#define sS2MM 0x34 //status reg
//#define daS2MM 0x48 //destination address
//#define blS2MM 0x58 //buffer length
//
////Data
//#define Number_Of_Bytes		0x24 //36 dec
//#define TX_BUFFER_BASE		XPAR_PS7_DDR_0_S_AXI_BASEADDR
//u32 *TxBufferPtr = (u32 *) TX_BUFFER_BASE;
//
////functions
//static void test(void);
//static void init_dma(void);
//static void reset_dma(void);
//void static execute_dma_transfer(void);
//void print_regs(void);
//
//int main() {
//	init_platform();
//	print("Start of Main\n\r");
//	reset_dma();
//
////	TxBufferPtr[0] = 3; //11
////	TxBufferPtr[1] = 6; //110
////	TxBufferPtr[2] = 12;//1100
////	TxBufferPtr[3] = 24;//11000
//
//	TxBufferPtr[0] = 1; //11
//	TxBufferPtr[1] = 2; //110
//	TxBufferPtr[2] = 4;//1100
//	TxBufferPtr[3] = 8;//11000
//
//	if(check_DMA_normal_mode() != XST_SUCCESS){
//		return XST_FAILURE;
//	}
//
//	test();
//
//	init_dma();
//
//	execute_dma_transfer();
//
//	print_regs();
//
//	xil_printf("End main\n\r\n\r\n\r\n\r ");
//	cleanup_platform();
//	return XST_SUCCESS;
//}
//
//void static init_dma(void) {
//	if (rd(XPAR_AXI_DMA_0_BASEADDR, sMM2S,3)) xil_printf("Scatter Gatherer is enabled, Disable and regenerate bitstream\n\r");
//
//	set(XPAR_AXI_DMA_0_BASEADDR, cMM2S, 0); //start MM2S channel
//	prrd(XPAR_AXI_DMA_0_BASEADDR, cMM2S, 0); //read if its written
//	prrd(XPAR_AXI_DMA_0_BASEADDR, sMM2S, 0); //read status if running
//}
//
//void static reset_dma(void) {
//	set(XPAR_AXI_DMA_0_BASEADDR, cMM2S, 2); //start MM2S channel
//	prrd(XPAR_AXI_DMA_0_BASEADDR, cMM2S, 0); //read if its written
//	sleep(1);
//	prrd(XPAR_AXI_DMA_0_BASEADDR, cMM2S, 0); //read if its written
//
////	clr(XPAR_AXI_DMA_0_BASEADDR, cMM2S, 2); //start MM2S channel
//}
//
//void static execute_dma_transfer(void) {
//	write(XPAR_AXI_DMA_0_BASEADDR, saMM2S, (u32) TxBufferPtr); //specify source address
//	write(XPAR_AXI_DMA_0_BASEADDR, tlMM2S, (u32) Number_Of_Bytes); //specify transfer length in bytes
//	prread(XPAR_AXI_DMA_0_BASEADDR, saMM2S); //read source address
//	prread(XPAR_AXI_DMA_0_BASEADDR, tlMM2S); //read transfer length
//}
//
//void print_regs() {
//	xil_printf("SMS reg0 %s \n\r",
//			getBinary(
//					MYIP_LITE_SLAVE_MASTER_STREAM_mReadReg(
//							XPAR_MYIP_LITE_SLAVE_MASTER_STREAM_0_S00_AXI_BASEADDR,
//							MYIP_LITE_SLAVE_MASTER_STREAM_S00_AXI_SLV_REG0_OFFSET)));
//
//	xil_printf("SMS reg1 %s \n\r",
//			getBinary(
//					MYIP_LITE_SLAVE_MASTER_STREAM_mReadReg(
//							XPAR_MYIP_LITE_SLAVE_MASTER_STREAM_0_S00_AXI_BASEADDR,
//							MYIP_LITE_SLAVE_MASTER_STREAM_S00_AXI_SLV_REG1_OFFSET)));
//
//	xil_printf("SMS reg2 %s \n\r",
//			getBinary(
//					MYIP_LITE_SLAVE_MASTER_STREAM_mReadReg(
//							XPAR_MYIP_LITE_SLAVE_MASTER_STREAM_0_S00_AXI_BASEADDR,
//							MYIP_LITE_SLAVE_MASTER_STREAM_S00_AXI_SLV_REG2_OFFSET)));
//
//	xil_printf("SMS reg0 %x \n\r",
//			(
//					MYIP_LITE_SLAVE_MASTER_STREAM_mReadReg(
//							XPAR_MYIP_LITE_SLAVE_MASTER_STREAM_0_S00_AXI_BASEADDR,
//							MYIP_LITE_SLAVE_MASTER_STREAM_S00_AXI_SLV_REG0_OFFSET)));
//
//	xil_printf("SMS reg1 %x \n\r",
//			(
//					MYIP_LITE_SLAVE_MASTER_STREAM_mReadReg(
//							XPAR_MYIP_LITE_SLAVE_MASTER_STREAM_0_S00_AXI_BASEADDR,
//							MYIP_LITE_SLAVE_MASTER_STREAM_S00_AXI_SLV_REG1_OFFSET)));
//
//	xil_printf("SMS reg2 %x \n\r",
//			(
//					MYIP_LITE_SLAVE_MASTER_STREAM_mReadReg(
//							XPAR_MYIP_LITE_SLAVE_MASTER_STREAM_0_S00_AXI_BASEADDR,
//							MYIP_LITE_SLAVE_MASTER_STREAM_S00_AXI_SLV_REG2_OFFSET)));
//	/* output:
//	 * binaries...
//	 * EA00000F
//	 * 00000017
//	 * 0000000B
//	 */
//}
//
//static void test() {
////	u32 a = 7;
////	u32 b = 1 << 2;
////	u32 tmp = a & ~b;
////	xil_printf("val: %d \n\r", tmp);
//	/*output:
//	 * 3
//	 */
//	///////////////////////////////////
//	///////////////////////////////////
////
////	xil_printf("TxBufferPtr = %x \n\r", (TxBufferPtr));
////	xil_printf("&TxBufferPtr = %x \n\r", (&TxBufferPtr));
////
////	xil_printf("TxBufferPtr[0] = %x \n\r", (TxBufferPtr[0]));
////	xil_printf("TxBufferPtr[1] = %x \n\r", (TxBufferPtr[1]));
////
////	xil_printf("&TxBufferPtr[0] = %x \n\r", (&TxBufferPtr[0]));
////	xil_printf("&TxBufferPtr[1] = %x \n\r", (&TxBufferPtr[1]));
////
////	xil_printf("*TxBufferPtr = %x \n\r", (*TxBufferPtr));
//	/* output:
//	 *
//	 * 10100000
//	 * 1028DC
//	 *
//	 * 3
//	 * 6
//	 *
//	 * 10100000
//	 * 10100004
//	 *
//	 * 3
//	 */
//
//	///////////////////////////////////
//	///////////////////////////////////
//
////	write(XPAR_AXI_DMA_0_BASEADDR, saMM2S, (u32) TxBufferPtr + 1);
////	prread(XPAR_AXI_DMA_0_BASEADDR, saMM2S);
////	prrd(XPAR_AXI_DMA_0_BASEADDR, saMM2S, 0);
////	clr(XPAR_AXI_DMA_0_BASEADDR, saMM2S, 0);
////	prrd(XPAR_AXI_DMA_0_BASEADDR, saMM2S, 0);
//	/*
//	 * output:
//	 * 269484033 (=00010000 00010000 00000000 00000001)
//	 * 0
//	 * 1
//	 */
//}
