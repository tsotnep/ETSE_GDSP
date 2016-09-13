

int main() {

	/*

DMA Buff size
                = (2^23)
                = 8388608 bytes
                = 0x00800000 bytes
                = 2 097 152 32-bit-number
                = 8.388608 MB


DMA size
                = (0x1FFFFFFF - 0x00100000)
                = 535822335 bytes
                = 0x1FEFFFFF bytes
                = 133 955 583.75 32-bit-number
                = 535.822335 MB


	 */


	/*
     * output:
Start of Main
Resetting DMA
Normal DMA mode is enabled
DMA interrupts are disabled
DMA interrupts are enabled
reading DMA channels enable bits in control reg(1=enabled):
reg_40400000+0[0] = 1
reg_40400000+30[0] = 1
reading DMA channels enable bits in status reg(0=running):
reg_40400000+4[0] = 0
reg_40400000+34[0] = 0
DMA irq flag has not been asserted
reading transfer addresses
reg_40400000+18 = 00100000
reg_40400000+48 = 00900000
reading transfer lengths
reg_40400000+28 = 007FFFFF
reg_40400000+58 = 007FFFFF
DMA is busy
DMA is busy
DMA is busy
DMA is busy
DMA is busy
DMA is busy
DMA is idle
TxBufferPtr = 00100000
TxBufferPtr[0] = 1
TxBufferPtr[1] = 2
TxBufferPtr[2] = 4
TxBufferPtr[3] = 8
RxBufferPtr = 00900000
RxBufferPtr[0] = 1
RxBufferPtr[1] = 2
RxBufferPtr[2] = 4
RxBufferPtr[3] = 8
reading transfer addresses
reg_40400000+18 = 00100000
reg_40400000+48 = 00900000
reading transfer lengths
reg_40400000+28 = 007FFFFF
reg_40400000+58 = 007FFFFF
DMA is busy
DMA is busy
DMA is busy
DMA is busy
DMA is busy
DMA is busy
DMA is idle
TxBufferPtr = 00100000
TxBufferPtr[0] = F
TxBufferPtr[1] = 4
TxBufferPtr[2] = 5
TxBufferPtr[3] = 7
RxBufferPtr = 00900000
RxBufferPtr[0] = F
RxBufferPtr[1] = 4
RxBufferPtr[2] = 5
RxBufferPtr[3] = 7
End main

	 */

	init_platform();
	print("Start of Main\n\r");
	enable_DMA_soft_reset();

	TxBufferPtr[0] = 1;
	TxBufferPtr[1] = 2;
	TxBufferPtr[2] = 4;
	TxBufferPtr[3] = 8;

	RxBufferPtr[0] = 0;
	RxBufferPtr[2] = 0;
	RxBufferPtr[1] = 0;
	RxBufferPtr[3] = 0;

	u32 status;
	status = check_DMA_normal_mode();
	status = init_dma();
	Xil_DCacheDisable();

    status = execute_dma_transfer();
	while (check_DMA_idle() != XST_SUCCESS);
    print_arr();




	xil_printf("End main\n\r\n\r\n\r\n\r ");
	cleanup_platform();
	return XST_SUCCESS;
}
