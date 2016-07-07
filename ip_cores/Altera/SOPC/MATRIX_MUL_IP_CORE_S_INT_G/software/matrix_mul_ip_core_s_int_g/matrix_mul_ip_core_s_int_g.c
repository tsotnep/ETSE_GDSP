#include "matrix_mul_ip_core_s_int_g.h"
#include <io.h>

PORT_MM_IP_t *const IP_CORE = MATRIX_MUL_IP_S_INT_0_BASE;
//matrix_mul_ip_core_status_flags_t GetMatrixMulIPStatus(void);
//
//
//matrix_mul_ip_core_status_flags_t GetMatrixMulIPStatus(void)
//{
//	matrix_mul_ip_core_status_flags_t flags;
//	int temp = *r_STATUS;
//	flags.READY = ((temp & READY_Msk) == READY_Msk);
//	flags.BUSY = ((temp & BUSY_Msk) == BUSY_Msk);
//	flags.LOADING_DONE = ((temp & LOADING_DONE_Msk) == LOADING_DONE_Msk);
//	flags.OP_DONE = ((temp & OP_DONE_Msk) == OP_DONE_Msk);
//	flags.UN_LOADING_DONE = ((temp & UN_LOADING_DONE_Msk) == UN_LOADING_DONE_Msk);
//
//	return flags;
//
//}

int *const r_CONFIG = MATRIX_MUL_IP_S_INT_0_BASE;
int *const r_STATUS = (int *)(MATRIX_MUL_IP_S_INT_0_BASE + 4);
int *const r_DIN = (int *)(MATRIX_MUL_IP_S_INT_0_BASE + 8);
int *const r_DOUT = (int *)(MATRIX_MUL_IP_S_INT_0_BASE + 12);

int selfTest()
{
//	*r_CONFIG = 0;
//
//	int t = *r_STATUS & 0xffffffff;
	int t = IORD_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE, 0);
	return t;

}


//int selfTest()
//{
//	IP_CORE->Config.PG = 0;
//	IP_CORE->Config.Bank_Sel = 0;
//	IP_CORE->Config.CMD = 0;
//
//	int t = IP_CORE->Status.READY;
//
//	return t;
//
//}
