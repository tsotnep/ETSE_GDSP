/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/FPGA/Internship Jobs/Codes/ETSE_GDSP/Matrix_for_RBM/MEMARRAY_V3.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1605435078_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_1332103392_3212880686_p_0(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    int t9;
    int t10;
    int t11;
    int t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    unsigned char t18;
    int t19;
    int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;

LAB0:    xsi_set_current_line(137, ng0);
    t1 = (t0 + 3368U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 13312);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(138, ng0);
    t3 = (t0 + 8208U);
    t4 = *((char **)t3);
    t3 = (t0 + 13440);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t4, 10U);
    xsi_driver_first_trans_delta(t3, 0U, 10U, 0LL);
    xsi_set_current_line(139, ng0);
    t9 = (5 - 1);
    t1 = (t0 + 25640);
    *((int *)t1) = 0;
    t3 = (t0 + 25644);
    *((int *)t3) = t9;
    t10 = 0;
    t11 = t9;

LAB5:    if (t10 <= t11)
        goto LAB6;

LAB8:    xsi_set_current_line(142, ng0);
    t1 = (t0 + 10184U);
    t3 = *((char **)t1);
    t9 = *((int *)t3);
    t10 = (t9 - 1);
    t1 = (t0 + 25648);
    *((int *)t1) = 1;
    t4 = (t0 + 25652);
    *((int *)t4) = t10;
    t11 = 1;
    t12 = t10;

LAB10:    if (t11 <= t12)
        goto LAB11;

