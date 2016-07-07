/*
 * matrix_mul_ip_core_s_int_g.h
 *
 *  Created on: 9 Sep 2015
 *      Author: MEC9
 */
#ifndef MATRIX_MUL_IP_CORE_S_INT_G_H_
#define MATRIX_MUL_IP_CORE_S_INT_G_H_

/***************************** Include Files *******************************/
#include <system.h>
/************************** Constant Definitions ***************************/

#define READY_Msk			0x00000001
#define BUSY_Msk			0x00000002
#define LOADING_DONE_Msk	0x00000004
#define OP_DONE_Msk			0x00000008
#define UN_LOADING_DONE_Msk	0x00000016

#define CMD_INIT   		0x00000000;
#define CMD_LOAD_G 		0x00000001;
#define CMD_LOAD_P 		0x00000010;
#define CMD_UN_LOAD_P	0x00000011;
#define CMD_PG			0x00000100;

// Declare pointers for registers

//int *const r_CONFIG = MATRIX_MUL_IP_S_INT_0_BASE;
//int *const r_STATUS = (int *)(MATRIX_MUL_IP_S_INT_0_BASE + 4);
//int *const r_DIN = (int *)(MATRIX_MUL_IP_S_INT_0_BASE + 8);
//int *const r_DOUT = (int *)(MATRIX_MUL_IP_S_INT_0_BASE + 12);

//int *r_CONFIG = MATRIX_MUL_IP_S_INT_0_BASE;
//int *r_STATUS = MATRIX_MUL_IP_S_INT_0_BASE + 4;
//int *r_DIN = MATRIX_MUL_IP_S_INT_0_BASE + 8;
//int *r_DOUT = MATRIX_MUL_IP_S_INT_0_BASE + 12;


typedef struct PORT_MM_IP_t PORT_MM_IP_t;
typedef struct Status_t Status_t;
typedef struct Config_t Config_t;
typedef int Data_t;



struct Status_t
{
	unsigned int READY: 1; //r_status(0)
	unsigned int BUSY: 1; //r_status(1)
	unsigned int LOADING_DONE : 1;//r_status(2)
	unsigned int OP_DONE : 1; //r_status(3)
	unsigned int UN_LOADING_DONE : 1;// r_status(4)

	unsigned int /* unused */ : 27;

};

struct Config_t
{
	unsigned int CMD : 3;
	unsigned int Bank_Sel: 1;
	unsigned int PG : 2;
	unsigned int /* unused */ : 26;
};
struct PORT_MM_IP_t
{
	Config_t Config;
	Status_t volatile Status;
	Data_t DIN;
	Data_t DOUT;
};



#endif /* MATRIX_MUL_IP_S_INT_G_H_ */
