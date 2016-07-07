/*****************************************************************************
* Filename:          C:\FPGA\Internship_Jobs\Codes\Virtex6_MUL_IP_CORE2/drivers/matrix_mul_ip_core_s_int_g_v1_00_a/src/matrix_mul_ip_core_s_int_g.h
* Version:           1.00.a
* Description:       matrix_mul_ip_core_s_int_g Driver Header File
* Date:              Thu Aug 13 21:51:30 2015 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef MATRIX_MUL_IP_CORE_S_INT_G_H
#define MATRIX_MUL_IP_CORE_S_INT_G_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 * -- SLV_REG2 : user logic slave module register 2
 * -- SLV_REG3 : user logic slave module register 3
 */
#define MATRIX_MUL_IP_CORE_S_INT_G_USER_SLV_SPACE_OFFSET (0x00000000)
#define MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG0_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_SLV_SPACE_OFFSET + 0x00000000)
#define MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG1_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_SLV_SPACE_OFFSET + 0x00000004)
#define MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG2_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_SLV_SPACE_OFFSET + 0x00000008)
#define MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG3_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_SLV_SPACE_OFFSET + 0x0000000C)

/**
 * User Logic Master Space Offsets
 * -- MST_CNTL_REG : user logic master module control register
 * -- MST_STAT_REG : user logic master module status register
 * -- MST_ADDR_REG : user logic master module address register
 * -- MST_BE_REG   : user logic master module byte enable register
 * -- MST_LEN_REG  : user logic master module length (data transfer in bytes) register
 * -- MST_GO_PORT  : user logic master module go bit (to start master operation)
 */
#define MATRIX_MUL_IP_CORE_S_INT_G_USER_MST_SPACE_OFFSET (0x00000100)
#define MATRIX_MUL_IP_CORE_S_INT_G_MST_CNTL_REG_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_MST_SPACE_OFFSET + 0x00000000)
#define MATRIX_MUL_IP_CORE_S_INT_G_MST_STAT_REG_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_MST_SPACE_OFFSET + 0x00000001)
#define MATRIX_MUL_IP_CORE_S_INT_G_MST_ADDR_REG_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_MST_SPACE_OFFSET + 0x00000004)
#define MATRIX_MUL_IP_CORE_S_INT_G_MST_BE_REG_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_MST_SPACE_OFFSET + 0x00000008)
#define MATRIX_MUL_IP_CORE_S_INT_G_MST_LEN_REG_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_MST_SPACE_OFFSET + 0x0000000C)
#define MATRIX_MUL_IP_CORE_S_INT_G_MST_GO_PORT_OFFSET (MATRIX_MUL_IP_CORE_S_INT_G_USER_MST_SPACE_OFFSET + 0x0000000F)

/**
 * User Logic Master Module Masks
 * -- MST_RD_MASK   : user logic master read request control
 * -- MST_WR_MASK   : user logic master write request control
 * -- MST_BL_MASK   : user logic master bus lock control
 * -- MST_BRST_MASK : user logic master burst assertion control
 * -- MST_DONE_MASK : user logic master transfer done status
 * -- MST_BSY_MASK  : user logic master busy status
 * -- MST_BRRD      : user logic master burst read request
 * -- MST_BRWR      : user logic master burst write request
 * -- MST_SGRD      : user logic master single read request
 * -- MST_SGWR      : user logic master single write request
 * -- MST_START     : user logic master to start transfer
 */
#define MST_RD_MASK (0x00000001UL)
#define MST_WR_MASK (0x00000002UL)
#define MST_BL_MASK (0x00000004UL)
#define MST_BRST_MASK (0x00000008UL)
#define MST_DONE_MASK (0x01)
#define MST_BSY_MASK (0x00000020UL)
#define MST_ERROR_MASK (0x00000040UL)
#define MST_TIMEOUT_MASK (0x00000080UL)
#define MST_BRRD (0x09)
#define MST_BRWR (0x0A)
#define MST_SGRD (0x01)
#define MST_SGWR (0x02)
#define MST_START (0x0A)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a MATRIX_MUL_IP_CORE_S_INT_G register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the MATRIX_MUL_IP_CORE_S_INT_G device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void MATRIX_MUL_IP_CORE_S_INT_G_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define MATRIX_MUL_IP_CORE_S_INT_G_mWriteReg(BaseAddress, RegOffset, Data) \
 	Xil_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a MATRIX_MUL_IP_CORE_S_INT_G register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the MATRIX_MUL_IP_CORE_S_INT_G device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 MATRIX_MUL_IP_CORE_S_INT_G_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define MATRIX_MUL_IP_CORE_S_INT_G_mReadReg(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from MATRIX_MUL_IP_CORE_S_INT_G user logic slave registers.
 *
 * @param   BaseAddress is the base address of the MATRIX_MUL_IP_CORE_S_INT_G device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void MATRIX_MUL_IP_CORE_S_INT_G_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 MATRIX_MUL_IP_CORE_S_INT_G_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define MATRIX_MUL_IP_CORE_S_INT_G_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define MATRIX_MUL_IP_CORE_S_INT_G_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define MATRIX_MUL_IP_CORE_S_INT_G_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define MATRIX_MUL_IP_CORE_S_INT_G_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))