LAB13:    xsi_set_current_line(146, ng0);
    t1 = (t0 + 7728U);
    t3 = *((char **)t1);
    t1 = (t0 + 10184U);
    t4 = *((char **)t1);
    t9 = *((int *)t4);
    t10 = (t9 - 1);
    t11 = (t10 - 0);
    t14 = (t11 * 1);
    t15 = (10U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t5 = (t0 + 13568);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t24 = *((char **)t8);
    memcpy(t24, t1, 10U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(147, ng0);
    t1 = (t0 + 7248U);
    t3 = *((char **)t1);
    t1 = (t0 + 10184U);
    t4 = *((char **)t1);
    t9 = *((int *)t4);
    t10 = (t9 - 1);
    t11 = (t10 - 0);
    t14 = (t11 * 1);
    t15 = (5U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t5 = (t0 + 13632);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t24 = *((char **)t8);
    memcpy(t24, t1, 5U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(149, ng0);
    t1 = (t0 + 8528U);
    t3 = *((char **)t1);
    t1 = (t0 + 13696);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 3U);
    xsi_driver_first_trans_delta(t1, 0U, 3U, 0LL);
    xsi_set_current_line(151, ng0);
    t1 = (t0 + 10064U);
    t3 = *((char **)t1);
    t9 = *((int *)t3);
    t10 = (t9 - 1);
    t1 = (t0 + 25656);
    *((int *)t1) = 1;
    t4 = (t0 + 25660);
    *((int *)t4) = t10;
    t11 = 1;
    t12 = t10;

LAB15:    if (t11 <= t12)
        goto LAB16;

LAB18:    xsi_set_current_line(159, ng0);
    t1 = (t0 + 6928U);
    t3 = *((char **)t1);
    t1 = (t0 + 10064U);
    t4 = *((char **)t1);
    t9 = *((int *)t4);
    t10 = (t9 - 1);
    t11 = (t10 - 0);
    t14 = (t11 * 1);
    t15 = (3U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t5 = (t0 + 13760);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t24 = *((char **)t8);
    memcpy(t24, t1, 3U);
    xsi_driver_first_trans_fast(t5);
    goto LAB3;

LAB6:    xsi_set_current_line(140, ng0);
    t4 = (t0 + 8048U);
    t5 = *((char **)t4);
    t4 = (t0 + 25640);
    t12 = *((int *)t4);
    t13 = (t12 - 4);
    t14 = (t13 * -1);
    xsi_vhdl_check_range_of_index(4, 0, -1, *((int *)t4));
    t15 = (1U * t14);
    t16 = (0 + t15);
    t6 = (t5 + t16);
    t2 = *((unsigned char *)t6);
    t7 = (t0 + 8688U);
    t8 = *((char **)t7);
    t17 = *((unsigned char *)t8);
    t18 = ieee_p_2592010699_sub_1605435078_503743352(IEEE_P_2592010699, t2, t17);
    t7 = (t0 + 25640);
    t19 = *((int *)t7);
    t20 = (t19 - 0);
    t21 = (t20 * 1);
    t22 = (1 * t21);
    t23 = (0U + t22);
    t24 = (t0 + 13504);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    *((unsigned char *)t28) = t18;
    xsi_driver_first_trans_delta(t24, t23, 1, 0LL);

LAB7:    t1 = (t0 + 25640);
    t10 = *((int *)t1);
    t3 = (t0 + 25644);
    t11 = *((int *)t3);
    if (t10 == t11)
        goto LAB8;

LAB9:    t9 = (t10 + 1);
    t10 = t9;
    t4 = (t0 + 25640);
    *((int *)t4) = t10;
    goto LAB5;

LAB11:    xsi_set_current_line(143, ng0);
    t5 = (t0 + 7248U);
    t6 = *((char **)t5);
    t5 = (t0 + 25648);
    t13 = *((int *)t5);
    t19 = (t13 - 1);
    t20 = (t19 - 0);
    t14 = (t20 * 1);
    xsi_vhdl_check_range_of_index(0, 7, 1, t19);
    t15 = (5U * t14);
    t16 = (0 + t15);
    t7 = (t6 + t16);
    t8 = (t0 + 25648);
    t29 = *((int *)t8);
    t30 = (t29 - 0);
    t21 = (t30 * 1);
    t22 = (5U * t21);
    t23 = (0U + t22);
    t24 = (t0 + 13504);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t7, 5U);
    xsi_driver_first_trans_delta(t24, t23, 5U, 0LL);
    xsi_set_current_line(144, ng0);
    t1 = (t0 + 7728U);
    t3 = *((char **)t1);
    t1 = (t0 + 25648);
    t9 = *((int *)t1);
    t10 = (t9 - 1);
    t13 = (t10 - 0);
    t14 = (t13 * 1);
    xsi_vhdl_check_range_of_index(0, 7, 1, t10);
    t15 = (10U * t14);
    t16 = (0 + t15);
    t4 = (t3 + t16);
    t5 = (t0 + 25648);
    t19 = *((int *)t5);
    t20 = (t19 - 0);
    t21 = (t20 * 1);
    t22 = (10U * t21);
    t23 = (0U + t22);
    t6 = (t0 + 13440);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t24 = (t8 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t4, 10U);
    xsi_driver_first_trans_delta(t6, t23, 10U, 0LL);

LAB12:    t1 = (t0 + 25648);
    t11 = *((int *)t1);
    t3 = (t0 + 25652);
    t12 = *((int *)t3);
    if (t11 == t12)
        goto LAB13;

LAB14:    t9 = (t11 + 1);
    t11 = t9;
    t4 = (t0 + 25648);
    *((int *)t4) = t11;
    goto LAB10;

LAB16:    xsi_set_current_line(155, ng0);
    t5 = (t0 + 6928U);
    t6 = *((char **)t5);
    t5 = (t0 + 25656);
    t13 = *((int *)t5);
    t19 = (t13 - 1);
    t20 = (t19 - 0);
    t14 = (t20 * 1);
    xsi_vhdl_check_range_of_index(0, 1, 1, t19);
    t15 = (3U * t14);
    t16 = (0 + t15);
    t7 = (t6 + t16);
    t8 = (t0 + 25656);
    t29 = *((int *)t8);
    t30 = (t29 - 0);
    t21 = (t30 * 1);
    t22 = (3U * t21);
    t23 = (0U + t22);
    t24 = (t0 + 13696);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t7, 3U);
    xsi_driver_first_trans_delta(t24, t23, 3U, 0LL);

LAB17:    t1 = (t0 + 25656);
    t11 = *((int *)t1);
    t3 = (t0 + 25660);
    t12 = *((int *)t3);
    if (t11 == t12)
        goto LAB18;

LAB19:    t9 = (t11 + 1);
    t11 = t9;
    t4 = (t0 + 25656);
    *((int *)t4) = t11;
    goto LAB15;

}

static void work_a_1332103392_3212880686_p_1(char *t0)
{
    char t10[16];
    char t12[16];
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    char *t9;
    char *t11;
    char *t13;
    char *t14;
    int t15;
    unsigned int t16;
    unsigned char t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;

LAB0:    xsi_set_current_line(195, ng0);

LAB3:    t1 = (t0 + 4688U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 7888U);
    t4 = *((char **)t1);
    t5 = (10U - 2);
    t6 = (9 - t5);
    t7 = (t6 * 1U);
    t8 = (0 + t7);
    t1 = (t4 + t8);
    t11 = ((IEEE_P_2592010699) + 4024);
    t13 = (t12 + 0U);
    t14 = (t13 + 0U);
    *((int *)t14) = 8;
    t14 = (t13 + 4U);
    *((int *)t14) = 0;
    t14 = (t13 + 8U);
    *((int *)t14) = -1;
    t15 = (0 - 8);
    t16 = (t15 * -1);
    t16 = (t16 + 1);
    t14 = (t13 + 12U);
    *((unsigned int *)t14) = t16;
    t9 = xsi_base_array_concat(t9, t10, t11, (char)99, t3, (char)97, t1, t12, (char)101);
    t16 = (1U + 9U);
    t17 = (10U != t16);
    if (t17 == 1)
        goto LAB5;

LAB6:    t14 = (t0 + 13824);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t9, 10U);
    xsi_driver_first_trans_fast(t14);

LAB2:    t22 = (t0 + 13328);
    *((int *)t22) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(10U, t16, 0);
    goto LAB6;

}

