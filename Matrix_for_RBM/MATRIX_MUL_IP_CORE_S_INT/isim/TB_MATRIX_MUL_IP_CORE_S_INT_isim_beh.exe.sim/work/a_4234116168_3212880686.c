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

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/tsotne/git/ETSE_GDSP/Matrix_for_RBM/MATRIX_MUL_IP_CORE_S_INT/MATRIX_MUL_IP_CORE_S_INT.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_3488768496604610246_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );


static void work_a_4234116168_3212880686_p_0(char *t0)
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

LAB0:    xsi_set_current_line(101, ng0);
    t1 = (t0 + 2312U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 12176);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(102, ng0);
    t3 = (t0 + 7632U);
    t4 = *((char **)t3);
    t3 = (t0 + 12320);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t4, 9U);
    xsi_driver_first_trans_delta(t3, 0U, 9U, 0LL);
    xsi_set_current_line(104, ng0);
    t9 = (3 - 1);
    t1 = (t0 + 25068);
    *((int *)t1) = 0;
    t3 = (t0 + 25072);
    *((int *)t3) = t9;
    t10 = 0;
    t11 = t9;

LAB5:    if (t10 <= t11)
        goto LAB6;

LAB8:    xsi_set_current_line(107, ng0);
    t1 = (t0 + 9288U);
    t3 = *((char **)t1);
    t9 = *((int *)t3);
    t10 = (t9 - 1);
    t1 = (t0 + 25076);
    *((int *)t1) = 1;
    t4 = (t0 + 25080);
    *((int *)t4) = t10;
    t11 = 1;
    t12 = t10;

LAB10:    if (t11 <= t12)
        goto LAB11;