#define MATRIX_MUL_IP_CORE_S_INT_G_mReadSlaveReg0(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG0_OFFSET) + (RegOffset))
#define MATRIX_MUL_IP_CORE_S_INT_G_mReadSlaveReg1(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG1_OFFSET) + (RegOffset))
#define MATRIX_MUL_IP_CORE_S_INT_G_mReadSlaveReg2(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG2_OFFSET) + (RegOffset))
#define MATRIX_MUL_IP_CORE_S_INT_G_mReadSlaveReg3(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (MATRIX_MUL_IP_CORE_S_INT_G_SLV_REG3_OFFSET) + (RegOffset))

/**
 *
 * Check status of MATRIX_MUL_IP_CORE_S_INT_G user logic master module.
 *
 * @param   BaseAddress is the base address of the MATRIX_MUL_IP_CORE_S_INT_G device.
 *
 * @return  Status is the result of status checking.
 *
 * @note
 * C-style signature:
 * 	bool MATRIX_MUL_IP_CORE_S_INT_G_mMasterDone(Xuint32 BaseAddress)
 * 	bool MATRIX_MUL_IP_CORE_S_INT_G_mMasterBusy(Xuint32 BaseAddress)
 * 	bool MATRIX_MUL_IP_CORE_S_INT_G_mMasterError(Xuint32 BaseAddress)
 * 	bool MATRIX_MUL_IP_CORE_S_INT_G_mMasterTimeout(Xuint32 BaseAddress)
 *
 */
#define MATRIX_MUL_IP_CORE_S_INT_G_mMasterDone(BaseAddress) \
 	((((Xuint32) Xil_In8((BaseAddress)+(MATRIX_MUL_IP_CORE_S_INT_G_MST_STAT_REG_OFFSET))) & MST_DONE_MASK) == MST_DONE_MASK)
#define MATRIX_MUL_IP_CORE_S_INT_G_mMasterBusy(BaseAddress) \
 	((((Xuint32) Xil_In8((BaseAddress)+(MATRIX_MUL_IP_CORE_S_INT_G_MST_STAT_REG_OFFSET))) & MST_BUSY_MASK) == MST_BUSY_MASK)
#define MATRIX_MUL_IP_CORE_S_INT_G_mMasterError(BaseAddress) \
 	((((Xuint32) Xil_In8((BaseAddress)+(MATRIX_MUL_IP_CORE_S_INT_G_MST_STAT_REG_OFFSET))) & MST_ERROR_MASK) == MST_ERROR_MASK)
#define MATRIX_MUL_IP_CORE_S_INT_G_mMasterTimeout(BaseAddress) \
 	((((Xuint32) Xil_In8((BaseAddress)+(MATRIX_MUL_IP_CORE_S_INT_G_MST_STAT_REG_OFFSET))) & MST_TIMEOUT_MASK) == MST_TIMEOUT_MASK)

/************************** Function Prototypes ****************************/


/**
 *
 * User logic master module to send/receive word to/from remote system memory.
 * While sending, one word is read from user logic local FIFO and written to remote system memory.
 * While receiving, one word is read from remote system memory and written to user logic local FIFO.
 *
 * @param   BaseAddress is the base address of the MATRIX_MUL_IP_CORE_S_INT_G device.
 * @param   Src/DstAddress is the destination system memory address from/to which the data will be fetched/stored.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void MATRIX_MUL_IP_CORE_S_INT_G_MasterSendWord(Xuint32 BaseAddress, Xuint32 DstAddress);
void MATRIX_MUL_IP_CORE_S_INT_G_MasterRecvWord(Xuint32 BaseAddress, Xuint32 SrcAddress);

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the MATRIX_MUL_IP_CORE_S_INT_G instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus MATRIX_MUL_IP_CORE_S_INT_G_SelfTest(void * baseaddr_p);
/**
*  Defines the number of registers available for read and write*/
#define TEST_AXI_LITE_USER_NUM_REG 4


#endif /** MATRIX_MUL_IP_CORE_S_INT_G_H */