static void work_a_1332103392_3212880686_p_2(char *t0)
{
    char t20[16];
    char t22[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t21;
    char *t23;
    char *t24;
    int t25;
    unsigned int t26;
    unsigned char t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;

LAB0:    xsi_set_current_line(197, ng0);
    t1 = (t0 + 4528U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t10 = (t0 + 4688U);
    t11 = *((char **)t10);
    t12 = *((unsigned char *)t11);
    t13 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t12);
    t10 = (t0 + 8208U);
    t14 = *((char **)t10);
    t15 = (10U - 2);
    t16 = (9 - t15);
    t17 = (t16 * 1U);
    t18 = (0 + t17);
    t10 = (t14 + t18);
    t21 = ((IEEE_P_2592010699) + 4024);
    t23 = (t22 + 0U);
    t24 = (t23 + 0U);
    *((int *)t24) = 8;
    t24 = (t23 + 4U);
    *((int *)t24) = 0;
    t24 = (t23 + 8U);
    *((int *)t24) = -1;
    t25 = (0 - 8);
    t26 = (t25 * -1);
    t26 = (t26 + 1);
    t24 = (t23 + 12U);
    *((unsigned int *)t24) = t26;
    t19 = xsi_base_array_concat(t19, t20, t21, (char)99, t13, (char)97, t10, t22, (char)101);
    t26 = (1U + 9U);
    t27 = (10U != t26);
    if (t27 == 1)
        goto LAB7;

LAB8:    t24 = (t0 + 13888);
    t28 = (t24 + 56U);
    t29 = *((char **)t28);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memcpy(t31, t19, 10U);
    xsi_driver_first_trans_fast(t24);

LAB2:    t32 = (t0 + 13344);
    *((int *)t32) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 4208U);
    t5 = *((char **)t1);
    t1 = (t0 + 13888);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 10U);
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    goto LAB2;

LAB7:    xsi_size_not_matching(10U, t26, 0);
    goto LAB8;

}

static void work_a_1332103392_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(201, ng0);
    t1 = (t0 + 4528U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t11 = (t0 + 8368U);
    t12 = *((char **)t11);
    t13 = *((unsigned char *)t12);
    t11 = (t0 + 13952);
    t14 = (t11 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    *((unsigned char *)t17) = t13;
    xsi_driver_first_trans_fast(t11);

LAB2:    t18 = (t0 + 13360);
    *((int *)t18) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 4368U);
    t5 = *((char **)t1);
    t6 = *((unsigned char *)t5);
    t1 = (t0 + 13952);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t6;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    goto LAB2;

}


extern void work_a_1332103392_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1332103392_3212880686_p_0,(void *)work_a_1332103392_3212880686_p_1,(void *)work_a_1332103392_3212880686_p_2,(void *)work_a_1332103392_3212880686_p_3};
	xsi_register_didat("work_a_1332103392_3212880686", "isim/TB_MEMARRAY_V4_isim_beh.exe.sim/work/a_1332103392_3212880686.didat");
	xsi_register_executes(pe);
}