LAB13:    xsi_set_current_line(112, ng0);
    t1 = (t0 + 5872U);
    t3 = *((char **)t1);
    t1 = (t0 + 9288U);
    t4 = *((char **)t1);
    t9 = *((int *)t4);
    t10 = (t9 - 1);
    t11 = (t10 - 0);
    t14 = (t11 * 1);
    t15 = (9U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t5 = (t0 + 12512);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t24 = *((char **)t8);
    memcpy(t24, t1, 9U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(114, ng0);
    t1 = (t0 + 5552U);
    t3 = *((char **)t1);
    t1 = (t0 + 9288U);
    t4 = *((char **)t1);
    t9 = *((int *)t4);
    t10 = (t9 - 1);
    t11 = (t10 - 0);
    t14 = (t11 * 1);
    t15 = (3U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t5 = (t0 + 12576);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t24 = *((char **)t8);
    memcpy(t24, t1, 3U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(116, ng0);
    t1 = (t0 + 6832U);
    t3 = *((char **)t1);
    t1 = (t0 + 12640);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 3U);
    xsi_driver_first_trans_delta(t1, 0U, 3U, 0LL);
    xsi_set_current_line(119, ng0);
    t1 = (t0 + 9168U);
    t3 = *((char **)t1);
    t9 = *((int *)t3);
    t10 = (t9 - 1);
    t1 = (t0 + 25084);
    *((int *)t1) = 1;
    t4 = (t0 + 25088);
    *((int *)t4) = t10;
    t11 = 1;
    t12 = t10;

LAB15:    if (t11 <= t12)
        goto LAB16;

LAB18:    xsi_set_current_line(122, ng0);
    t1 = (t0 + 5232U);
    t3 = *((char **)t1);
    t1 = (t0 + 9168U);
    t4 = *((char **)t1);
    t9 = *((int *)t4);
    t10 = (t9 - 1);
    t11 = (t10 - 0);
    t14 = (t11 * 1);
    t15 = (3U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t5 = (t0 + 12704);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t24 = *((char **)t8);
    memcpy(t24, t1, 3U);
    xsi_driver_first_trans_fast(t5);
    goto LAB3;

LAB6:    xsi_set_current_line(105, ng0);
    t4 = (t0 + 6352U);
    t5 = *((char **)t4);
    t4 = (t0 + 25068);
    t12 = *((int *)t4);
    t13 = (t12 - 2);
    t14 = (t13 * -1);
    xsi_vhdl_check_range_of_index(2, 0, -1, *((int *)t4));
    t15 = (1U * t14);
    t16 = (0 + t15);
    t6 = (t5 + t16);
    t2 = *((unsigned char *)t6);
    t7 = (t0 + 6992U);
    t8 = *((char **)t7);
    t17 = *((unsigned char *)t8);
    t18 = ieee_p_2592010699_sub_3488768496604610246_503743352(IEEE_P_2592010699, t2, t17);
    t7 = (t0 + 25068);
    t19 = *((int *)t7);
    t20 = (t19 - 0);
    t21 = (t20 * 1);
    t22 = (1 * t21);
    t23 = (0U + t22);
    t24 = (t0 + 12384);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    *((unsigned char *)t28) = t18;
    xsi_driver_first_trans_delta(t24, t23, 1, 0LL);

LAB7:    t1 = (t0 + 25068);
    t10 = *((int *)t1);
    t3 = (t0 + 25072);
    t11 = *((int *)t3);
    if (t10 == t11)
        goto LAB8;

LAB9:    t9 = (t10 + 1);
    t10 = t9;
    t4 = (t0 + 25068);
    *((int *)t4) = t10;
    goto LAB5;

LAB11:    xsi_set_current_line(108, ng0);
    t5 = (t0 + 5552U);
    t6 = *((char **)t5);
    t5 = (t0 + 25076);
    t13 = *((int *)t5);
    t19 = (t13 - 1);
    t20 = (t19 - 0);
    t14 = (t20 * 1);
    xsi_vhdl_check_range_of_index(0, 7, 1, t19);
    t15 = (3U * t14);
    t16 = (0 + t15);
    t7 = (t6 + t16);
    t8 = (t0 + 25076);
    t29 = *((int *)t8);
    t30 = (t29 - 0);
    t21 = (t30 * 1);
    t22 = (3U * t21);
    t23 = (0U + t22);
    t24 = (t0 + 12384);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t7, 3U);
    xsi_driver_first_trans_delta(t24, t23, 3U, 0LL);
    xsi_set_current_line(109, ng0);
    t1 = (t0 + 5872U);
    t3 = *((char **)t1);
    t1 = (t0 + 25076);
    t9 = *((int *)t1);
    t10 = (t9 - 1);
    t13 = (t10 - 0);
    t14 = (t13 * 1);
    xsi_vhdl_check_range_of_index(0, 7, 1, t10);
    t15 = (9U * t14);
    t16 = (0 + t15);
    t4 = (t3 + t16);
    t5 = (t0 + 25076);
    t19 = *((int *)t5);
    t20 = (t19 - 0);
    t21 = (t20 * 1);
    t22 = (9U * t21);
    t23 = (0U + t22);
    t6 = (t0 + 12320);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t24 = (t8 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t4, 9U);
    xsi_driver_first_trans_delta(t6, t23, 9U, 0LL);
    xsi_set_current_line(110, ng0);
    t1 = (t0 + 6032U);
    t3 = *((char **)t1);
    t1 = (t0 + 25076);
    t9 = *((int *)t1);
    t10 = (t9 - 1);
    t13 = (t10 - 0);
    t14 = (t13 * 1);
    xsi_vhdl_check_range_of_index(0, 7, 1, t10);
    t15 = (9U * t14);
    t16 = (0 + t15);
    t4 = (t3 + t16);
    t5 = (t0 + 25076);
    t19 = *((int *)t5);
    t20 = (t19 - 0);
    t21 = (t20 * 1);
    t22 = (9U * t21);
    t23 = (0U + t22);
    t6 = (t0 + 12448);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t24 = (t8 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t4, 9U);
    xsi_driver_first_trans_delta(t6, t23, 9U, 0LL);

LAB12:    t1 = (t0 + 25076);
    t11 = *((int *)t1);
    t3 = (t0 + 25080);
    t12 = *((int *)t3);
    if (t11 == t12)
        goto LAB13;

LAB14:    t9 = (t11 + 1);
    t11 = t9;
    t4 = (t0 + 25076);
    *((int *)t4) = t11;
    goto LAB10;

LAB16:    xsi_set_current_line(120, ng0);
    t5 = (t0 + 5232U);
    t6 = *((char **)t5);
    t5 = (t0 + 25084);
    t13 = *((int *)t5);
    t19 = (t13 - 1);
    t20 = (t19 - 0);
    t14 = (t20 * 1);
    xsi_vhdl_check_range_of_index(0, 1, 1, t19);
    t15 = (3U * t14);
    t16 = (0 + t15);
    t7 = (t6 + t16);
    t8 = (t0 + 25084);
    t29 = *((int *)t8);
    t30 = (t29 - 0);
    t21 = (t30 * 1);
    t22 = (3U * t21);
    t23 = (0U + t22);
    t24 = (t0 + 12640);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t7, 3U);
    xsi_driver_first_trans_delta(t24, t23, 3U, 0LL);

LAB17:    t1 = (t0 + 25084);
    t11 = *((int *)t1);
    t3 = (t0 + 25088);
    t12 = *((int *)t3);
    if (t11 == t12)
        goto LAB18;

LAB19:    t9 = (t11 + 1);
    t11 = t9;
    t4 = (t0 + 25084);
    *((int *)t4) = t11;
    goto LAB15;

}

static void work_a_4234116168_3212880686_p_1(char *t0)
{
    char t5[16];
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned char t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(169, ng0);

LAB3:    t1 = (t0 + 3312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6192U);
    t4 = *((char **)t1);
    t6 = ((IEEE_P_2592010699) + 4000);
    t7 = (t0 + 24400U);
    t1 = xsi_base_array_concat(t1, t5, t6, (char)99, t3, (char)97, t4, t7, (char)101);
    t8 = (1U + 9U);
    t9 = (10U != t8);
    if (t9 == 1)
        goto LAB5;

LAB6:    t10 = (t0 + 12768);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t1, 10U);
    xsi_driver_first_trans_fast(t10);

LAB2:    t15 = (t0 + 12192);
    *((int *)t15) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(10U, t8, 0);
    goto LAB6;

}

