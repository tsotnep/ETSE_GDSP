/*****************************************************************************
* Filename:          C:\FPGA\AXI4\Virtex6_ML605_MUL_IP_CORE/drivers/matrix_mul_ip_core_s_int_g_v1_00_a/src/matrix_mul_ip_core_s_int_g.c
* Version:           1.00.a
* Description:       matrix_mul_ip_core_s_int_g Driver Source File
* Date:              Wed Aug 05 15:25:43 2015 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "matrix_mul_ip_core_s_int_g.h"

/************************** Function Definitions ***************************/


/**
 *
 * User logic master module to send/receive word to/from remote system memory.
 * While sending, one word is read from user logic local FIFO and written to remote system memory.
 * While receiving, one word is read from remote system memory and written to user logic local FIFO.
 *
 * @param   BaseAddress is the base address of the matrix_mul_ip_core_s_int_g device.
 * @param   Src/DstAddress is the destination system memory address from/to which the data will be fetched/stored.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void matrix_mul_ip_core_s_int_g_MasterSendWord(Xuint32 BaseAddress, Xuint32 DstAddress)
{
  /*
   * Set user logic master control register for write transfer.
   */
  Xil_Out8(BaseAddress+matrix_mul_ip_core_s_int_g_MST_CNTL_REG_OFFSET, MST_SGWR);

  /*
   * Set user logic master address register to drive IP2Bus_Mst_Addr signal.
   */
  Xil_Out32(BaseAddress+matrix_mul_ip_core_s_int_g_MST_ADDR_REG_OFFSET, DstAddress);

  /*
   * Set user logic master byte enable register to drive IP2Bus_Mst_BE signal.
   */
  Xil_Out16(BaseAddress+matrix_mul_ip_core_s_int_g_MST_BE_REG_OFFSET, 0xFFFF);

  /*
   * Start user logic master write transfer by writting special pattern to its go port.
   */
  Xil_Out8(BaseAddress+matrix_mul_ip_core_s_int_g_MST_GO_PORT_OFFSET, MST_START);
}

void matrix_mul_ip_core_s_int_g_MasterRecvWord(Xuint32 BaseAddress, Xuint32 SrcAddress)
{
  /*
   * Set user logic master control register for read transfer.
   */
  Xil_Out8(BaseAddress+matrix_mul_ip_core_s_int_g_MST_CNTL_REG_OFFSET, MST_SGRD);

  /*
   * Set user logic master address register to drive IP2Bus_Mst_Addr signal.
   */
  Xil_Out32(BaseAddress+matrix_mul_ip_core_s_int_g_MST_ADDR_REG_OFFSET, SrcAddress);

  /*
   * Set user logic master byte enable register to drive IP2Bus_Mst_BE signal.
   */
  Xil_Out16(BaseAddress+matrix_mul_ip_core_s_int_g_MST_BE_REG_OFFSET, 0xFFFF);

  /*
   * Start user logic master read transfer by writting special pattern to its go port.
   */
  Xil_Out8(BaseAddress+matrix_mul_ip_core_s_int_g_MST_GO_PORT_OFFSET, MST_START);
}