static void work_a_4234116168_3212880686_p_2(char *t0)
{
    char t6[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(174, ng0);

LAB3:    t1 = (t0 + 3312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t3);
    t1 = (t0 + 6512U);
    t5 = *((char **)t1);
    t7 = ((IEEE_P_2592010699) + 4000);
    t8 = (t0 + 24432U);
    t1 = xsi_base_array_concat(t1, t6, t7, (char)99, t4, (char)97, t5, t8, (char)101);
    t9 = (1U + 9U);
    t10 = (10U != t9);
    if (t10 == 1)
        goto LAB5;

LAB6:    t11 = (t0 + 12832);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t1, 10U);
    xsi_driver_first_trans_fast(t11);

LAB2:    t16 = (t0 + 12208);
    *((int *)t16) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(10U, t9, 0);
    goto LAB6;

}

static void work_a_4234116168_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(176, ng0);
    t1 = (t0 + 7952U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t15 = xsi_get_transient_memory(18U);
    memset(t15, 0, 18U);
    t16 = t15;
    memset(t16, (unsigned char)2, 18U);
    t17 = (0 - 17);
    t18 = (t17 * -1);
    t19 = (1U * t18);
    t20 = (t16 + t19);
    *((unsigned char *)t20) = (unsigned char)3;
    t21 = (t0 + 12896);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t15, 18U);
    xsi_driver_first_trans_fast(t21);

LAB2:    t26 = (t0 + 12224);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 3472U);
    t5 = *((char **)t1);
    t6 = (18 - 1);
    t7 = (17 - t6);
    t8 = (t7 * 1U);
    t9 = (0 + t8);
    t1 = (t5 + t9);
    t10 = (t0 + 12896);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t1, 18U);
    xsi_driver_first_trans_fast(t10);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_4234116168_3212880686_p_4(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    int t4;
    unsigned int t5;
    unsigned int t6;
    int t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(222, ng0);

LAB3:    t1 = (t0 + 5072U);
    t2 = *((char **)t1);
    t3 = (48 - 1);
    t4 = (18 - 1);
    t5 = (t3 - t4);
    t6 = (t5 * 1U);
    t7 = (3 - 1);
    t8 = (t7 - 0);
    t9 = (t8 * 1);
    t10 = (48U * t9);
    t11 = (0 + t10);
    t12 = (t11 + t6);
    t1 = (t2 + t12);
    t13 = (t0 + 12960);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t1, 18U);
    xsi_driver_first_trans_fast_port(t13);

LAB2:    t18 = (t0 + 12240);
    *((int *)t18) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_4234116168_3212880686_init()
{
	static char *pe[] = {(void *)work_a_4234116168_3212880686_p_0,(void *)work_a_4234116168_3212880686_p_1,(void *)work_a_4234116168_3212880686_p_2,(void *)work_a_4234116168_3212880686_p_3,(void *)work_a_4234116168_3212880686_p_4};
	xsi_register_didat("work_a_4234116168_3212880686", "isim/TB_MATRIX_MUL_IP_CORE_S_INT_isim_beh.exe.sim/work/a_4234116168_3212880686.didat");
	xsi_register_executes(pe);
}
