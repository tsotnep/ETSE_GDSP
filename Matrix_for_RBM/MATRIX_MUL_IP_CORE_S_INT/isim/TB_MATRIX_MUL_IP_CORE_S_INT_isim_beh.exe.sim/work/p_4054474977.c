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
extern char *STD_TEXTIO;
extern char *STD_STANDARD;
static const char *ng2 = "Function str ended without a return statement";
extern char *IEEE_P_2592010699;
static const char *ng4 = "Function is_whitespace ended without a return statement";



void work_p_4054474977_sub_139404078134298855_1800819092(char *t0, char *t1, char *t2, char *t3)
{
    char t4[80];
    char t5[24];
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    char *t14;
    char *t15;
    unsigned int t16;
    char *t17;

LAB0:    t6 = (t4 + 4U);
    t7 = ((STD_TEXTIO) + 3248);
    t8 = (t6 + 56U);
    *((char **)t8) = t7;
    t9 = (t6 + 40U);
    *((char **)t9) = 0;
    t10 = (t6 + 64U);
    *((int *)t10) = 1;
    t11 = (t6 + 48U);
    *((char **)t11) = 0;
    t12 = (t5 + 4U);
    t13 = (t2 != 0);
    if (t13 == 1)
        goto LAB3;

LAB2:    t14 = (t5 + 12U);
    *((char **)t14) = t3;
    t15 = (t3 + 12U);
    t16 = *((unsigned int *)t15);
    t16 = (t16 * 1U);
    t17 = (char *)alloca(t16);
    memcpy(t17, t2, t16);
    std_textio_write7(STD_TEXTIO, t1, t6, t17, t3, (unsigned char)0, 0);
    t7 = ((STD_TEXTIO) + 1480U);
    std_textio_writeline(STD_TEXTIO, t1, t7, t6);

LAB1:    xsi_access_variable_delete(t6);
    return;
LAB3:    *((char **)t12) = t2;
    goto LAB2;

}

void work_p_4054474977_sub_1914570909748075741_1800819092(char *t0, char *t1, unsigned char t2, char *t3, char *t4)
{
    char t6[24];
    char *t7;
    char *t8;
    unsigned char t9;
    char *t10;
    char *t11;
    unsigned int t12;
    char *t13;

LAB0:    t7 = (t6 + 4U);
    *((unsigned char *)t7) = t2;
    t8 = (t6 + 5U);
    t9 = (t3 != 0);
    if (t9 == 1)
        goto LAB3;

LAB2:    t10 = (t6 + 13U);
    *((char **)t10) = t4;
    if (t2 != 0)
        goto LAB4;

LAB6:
LAB5:
LAB1:    return;
LAB3:    *((char **)t8) = t3;
    goto LAB2;

LAB4:    t11 = (t4 + 12U);
    t12 = *((unsigned int *)t11);
    t12 = (t12 * 1U);
    t13 = (char *)alloca(t12);
    memcpy(t13, t3, t12);
    work_p_4054474977_sub_139404078134298855_1800819092(t0, t1, t13, t4);
    goto LAB5;

}

unsigned char work_p_4054474977_sub_9806269716244591205_1800819092(char *t1, unsigned char t2)
{
    char t3[128];
    char t4[8];
    char t8[8];
    unsigned char t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    static char *nl0[] = {&&LAB3, &&LAB4, &&LAB5, &&LAB6, &&LAB7, &&LAB8, &&LAB9, &&LAB10, &&LAB11};

LAB0:    t5 = (t3 + 4U);
    t6 = ((STD_STANDARD) + 192);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    xsi_type_set_default_value(t6, t8, 0);
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 1U;
    t11 = (t4 + 4U);
    *((unsigned char *)t11) = t2;
    t12 = (char *)((nl0) + t2);
    goto **((char **)t12);

LAB2:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t15 = *((unsigned char *)t7);
    t0 = t15;

LAB1:    return t0;
LAB3:    t13 = (t5 + 56U);
    t14 = *((char **)t13);
    t13 = (t14 + 0);
    *((unsigned char *)t13) = (unsigned char)85;
    goto LAB2;

LAB4:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)88;
    goto LAB2;

LAB5:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)48;
    goto LAB2;

LAB6:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)49;
    goto LAB2;

LAB7:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)90;
    goto LAB2;

LAB8:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)87;
    goto LAB2;

LAB9:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)76;
    goto LAB2;

LAB10:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)72;
    goto LAB2;

LAB11:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)45;
    goto LAB2;

LAB12:;
}

char *work_p_4054474977_sub_1544710075999088019_1800819092(char *t1, char *t2, unsigned char t3)
{
    char t4[144];
    char t5[8];
    char t6[16];
    char *t0;
    char *t7;
    char *t8;
    int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    int t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    unsigned char t28;
    char *t29;
    char *t30;
    int t31;
    char *t32;
    int t33;
    int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    char *t38;

LAB0:    t7 = (t6 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 1;
    t8 = (t7 + 4U);
    *((int *)t8) = 1;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t9 = (1 - 1);
    t10 = (t9 * 1);
    t10 = (t10 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t10;
    t8 = (t4 + 4U);
    t11 = ((STD_STANDARD) + 984);
    t12 = (t8 + 88U);
    *((char **)t12) = t11;
    t13 = xsi_get_memory(1U);
    t14 = (t8 + 56U);
    *((char **)t14) = t13;
    xsi_type_set_default_value(t11, t13, t6);
    t15 = (t8 + 64U);
    *((char **)t15) = t6;
    t16 = (t8 + 80U);
    *((unsigned int *)t16) = 1U;
    t17 = (t8 + 128U);
    *((char **)t17) = t13;
    t18 = (t8 + 120U);
    *((int *)t18) = 0;
    t19 = (t8 + 124U);
    t20 = (t6 + 12U);
    t10 = *((unsigned int *)t20);
    t21 = (t10 - 1);
    *((int *)t19) = t21;
    t22 = (t8 + 116U);
    t24 = (1U > 2147483644);
    if (t24 == 1)
        goto LAB2;

LAB3:    t25 = (1U + 3);
    t26 = (t25 / 16);
    t23 = t26;

LAB4:    *((unsigned int *)t22) = t23;
    t27 = (t5 + 4U);
    *((unsigned char *)t27) = t3;
    t28 = work_p_4054474977_sub_9806269716244591205_1800819092(t1, t3);
    t29 = (t8 + 56U);
    t30 = *((char **)t29);
    t29 = (t6 + 0U);
    t31 = *((int *)t29);
    t32 = (t6 + 8U);
    t33 = *((int *)t32);
    t34 = (1 - t31);
    t35 = (t34 * t33);
    t36 = (1U * t35);
    t37 = (0 + t36);
    t38 = (t30 + t37);
    *((unsigned char *)t38) = t28;
    t7 = (t8 + 56U);
    t11 = *((char **)t7);
    t7 = (t6 + 12U);
    t10 = *((unsigned int *)t7);
    t10 = (t10 * 1U);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t11, t10);
    t12 = (t6 + 0U);
    t9 = *((int *)t12);
    t13 = (t6 + 4U);
    t21 = *((int *)t13);
    t14 = (t6 + 8U);
    t31 = *((int *)t14);
    t15 = (t2 + 0U);
    t16 = (t15 + 0U);
    *((int *)t16) = t9;
    t16 = (t15 + 4U);
    *((int *)t16) = t21;
    t16 = (t15 + 8U);
    *((int *)t16) = t31;
    t33 = (t21 - t9);
    t23 = (t33 * t31);
    t23 = (t23 + 1);
    t16 = (t15 + 12U);
    *((unsigned int *)t16) = t23;

LAB1:    t7 = (t8 + 80);
    t9 = *((int *)t7);
    t11 = (t8 + 128U);
    t12 = *((char **)t11);
    xsi_put_memory(t9, t12);
    return t0;
LAB2:    t23 = 2147483647;
    goto LAB4;

LAB5:;
}

char *work_p_4054474977_sub_1324089442196103547_1800819092(char *t1, char *t2, char *t3, char *t4)
{
    char t5[264];
    char t6[24];
    char t11[16];
    char t37[8];
    char *t0;
    char *t7;
    unsigned int t8;
    int t9;
    unsigned int t10;
    char *t12;
    unsigned int t13;
    char *t14;
    char *t15;
    int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    int t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    char *t34;
    char *t35;
    char *t36;
    char *t38;
    char *t39;
    char *t40;
    unsigned char t41;
    char *t42;
    char *t43;
    char *t44;
    int t45;
    int t46;
    int t47;
    int t48;
    int t49;
    int t50;
    int t51;
    unsigned char t52;
    int t53;
    int t54;
    int t55;
    int t56;
    int t57;

LAB0:    t7 = (t4 + 12U);
    t8 = *((unsigned int *)t7);
    t9 = (t8 - 1);
    t10 = (t9 * 1);
    t10 = (t10 + 1);
    t10 = (t10 * 1U);
    t12 = (t4 + 12U);
    t13 = *((unsigned int *)t12);
    t14 = (t11 + 0U);
    t15 = (t14 + 0U);
    *((int *)t15) = 1;
    t15 = (t14 + 4U);
    *((unsigned int *)t15) = t13;
    t15 = (t14 + 8U);
    *((int *)t15) = 1;
    t16 = (t13 - 1);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t15 = (t14 + 12U);
    *((unsigned int *)t15) = t17;
    t15 = (t5 + 4U);
    t18 = ((STD_STANDARD) + 984);
    t19 = (t15 + 88U);
    *((char **)t19) = t18;
    t20 = xsi_get_memory(t10);
    t21 = (t15 + 56U);
    *((char **)t21) = t20;
    xsi_type_set_default_value(t18, t20, t11);
    t22 = (t15 + 64U);
    *((char **)t22) = t11;
    t23 = (t15 + 80U);
    *((unsigned int *)t23) = t10;
    t24 = (t15 + 128U);
    *((char **)t24) = t20;
    t25 = (t15 + 120U);
    *((int *)t25) = 0;
    t26 = (t15 + 124U);
    t27 = (t11 + 12U);
    t17 = *((unsigned int *)t27);
    t28 = (t17 - 1);
    *((int *)t26) = t28;
    t29 = (t15 + 116U);
    t31 = (t10 > 2147483644);
    if (t31 == 1)
        goto LAB2;

LAB3:    t32 = (t10 + 3);
    t33 = (t32 / 16);
    t30 = t33;

LAB4:    *((unsigned int *)t29) = t30;
    t34 = (t5 + 140U);
    t35 = ((STD_STANDARD) + 384);
    t36 = (t34 + 88U);
    *((char **)t36) = t35;
    t38 = (t34 + 56U);
    *((char **)t38) = t37;
    xsi_type_set_default_value(t35, t37, 0);
    t39 = (t34 + 80U);
    *((unsigned int *)t39) = 4U;
    t40 = (t6 + 4U);
    t41 = (t3 != 0);
    if (t41 == 1)
        goto LAB6;

LAB5:    t42 = (t6 + 12U);
    *((char **)t42) = t4;
    t43 = (t34 + 56U);
    t44 = *((char **)t43);
    t43 = (t44 + 0);
    *((int *)t43) = 1;
    t7 = (t4 + 8U);
    t9 = *((int *)t7);
    t12 = (t4 + 4U);
    t16 = *((int *)t12);
    t14 = (t4 + 0U);
    t28 = *((int *)t14);
    t45 = t28;
    t46 = t16;

LAB7:    t47 = (t46 * t9);
    t48 = (t45 * t9);
    if (t48 <= t47)
        goto LAB8;

LAB10:    t7 = (t15 + 56U);
    t12 = *((char **)t7);
    t7 = (t11 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t0 = xsi_get_transient_memory(t8);
    memcpy(t0, t12, t8);
    t14 = (t11 + 0U);
    t9 = *((int *)t14);
    t18 = (t11 + 4U);
    t16 = *((int *)t18);
    t19 = (t11 + 8U);
    t28 = *((int *)t19);
    t20 = (t2 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = t9;
    t21 = (t20 + 4U);
    *((int *)t21) = t16;
    t21 = (t20 + 8U);
    *((int *)t21) = t28;
    t45 = (t16 - t9);
    t10 = (t45 * t28);
    t10 = (t10 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t10;

LAB1:    t7 = (t15 + 80);
    t9 = *((int *)t7);
    t12 = (t15 + 128U);
    t14 = *((char **)t12);
    xsi_put_memory(t9, t14);
    return t0;
LAB2:    t30 = 2147483647;
    goto LAB4;

LAB6:    *((char **)t40) = t3;
    goto LAB5;

LAB8:    t18 = (t4 + 0U);
    t49 = *((int *)t18);
    t19 = (t4 + 8U);
    t50 = *((int *)t19);
    t51 = (t45 - t49);
    t8 = (t51 * t50);
    t10 = (1U * t8);
    t13 = (0 + t10);
    t20 = (t3 + t13);
    t41 = *((unsigned char *)t20);
    t52 = work_p_4054474977_sub_9806269716244591205_1800819092(t1, t41);
    t21 = (t15 + 56U);
    t22 = *((char **)t21);
    t21 = (t34 + 56U);
    t23 = *((char **)t21);
    t53 = *((int *)t23);
    t21 = (t11 + 0U);
    t54 = *((int *)t21);
    t24 = (t11 + 8U);
    t55 = *((int *)t24);
    t56 = (t53 - t54);
    t17 = (t56 * t55);
    t25 = (t11 + 4U);
    t57 = *((int *)t25);
    xsi_vhdl_check_range_of_index(t54, t57, t55, t53);
    t30 = (1U * t17);
    t31 = (0 + t30);
    t26 = (t22 + t31);
    *((unsigned char *)t26) = t52;
    t7 = (t34 + 56U);
    t12 = *((char **)t7);
    t16 = *((int *)t12);
    t28 = (t16 + 1);
    t7 = (t34 + 56U);
    t14 = *((char **)t7);
    t7 = (t14 + 0);
    *((int *)t7) = t28;

LAB9:    if (t45 == t46)
        goto LAB10;

LAB11:    t16 = (t45 + t9);
    t45 = t16;
    goto LAB7;

LAB12:;
}

char *work_p_4054474977_sub_806112259833254140_1800819092(char *t1, char *t2, unsigned char t3)
{
    char t5[8];
    char *t0;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;

LAB0:    t6 = (t5 + 4U);
    *((unsigned char *)t6) = t3;
    if (t3 != 0)
        goto LAB2;

LAB4:    t7 = (t1 + 3428);
    t0 = xsi_get_transient_memory(5U);
    memcpy(t0, t7, 5U);
    t9 = (t2 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 1;
    t10 = (t9 + 4U);
    *((int *)t10) = 5;
    t10 = (t9 + 8U);
    *((int *)t10) = 1;
    t11 = (5 - 1);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t12;

LAB1:    return t0;
LAB2:    t7 = (t1 + 3424);
    t0 = xsi_get_transient_memory(4U);
    memcpy(t0, t7, 4U);
    t9 = (t2 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 1;
    t10 = (t9 + 4U);
    *((int *)t10) = 4;
    t10 = (t9 + 8U);
    *((int *)t10) = 1;
    t11 = (4 - 1);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB3:    xsi_error(ng2);
    t0 = 0;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:    goto LAB3;

}

unsigned char work_p_4054474977_sub_10123136052646600953_1800819092(char *t1, int t2)
{
    char t3[128];
    char t4[8];
    char t8[8];
    unsigned char t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    unsigned char t14;

LAB0:    t5 = (t3 + 4U);
    t6 = ((STD_STANDARD) + 192);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    xsi_type_set_default_value(t6, t8, 0);
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 1U;
    t11 = (t4 + 4U);
    *((int *)t11) = t2;
    if (t2 == 0)
        goto LAB3;

LAB40:    if (t2 == 1)
        goto LAB4;

LAB41:    if (t2 == 2)
        goto LAB5;

LAB42:    if (t2 == 3)
        goto LAB6;

LAB43:    if (t2 == 4)
        goto LAB7;

LAB44:    if (t2 == 5)
        goto LAB8;

LAB45:    if (t2 == 6)
        goto LAB9;

LAB46:    if (t2 == 7)
        goto LAB10;

LAB47:    if (t2 == 8)
        goto LAB11;

LAB48:    if (t2 == 9)
        goto LAB12;

LAB49:    if (t2 == 10)
        goto LAB13;

LAB50:    if (t2 == 11)
        goto LAB14;

LAB51:    if (t2 == 12)
        goto LAB15;

LAB52:    if (t2 == 13)
        goto LAB16;

LAB53:    if (t2 == 14)
        goto LAB17;

LAB54:    if (t2 == 15)
        goto LAB18;

LAB55:    if (t2 == 16)
        goto LAB19;

LAB56:    if (t2 == 17)
        goto LAB20;

LAB57:    if (t2 == 18)
        goto LAB21;

LAB58:    if (t2 == 19)
        goto LAB22;

LAB59:    if (t2 == 20)
        goto LAB23;

LAB60:    if (t2 == 21)
        goto LAB24;

LAB61:    if (t2 == 22)
        goto LAB25;

LAB62:    if (t2 == 23)
        goto LAB26;

LAB63:    if (t2 == 24)
        goto LAB27;

LAB64:    if (t2 == 25)
        goto LAB28;

LAB65:    if (t2 == 26)
        goto LAB29;

LAB66:    if (t2 == 27)
        goto LAB30;

LAB67:    if (t2 == 28)
        goto LAB31;

LAB68:    if (t2 == 29)
        goto LAB32;

LAB69:    if (t2 == 30)
        goto LAB33;

LAB70:    if (t2 == 31)
        goto LAB34;

LAB71:    if (t2 == 32)
        goto LAB35;

LAB72:    if (t2 == 33)
        goto LAB36;

LAB73:    if (t2 == 34)
        goto LAB37;

LAB74:    if (t2 == 35)
        goto LAB38;

LAB75:
LAB39:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)63;

LAB2:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t14 = *((unsigned char *)t7);
    t0 = t14;

LAB1:    return t0;
LAB3:    t12 = (t5 + 56U);
    t13 = *((char **)t12);
    t12 = (t13 + 0);
    *((unsigned char *)t12) = (unsigned char)48;
    goto LAB2;

LAB4:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)49;
    goto LAB2;

LAB5:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)50;
    goto LAB2;

LAB6:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)51;
    goto LAB2;

LAB7:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)52;
    goto LAB2;

LAB8:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)53;
    goto LAB2;

LAB9:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)54;
    goto LAB2;

LAB10:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)55;
    goto LAB2;

LAB11:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)56;
    goto LAB2;

LAB12:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)57;
    goto LAB2;

LAB13:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)65;
    goto LAB2;

LAB14:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)66;
    goto LAB2;

LAB15:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)67;
    goto LAB2;

LAB16:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)68;
    goto LAB2;

LAB17:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)69;
    goto LAB2;

LAB18:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)70;
    goto LAB2;

LAB19:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)71;
    goto LAB2;

LAB20:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)72;
    goto LAB2;

LAB21:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)73;
    goto LAB2;

LAB22:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)74;
    goto LAB2;

LAB23:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)75;
    goto LAB2;

LAB24:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)76;
    goto LAB2;

LAB25:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)77;
    goto LAB2;

LAB26:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)78;
    goto LAB2;

LAB27:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)79;
    goto LAB2;

LAB28:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)80;
    goto LAB2;

LAB29:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)81;
    goto LAB2;

LAB30:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)82;
    goto LAB2;

LAB31:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)83;
    goto LAB2;

LAB32:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)84;
    goto LAB2;

LAB33:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)85;
    goto LAB2;

LAB34:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)86;
    goto LAB2;

LAB35:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)87;
    goto LAB2;

LAB36:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)88;
    goto LAB2;

LAB37:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)89;
    goto LAB2;

LAB38:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)90;
    goto LAB2;

LAB76:;
LAB77:;
}

char *work_p_4054474977_sub_3848912576313210135_1800819092(char *t1, char *t2, int t3, int t4)
{
    char t5[624];
    char t6[16];
    char t7[16];
    char t31[8];
    char t37[8];
    char t43[8];
    char t49[8];
    char t66[16];
    char t67[16];
    char *t0;
    char *t8;
    char *t9;
    int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    int t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    char *t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    int t54;
    char *t55;
    char *t56;
    unsigned char t57;
    int t58;
    int t59;
    int t60;
    int t61;
    int t62;
    int t63;
    int t64;
    int t65;
    unsigned int t68;
    int t69;
    unsigned int t70;

LAB0:    t8 = (t7 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 1;
    t9 = (t8 + 4U);
    *((int *)t9) = 10;
    t9 = (t8 + 8U);
    *((int *)t9) = 1;
    t10 = (10 - 1);
    t11 = (t10 * 1);
    t11 = (t11 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t11;
    t9 = (t5 + 4U);
    t12 = ((STD_STANDARD) + 984);
    t13 = (t9 + 88U);
    *((char **)t13) = t12;
    t14 = xsi_get_memory(10U);
    t15 = (t9 + 56U);
    *((char **)t15) = t14;
    xsi_type_set_default_value(t12, t14, t7);
    t16 = (t9 + 64U);
    *((char **)t16) = t7;
    t17 = (t9 + 80U);
    *((unsigned int *)t17) = 10U;
    t18 = (t9 + 128U);
    *((char **)t18) = t14;
    t19 = (t9 + 120U);
    *((int *)t19) = 0;
    t20 = (t9 + 124U);
    t21 = (t7 + 12U);
    t11 = *((unsigned int *)t21);
    t22 = (t11 - 1);
    *((int *)t20) = t22;
    t23 = (t9 + 116U);
    t25 = (10U > 2147483644);
    if (t25 == 1)
        goto LAB2;

LAB3:    t26 = (10U + 3);
    t27 = (t26 / 16);
    t24 = t27;

LAB4:    *((unsigned int *)t23) = t24;
    t28 = (t5 + 140U);
    t29 = ((STD_STANDARD) + 384);
    t30 = (t28 + 88U);
    *((char **)t30) = t29;
    t32 = (t28 + 56U);
    *((char **)t32) = t31;
    xsi_type_set_default_value(t29, t31, 0);
    t33 = (t28 + 80U);
    *((unsigned int *)t33) = 4U;
    t34 = (t5 + 260U);
    t35 = ((STD_STANDARD) + 384);
    t36 = (t34 + 88U);
    *((char **)t36) = t35;
    t38 = (t34 + 56U);
    *((char **)t38) = t37;
    xsi_type_set_default_value(t35, t37, 0);
    t39 = (t34 + 80U);
    *((unsigned int *)t39) = 4U;
    t40 = (t5 + 380U);
    t41 = ((STD_STANDARD) + 384);
    t42 = (t40 + 88U);
    *((char **)t42) = t41;
    t44 = (t40 + 56U);
    *((char **)t44) = t43;
    *((int *)t43) = 1;
    t45 = (t40 + 80U);
    *((unsigned int *)t45) = 4U;
    t46 = (t5 + 500U);
    t47 = ((STD_STANDARD) + 384);
    t48 = (t46 + 88U);
    *((char **)t48) = t47;
    t50 = (t46 + 56U);
    *((char **)t50) = t49;
    *((int *)t49) = 1;
    t51 = (t46 + 80U);
    *((unsigned int *)t51) = 4U;
    t52 = (t6 + 4U);
    *((int *)t52) = t3;
    t53 = (t6 + 8U);
    *((int *)t53) = t4;
    t54 = (t3>=0?t3: -t3);
    t55 = (t34 + 56U);
    t56 = *((char **)t55);
    t55 = (t56 + 0);
    *((int *)t55) = t54;
    t8 = (t34 + 56U);
    t12 = *((char **)t8);
    t10 = *((int *)t12);
    t8 = (t28 + 56U);
    t13 = *((char **)t8);
    t8 = (t13 + 0);
    *((int *)t8) = t10;

LAB5:    t8 = (t28 + 56U);
    t12 = *((char **)t8);
    t10 = *((int *)t12);
    t57 = (t10 >= t4);
    if (t57 != 0)
        goto LAB6;

LAB8:    t8 = (t40 + 56U);
    t12 = *((char **)t8);
    t10 = *((int *)t12);
    t22 = t10;
    t54 = 1;

LAB9:    if (t22 >= t54)
        goto LAB10;

LAB12:    t57 = (t3 < 0);
    if (t57 != 0)
        goto LAB14;

LAB16:    t8 = (t9 + 56U);
    t12 = *((char **)t8);
    t8 = (t7 + 0U);
    t10 = *((int *)t8);
    t11 = (1 - t10);
    t13 = (t40 + 56U);
    t14 = *((char **)t13);
    t22 = *((int *)t14);
    t13 = (t7 + 4U);
    t54 = *((int *)t13);
    t15 = (t7 + 8U);
    t58 = *((int *)t15);
    xsi_vhdl_check_range_of_slice(t10, t54, t58, 1, t22, 1);
    t24 = (t11 * 1U);
    t25 = (0 + t24);
    t16 = (t12 + t25);
    t17 = (t40 + 56U);
    t18 = *((char **)t17);
    t59 = *((int *)t18);
    t60 = (t59 - 1);
    t26 = (t60 * 1);
    t26 = (t26 + 1);
    t27 = (1U * t26);
    t0 = xsi_get_transient_memory(t27);
    memcpy(t0, t16, t27);
    t17 = (t40 + 56U);
    t19 = *((char **)t17);
    t61 = *((int *)t19);
    t17 = (t2 + 0U);
    t20 = (t17 + 0U);
    *((int *)t20) = 1;
    t20 = (t17 + 4U);
    *((int *)t20) = t61;
    t20 = (t17 + 8U);
    *((int *)t20) = 1;
    t62 = (t61 - 1);
    t68 = (t62 * 1);
    t68 = (t68 + 1);
    t20 = (t17 + 12U);
    *((unsigned int *)t20) = t68;

LAB1:    t8 = (t9 + 80);
    t10 = *((int *)t8);
    t12 = (t9 + 128U);
    t13 = *((char **)t12);
    xsi_put_memory(t10, t13);
    return t0;
LAB2:    t24 = 2147483647;
    goto LAB4;

LAB6:    t8 = (t40 + 56U);
    t13 = *((char **)t8);
    t22 = *((int *)t13);
    t54 = (t22 + 1);
    t8 = (t40 + 56U);
    t14 = *((char **)t8);
    t8 = (t14 + 0);
    *((int *)t8) = t54;
    t8 = (t28 + 56U);
    t12 = *((char **)t8);
    t10 = *((int *)t12);
    t22 = (t10 / t4);
    t8 = (t28 + 56U);
    t13 = *((char **)t8);
    t8 = (t13 + 0);
    *((int *)t8) = t22;
    goto LAB5;

LAB7:;
LAB10:    t8 = (t34 + 56U);
    t13 = *((char **)t8);
    t58 = *((int *)t13);
    t8 = (t46 + 56U);
    t14 = *((char **)t8);
    t59 = *((int *)t14);
    t60 = (t58 / t59);
    t61 = xsi_vhdl_mod(t60, t4);
    t57 = work_p_4054474977_sub_10123136052646600953_1800819092(t1, t61);
    t8 = (t9 + 56U);
    t15 = *((char **)t8);
    t8 = (t7 + 0U);
    t62 = *((int *)t8);
    t16 = (t7 + 8U);
    t63 = *((int *)t16);
    t64 = (t22 - t62);
    t11 = (t64 * t63);
    t17 = (t7 + 4U);
    t65 = *((int *)t17);
    xsi_vhdl_check_range_of_index(t62, t65, t63, t22);
    t24 = (1U * t11);
    t25 = (0 + t24);
    t18 = (t15 + t25);
    *((unsigned char *)t18) = t57;
    t8 = (t46 + 56U);
    t12 = *((char **)t8);
    t10 = *((int *)t12);
    t58 = (t10 * t4);
    t8 = (t46 + 56U);
    t13 = *((char **)t8);
    t8 = (t13 + 0);
    *((int *)t8) = t58;

LAB11:    if (t22 == t54)
        goto LAB12;

LAB13:    t10 = (t22 + -1);
    t22 = t10;
    goto LAB9;

LAB14:    t8 = (t9 + 56U);
    t12 = *((char **)t8);
    t8 = (t7 + 0U);
    t10 = *((int *)t8);
    t11 = (1 - t10);
    t13 = (t40 + 56U);
    t14 = *((char **)t13);
    t22 = *((int *)t14);
    t13 = (t7 + 4U);
    t54 = *((int *)t13);
    t15 = (t7 + 8U);
    t58 = *((int *)t15);
    xsi_vhdl_check_range_of_slice(t10, t54, t58, 1, t22, 1);
    t24 = (t11 * 1U);
    t25 = (0 + t24);
    t16 = (t12 + t25);
    t18 = ((STD_STANDARD) + 984);
    t19 = (t40 + 56U);
    t20 = *((char **)t19);
    t59 = *((int *)t20);
    t19 = (t67 + 0U);
    t21 = (t19 + 0U);
    *((int *)t21) = 1;
    t21 = (t19 + 4U);
    *((int *)t21) = t59;
    t21 = (t19 + 8U);
    *((int *)t21) = 1;
    t60 = (t59 - 1);
    t26 = (t60 * 1);
    t26 = (t26 + 1);
    t21 = (t19 + 12U);
    *((unsigned int *)t21) = t26;
    t17 = xsi_base_array_concat(t17, t66, t18, (char)99, (unsigned char)45, (char)97, t16, t67, (char)101);
    t21 = (t40 + 56U);
    t23 = *((char **)t21);
    t61 = *((int *)t23);
    t62 = (t61 - 1);
    t26 = (t62 * 1);
    t26 = (t26 + 1);
    t27 = (1U * t26);
    t68 = (1U + t27);
    t0 = xsi_get_transient_memory(t68);
    memcpy(t0, t17, t68);
    t21 = (t66 + 0U);
    t63 = *((int *)t21);
    t29 = (t66 + 4U);
    t64 = *((int *)t29);
    t30 = (t66 + 8U);
    t65 = *((int *)t30);
    t32 = (t2 + 0U);
    t33 = (t32 + 0U);
    *((int *)t33) = t63;
    t33 = (t32 + 4U);
    *((int *)t33) = t64;
    t33 = (t32 + 8U);
    *((int *)t33) = t65;
    t69 = (t64 - t63);
    t70 = (t69 * t65);
    t70 = (t70 + 1);
    t33 = (t32 + 12U);
    *((unsigned int *)t33) = t70;
    goto LAB1;

LAB15:    xsi_error(ng2);
    t0 = 0;
    goto LAB1;

LAB17:    goto LAB15;

LAB18:    goto LAB15;

}

char *work_p_4054474977_sub_895122493602968861_1800819092(char *t1, char *t2, int t3)
{
    char t5[8];
    char t7[16];
    char *t0;
    char *t6;
    char *t8;
    char *t9;
    unsigned int t10;
    char *t11;
    int t12;
    char *t13;
    int t14;
    char *t15;
    int t16;
    char *t17;
    char *t18;
    int t19;
    unsigned int t20;

LAB0:    t6 = (t5 + 4U);
    *((int *)t6) = t3;
    t8 = work_p_4054474977_sub_3848912576313210135_1800819092(t1, t7, t3, 10);
    t9 = (t7 + 12U);
    t10 = *((unsigned int *)t9);
    t10 = (t10 * 1U);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t8, t10);
    t11 = (t7 + 0U);
    t12 = *((int *)t11);
    t13 = (t7 + 4U);
    t14 = *((int *)t13);
    t15 = (t7 + 8U);
    t16 = *((int *)t15);
    t17 = (t2 + 0U);
    t18 = (t17 + 0U);
    *((int *)t18) = t12;
    t18 = (t17 + 4U);
    *((int *)t18) = t14;
    t18 = (t17 + 8U);
    *((int *)t18) = t16;
    t19 = (t14 - t12);
    t20 = (t19 * t16);
    t20 = (t20 + 1);
    t18 = (t17 + 12U);
    *((unsigned int *)t18) = t20;

LAB1:    return t0;
LAB2:;
}

char *work_p_4054474977_sub_1991549367214789767_1800819092(char *t1, char *t2, char *t3, char *t4)
{
    char t5[504];
    char t6[24];
    char t10[8];
    char t15[16];
    char t22[72];
    char t26[16];
    char t46[16];
    char t53[8];
    char *t0;
    char *t7;
    char *t8;
    char *t9;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t23;
    char *t24;
    char *t25;
    char *t27;
    char *t28;
    int t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    int t40;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    char *t47;
    char *t48;
    int t49;
    unsigned int t50;
    char *t51;
    char *t52;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    unsigned char t58;
    char *t59;
    char *t60;
    int t61;
    int t62;
    int t63;
    char *t64;
    char *t65;
    int t66;
    int t67;
    int t68;
    int t69;
    int t70;
    int t71;
    int t72;
    int t73;
    int t74;
    int t75;
    int t76;
    char *t77;
    int t79;
    char *t80;
    int t82;
    char *t83;
    int t85;
    char *t86;
    char *t87;
    char *t88;
    int t89;
    int t90;
    int t91;
    char *t92;
    int t93;
    int t94;
    char *t95;
    int t96;
    char *t97;

LAB0:    t7 = (t5 + 4U);
    t8 = ((STD_STANDARD) + 384);
    t9 = (t7 + 88U);
    *((char **)t9) = t8;
    t11 = (t7 + 56U);
    *((char **)t11) = t10;
    xsi_type_set_default_value(t8, t10, 0);
    t12 = (t7 + 80U);
    *((unsigned int *)t12) = 4U;
    t13 = xsi_get_transient_memory(68U);
    memset(t13, 0, 68U);
    t14 = t13;
    memset(t14, (unsigned char)2, 68U);
    t16 = (t15 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = 67;
    t17 = (t16 + 4U);
    *((int *)t17) = 0;
    t17 = (t16 + 8U);
    *((int *)t17) = -1;
    t18 = (0 - 67);
    t19 = (t18 * -1);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t5 + 124U);
    t20 = ((IEEE_P_2592010699) + 4000);
    t21 = (t17 + 88U);
    *((char **)t21) = t20;
    t23 = (t17 + 56U);
    *((char **)t23) = t22;
    memcpy(t22, t13, 68U);
    t24 = (t17 + 64U);
    *((char **)t24) = t15;
    t25 = (t17 + 80U);
    *((unsigned int *)t25) = 68U;
    t27 = (t26 + 0U);
    t28 = (t27 + 0U);
    *((int *)t28) = 1;
    t28 = (t27 + 4U);
    *((int *)t28) = 16;
    t28 = (t27 + 8U);
    *((int *)t28) = 1;
    t29 = (16 - 1);
    t19 = (t29 * 1);
    t19 = (t19 + 1);
    t28 = (t27 + 12U);
    *((unsigned int *)t28) = t19;
    t28 = (t5 + 244U);
    t30 = ((STD_STANDARD) + 984);
    t31 = (t28 + 88U);
    *((char **)t31) = t30;
    t32 = xsi_get_memory(16U);
    t33 = (t28 + 56U);
    *((char **)t33) = t32;
    xsi_type_set_default_value(t30, t32, t26);
    t34 = (t28 + 64U);
    *((char **)t34) = t26;
    t35 = (t28 + 80U);
    *((unsigned int *)t35) = 16U;
    t36 = (t28 + 128U);
    *((char **)t36) = t32;
    t37 = (t28 + 120U);
    *((int *)t37) = 0;
    t38 = (t28 + 124U);
    t39 = (t26 + 12U);
    t19 = *((unsigned int *)t39);
    t40 = (t19 - 1);
    *((int *)t38) = t40;
    t41 = (t28 + 116U);
    t43 = (16U > 2147483644);
    if (t43 == 1)
        goto LAB2;

LAB3:    t44 = (16U + 3);
    t45 = (t44 / 16);
    t42 = t45;

LAB4:    *((unsigned int *)t41) = t42;
    t47 = (t46 + 0U);
    t48 = (t47 + 0U);
    *((int *)t48) = 3;
    t48 = (t47 + 4U);
    *((int *)t48) = 0;
    t48 = (t47 + 8U);
    *((int *)t48) = -1;
    t49 = (0 - 3);
    t50 = (t49 * -1);
    t50 = (t50 + 1);
    t48 = (t47 + 12U);
    *((unsigned int *)t48) = t50;
    t48 = (t5 + 380U);
    t51 = ((IEEE_P_2592010699) + 4000);
    t52 = (t48 + 88U);
    *((char **)t52) = t51;
    t54 = (t48 + 56U);
    *((char **)t54) = t53;
    xsi_type_set_default_value(t51, t53, t46);
    t55 = (t48 + 64U);
    *((char **)t55) = t46;
    t56 = (t48 + 80U);
    *((unsigned int *)t56) = 4U;
    t57 = (t6 + 4U);
    t58 = (t3 != 0);
    if (t58 == 1)
        goto LAB6;

LAB5:    t59 = (t6 + 12U);
    *((char **)t59) = t4;
    t60 = (t4 + 0U);
    t61 = *((int *)t60);
    t62 = (t61 + 1);
    t63 = (t62 / 4);
    t64 = (t7 + 56U);
    t65 = *((char **)t64);
    t64 = (t65 + 0);
    *((int *)t64) = t63;
    t8 = (t4 + 0U);
    t18 = *((int *)t8);
    t29 = (t18 + 1);
    t40 = xsi_vhdl_mod(t29, 4);
    t58 = (t40 != 0);
    if (t58 != 0)
        goto LAB7;

LAB9:
LAB8:    t8 = (t17 + 56U);
    t9 = *((char **)t8);
    t8 = (t15 + 0U);
    t18 = *((int *)t8);
    t11 = (t4 + 0U);
    t29 = *((int *)t11);
    t19 = (t18 - t29);
    t12 = (t15 + 4U);
    t40 = *((int *)t12);
    t13 = (t15 + 8U);
    t49 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(t18, t40, t49, t29, 0, -1);
    t42 = (t19 * 1U);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    t16 = (t4 + 12U);
    t44 = *((unsigned int *)t16);
    t44 = (t44 * 1U);
    memcpy(t14, t3, t44);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t18 = *((int *)t9);
    t29 = (t18 - 1);
    t40 = t29;
    t49 = 0;

LAB10:    if (t40 >= t49)
        goto LAB11;

LAB13:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t26 + 0U);
    t18 = *((int *)t8);
    t19 = (1 - t18);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    t29 = *((int *)t12);
    t11 = (t26 + 4U);
    t40 = *((int *)t11);
    t13 = (t26 + 8U);
    t49 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(t18, t40, t49, 1, t29, 1);
    t42 = (t19 * 1U);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    t16 = (t7 + 56U);
    t20 = *((char **)t16);
    t61 = *((int *)t20);
    t62 = (t61 - 1);
    t44 = (t62 * 1);
    t44 = (t44 + 1);
    t45 = (1U * t44);
    t0 = xsi_get_transient_memory(t45);
    memcpy(t0, t14, t45);
    t16 = (t7 + 56U);
    t21 = *((char **)t16);
    t63 = *((int *)t21);
    t16 = (t2 + 0U);
    t23 = (t16 + 0U);
    *((int *)t23) = 1;
    t23 = (t16 + 4U);
    *((int *)t23) = t63;
    t23 = (t16 + 8U);
    *((int *)t23) = 1;
    t66 = (t63 - 1);
    t50 = (t66 * 1);
    t50 = (t50 + 1);
    t23 = (t16 + 12U);
    *((unsigned int *)t23) = t50;

LAB1:    t8 = (t28 + 80);
    t18 = *((int *)t8);
    t9 = (t28 + 128U);
    t11 = *((char **)t9);
    xsi_put_memory(t18, t11);
    return t0;
LAB2:    t42 = 2147483647;
    goto LAB4;

LAB6:    *((char **)t57) = t3;
    goto LAB5;

LAB7:    t9 = (t7 + 56U);
    t11 = *((char **)t9);
    t49 = *((int *)t11);
    t61 = (t49 + 1);
    t9 = (t7 + 56U);
    t12 = *((char **)t9);
    t9 = (t12 + 0);
    *((int *)t9) = t61;
    goto LAB8;

LAB11:    t8 = (t17 + 56U);
    t11 = *((char **)t8);
    t8 = (t15 + 0U);
    t61 = *((int *)t8);
    t62 = (t40 * 4);
    t63 = (t62 + 3);
    t19 = (t61 - t63);
    t66 = (t40 * 4);
    t12 = (t15 + 4U);
    t67 = *((int *)t12);
    t13 = (t15 + 8U);
    t68 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(t61, t67, t68, t63, t66, -1);
    t42 = (t19 * 1U);
    t43 = (0 + t42);
    t14 = (t11 + t43);
    t16 = (t48 + 56U);
    t20 = *((char **)t16);
    t16 = (t20 + 0);
    t69 = (t40 * 4);
    t70 = (t69 + 3);
    t71 = (t40 * 4);
    t72 = (t71 - t70);
    t44 = (t72 * -1);
    t44 = (t44 + 1);
    t45 = (1U * t44);
    memcpy(t16, t14, t45);
    t8 = (t48 + 56U);
    t9 = *((char **)t8);
    t8 = (t1 + 3433);
    t18 = xsi_mem_cmp(t8, t9, 4U);
    if (t18 == 1)
        goto LAB15;

LAB35:    t12 = (t1 + 3437);
    t29 = xsi_mem_cmp(t12, t9, 4U);
    if (t29 == 1)
        goto LAB16;

LAB36:    t14 = (t1 + 3441);
    t61 = xsi_mem_cmp(t14, t9, 4U);
    if (t61 == 1)
        goto LAB17;

LAB37:    t20 = (t1 + 3445);
    t62 = xsi_mem_cmp(t20, t9, 4U);
    if (t62 == 1)
        goto LAB18;

LAB38:    t23 = (t1 + 3449);
    t63 = xsi_mem_cmp(t23, t9, 4U);
    if (t63 == 1)
        goto LAB19;

LAB39:    t25 = (t1 + 3453);
    t66 = xsi_mem_cmp(t25, t9, 4U);
    if (t66 == 1)
        goto LAB20;

LAB40:    t30 = (t1 + 3457);
    t67 = xsi_mem_cmp(t30, t9, 4U);
    if (t67 == 1)
        goto LAB21;

LAB41:    t32 = (t1 + 3461);
    t68 = xsi_mem_cmp(t32, t9, 4U);
    if (t68 == 1)
        goto LAB22;

LAB42:    t34 = (t1 + 3465);
    t69 = xsi_mem_cmp(t34, t9, 4U);
    if (t69 == 1)
        goto LAB23;

LAB43:    t36 = (t1 + 3469);
    t70 = xsi_mem_cmp(t36, t9, 4U);
    if (t70 == 1)
        goto LAB24;

LAB44:    t38 = (t1 + 3473);
    t71 = xsi_mem_cmp(t38, t9, 4U);
    if (t71 == 1)
        goto LAB25;

LAB45:    t41 = (t1 + 3477);
    t72 = xsi_mem_cmp(t41, t9, 4U);
    if (t72 == 1)
        goto LAB26;

LAB46:    t51 = (t1 + 3481);
    t73 = xsi_mem_cmp(t51, t9, 4U);
    if (t73 == 1)
        goto LAB27;

LAB47:    t54 = (t1 + 3485);
    t74 = xsi_mem_cmp(t54, t9, 4U);
    if (t74 == 1)
        goto LAB28;

LAB48:    t56 = (t1 + 3489);
    t75 = xsi_mem_cmp(t56, t9, 4U);
    if (t75 == 1)
        goto LAB29;

LAB49:    t64 = (t1 + 3493);
    t76 = xsi_mem_cmp(t64, t9, 4U);
    if (t76 == 1)
        goto LAB30;

LAB50:    t77 = (t1 + 3497);
    t79 = xsi_mem_cmp(t77, t9, 4U);
    if (t79 == 1)
        goto LAB31;

LAB51:    t80 = (t1 + 3501);
    t82 = xsi_mem_cmp(t80, t9, 4U);
    if (t82 == 1)
        goto LAB32;

LAB52:    t83 = (t1 + 3505);
    t85 = xsi_mem_cmp(t83, t9, 4U);
    if (t85 == 1)
        goto LAB33;

LAB53:
LAB34:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)63;

LAB14:
LAB12:    if (t40 == t49)
        goto LAB13;

LAB55:    t18 = (t40 + -1);
    t40 = t18;
    goto LAB10;

LAB15:    t86 = (t28 + 56U);
    t87 = *((char **)t86);
    t86 = (t7 + 56U);
    t88 = *((char **)t86);
    t89 = *((int *)t88);
    t90 = (t89 - t40);
    t86 = (t26 + 0U);
    t91 = *((int *)t86);
    t92 = (t26 + 8U);
    t93 = *((int *)t92);
    t94 = (t90 - t91);
    t19 = (t94 * t93);
    t95 = (t26 + 4U);
    t96 = *((int *)t95);
    xsi_vhdl_check_range_of_index(t91, t96, t93, t90);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t97 = (t87 + t43);
    *((unsigned char *)t97) = (unsigned char)48;
    goto LAB14;

LAB16:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)49;
    goto LAB14;

LAB17:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)50;
    goto LAB14;

LAB18:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)51;
    goto LAB14;

LAB19:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)52;
    goto LAB14;

LAB20:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)53;
    goto LAB14;

LAB21:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)54;
    goto LAB14;

LAB22:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)55;
    goto LAB14;

LAB23:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)56;
    goto LAB14;

LAB24:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)57;
    goto LAB14;

LAB25:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)65;
    goto LAB14;

LAB26:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)66;
    goto LAB14;

LAB27:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)67;
    goto LAB14;

LAB28:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)68;
    goto LAB14;

LAB29:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)69;
    goto LAB14;

LAB30:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)70;
    goto LAB14;

LAB31:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)122;
    goto LAB14;

LAB32:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)117;
    goto LAB14;

LAB33:    t8 = (t28 + 56U);
    t9 = *((char **)t8);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    t18 = *((int *)t11);
    t29 = (t18 - t40);
    t8 = (t26 + 0U);
    t61 = *((int *)t8);
    t12 = (t26 + 8U);
    t62 = *((int *)t12);
    t63 = (t29 - t61);
    t19 = (t63 * t62);
    t13 = (t26 + 4U);
    t66 = *((int *)t13);
    xsi_vhdl_check_range_of_index(t61, t66, t62, t29);
    t42 = (1U * t19);
    t43 = (0 + t42);
    t14 = (t9 + t43);
    *((unsigned char *)t14) = (unsigned char)120;
    goto LAB14;

LAB54:;
LAB56:;
}

unsigned char work_p_4054474977_sub_1218922380805091609_1800819092(char *t1, unsigned char t2)
{
    char t3[128];
    char t4[8];
    char t8[8];
    unsigned char t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    static char *nl0[] = {&&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB3, &&LAB4, &&LAB5, &&LAB6, &&LAB7, &&LAB8, &&LAB9, &&LAB10, &&LAB11, &&LAB12, &&LAB13, &&LAB14, &&LAB15, &&LAB16, &&LAB17, &&LAB18, &&LAB19, &&LAB20, &&LAB21, &&LAB22, &&LAB23, &&LAB24, &&LAB25, &&LAB26, &&LAB27, &&LAB28, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29};

LAB0:    t5 = (t3 + 4U);
    t6 = ((STD_STANDARD) + 192);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    xsi_type_set_default_value(t6, t8, 0);
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 1U;
    t11 = (t4 + 4U);
    *((unsigned char *)t11) = t2;
    t12 = (char *)((nl0) + t2);
    goto **((char **)t12);

LAB2:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t15 = *((unsigned char *)t7);
    t0 = t15;

LAB1:    return t0;
LAB3:    t13 = (t5 + 56U);
    t14 = *((char **)t13);
    t13 = (t14 + 0);
    *((unsigned char *)t13) = (unsigned char)65;
    goto LAB2;

LAB4:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)66;
    goto LAB2;

LAB5:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)67;
    goto LAB2;

LAB6:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)68;
    goto LAB2;

LAB7:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)69;
    goto LAB2;

LAB8:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)70;
    goto LAB2;

LAB9:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)71;
    goto LAB2;

LAB10:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)72;
    goto LAB2;

LAB11:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)73;
    goto LAB2;

LAB12:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)74;
    goto LAB2;

LAB13:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)75;
    goto LAB2;

LAB14:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)76;
    goto LAB2;

LAB15:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)77;
    goto LAB2;

LAB16:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)78;
    goto LAB2;

LAB17:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)79;
    goto LAB2;

LAB18:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)80;
    goto LAB2;

LAB19:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)81;
    goto LAB2;

LAB20:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)82;
    goto LAB2;

LAB21:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)83;
    goto LAB2;

LAB22:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)84;
    goto LAB2;

LAB23:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)85;
    goto LAB2;

LAB24:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)86;
    goto LAB2;

LAB25:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)87;
    goto LAB2;

LAB26:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)88;
    goto LAB2;

LAB27:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)89;
    goto LAB2;

LAB28:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)90;
    goto LAB2;

LAB29:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = t2;
    goto LAB2;

LAB30:;
}

unsigned char work_p_4054474977_sub_1218922369151045923_1800819092(char *t1, unsigned char t2)
{
    char t3[128];
    char t4[8];
    char t8[8];
    unsigned char t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    static char *nl0[] = {&&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB3, &&LAB4, &&LAB5, &&LAB6, &&LAB7, &&LAB8, &&LAB9, &&LAB10, &&LAB11, &&LAB12, &&LAB13, &&LAB14, &&LAB15, &&LAB16, &&LAB17, &&LAB18, &&LAB19, &&LAB20, &&LAB21, &&LAB22, &&LAB23, &&LAB24, &&LAB25, &&LAB26, &&LAB27, &&LAB28, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29, &&LAB29};

LAB0:    t5 = (t3 + 4U);
    t6 = ((STD_STANDARD) + 192);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    xsi_type_set_default_value(t6, t8, 0);
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 1U;
    t11 = (t4 + 4U);
    *((unsigned char *)t11) = t2;
    t12 = (char *)((nl0) + t2);
    goto **((char **)t12);

LAB2:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t15 = *((unsigned char *)t7);
    t0 = t15;

LAB1:    return t0;
LAB3:    t13 = (t5 + 56U);
    t14 = *((char **)t13);
    t13 = (t14 + 0);
    *((unsigned char *)t13) = (unsigned char)97;
    goto LAB2;

LAB4:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)98;
    goto LAB2;

LAB5:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)99;
    goto LAB2;

LAB6:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)100;
    goto LAB2;

LAB7:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)101;
    goto LAB2;

LAB8:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)102;
    goto LAB2;

LAB9:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)103;
    goto LAB2;

LAB10:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)104;
    goto LAB2;

LAB11:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)105;
    goto LAB2;

LAB12:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)106;
    goto LAB2;

LAB13:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)107;
    goto LAB2;

LAB14:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)108;
    goto LAB2;

LAB15:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)109;
    goto LAB2;

LAB16:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)110;
    goto LAB2;

LAB17:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)111;
    goto LAB2;

LAB18:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)112;
    goto LAB2;

LAB19:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)113;
    goto LAB2;

LAB20:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)114;
    goto LAB2;

LAB21:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)115;
    goto LAB2;

LAB22:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)116;
    goto LAB2;

LAB23:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)117;
    goto LAB2;

LAB24:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)118;
    goto LAB2;

LAB25:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)119;
    goto LAB2;

LAB26:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)120;
    goto LAB2;

LAB27:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)121;
    goto LAB2;

LAB28:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)122;
    goto LAB2;

LAB29:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = t2;
    goto LAB2;

LAB30:;
}

char *work_p_4054474977_sub_9066030637531271026_1800819092(char *t1, char *t2, char *t3, char *t4)
{
    char t5[144];
    char t6[24];
    char t9[16];
    char *t0;
    char *t7;
    unsigned int t8;
    char *t10;
    int t11;
    char *t12;
    int t13;
    char *t14;
    int t15;
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    int t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    unsigned char t37;
    char *t38;
    char *t39;
    int t40;
    char *t41;
    int t42;
    char *t43;
    int t44;
    int t45;
    int t46;
    int t47;
    int t48;
    char *t49;
    int t50;
    char *t51;
    int t52;
    int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    char *t57;
    unsigned char t58;
    unsigned char t59;
    char *t60;
    char *t61;
    int t62;
    char *t63;
    int t64;
    int t65;
    unsigned int t66;
    char *t67;
    int t68;
    unsigned int t69;
    unsigned int t70;
    char *t71;

LAB0:    t7 = (t4 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t10 = (t4 + 0U);
    t11 = *((int *)t10);
    t12 = (t4 + 4U);
    t13 = *((int *)t12);
    t14 = (t4 + 8U);
    t15 = *((int *)t14);
    t16 = (t9 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = t11;
    t17 = (t16 + 4U);
    *((int *)t17) = t13;
    t17 = (t16 + 8U);
    *((int *)t17) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t5 + 4U);
    t20 = ((STD_STANDARD) + 984);
    t21 = (t17 + 88U);
    *((char **)t21) = t20;
    t22 = xsi_get_memory(t8);
    t23 = (t17 + 56U);
    *((char **)t23) = t22;
    xsi_type_set_default_value(t20, t22, t9);
    t24 = (t17 + 64U);
    *((char **)t24) = t9;
    t25 = (t17 + 80U);
    *((unsigned int *)t25) = t8;
    t26 = (t17 + 128U);
    *((char **)t26) = t22;
    t27 = (t17 + 120U);
    *((int *)t27) = 0;
    t28 = (t17 + 124U);
    t29 = (t9 + 12U);
    t19 = *((unsigned int *)t29);
    t30 = (t19 - 1);
    *((int *)t28) = t30;
    t31 = (t17 + 116U);
    t33 = (t8 > 2147483644);
    if (t33 == 1)
        goto LAB2;

LAB3:    t34 = (t8 + 3);
    t35 = (t34 / 16);
    t32 = t35;

LAB4:    *((unsigned int *)t31) = t32;
    t36 = (t6 + 4U);
    t37 = (t3 != 0);
    if (t37 == 1)
        goto LAB6;

LAB5:    t38 = (t6 + 12U);
    *((char **)t38) = t4;
    t39 = (t4 + 8U);
    t40 = *((int *)t39);
    t41 = (t4 + 4U);
    t42 = *((int *)t41);
    t43 = (t4 + 0U);
    t44 = *((int *)t43);
    t45 = t44;
    t46 = t42;

LAB7:    t47 = (t46 * t40);
    t48 = (t45 * t40);
    if (t48 <= t47)
        goto LAB8;

LAB10:    t7 = (t17 + 56U);
    t10 = *((char **)t7);
    t7 = (t9 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t0 = xsi_get_transient_memory(t8);
    memcpy(t0, t10, t8);
    t12 = (t9 + 0U);
    t11 = *((int *)t12);
    t14 = (t9 + 4U);
    t13 = *((int *)t14);
    t16 = (t9 + 8U);
    t15 = *((int *)t16);
    t20 = (t2 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = t11;
    t21 = (t20 + 4U);
    *((int *)t21) = t13;
    t21 = (t20 + 8U);
    *((int *)t21) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t19;

LAB1:    t7 = (t17 + 80);
    t11 = *((int *)t7);
    t10 = (t17 + 128U);
    t12 = *((char **)t10);
    xsi_put_memory(t11, t12);
    return t0;
LAB2:    t32 = 2147483647;
    goto LAB4;

LAB6:    *((char **)t36) = t3;
    goto LAB5;

LAB8:    t49 = (t4 + 0U);
    t50 = *((int *)t49);
    t51 = (t4 + 8U);
    t52 = *((int *)t51);
    t53 = (t45 - t50);
    t54 = (t53 * t52);
    t55 = (1U * t54);
    t56 = (0 + t55);
    t57 = (t3 + t56);
    t58 = *((unsigned char *)t57);
    t59 = work_p_4054474977_sub_1218922380805091609_1800819092(t1, t58);
    t60 = (t17 + 56U);
    t61 = *((char **)t60);
    t60 = (t9 + 0U);
    t62 = *((int *)t60);
    t63 = (t9 + 8U);
    t64 = *((int *)t63);
    t65 = (t45 - t62);
    t66 = (t65 * t64);
    t67 = (t9 + 4U);
    t68 = *((int *)t67);
    xsi_vhdl_check_range_of_index(t62, t68, t64, t45);
    t69 = (1U * t66);
    t70 = (0 + t69);
    t71 = (t61 + t70);
    *((unsigned char *)t71) = t59;

LAB9:    if (t45 == t46)
        goto LAB10;

LAB11:    t11 = (t45 + t40);
    t45 = t11;
    goto LAB7;

LAB12:;
}

char *work_p_4054474977_sub_9066004450162279423_1800819092(char *t1, char *t2, char *t3, char *t4)
{
    char t5[144];
    char t6[24];
    char t9[16];
    char *t0;
    char *t7;
    unsigned int t8;
    char *t10;
    int t11;
    char *t12;
    int t13;
    char *t14;
    int t15;
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    int t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    unsigned char t37;
    char *t38;
    char *t39;
    int t40;
    char *t41;
    int t42;
    char *t43;
    int t44;
    int t45;
    int t46;
    int t47;
    int t48;
    char *t49;
    int t50;
    char *t51;
    int t52;
    int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    char *t57;
    unsigned char t58;
    unsigned char t59;
    char *t60;
    char *t61;
    int t62;
    char *t63;
    int t64;
    int t65;
    unsigned int t66;
    char *t67;
    int t68;
    unsigned int t69;
    unsigned int t70;
    char *t71;

LAB0:    t7 = (t4 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t10 = (t4 + 0U);
    t11 = *((int *)t10);
    t12 = (t4 + 4U);
    t13 = *((int *)t12);
    t14 = (t4 + 8U);
    t15 = *((int *)t14);
    t16 = (t9 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = t11;
    t17 = (t16 + 4U);
    *((int *)t17) = t13;
    t17 = (t16 + 8U);
    *((int *)t17) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t5 + 4U);
    t20 = ((STD_STANDARD) + 984);
    t21 = (t17 + 88U);
    *((char **)t21) = t20;
    t22 = xsi_get_memory(t8);
    t23 = (t17 + 56U);
    *((char **)t23) = t22;
    xsi_type_set_default_value(t20, t22, t9);
    t24 = (t17 + 64U);
    *((char **)t24) = t9;
    t25 = (t17 + 80U);
    *((unsigned int *)t25) = t8;
    t26 = (t17 + 128U);
    *((char **)t26) = t22;
    t27 = (t17 + 120U);
    *((int *)t27) = 0;
    t28 = (t17 + 124U);
    t29 = (t9 + 12U);
    t19 = *((unsigned int *)t29);
    t30 = (t19 - 1);
    *((int *)t28) = t30;
    t31 = (t17 + 116U);
    t33 = (t8 > 2147483644);
    if (t33 == 1)
        goto LAB2;

LAB3:    t34 = (t8 + 3);
    t35 = (t34 / 16);
    t32 = t35;

LAB4:    *((unsigned int *)t31) = t32;
    t36 = (t6 + 4U);
    t37 = (t3 != 0);
    if (t37 == 1)
        goto LAB6;

LAB5:    t38 = (t6 + 12U);
    *((char **)t38) = t4;
    t39 = (t4 + 8U);
    t40 = *((int *)t39);
    t41 = (t4 + 4U);
    t42 = *((int *)t41);
    t43 = (t4 + 0U);
    t44 = *((int *)t43);
    t45 = t44;
    t46 = t42;

LAB7:    t47 = (t46 * t40);
    t48 = (t45 * t40);
    if (t48 <= t47)
        goto LAB8;

LAB10:    t7 = (t17 + 56U);
    t10 = *((char **)t7);
    t7 = (t9 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t0 = xsi_get_transient_memory(t8);
    memcpy(t0, t10, t8);
    t12 = (t9 + 0U);
    t11 = *((int *)t12);
    t14 = (t9 + 4U);
    t13 = *((int *)t14);
    t16 = (t9 + 8U);
    t15 = *((int *)t16);
    t20 = (t2 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = t11;
    t21 = (t20 + 4U);
    *((int *)t21) = t13;
    t21 = (t20 + 8U);
    *((int *)t21) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t19;

LAB1:    t7 = (t17 + 80);
    t11 = *((int *)t7);
    t10 = (t17 + 128U);
    t12 = *((char **)t10);
    xsi_put_memory(t11, t12);
    return t0;
LAB2:    t32 = 2147483647;
    goto LAB4;

LAB6:    *((char **)t36) = t3;
    goto LAB5;

LAB8:    t49 = (t4 + 0U);
    t50 = *((int *)t49);
    t51 = (t4 + 8U);
    t52 = *((int *)t51);
    t53 = (t45 - t50);
    t54 = (t53 * t52);
    t55 = (1U * t54);
    t56 = (0 + t55);
    t57 = (t3 + t56);
    t58 = *((unsigned char *)t57);
    t59 = work_p_4054474977_sub_1218922369151045923_1800819092(t1, t58);
    t60 = (t17 + 56U);
    t61 = *((char **)t60);
    t60 = (t9 + 0U);
    t62 = *((int *)t60);
    t63 = (t9 + 8U);
    t64 = *((int *)t63);
    t65 = (t45 - t62);
    t66 = (t65 * t64);
    t67 = (t9 + 4U);
    t68 = *((int *)t67);
    xsi_vhdl_check_range_of_index(t62, t68, t64, t45);
    t69 = (1U * t66);
    t70 = (0 + t69);
    t71 = (t61 + t70);
    *((unsigned char *)t71) = t59;

LAB9:    if (t45 == t46)
        goto LAB10;

LAB11:    t11 = (t45 + t40);
    t45 = t11;
    goto LAB7;

LAB12:;
}

unsigned char work_p_4054474977_sub_9666642923616660399_1800819092(char *t1, unsigned char t2)
{
    char t4[8];
    unsigned char t0;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    unsigned char t8;

LAB0:    t5 = (t4 + 4U);
    *((unsigned char *)t5) = t2;
    t7 = (t2 == (unsigned char)32);
    if (t7 == 1)
        goto LAB5;

LAB6:    t8 = (t2 == (unsigned char)9);
    t6 = t8;

LAB7:    if (t6 != 0)
        goto LAB2;

LAB4:    t0 = (unsigned char)0;

LAB1:    return t0;
LAB2:    t0 = (unsigned char)1;
    goto LAB1;

LAB3:    xsi_error(ng4);
    t0 = 0;
    goto LAB1;

LAB5:    t6 = (unsigned char)1;
    goto LAB7;

LAB8:    goto LAB3;

LAB9:    goto LAB3;

}

char *work_p_4054474977_sub_10753423040196883069_1800819092(char *t1, char *t2, char *t3, char *t4)
{
    char t5[384];
    char t6[24];
    char t9[16];
    char t39[8];
    char t45[8];
    char *t0;
    char *t7;
    unsigned int t8;
    char *t10;
    int t11;
    char *t12;
    int t13;
    char *t14;
    int t15;
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    int t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t46;
    char *t47;
    char *t48;
    unsigned char t49;
    char *t50;
    char *t51;
    int t52;
    char *t53;
    int t54;
    char *t55;
    int t56;
    int t57;
    int t58;
    int t59;
    int t60;
    char *t61;
    char *t62;
    int t63;
    char *t64;
    int t65;
    int t66;
    unsigned int t67;
    char *t68;
    int t69;
    unsigned int t70;
    unsigned int t71;
    char *t72;
    unsigned char t73;

LAB0:    t7 = (t4 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t10 = (t4 + 0U);
    t11 = *((int *)t10);
    t12 = (t4 + 4U);
    t13 = *((int *)t12);
    t14 = (t4 + 8U);
    t15 = *((int *)t14);
    t16 = (t9 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = t11;
    t17 = (t16 + 4U);
    *((int *)t17) = t13;
    t17 = (t16 + 8U);
    *((int *)t17) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t5 + 4U);
    t20 = ((STD_STANDARD) + 984);
    t21 = (t17 + 88U);
    *((char **)t21) = t20;
    t22 = xsi_get_memory(t8);
    t23 = (t17 + 56U);
    *((char **)t23) = t22;
    xsi_type_set_default_value(t20, t22, t9);
    t24 = (t17 + 64U);
    *((char **)t24) = t9;
    t25 = (t17 + 80U);
    *((unsigned int *)t25) = t8;
    t26 = (t17 + 128U);
    *((char **)t26) = t22;
    t27 = (t17 + 120U);
    *((int *)t27) = 0;
    t28 = (t17 + 124U);
    t29 = (t9 + 12U);
    t19 = *((unsigned int *)t29);
    t30 = (t19 - 1);
    *((int *)t28) = t30;
    t31 = (t17 + 116U);
    t33 = (t8 > 2147483644);
    if (t33 == 1)
        goto LAB2;

LAB3:    t34 = (t8 + 3);
    t35 = (t34 / 16);
    t32 = t35;

LAB4:    *((unsigned int *)t31) = t32;
    t36 = (t5 + 140U);
    t37 = ((STD_STANDARD) + 904);
    t38 = (t36 + 88U);
    *((char **)t38) = t37;
    t40 = (t36 + 56U);
    *((char **)t40) = t39;
    *((int *)t39) = 1;
    t41 = (t36 + 80U);
    *((unsigned int *)t41) = 4U;
    t42 = (t5 + 260U);
    t43 = ((STD_STANDARD) + 904);
    t44 = (t42 + 88U);
    *((char **)t44) = t43;
    t46 = (t42 + 56U);
    *((char **)t46) = t45;
    *((int *)t45) = 1;
    t47 = (t42 + 80U);
    *((unsigned int *)t47) = 4U;
    t48 = (t6 + 4U);
    t49 = (t3 != 0);
    if (t49 == 1)
        goto LAB6;

LAB5:    t50 = (t6 + 12U);
    *((char **)t50) = t4;
    t51 = (t4 + 8U);
    t52 = *((int *)t51);
    t53 = (t4 + 4U);
    t54 = *((int *)t53);
    t55 = (t4 + 0U);
    t56 = *((int *)t55);
    t57 = t56;
    t58 = t54;

LAB7:    t59 = (t58 * t52);
    t60 = (t57 * t52);
    if (t60 <= t59)
        goto LAB8;

LAB10:    t7 = (t4 + 8U);
    t11 = *((int *)t7);
    t10 = (t4 + 4U);
    t13 = *((int *)t10);
    t12 = (t4 + 0U);
    t15 = *((int *)t12);
    t18 = t15;
    t30 = t13;

LAB12:    t52 = (t30 * t11);
    t54 = (t18 * t11);
    if (t54 <= t52)
        goto LAB13;

LAB15:    t7 = (t4 + 12U);
    t8 = *((unsigned int *)t7);
    t10 = (t36 + 56U);
    t12 = *((char **)t10);
    t11 = *((int *)t12);
    t13 = t11;
    t15 = t8;

LAB21:    if (t13 <= t15)
        goto LAB22;

LAB24:    t7 = (t17 + 56U);
    t10 = *((char **)t7);
    t7 = (t9 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t0 = xsi_get_transient_memory(t8);
    memcpy(t0, t10, t8);
    t12 = (t9 + 0U);
    t11 = *((int *)t12);
    t14 = (t9 + 4U);
    t13 = *((int *)t14);
    t16 = (t9 + 8U);
    t15 = *((int *)t16);
    t20 = (t2 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = t11;
    t21 = (t20 + 4U);
    *((int *)t21) = t13;
    t21 = (t20 + 8U);
    *((int *)t21) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t19;

LAB1:    t7 = (t17 + 80);
    t11 = *((int *)t7);
    t10 = (t17 + 128U);
    t12 = *((char **)t10);
    xsi_put_memory(t11, t12);
    return t0;
LAB2:    t32 = 2147483647;
    goto LAB4;

LAB6:    *((char **)t48) = t3;
    goto LAB5;

LAB8:    t61 = (t17 + 56U);
    t62 = *((char **)t61);
    t61 = (t9 + 0U);
    t63 = *((int *)t61);
    t64 = (t9 + 8U);
    t65 = *((int *)t64);
    t66 = (t57 - t63);
    t67 = (t66 * t65);
    t68 = (t9 + 4U);
    t69 = *((int *)t68);
    xsi_vhdl_check_range_of_index(t63, t69, t65, t57);
    t70 = (1U * t67);
    t71 = (0 + t70);
    t72 = (t62 + t71);
    *((unsigned char *)t72) = (unsigned char)32;

LAB9:    if (t57 == t58)
        goto LAB10;

LAB11:    t11 = (t57 + t52);
    t57 = t11;
    goto LAB7;

LAB13:    t14 = (t4 + 0U);
    t56 = *((int *)t14);
    t16 = (t4 + 8U);
    t57 = *((int *)t16);
    t58 = (t18 - t56);
    t8 = (t58 * t57);
    t19 = (1U * t8);
    t32 = (0 + t19);
    t20 = (t3 + t32);
    t49 = *((unsigned char *)t20);
    t73 = work_p_4054474977_sub_9666642923616660399_1800819092(t1, t49);
    if (t73 != 0)
        goto LAB16;

LAB18:    goto LAB15;

LAB14:    if (t18 == t30)
        goto LAB15;

LAB20:    t13 = (t18 + t11);
    t18 = t13;
    goto LAB12;

LAB16:    t21 = (t36 + 56U);
    t22 = *((char **)t21);
    t59 = *((int *)t22);
    t60 = (t59 + 1);
    t21 = (t36 + 56U);
    t23 = *((char **)t21);
    t21 = (t23 + 0);
    *((int *)t21) = t60;

LAB17:    goto LAB14;

LAB19:    goto LAB17;

LAB22:    t10 = (t4 + 0U);
    t18 = *((int *)t10);
    t14 = (t4 + 8U);
    t30 = *((int *)t14);
    t52 = (t13 - t18);
    t19 = (t52 * t30);
    t16 = (t4 + 4U);
    t54 = *((int *)t16);
    xsi_vhdl_check_range_of_index(t18, t54, t30, t13);
    t32 = (1U * t19);
    t33 = (0 + t32);
    t20 = (t3 + t33);
    t49 = *((unsigned char *)t20);
    t21 = (t17 + 56U);
    t22 = *((char **)t21);
    t21 = (t42 + 56U);
    t23 = *((char **)t21);
    t56 = *((int *)t23);
    t21 = (t9 + 0U);
    t57 = *((int *)t21);
    t24 = (t9 + 8U);
    t58 = *((int *)t24);
    t59 = (t56 - t57);
    t34 = (t59 * t58);
    t25 = (t9 + 4U);
    t60 = *((int *)t25);
    xsi_vhdl_check_range_of_index(t57, t60, t58, t56);
    t35 = (1U * t34);
    t67 = (0 + t35);
    t26 = (t22 + t67);
    *((unsigned char *)t26) = t49;
    t7 = (t42 + 56U);
    t10 = *((char **)t7);
    t11 = *((int *)t10);
    t18 = (t11 + 1);
    t7 = (t42 + 56U);
    t12 = *((char **)t7);
    t7 = (t12 + 0);
    *((int *)t7) = t18;

LAB23:    if (t13 == t15)
        goto LAB24;

LAB25:    t11 = (t13 + 1);
    t13 = t11;
    goto LAB21;

LAB26:;
}

char *work_p_4054474977_sub_9172743049448807586_1800819092(char *t1, char *t2, char *t3, char *t4)
{
    char t5[280];
    char t6[24];
    char t9[16];
    char t79[16];
    char *t0;
    char *t7;
    unsigned int t8;
    char *t10;
    int t11;
    char *t12;
    int t13;
    char *t14;
    int t15;
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    int t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    unsigned int t47;
    int t48;
    char *t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    char *t54;
    unsigned char t55;
    char *t56;
    char *t57;
    int t58;
    char *t59;
    int t60;
    char *t61;
    int t62;
    int t63;
    int t64;
    int t65;
    int t66;
    char *t67;
    char *t68;
    int t69;
    char *t70;
    int t71;
    int t72;
    unsigned int t73;
    char *t74;
    int t75;
    unsigned int t76;
    unsigned int t77;
    char *t78;
    unsigned char t80;
    unsigned char t81;
    unsigned char t82;

LAB0:    t7 = (t4 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t10 = (t4 + 0U);
    t11 = *((int *)t10);
    t12 = (t4 + 4U);
    t13 = *((int *)t12);
    t14 = (t4 + 8U);
    t15 = *((int *)t14);
    t16 = (t9 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = t11;
    t17 = (t16 + 4U);
    *((int *)t17) = t13;
    t17 = (t16 + 8U);
    *((int *)t17) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t5 + 4U);
    t20 = ((STD_STANDARD) + 984);
    t21 = (t17 + 88U);
    *((char **)t21) = t20;
    t22 = xsi_get_memory(t8);
    t23 = (t17 + 56U);
    *((char **)t23) = t22;
    xsi_type_set_default_value(t20, t22, t9);
    t24 = (t17 + 64U);
    *((char **)t24) = t9;
    t25 = (t17 + 80U);
    *((unsigned int *)t25) = t8;
    t26 = (t17 + 128U);
    *((char **)t26) = t22;
    t27 = (t17 + 120U);
    *((int *)t27) = 0;
    t28 = (t17 + 124U);
    t29 = (t9 + 12U);
    t19 = *((unsigned int *)t29);
    t30 = (t19 - 1);
    *((int *)t28) = t30;
    t31 = (t17 + 116U);
    t33 = (t8 > 2147483644);
    if (t33 == 1)
        goto LAB2;

LAB3:    t34 = (t8 + 3);
    t35 = (t34 / 16);
    t32 = t35;

LAB4:    *((unsigned int *)t31) = t32;
    t36 = (t5 + 140U);
    t37 = ((STD_STANDARD) + 984);
    t38 = (t36 + 88U);
    *((char **)t38) = t37;
    t39 = xsi_get_memory(t8);
    t40 = (t36 + 56U);
    *((char **)t40) = t39;
    xsi_type_set_default_value(t37, t39, t9);
    t41 = (t36 + 64U);
    *((char **)t41) = t9;
    t42 = (t36 + 80U);
    *((unsigned int *)t42) = t8;
    t43 = (t36 + 128U);
    *((char **)t43) = t39;
    t44 = (t36 + 120U);
    *((int *)t44) = 0;
    t45 = (t36 + 124U);
    t46 = (t9 + 12U);
    t47 = *((unsigned int *)t46);
    t48 = (t47 - 1);
    *((int *)t45) = t48;
    t49 = (t36 + 116U);
    t51 = (t8 > 2147483644);
    if (t51 == 1)
        goto LAB5;

LAB6:    t52 = (t8 + 3);
    t53 = (t52 / 16);
    t50 = t53;

LAB7:    *((unsigned int *)t49) = t50;
    t54 = (t6 + 4U);
    t55 = (t3 != 0);
    if (t55 == 1)
        goto LAB9;

LAB8:    t56 = (t6 + 12U);
    *((char **)t56) = t4;
    t57 = (t4 + 8U);
    t58 = *((int *)t57);
    t59 = (t4 + 4U);
    t60 = *((int *)t59);
    t61 = (t4 + 0U);
    t62 = *((int *)t61);
    t63 = t62;
    t64 = t60;

LAB10:    t65 = (t64 * t58);
    t66 = (t63 * t58);
    if (t66 <= t65)
        goto LAB11;

LAB13:    t7 = work_p_4054474977_sub_10753423040196883069_1800819092(t1, t79, t3, t4);
    t10 = (t17 + 56U);
    t12 = *((char **)t10);
    t10 = (t12 + 0);
    t14 = (t79 + 12U);
    t8 = *((unsigned int *)t14);
    t8 = (t8 * 1U);
    memcpy(t10, t7, t8);
    t7 = (t9 + 8U);
    t11 = *((int *)t7);
    t10 = (t9 + 4U);
    t13 = *((int *)t10);
    t12 = (t9 + 0U);
    t15 = *((int *)t12);
    t18 = t15;
    t30 = t13;

LAB15:    t48 = (t30 * t11);
    t58 = (t18 * t11);
    if (t58 <= t48)
        goto LAB16;

LAB18:    t7 = (t36 + 56U);
    t10 = *((char **)t7);
    t7 = (t9 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t0 = xsi_get_transient_memory(t8);
    memcpy(t0, t10, t8);
    t12 = (t9 + 0U);
    t11 = *((int *)t12);
    t14 = (t9 + 4U);
    t13 = *((int *)t14);
    t16 = (t9 + 8U);
    t15 = *((int *)t16);
    t20 = (t2 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = t11;
    t21 = (t20 + 4U);
    *((int *)t21) = t13;
    t21 = (t20 + 8U);
    *((int *)t21) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t19;

LAB1:    t7 = (t17 + 80);
    t11 = *((int *)t7);
    t10 = (t17 + 128U);
    t12 = *((char **)t10);
    xsi_put_memory(t11, t12);
    t14 = (t36 + 80);
    t13 = *((int *)t14);
    t16 = (t36 + 128U);
    t20 = *((char **)t16);
    xsi_put_memory(t13, t20);
    return t0;
LAB2:    t32 = 2147483647;
    goto LAB4;

LAB5:    t50 = 2147483647;
    goto LAB7;

LAB9:    *((char **)t54) = t3;
    goto LAB8;

LAB11:    t67 = (t36 + 56U);
    t68 = *((char **)t67);
    t67 = (t9 + 0U);
    t69 = *((int *)t67);
    t70 = (t9 + 8U);
    t71 = *((int *)t70);
    t72 = (t63 - t69);
    t73 = (t72 * t71);
    t74 = (t9 + 4U);
    t75 = *((int *)t74);
    xsi_vhdl_check_range_of_index(t69, t75, t71, t63);
    t76 = (1U * t73);
    t77 = (0 + t76);
    t78 = (t68 + t77);
    *((unsigned char *)t78) = (unsigned char)32;

LAB12:    if (t63 == t64)
        goto LAB13;

LAB14:    t11 = (t63 + t58);
    t63 = t11;
    goto LAB10;

LAB16:    t14 = (t17 + 56U);
    t16 = *((char **)t14);
    t14 = (t9 + 0U);
    t60 = *((int *)t14);
    t20 = (t9 + 8U);
    t62 = *((int *)t20);
    t63 = (t18 - t60);
    t8 = (t63 * t62);
    t19 = (1U * t8);
    t32 = (0 + t19);
    t21 = (t16 + t32);
    t55 = *((unsigned char *)t21);
    t80 = work_p_4054474977_sub_9666642923616660399_1800819092(t1, t55);
    t81 = (!(t80));
    if (t81 != 0)
        goto LAB19;

LAB21:    goto LAB18;

LAB17:    if (t18 == t30)
        goto LAB18;

LAB23:    t13 = (t18 + t11);
    t18 = t13;
    goto LAB15;

LAB19:    t22 = (t17 + 56U);
    t23 = *((char **)t22);
    t22 = (t9 + 0U);
    t64 = *((int *)t22);
    t24 = (t9 + 8U);
    t65 = *((int *)t24);
    t66 = (t18 - t64);
    t33 = (t66 * t65);
    t34 = (1U * t33);
    t35 = (0 + t34);
    t25 = (t23 + t35);
    t82 = *((unsigned char *)t25);
    t26 = (t36 + 56U);
    t27 = *((char **)t26);
    t26 = (t9 + 0U);
    t69 = *((int *)t26);
    t28 = (t9 + 8U);
    t71 = *((int *)t28);
    t72 = (t18 - t69);
    t47 = (t72 * t71);
    t29 = (t9 + 4U);
    t75 = *((int *)t29);
    xsi_vhdl_check_range_of_index(t69, t75, t71, t18);
    t50 = (1U * t47);
    t51 = (0 + t50);
    t31 = (t27 + t51);
    *((unsigned char *)t31) = t82;

LAB20:    goto LAB17;

LAB22:    goto LAB20;

LAB24:;
}

void work_p_4054474977_sub_1368629771300680975_1800819092(char *t0, char *t1, char *t2, char *t3, char *t4, char *t5)
{
    char t6[520];
    char t7[40];
    char t10[16];
    char t58[8];
    char t64[8];
    char t93[16];
    char *t8;
    unsigned int t9;
    char *t11;
    int t12;
    char *t13;
    int t14;
    char *t15;
    int t16;
    char *t17;
    char *t18;
    int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    int t31;
    char *t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    unsigned int t48;
    int t49;
    char *t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    char *t55;
    char *t56;
    char *t57;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    int t72;
    char *t73;
    int t74;
    char *t75;
    int t76;
    int t77;
    int t78;
    int t79;
    int t80;
    char *t81;
    char *t82;
    int t83;
    char *t84;
    int t85;
    int t86;
    unsigned int t87;
    char *t88;
    int t89;
    unsigned int t90;
    unsigned int t91;
    char *t92;
    unsigned char t94;
    unsigned char t95;
    unsigned char t96;

LAB0:    t8 = (t3 + 12U);
    t9 = *((unsigned int *)t8);
    t9 = (t9 * 1U);
    t11 = (t3 + 0U);
    t12 = *((int *)t11);
    t13 = (t3 + 4U);
    t14 = *((int *)t13);
    t15 = (t3 + 8U);
    t16 = *((int *)t15);
    t17 = (t10 + 0U);
    t18 = (t17 + 0U);
    *((int *)t18) = t12;
    t18 = (t17 + 4U);
    *((int *)t18) = t14;
    t18 = (t17 + 8U);
    *((int *)t18) = t16;
    t19 = (t14 - t12);
    t20 = (t19 * t16);
    t20 = (t20 + 1);
    t18 = (t17 + 12U);
    *((unsigned int *)t18) = t20;
    t18 = (t6 + 4U);
    t21 = ((STD_STANDARD) + 984);
    t22 = (t18 + 88U);
    *((char **)t22) = t21;
    t23 = xsi_get_memory(t9);
    t24 = (t18 + 56U);
    *((char **)t24) = t23;
    xsi_type_set_default_value(t21, t23, t10);
    t25 = (t18 + 64U);
    *((char **)t25) = t10;
    t26 = (t18 + 80U);
    *((unsigned int *)t26) = t9;
    t27 = (t18 + 128U);
    *((char **)t27) = t23;
    t28 = (t18 + 120U);
    *((int *)t28) = 0;
    t29 = (t18 + 124U);
    t30 = (t10 + 12U);
    t20 = *((unsigned int *)t30);
    t31 = (t20 - 1);
    *((int *)t29) = t31;
    t32 = (t18 + 116U);
    t34 = (t9 > 2147483644);
    if (t34 == 1)
        goto LAB2;

LAB3:    t35 = (t9 + 3);
    t36 = (t35 / 16);
    t33 = t36;

LAB4:    *((unsigned int *)t32) = t33;
    t37 = (t6 + 140U);
    t38 = ((STD_STANDARD) + 984);
    t39 = (t37 + 88U);
    *((char **)t39) = t38;
    t40 = xsi_get_memory(t9);
    t41 = (t37 + 56U);
    *((char **)t41) = t40;
    xsi_type_set_default_value(t38, t40, t10);
    t42 = (t37 + 64U);
    *((char **)t42) = t10;
    t43 = (t37 + 80U);
    *((unsigned int *)t43) = t9;
    t44 = (t37 + 128U);
    *((char **)t44) = t40;
    t45 = (t37 + 120U);
    *((int *)t45) = 0;
    t46 = (t37 + 124U);
    t47 = (t10 + 12U);
    t48 = *((unsigned int *)t47);
    t49 = (t48 - 1);
    *((int *)t46) = t49;
    t50 = (t37 + 116U);
    t52 = (t9 > 2147483644);
    if (t52 == 1)
        goto LAB5;

LAB6:    t53 = (t9 + 3);
    t54 = (t53 / 16);
    t51 = t54;

LAB7:    *((unsigned int *)t50) = t51;
    t55 = (t6 + 276U);
    t56 = ((STD_STANDARD) + 904);
    t57 = (t55 + 88U);
    *((char **)t57) = t56;
    t59 = (t55 + 56U);
    *((char **)t59) = t58;
    *((int *)t58) = 1;
    t60 = (t55 + 80U);
    *((unsigned int *)t60) = 4U;
    t61 = (t6 + 396U);
    t62 = ((STD_STANDARD) + 904);
    t63 = (t61 + 88U);
    *((char **)t63) = t62;
    t65 = (t61 + 56U);
    *((char **)t65) = t64;
    *((int *)t64) = 1;
    t66 = (t61 + 80U);
    *((unsigned int *)t66) = 4U;
    t67 = (t7 + 4U);
    *((char **)t67) = t2;
    t68 = (t7 + 12U);
    *((char **)t68) = t3;
    t69 = (t7 + 20U);
    *((char **)t69) = t4;
    t70 = (t7 + 28U);
    *((char **)t70) = t5;
    t71 = (t3 + 8U);
    t72 = *((int *)t71);
    t73 = (t3 + 4U);
    t74 = *((int *)t73);
    t75 = (t3 + 0U);
    t76 = *((int *)t75);
    t77 = t76;
    t78 = t74;

LAB8:    t79 = (t78 * t72);
    t80 = (t77 * t72);
    if (t80 <= t79)
        goto LAB9;

LAB11:    t8 = work_p_4054474977_sub_10753423040196883069_1800819092(t0, t93, t2, t3);
    t11 = (t18 + 56U);
    t13 = *((char **)t11);
    t11 = (t13 + 0);
    t15 = (t93 + 12U);
    t9 = *((unsigned int *)t15);
    t9 = (t9 * 1U);
    memcpy(t11, t8, t9);
    t8 = (t18 + 56U);
    t11 = *((char **)t8);
    t8 = work_p_4054474977_sub_9172743049448807586_1800819092(t0, t93, t11, t10);
    t13 = (t4 + 0);
    t15 = (t93 + 12U);
    t9 = *((unsigned int *)t15);
    t9 = (t9 * 1U);
    memcpy(t13, t8, t9);
    t8 = (t10 + 8U);
    t12 = *((int *)t8);
    t11 = (t10 + 4U);
    t14 = *((int *)t11);
    t13 = (t10 + 0U);
    t16 = *((int *)t13);
    t19 = t16;
    t31 = t14;

LAB13:    t49 = (t31 * t12);
    t72 = (t19 * t12);
    if (t72 <= t49)
        goto LAB14;

LAB16:    t8 = (t10 + 12U);
    t9 = *((unsigned int *)t8);
    t11 = (t55 + 56U);
    t13 = *((char **)t11);
    t12 = *((int *)t13);
    t14 = t12;
    t16 = t9;

LAB22:    if (t14 <= t16)
        goto LAB23;

LAB25:    t8 = (t37 + 56U);
    t11 = *((char **)t8);
    t8 = (t2 + 0);
    t13 = (t10 + 12U);
    t9 = *((unsigned int *)t13);
    t9 = (t9 * 1U);
    memcpy(t8, t11, t9);

LAB1:    t8 = (t18 + 80);
    t12 = *((int *)t8);
    t11 = (t18 + 128U);
    t13 = *((char **)t11);
    xsi_put_memory(t12, t13);
    t15 = (t37 + 80);
    t14 = *((int *)t15);
    t17 = (t37 + 128U);
    t21 = *((char **)t17);
    xsi_put_memory(t14, t21);
    return;
LAB2:    t33 = 2147483647;
    goto LAB4;

LAB5:    t51 = 2147483647;
    goto LAB7;

LAB9:    t81 = (t18 + 56U);
    t82 = *((char **)t81);
    t81 = (t10 + 0U);
    t83 = *((int *)t81);
    t84 = (t10 + 8U);
    t85 = *((int *)t84);
    t86 = (t77 - t83);
    t87 = (t86 * t85);
    t88 = (t10 + 4U);
    t89 = *((int *)t88);
    xsi_vhdl_check_range_of_index(t83, t89, t85, t77);
    t90 = (1U * t87);
    t91 = (0 + t90);
    t92 = (t82 + t91);
    *((unsigned char *)t92) = (unsigned char)32;
    t8 = (t37 + 56U);
    t11 = *((char **)t8);
    t8 = (t10 + 0U);
    t12 = *((int *)t8);
    t13 = (t10 + 8U);
    t14 = *((int *)t13);
    t16 = (t77 - t12);
    t9 = (t16 * t14);
    t15 = (t10 + 4U);
    t19 = *((int *)t15);
    xsi_vhdl_check_range_of_index(t12, t19, t14, t77);
    t20 = (1U * t9);
    t33 = (0 + t20);
    t17 = (t11 + t33);
    *((unsigned char *)t17) = (unsigned char)32;

LAB10:    if (t77 == t78)
        goto LAB11;

LAB12:    t12 = (t77 + t72);
    t77 = t12;
    goto LAB8;

LAB14:    t15 = (t18 + 56U);
    t17 = *((char **)t15);
    t15 = (t10 + 0U);
    t74 = *((int *)t15);
    t21 = (t10 + 8U);
    t76 = *((int *)t21);
    t77 = (t19 - t74);
    t9 = (t77 * t76);
    t20 = (1U * t9);
    t33 = (0 + t20);
    t22 = (t17 + t33);
    t94 = *((unsigned char *)t22);
    t95 = work_p_4054474977_sub_9666642923616660399_1800819092(t0, t94);
    t96 = (!(t95));
    if (t96 != 0)
        goto LAB17;

LAB19:    goto LAB16;

LAB15:    if (t19 == t31)
        goto LAB16;

LAB21:    t14 = (t19 + t12);
    t19 = t14;
    goto LAB13;

LAB17:    t23 = (t55 + 56U);
    t24 = *((char **)t23);
    t78 = *((int *)t24);
    t79 = (t78 + 1);
    t23 = (t55 + 56U);
    t25 = *((char **)t23);
    t23 = (t25 + 0);
    *((int *)t23) = t79;

LAB18:    goto LAB15;

LAB20:    goto LAB18;

LAB23:    t11 = (t18 + 56U);
    t15 = *((char **)t11);
    t11 = (t10 + 0U);
    t19 = *((int *)t11);
    t17 = (t10 + 8U);
    t31 = *((int *)t17);
    t49 = (t14 - t19);
    t20 = (t49 * t31);
    t21 = (t10 + 4U);
    t72 = *((int *)t21);
    xsi_vhdl_check_range_of_index(t19, t72, t31, t14);
    t33 = (1U * t20);
    t34 = (0 + t33);
    t22 = (t15 + t34);
    t94 = *((unsigned char *)t22);
    t23 = (t37 + 56U);
    t24 = *((char **)t23);
    t23 = (t61 + 56U);
    t25 = *((char **)t23);
    t74 = *((int *)t25);
    t23 = (t10 + 0U);
    t76 = *((int *)t23);
    t26 = (t10 + 8U);
    t77 = *((int *)t26);
    t78 = (t74 - t76);
    t35 = (t78 * t77);
    t27 = (t10 + 4U);
    t79 = *((int *)t27);
    xsi_vhdl_check_range_of_index(t76, t79, t77, t74);
    t36 = (1U * t35);
    t48 = (0 + t36);
    t28 = (t24 + t48);
    *((unsigned char *)t28) = t94;
    t8 = (t61 + 56U);
    t11 = *((char **)t8);
    t12 = *((int *)t11);
    t19 = (t12 + 1);
    t8 = (t61 + 56U);
    t13 = *((char **)t8);
    t8 = (t13 + 0);
    *((int *)t8) = t19;

LAB24:    if (t14 == t16)
        goto LAB25;

LAB26:    t12 = (t14 + 1);
    t14 = t12;
    goto LAB22;

}

unsigned char work_p_4054474977_sub_6205399195240504445_1800819092(char *t1, unsigned char t2)
{
    char t3[128];
    char t4[8];
    char t8[8];
    unsigned char t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    static char *nl0[] = {&&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB11, &&LAB12, &&LAB12, &&LAB5, &&LAB6, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB10, &&LAB12, &&LAB12, &&LAB12, &&LAB9, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB3, &&LAB12, &&LAB8, &&LAB4, &&LAB12, &&LAB7, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12, &&LAB12};

LAB0:    t5 = (t3 + 4U);
    t6 = ((IEEE_P_2592010699) + 3312);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    xsi_type_set_default_value(t6, t8, 0);
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 1U;
    t11 = (t4 + 4U);
    *((unsigned char *)t11) = t2;
    t12 = (char *)((nl0) + t2);
    goto **((char **)t12);

LAB2:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t15 = *((unsigned char *)t7);
    t0 = t15;

LAB1:    return t0;
LAB3:    t13 = (t5 + 56U);
    t14 = *((char **)t13);
    t13 = (t14 + 0);
    *((unsigned char *)t13) = (unsigned char)0;
    goto LAB2;

LAB4:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)1;
    goto LAB2;

LAB5:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)2;
    goto LAB2;

LAB6:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)3;
    goto LAB2;

LAB7:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)4;
    goto LAB2;

LAB8:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)5;
    goto LAB2;

LAB9:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)6;
    goto LAB2;

LAB10:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)7;
    goto LAB2;

LAB11:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)8;
    goto LAB2;

LAB12:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)1;
    goto LAB2;

LAB13:;
}

char *work_p_4054474977_sub_16286008207252954496_1800819092(char *t1, char *t2, unsigned char t3)
{
    char t4[128];
    char t5[8];
    char t6[16];
    char t13[8];
    char *t0;
    char *t7;
    char *t8;
    int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t21;
    char *t22;
    int t23;
    int t24;
    int t25;
    unsigned int t26;
    static char *nl0[] = {&&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB3, &&LAB4, &&LAB5, &&LAB6, &&LAB7, &&LAB8, &&LAB9, &&LAB10, &&LAB11, &&LAB12, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB13, &&LAB14, &&LAB15, &&LAB16, &&LAB17, &&LAB18, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB13, &&LAB14, &&LAB15, &&LAB16, &&LAB17, &&LAB18, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19, &&LAB19};

LAB0:    t7 = (t6 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 3;
    t8 = (t7 + 4U);
    *((int *)t8) = 0;
    t8 = (t7 + 8U);
    *((int *)t8) = -1;
    t9 = (0 - 3);
    t10 = (t9 * -1);
    t10 = (t10 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t10;
    t8 = (t4 + 4U);
    t11 = ((IEEE_P_2592010699) + 4000);
    t12 = (t8 + 88U);
    *((char **)t12) = t11;
    t14 = (t8 + 56U);
    *((char **)t14) = t13;
    xsi_type_set_default_value(t11, t13, t6);
    t15 = (t8 + 64U);
    *((char **)t15) = t6;
    t16 = (t8 + 80U);
    *((unsigned int *)t16) = 4U;
    t17 = (t5 + 4U);
    *((unsigned char *)t17) = t3;
    t18 = (char *)((nl0) + t3);
    goto **((char **)t18);

LAB2:    t7 = (t8 + 56U);
    t11 = *((char **)t7);
    t7 = (t6 + 12U);
    t10 = *((unsigned int *)t7);
    t10 = (t10 * 1U);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t11, t10);
    t12 = (t6 + 0U);
    t9 = *((int *)t12);
    t14 = (t6 + 4U);
    t23 = *((int *)t14);
    t15 = (t6 + 8U);
    t24 = *((int *)t15);
    t16 = (t2 + 0U);
    t18 = (t16 + 0U);
    *((int *)t18) = t9;
    t18 = (t16 + 4U);
    *((int *)t18) = t23;
    t18 = (t16 + 8U);
    *((int *)t18) = t24;
    t25 = (t23 - t9);
    t26 = (t25 * t24);
    t26 = (t26 + 1);
    t18 = (t16 + 12U);
    *((unsigned int *)t18) = t26;

LAB1:    return t0;
LAB3:    t19 = (t1 + 3509);
    t21 = (t8 + 56U);
    t22 = *((char **)t21);
    t21 = (t22 + 0);
    memcpy(t21, t19, 4U);
    goto LAB2;

LAB4:    t7 = (t1 + 3513);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB5:    t7 = (t1 + 3517);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB6:    t7 = (t1 + 3521);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB7:    t7 = (t1 + 3525);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB8:    t7 = (t1 + 3529);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB9:    t7 = (t1 + 3533);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB10:    t7 = (t1 + 3537);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB11:    t7 = (t1 + 3541);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB12:    t7 = (t1 + 3545);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB13:    t7 = (t1 + 3549);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB14:    t7 = (t1 + 3553);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB15:    t7 = (t1 + 3557);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB16:    t7 = (t1 + 3561);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB17:    t7 = (t1 + 3565);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB18:    t7 = (t1 + 3569);
    t12 = (t8 + 56U);
    t14 = *((char **)t12);
    t12 = (t14 + 0);
    memcpy(t12, t7, 4U);
    goto LAB2;

LAB19:    goto LAB2;

LAB20:;
}

int work_p_4054474977_sub_18128735684734754531_1800819092(char *t1, unsigned char t2)
{
    char t3[128];
    char t4[8];
    char t8[8];
    int t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    int t15;
    static char *nl0[] = {&&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB3, &&LAB4, &&LAB5, &&LAB6, &&LAB7, &&LAB8, &&LAB9, &&LAB10, &&LAB11, &&LAB12, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13, &&LAB13};

LAB0:    t5 = (t3 + 4U);
    t6 = ((STD_STANDARD) + 384);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    xsi_type_set_default_value(t6, t8, 0);
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 4U;
    t11 = (t4 + 4U);
    *((unsigned char *)t11) = t2;
    t12 = (char *)((nl0) + t2);
    goto **((char **)t12);

LAB2:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t15 = *((int *)t7);
    t0 = t15;

LAB1:    return t0;
LAB3:    t13 = (t5 + 56U);
    t14 = *((char **)t13);
    t13 = (t14 + 0);
    *((int *)t13) = 0;
    goto LAB2;

LAB4:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 1;
    goto LAB2;

LAB5:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 2;
    goto LAB2;

LAB6:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 3;
    goto LAB2;

LAB7:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 4;
    goto LAB2;

LAB8:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 5;
    goto LAB2;

LAB9:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 6;
    goto LAB2;

LAB10:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 7;
    goto LAB2;

LAB11:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 8;
    goto LAB2;

LAB12:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 9;
    goto LAB2;

LAB13:    goto LAB2;

LAB14:;
}

char *work_p_4054474977_sub_13627294910037070387_1800819092(char *t1, char *t2, char *t3, char *t4)
{
    char t5[248];
    char t6[24];
    char t24[16];
    char t53[8];
    char *t0;
    int t7;
    char *t8;
    int t9;
    char *t10;
    int t11;
    char *t12;
    int t13;
    int t14;
    char *t15;
    int t16;
    char *t17;
    int t18;
    char *t19;
    int t20;
    int t21;
    int t22;
    unsigned int t23;
    int t25;
    char *t26;
    int t27;
    char *t28;
    int t29;
    char *t30;
    int t31;
    int t32;
    char *t33;
    int t34;
    char *t35;
    int t36;
    char *t37;
    int t38;
    int t39;
    char *t40;
    char *t41;
    int t42;
    unsigned int t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t54;
    char *t55;
    char *t56;
    unsigned char t57;
    char *t58;
    int t59;
    char *t60;
    int t61;
    char *t62;
    int t63;
    char *t64;
    int t65;
    int t66;
    char *t67;
    int t68;
    char *t69;
    int t70;
    char *t71;
    int t72;
    int t73;
    char *t74;
    char *t75;
    unsigned int t76;
    unsigned char t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;

LAB0:    t8 = (t4 + 0U);
    t9 = *((int *)t8);
    t10 = (t4 + 4U);
    t11 = *((int *)t10);
    t12 = (t4 + 8U);
    t13 = *((int *)t12);
    if (t9 > t11)
        goto LAB2;

LAB3:    if (t13 == -1)
        goto LAB7;

LAB8:    t7 = t11;

LAB4:    t15 = (t4 + 0U);
    t16 = *((int *)t15);
    t17 = (t4 + 4U);
    t18 = *((int *)t17);
    t19 = (t4 + 8U);
    t20 = *((int *)t19);
    if (t16 > t18)
        goto LAB9;

LAB10:    if (t20 == -1)
        goto LAB14;

LAB15:    t14 = t16;

LAB11:    t21 = (t7 - t14);
    t22 = (0 - t21);
    t23 = (t22 * -1);
    t23 = (t23 + 1);
    t23 = (t23 * 1U);
    t26 = (t4 + 0U);
    t27 = *((int *)t26);
    t28 = (t4 + 4U);
    t29 = *((int *)t28);
    t30 = (t4 + 8U);
    t31 = *((int *)t30);
    if (t27 > t29)
        goto LAB16;

LAB17:    if (t31 == -1)
        goto LAB21;

LAB22:    t25 = t29;

LAB18:    t33 = (t4 + 0U);
    t34 = *((int *)t33);
    t35 = (t4 + 4U);
    t36 = *((int *)t35);
    t37 = (t4 + 8U);
    t38 = *((int *)t37);
    if (t34 > t36)
        goto LAB23;

LAB24:    if (t38 == -1)
        goto LAB28;

LAB29:    t32 = t34;

LAB25:    t39 = (t25 - t32);
    t40 = (t24 + 0U);
    t41 = (t40 + 0U);
    *((int *)t41) = t39;
    t41 = (t40 + 4U);
    *((int *)t41) = 0;
    t41 = (t40 + 8U);
    *((int *)t41) = -1;
    t42 = (0 - t39);
    t43 = (t42 * -1);
    t43 = (t43 + 1);
    t41 = (t40 + 12U);
    *((unsigned int *)t41) = t43;
    t41 = (t5 + 4U);
    t44 = ((IEEE_P_2592010699) + 4000);
    t45 = (t41 + 88U);
    *((char **)t45) = t44;
    t46 = (char *)alloca(t23);
    t47 = (t41 + 56U);
    *((char **)t47) = t46;
    xsi_type_set_default_value(t44, t46, t24);
    t48 = (t41 + 64U);
    *((char **)t48) = t24;
    t49 = (t41 + 80U);
    *((unsigned int *)t49) = t23;
    t50 = (t5 + 124U);
    t51 = ((STD_STANDARD) + 384);
    t52 = (t50 + 88U);
    *((char **)t52) = t51;
    t54 = (t50 + 56U);
    *((char **)t54) = t53;
    xsi_type_set_default_value(t51, t53, 0);
    t55 = (t50 + 80U);
    *((unsigned int *)t55) = 4U;
    t56 = (t6 + 4U);
    t57 = (t3 != 0);
    if (t57 == 1)
        goto LAB31;

LAB30:    t58 = (t6 + 12U);
    *((char **)t58) = t4;
    t60 = (t4 + 0U);
    t61 = *((int *)t60);
    t62 = (t4 + 4U);
    t63 = *((int *)t62);
    t64 = (t4 + 8U);
    t65 = *((int *)t64);
    if (t61 > t63)
        goto LAB32;

LAB33:    if (t65 == -1)
        goto LAB37;

LAB38:    t59 = t63;

LAB34:    t67 = (t4 + 0U);
    t68 = *((int *)t67);
    t69 = (t4 + 4U);
    t70 = *((int *)t69);
    t71 = (t4 + 8U);
    t72 = *((int *)t71);
    if (t68 > t70)
        goto LAB39;

LAB40:    if (t72 == -1)
        goto LAB44;

LAB45:    t66 = t68;

LAB41:    t73 = (t59 - t66);
    t74 = (t50 + 56U);
    t75 = *((char **)t74);
    t74 = (t75 + 0);
    *((int *)t74) = t73;
    t8 = (t4 + 8U);
    t7 = *((int *)t8);
    t10 = (t4 + 4U);
    t9 = *((int *)t10);
    t12 = (t4 + 0U);
    t11 = *((int *)t12);
    t13 = t11;
    t14 = t9;

LAB46:    t16 = (t14 * t7);
    t18 = (t13 * t7);
    if (t18 <= t16)
        goto LAB47;

LAB49:    t8 = (t41 + 56U);
    t10 = *((char **)t8);
    t8 = (t24 + 12U);
    t23 = *((unsigned int *)t8);
    t23 = (t23 * 1U);
    t0 = xsi_get_transient_memory(t23);
    memcpy(t0, t10, t23);
    t12 = (t24 + 0U);
    t7 = *((int *)t12);
    t15 = (t24 + 4U);
    t9 = *((int *)t15);
    t17 = (t24 + 8U);
    t11 = *((int *)t17);
    t19 = (t2 + 0U);
    t26 = (t19 + 0U);
    *((int *)t26) = t7;
    t26 = (t19 + 4U);
    *((int *)t26) = t9;
    t26 = (t19 + 8U);
    *((int *)t26) = t11;
    t13 = (t9 - t7);
    t43 = (t13 * t11);
    t43 = (t43 + 1);
    t26 = (t19 + 12U);
    *((unsigned int *)t26) = t43;

LAB1:    return t0;
LAB2:    if (t13 == 1)
        goto LAB5;

LAB6:    t7 = t9;
    goto LAB4;

LAB5:    t7 = t11;
    goto LAB4;

LAB7:    t7 = t9;
    goto LAB4;

LAB9:    if (t20 == 1)
        goto LAB12;

LAB13:    t14 = t18;
    goto LAB11;

LAB12:    t14 = t16;
    goto LAB11;

LAB14:    t14 = t18;
    goto LAB11;

LAB16:    if (t31 == 1)
        goto LAB19;

LAB20:    t25 = t27;
    goto LAB18;

LAB19:    t25 = t29;
    goto LAB18;

LAB21:    t25 = t27;
    goto LAB18;

LAB23:    if (t38 == 1)
        goto LAB26;

LAB27:    t32 = t36;
    goto LAB25;

LAB26:    t32 = t34;
    goto LAB25;

LAB28:    t32 = t36;
    goto LAB25;

LAB31:    *((char **)t56) = t3;
    goto LAB30;

LAB32:    if (t65 == 1)
        goto LAB35;

LAB36:    t59 = t61;
    goto LAB34;

LAB35:    t59 = t63;
    goto LAB34;

LAB37:    t59 = t61;
    goto LAB34;

LAB39:    if (t72 == 1)
        goto LAB42;

LAB43:    t66 = t70;
    goto LAB41;

LAB42:    t66 = t68;
    goto LAB41;

LAB44:    t66 = t70;
    goto LAB41;

LAB47:    t15 = (t4 + 0U);
    t20 = *((int *)t15);
    t17 = (t4 + 8U);
    t21 = *((int *)t17);
    t22 = (t13 - t20);
    t23 = (t22 * t21);
    t43 = (1U * t23);
    t76 = (0 + t43);
    t19 = (t3 + t76);
    t57 = *((unsigned char *)t19);
    t77 = work_p_4054474977_sub_6205399195240504445_1800819092(t1, t57);
    t26 = (t41 + 56U);
    t28 = *((char **)t26);
    t26 = (t50 + 56U);
    t30 = *((char **)t26);
    t25 = *((int *)t30);
    t26 = (t24 + 0U);
    t27 = *((int *)t26);
    t33 = (t24 + 8U);
    t29 = *((int *)t33);
    t31 = (t25 - t27);
    t78 = (t31 * t29);
    t35 = (t24 + 4U);
    t32 = *((int *)t35);
    xsi_vhdl_check_range_of_index(t27, t32, t29, t25);
    t79 = (1U * t78);
    t80 = (0 + t79);
    t37 = (t28 + t80);
    *((unsigned char *)t37) = t77;
    t8 = (t50 + 56U);
    t10 = *((char **)t8);
    t9 = *((int *)t10);
    t11 = (t9 - 1);
    t8 = (t50 + 56U);
    t12 = *((char **)t8);
    t8 = (t12 + 0);
    *((int *)t8) = t11;

LAB48:    if (t13 == t14)
        goto LAB49;

LAB50:    t9 = (t13 + t7);
    t13 = t9;
    goto LAB46;

LAB51:;
}

char *work_p_4054474977_sub_5434987555110971454_1800819092(char *t1, char *t2, char *t3, char *t4)
{
    char t5[248];
    char t6[24];
    char t21[16];
    char t39[8];
    char t68[16];
    char t81[16];
    char t83[16];
    char *t0;
    char *t7;
    unsigned int t8;
    int t9;
    int t10;
    int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    int t17;
    int t18;
    int t19;
    unsigned int t20;
    char *t22;
    unsigned int t23;
    int t24;
    int t25;
    char *t26;
    char *t27;
    int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t40;
    char *t41;
    char *t42;
    unsigned char t43;
    char *t44;
    char *t45;
    int t46;
    char *t47;
    int t48;
    char *t49;
    int t50;
    int t51;
    int t52;
    int t53;
    int t54;
    char *t55;
    char *t56;
    int t57;
    char *t58;
    int t59;
    unsigned int t60;
    char *t61;
    int t62;
    char *t63;
    int t64;
    unsigned int t65;
    unsigned int t66;
    char *t67;
    char *t69;
    int t70;
    char *t71;
    int t72;
    int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    char *t77;
    unsigned char t78;
    char *t79;
    char *t80;
    char *t82;
    char *t84;
    unsigned int t85;
    int t86;
    char *t87;
    char *t88;
    int t89;
    unsigned int t90;
    char *t91;
    char *t92;
    int t93;
    int t94;
    unsigned int t95;
    unsigned int t96;
    char *t97;
    unsigned int t98;
    unsigned int t99;

LAB0:    t7 = (t4 + 12U);
    t8 = *((unsigned int *)t7);
    t9 = (t8 * 4);
    t10 = (t9 - 1);
    t11 = (0 - t10);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t12 = (t12 * 1U);
    t13 = xsi_get_transient_memory(t12);
    memset(t13, 0, t12);
    t14 = t13;
    memset(t14, (unsigned char)2, t12);
    t15 = (t4 + 12U);
    t16 = *((unsigned int *)t15);
    t17 = (t16 * 4);
    t18 = (t17 - 1);
    t19 = (0 - t18);
    t20 = (t19 * -1);
    t20 = (t20 + 1);
    t20 = (t20 * 1U);
    t22 = (t4 + 12U);
    t23 = *((unsigned int *)t22);
    t24 = (t23 * 4);
    t25 = (t24 - 1);
    t26 = (t21 + 0U);
    t27 = (t26 + 0U);
    *((int *)t27) = t25;
    t27 = (t26 + 4U);
    *((int *)t27) = 0;
    t27 = (t26 + 8U);
    *((int *)t27) = -1;
    t28 = (0 - t25);
    t29 = (t28 * -1);
    t29 = (t29 + 1);
    t27 = (t26 + 12U);
    *((unsigned int *)t27) = t29;
    t27 = (t5 + 4U);
    t30 = ((IEEE_P_2592010699) + 4000);
    t31 = (t27 + 88U);
    *((char **)t31) = t30;
    t32 = (char *)alloca(t20);
    t33 = (t27 + 56U);
    *((char **)t33) = t32;
    memcpy(t32, t13, t20);
    t34 = (t27 + 64U);
    *((char **)t34) = t21;
    t35 = (t27 + 80U);
    *((unsigned int *)t35) = t20;
    t36 = (t5 + 124U);
    t37 = ((STD_STANDARD) + 384);
    t38 = (t36 + 88U);
    *((char **)t38) = t37;
    t40 = (t36 + 56U);
    *((char **)t40) = t39;
    xsi_type_set_default_value(t37, t39, 0);
    t41 = (t36 + 80U);
    *((unsigned int *)t41) = 4U;
    t42 = (t6 + 4U);
    t43 = (t3 != 0);
    if (t43 == 1)
        goto LAB3;

LAB2:    t44 = (t6 + 12U);
    *((char **)t44) = t4;
    t45 = (t4 + 8U);
    t46 = *((int *)t45);
    t47 = (t4 + 4U);
    t48 = *((int *)t47);
    t49 = (t4 + 0U);
    t50 = *((int *)t49);
    t51 = t50;
    t52 = t48;

LAB4:    t53 = (t52 * t46);
    t54 = (t51 * t46);
    if (t54 <= t53)
        goto LAB5;

LAB7:    t7 = (t27 + 56U);
    t13 = *((char **)t7);
    t7 = (t21 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t0 = xsi_get_transient_memory(t8);
    memcpy(t0, t13, t8);
    t14 = (t21 + 0U);
    t9 = *((int *)t14);
    t15 = (t21 + 4U);
    t10 = *((int *)t15);
    t22 = (t21 + 8U);
    t11 = *((int *)t22);
    t26 = (t2 + 0U);
    t30 = (t26 + 0U);
    *((int *)t30) = t9;
    t30 = (t26 + 4U);
    *((int *)t30) = t10;
    t30 = (t26 + 8U);
    *((int *)t30) = t11;
    t17 = (t10 - t9);
    t12 = (t17 * t11);
    t12 = (t12 + 1);
    t30 = (t26 + 12U);
    *((unsigned int *)t30) = t12;

LAB1:    return t0;
LAB3:    *((char **)t42) = t3;
    goto LAB2;

LAB5:    t55 = (t27 + 56U);
    t56 = *((char **)t55);
    t55 = (t21 + 0U);
    t57 = *((int *)t55);
    t58 = (t21 + 12U);
    t29 = *((unsigned int *)t58);
    t59 = (t29 - 5);
    t60 = (t57 - t59);
    t61 = (t21 + 4U);
    t62 = *((int *)t61);
    t63 = (t21 + 8U);
    t64 = *((int *)t63);
    xsi_vhdl_check_range_of_slice(t57, t62, t64, t59, 0, -1);
    t65 = (t60 * 1U);
    t66 = (0 + t65);
    t67 = (t56 + t66);
    t69 = (t4 + 0U);
    t70 = *((int *)t69);
    t71 = (t4 + 8U);
    t72 = *((int *)t71);
    t73 = (t51 - t70);
    t74 = (t73 * t72);
    t75 = (1U * t74);
    t76 = (0 + t75);
    t77 = (t3 + t76);
    t78 = *((unsigned char *)t77);
    t79 = work_p_4054474977_sub_16286008207252954496_1800819092(t1, t68, t78);
    t82 = ((IEEE_P_2592010699) + 4000);
    t84 = (t21 + 12U);
    t85 = *((unsigned int *)t84);
    t86 = (t85 - 5);
    t87 = (t83 + 0U);
    t88 = (t87 + 0U);
    *((int *)t88) = t86;
    t88 = (t87 + 4U);
    *((int *)t88) = 0;
    t88 = (t87 + 8U);
    *((int *)t88) = -1;
    t89 = (0 - t86);
    t90 = (t89 * -1);
    t90 = (t90 + 1);
    t88 = (t87 + 12U);
    *((unsigned int *)t88) = t90;
    t80 = xsi_base_array_concat(t80, t81, t82, (char)97, t67, t83, (char)97, t79, t68, (char)101);
    t88 = (t27 + 56U);
    t91 = *((char **)t88);
    t88 = (t91 + 0);
    t92 = (t21 + 12U);
    t90 = *((unsigned int *)t92);
    t93 = (t90 - 5);
    t94 = (0 - t93);
    t95 = (t94 * -1);
    t95 = (t95 + 1);
    t96 = (1U * t95);
    t97 = (t68 + 12U);
    t98 = *((unsigned int *)t97);
    t98 = (t98 * 1U);
    t99 = (t96 + t98);
    memcpy(t88, t80, t99);

LAB6:    if (t51 == t52)
        goto LAB7;

LAB8:    t9 = (t51 + t46);
    t51 = t9;
    goto LAB4;

LAB9:;
}

int work_p_4054474977_sub_16102273466969797619_1800819092(char *t1, char *t2, char *t3)
{
    char t4[128];
    char t5[24];
    char t9[8];
    int t0;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    char *t14;
    char *t15;
    char *t16;
    int t17;
    int t18;
    int t19;
    int t20;
    int t21;
    int t22;
    int t23;
    int t24;
    int t25;
    int t26;
    int t27;
    int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    int t33;
    int t34;
    char *t35;
    char *t36;

LAB0:    t6 = (t4 + 4U);
    t7 = ((STD_STANDARD) + 384);
    t8 = (t6 + 88U);
    *((char **)t8) = t7;
    t10 = (t6 + 56U);
    *((char **)t10) = t9;
    xsi_type_set_default_value(t7, t9, 0);
    t11 = (t6 + 80U);
    *((unsigned int *)t11) = 4U;
    t12 = (t5 + 4U);
    t13 = (t2 != 0);
    if (t13 == 1)
        goto LAB3;

LAB2:    t14 = (t5 + 12U);
    *((char **)t14) = t3;
    t15 = (t6 + 56U);
    t16 = *((char **)t15);
    t15 = (t16 + 0);
    *((int *)t15) = 0;
    t7 = (t3 + 8U);
    t17 = *((int *)t7);
    t8 = (t3 + 4U);
    t18 = *((int *)t8);
    t10 = (t3 + 0U);
    t19 = *((int *)t10);
    t20 = t19;
    t21 = t18;

LAB4:    t22 = (t21 * t17);
    t23 = (t20 * t17);
    if (t23 <= t22)
        goto LAB5;

LAB7:    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t17 = *((int *)t8);
    t0 = t17;

LAB1:    return t0;
LAB3:    *((char **)t12) = t2;
    goto LAB2;

LAB5:    t11 = (t6 + 56U);
    t15 = *((char **)t11);
    t24 = *((int *)t15);
    t25 = (t24 * 10);
    t11 = (t3 + 0U);
    t26 = *((int *)t11);
    t16 = (t3 + 8U);
    t27 = *((int *)t16);
    t28 = (t20 - t26);
    t29 = (t28 * t27);
    t30 = (1U * t29);
    t31 = (0 + t30);
    t32 = (t2 + t31);
    t13 = *((unsigned char *)t32);
    t33 = work_p_4054474977_sub_18128735684734754531_1800819092(t1, t13);
    t34 = (t25 + t33);
    t35 = (t6 + 56U);
    t36 = *((char **)t35);
    t35 = (t36 + 0);
    *((int *)t35) = t34;

LAB6:    if (t20 == t21)
        goto LAB7;

LAB8:    t18 = (t20 + t17);
    t20 = t18;
    goto LAB4;

LAB9:;
}

int work_p_4054474977_sub_15061112934082860375_1800819092(char *t1, char *t2, char *t3)
{
    char t4[128];
    char t5[24];
    char t9[8];
    int t0;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    char *t14;
    char *t15;
    int t16;
    char *t17;
    int t18;
    int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    unsigned char t24;
    unsigned char t25;
    char *t26;
    int t27;
    char *t28;
    int t29;
    char *t30;
    int t31;
    int t32;
    int t33;
    int t34;
    int t35;
    char *t36;
    char *t37;
    int t38;
    int t39;
    int t40;
    char *t41;
    int t42;
    int t43;
    unsigned int t44;
    char *t45;
    int t46;
    unsigned int t47;
    unsigned int t48;
    char *t49;
    unsigned char t50;
    unsigned char t51;
    char *t52;
    char *t53;
    int t54;
    int t55;
    char *t56;

LAB0:    t6 = (t4 + 4U);
    t7 = ((STD_STANDARD) + 384);
    t8 = (t6 + 88U);
    *((char **)t8) = t7;
    t10 = (t6 + 56U);
    *((char **)t10) = t9;
    *((int *)t9) = 0;
    t11 = (t6 + 80U);
    *((unsigned int *)t11) = 4U;
    t12 = (t5 + 4U);
    t13 = (t2 != 0);
    if (t13 == 1)
        goto LAB3;

LAB2:    t14 = (t5 + 12U);
    *((char **)t14) = t3;
    t15 = (t3 + 0U);
    t16 = *((int *)t15);
    t17 = (t3 + 8U);
    t18 = *((int *)t17);
    t19 = (1 - t16);
    t20 = (t19 * t18);
    t21 = (1U * t20);
    t22 = (0 + t21);
    t23 = (t2 + t22);
    t24 = *((unsigned char *)t23);
    t25 = (t24 != (unsigned char)32);
    if (t25 != 0)
        goto LAB4;

LAB6:
LAB5:    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t16 = *((int *)t8);
    t0 = t16;

LAB1:    return t0;
LAB3:    *((char **)t12) = t2;
    goto LAB2;

LAB4:    t26 = (t3 + 8U);
    t27 = *((int *)t26);
    t28 = (t3 + 4U);
    t29 = *((int *)t28);
    t30 = (t3 + 0U);
    t31 = *((int *)t30);
    t32 = t31;
    t33 = t29;

LAB7:    t34 = (t33 * t27);
    t35 = (t32 * t27);
    if (t35 <= t34)
        goto LAB8;

LAB10:    goto LAB5;

LAB8:    t36 = (t6 + 56U);
    t37 = *((char **)t36);
    t38 = *((int *)t37);
    t39 = (t38 + 1);
    t36 = (t3 + 0U);
    t40 = *((int *)t36);
    t41 = (t3 + 8U);
    t42 = *((int *)t41);
    t43 = (t39 - t40);
    t44 = (t43 * t42);
    t45 = (t3 + 4U);
    t46 = *((int *)t45);
    xsi_vhdl_check_range_of_index(t40, t46, t42, t39);
    t47 = (1U * t44);
    t48 = (0 + t47);
    t49 = (t2 + t48);
    t50 = *((unsigned char *)t49);
    t51 = (t50 != (unsigned char)32);
    if (t51 != 0)
        goto LAB11;

LAB13:
LAB12:
LAB9:    if (t32 == t33)
        goto LAB10;

LAB14:    t16 = (t32 + t27);
    t32 = t16;
    goto LAB7;

LAB11:    t52 = (t6 + 56U);
    t53 = *((char **)t52);
    t54 = *((int *)t53);
    t55 = (t54 + 1);
    t52 = (t6 + 56U);
    t56 = *((char **)t52);
    t52 = (t56 + 0);
    *((int *)t52) = t55;
    goto LAB12;

LAB15:;
}

void work_p_4054474977_sub_12291005972952596459_1800819092(char *t0, char *t1, char *t2, char *t3, char *t4)
{
    char t5[320];
    char t6[32];
    char t16[8];
    char t22[8];
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t23;
    char *t24;
    char *t25;
    unsigned char t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    int t33;
    int t34;
    int t35;
    int t36;
    int t37;
    int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned char t42;

LAB0:    t7 = (t5 + 4U);
    t8 = ((STD_TEXTIO) + 3248);
    t9 = (t7 + 56U);
    *((char **)t9) = t8;
    t10 = (t7 + 40U);
    *((char **)t10) = 0;
    t11 = (t7 + 64U);
    *((int *)t11) = 1;
    t12 = (t7 + 48U);
    *((char **)t12) = 0;
    t13 = (t5 + 76U);
    t14 = ((STD_STANDARD) + 192);
    t15 = (t13 + 88U);
    *((char **)t15) = t14;
    t17 = (t13 + 56U);
    *((char **)t17) = t16;
    xsi_type_set_default_value(t14, t16, 0);
    t18 = (t13 + 80U);
    *((unsigned int *)t18) = 1U;
    t19 = (t5 + 196U);
    t20 = ((STD_STANDARD) + 0);
    t21 = (t19 + 88U);
    *((char **)t21) = t20;
    t23 = (t19 + 56U);
    *((char **)t23) = t22;
    xsi_type_set_default_value(t20, t22, 0);
    t24 = (t19 + 80U);
    *((unsigned int *)t24) = 1U;
    t25 = (t6 + 4U);
    t26 = (t2 != 0);
    if (t26 == 1)
        goto LAB3;

LAB2:    t27 = (t6 + 12U);
    *((char **)t27) = t3;
    t28 = (t6 + 20U);
    *((char **)t28) = t4;
    std_textio_readline(STD_TEXTIO, t1, t2, t7);
    t8 = (t4 + 8U);
    t29 = *((int *)t8);
    t9 = (t4 + 4U);
    t30 = *((int *)t9);
    t10 = (t4 + 0U);
    t31 = *((int *)t10);
    t32 = t31;
    t33 = t30;

LAB4:    t34 = (t33 * t29);
    t35 = (t32 * t29);
    if (t35 <= t34)
        goto LAB5;

LAB7:    t8 = (t4 + 8U);
    t29 = *((int *)t8);
    t9 = (t4 + 4U);
    t30 = *((int *)t9);
    t10 = (t4 + 0U);
    t31 = *((int *)t10);
    t32 = t31;
    t33 = t30;

LAB9:    t34 = (t33 * t29);
    t35 = (t32 * t29);
    if (t35 <= t34)
        goto LAB10;

LAB12:
LAB1:    xsi_access_variable_delete(t7);
    return;
LAB3:    *((char **)t25) = t2;
    goto LAB2;

LAB5:    t11 = (t4 + 0U);
    t36 = *((int *)t11);
    t12 = (t4 + 8U);
    t37 = *((int *)t12);
    t38 = (t32 - t36);
    t39 = (t38 * t37);
    t40 = (1U * t39);
    t41 = (0 + t40);
    t14 = (t3 + t41);
    *((unsigned char *)t14) = (unsigned char)32;

LAB6:    if (t32 == t33)
        goto LAB7;

LAB8:    t30 = (t32 + t29);
    t32 = t30;
    goto LAB4;

LAB10:    t11 = (t13 + 56U);
    t12 = *((char **)t11);
    t11 = (t12 + 0);
    t14 = (t19 + 56U);
    t15 = *((char **)t14);
    t14 = (t15 + 0);
    std_textio_read7(STD_TEXTIO, t1, t7, t11, t14);
    t8 = (t19 + 56U);
    t9 = *((char **)t8);
    t26 = *((unsigned char *)t9);
    if (t26 != 0)
        goto LAB13;

LAB15:    goto LAB12;

LAB11:    if (t32 == t33)
        goto LAB12;

LAB17:    t30 = (t32 + t29);
    t32 = t30;
    goto LAB9;

LAB13:    t8 = (t13 + 56U);
    t10 = *((char **)t8);
    t42 = *((unsigned char *)t10);
    t8 = (t4 + 0U);
    t30 = *((int *)t8);
    t11 = (t4 + 8U);
    t31 = *((int *)t11);
    t34 = (t32 - t30);
    t39 = (t34 * t31);
    t40 = (1U * t39);
    t41 = (0 + t40);
    t12 = (t3 + t41);
    *((unsigned char *)t12) = t42;

LAB14:    goto LAB11;

LAB16:    goto LAB14;

}

void work_p_4054474977_sub_6024527269204825312_1800819092(char *t0, char *t1, char *t2, char *t3, char *t4, char *t5)
{
    char t6[368];
    char t7[40];
    char t11[8];
    char t17[8];
    char t23[8];
    char *t8;
    char *t9;
    char *t10;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    int t31;
    char *t32;
    int t33;
    char *t34;
    int t35;
    int t36;
    int t37;
    int t38;
    int t39;
    char *t40;
    int t41;
    char *t42;
    int t43;
    int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    char *t48;
    unsigned char t49;
    unsigned char t50;
    unsigned char t51;
    unsigned char t52;
    unsigned char t53;
    int t54;
    int t55;

LAB0:    t8 = (t6 + 4U);
    t9 = ((STD_STANDARD) + 192);
    t10 = (t8 + 88U);
    *((char **)t10) = t9;
    t12 = (t8 + 56U);
    *((char **)t12) = t11;
    *((unsigned char *)t11) = (unsigned char)32;
    t13 = (t8 + 80U);
    *((unsigned int *)t13) = 1U;
    t14 = (t6 + 124U);
    t15 = ((STD_STANDARD) + 0);
    t16 = (t14 + 88U);
    *((char **)t16) = t15;
    t18 = (t14 + 56U);
    *((char **)t18) = t17;
    xsi_type_set_default_value(t15, t17, 0);
    t19 = (t14 + 80U);
    *((unsigned int *)t19) = 1U;
    t20 = (t6 + 244U);
    t21 = ((STD_STANDARD) + 384);
    t22 = (t20 + 88U);
    *((char **)t22) = t21;
    t24 = (t20 + 56U);
    *((char **)t24) = t23;
    xsi_type_set_default_value(t21, t23, 0);
    t25 = (t20 + 80U);
    *((unsigned int *)t25) = 4U;
    t26 = (t7 + 4U);
    *((char **)t26) = t2;
    t27 = (t7 + 12U);
    *((char **)t27) = t3;
    t28 = (t7 + 20U);
    *((char **)t28) = t4;
    t29 = (t7 + 28U);
    *((char **)t29) = t5;
    t30 = (t4 + 8U);
    t31 = *((int *)t30);
    t32 = (t4 + 4U);
    t33 = *((int *)t32);
    t34 = (t4 + 0U);
    t35 = *((int *)t34);
    t36 = t35;
    t37 = t33;

LAB2:    t38 = (t37 * t31);
    t39 = (t36 * t31);
    if (t39 <= t38)
        goto LAB3;

LAB5:
LAB7:    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t50 = *((unsigned char *)t10);
    t51 = (t50 == (unsigned char)32);
    if (t51 == 1)
        goto LAB11;

LAB12:    t49 = (unsigned char)0;

LAB13:    if (t49 != 0)
        goto LAB8;

LAB10:    t9 = (t20 + 56U);
    t10 = *((char **)t9);
    t9 = (t10 + 0);
    *((int *)t9) = 1;
    t9 = (t4 + 8U);
    t31 = *((int *)t9);
    t10 = (t4 + 4U);
    t33 = *((int *)t10);
    t12 = (t4 + 0U);
    t35 = *((int *)t12);
    t36 = t35;
    t37 = t33;

LAB14:    t38 = (t37 * t31);
    t39 = (t36 * t31);
    if (t39 <= t38)
        goto LAB15;

LAB17:    t9 = (t14 + 56U);
    t10 = *((char **)t9);
    t49 = *((unsigned char *)t10);
    t9 = (t5 + 0);
    *((unsigned char *)t9) = t49;

LAB1:    return;
LAB3:    t40 = (t4 + 0U);
    t41 = *((int *)t40);
    t42 = (t4 + 8U);
    t43 = *((int *)t42);
    t44 = (t36 - t41);
    t45 = (t44 * t43);
    t46 = (1U * t45);
    t47 = (0 + t46);
    t48 = (t3 + t47);
    *((unsigned char *)t48) = (unsigned char)32;

LAB4:    if (t36 == t37)
        goto LAB5;

LAB6:    t33 = (t36 + t31);
    t36 = t33;
    goto LAB2;

LAB8:    t9 = (t8 + 56U);
    t13 = *((char **)t9);
    t9 = (t13 + 0);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t15 = (t16 + 0);
    std_textio_read7(STD_TEXTIO, t1, t2, t9, t15);
    goto LAB7;

LAB9:;
LAB11:    t9 = (t14 + 56U);
    t12 = *((char **)t9);
    t52 = *((unsigned char *)t12);
    t53 = (t52 == (unsigned char)1);
    t49 = t53;
    goto LAB13;

LAB15:    t13 = (t14 + 56U);
    t15 = *((char **)t13);
    t49 = *((unsigned char *)t15);
    if (t49 != 0)
        goto LAB18;

LAB20:
LAB19:    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t9 = (t10 + 0);
    t12 = (t14 + 56U);
    t13 = *((char **)t12);
    t12 = (t13 + 0);
    std_textio_read7(STD_TEXTIO, t1, t2, t9, t12);

LAB16:    if (t36 == t37)
        goto LAB17;

LAB24:    t33 = (t36 + t31);
    t36 = t33;
    goto LAB14;

LAB18:    t13 = (t8 + 56U);
    t16 = *((char **)t13);
    t50 = *((unsigned char *)t16);
    t51 = (t50 != (unsigned char)32);
    if (t51 != 0)
        goto LAB21;

LAB23:
LAB22:    goto LAB19;

LAB21:    t13 = (t8 + 56U);
    t18 = *((char **)t13);
    t52 = *((unsigned char *)t18);
    t13 = (t20 + 56U);
    t19 = *((char **)t13);
    t41 = *((int *)t19);
    t13 = (t4 + 0U);
    t43 = *((int *)t13);
    t21 = (t4 + 8U);
    t44 = *((int *)t21);
    t54 = (t41 - t43);
    t45 = (t54 * t44);
    t22 = (t4 + 4U);
    t55 = *((int *)t22);
    xsi_vhdl_check_range_of_index(t43, t55, t44, t41);
    t46 = (1U * t45);
    t47 = (0 + t46);
    t24 = (t3 + t47);
    *((unsigned char *)t24) = t52;
    t9 = (t20 + 56U);
    t10 = *((char **)t9);
    t33 = *((int *)t10);
    t35 = (t33 + 1);
    t9 = (t20 + 56U);
    t12 = *((char **)t9);
    t9 = (t12 + 0);
    *((int *)t9) = t35;
    goto LAB22;

}

void work_p_4054474977_sub_1621482321996872493_1800819092(char *t0, char *t1, char *t2, char *t3, char *t4)
{
    char t5[80];
    char t6[32];
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    unsigned char t14;
    char *t15;
    unsigned char t16;
    char *t17;
    char *t18;
    unsigned int t19;
    char *t20;

LAB0:    t7 = (t5 + 4U);
    t8 = ((STD_TEXTIO) + 3248);
    t9 = (t7 + 56U);
    *((char **)t9) = t8;
    t10 = (t7 + 40U);
    *((char **)t10) = 0;
    t11 = (t7 + 64U);
    *((int *)t11) = 1;
    t12 = (t7 + 48U);
    *((char **)t12) = 0;
    t13 = (t6 + 4U);
    t14 = (t2 != 0);
    if (t14 == 1)
        goto LAB3;

LAB2:    t15 = (t6 + 12U);
    t16 = (t3 != 0);
    if (t16 == 1)
        goto LAB5;

LAB4:    t17 = (t6 + 20U);
    *((char **)t17) = t4;
    t18 = (t4 + 12U);
    t19 = *((unsigned int *)t18);
    t19 = (t19 * 1U);
    t20 = (char *)alloca(t19);
    memcpy(t20, t3, t19);
    std_textio_write7(STD_TEXTIO, t1, t7, t20, t4, (unsigned char)0, 0);
    std_textio_writeline(STD_TEXTIO, t1, t2, t7);

LAB1:    xsi_access_variable_delete(t7);
    return;
LAB3:    *((char **)t13) = t2;
    goto LAB2;

LAB5:    *((char **)t15) = t3;
    goto LAB4;

}

void work_p_4054474977_sub_3758139270282891836_1800819092(char *t0, char *t1, char *t2, unsigned char t3)
{
    char t4[80];
    char t5[16];
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    char *t14;

LAB0:    t6 = (t4 + 4U);
    t7 = ((STD_TEXTIO) + 3248);
    t8 = (t6 + 56U);
    *((char **)t8) = t7;
    t9 = (t6 + 40U);
    *((char **)t9) = 0;
    t10 = (t6 + 64U);
    *((int *)t10) = 1;
    t11 = (t6 + 48U);
    *((char **)t11) = 0;
    t12 = (t5 + 4U);
    t13 = (t2 != 0);
    if (t13 == 1)
        goto LAB3;

LAB2:    t14 = (t5 + 12U);
    *((unsigned char *)t14) = t3;
    std_textio_write4(STD_TEXTIO, t1, t6, t3, (unsigned char)0, 0);
    std_textio_writeline(STD_TEXTIO, t1, t2, t6);

LAB1:    xsi_access_variable_delete(t6);
    return;
LAB3:    *((char **)t12) = t2;
    goto LAB2;

}

void work_p_4054474977_sub_17157678992489980629_1800819092(char *t0, char *t1, char *t2, char *t3, char *t4)
{
    char t6[32];
    char *t7;
    unsigned char t8;
    char *t9;
    unsigned char t10;
    char *t11;
    char *t12;
    int t13;
    char *t14;
    int t15;
    char *t16;
    int t17;
    int t18;
    int t19;
    int t20;
    int t21;
    char *t22;
    int t23;
    char *t24;
    int t25;
    int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    unsigned char t31;

LAB0:    t7 = (t6 + 4U);
    t8 = (t2 != 0);
    if (t8 == 1)
        goto LAB3;

LAB2:    t9 = (t6 + 12U);
    t10 = (t3 != 0);
    if (t10 == 1)
        goto LAB5;

LAB4:    t11 = (t6 + 20U);
    *((char **)t11) = t4;
    t12 = (t4 + 8U);
    t13 = *((int *)t12);
    t14 = (t4 + 4U);
    t15 = *((int *)t14);
    t16 = (t4 + 0U);
    t17 = *((int *)t16);
    t18 = t17;
    t19 = t15;

LAB6:    t20 = (t19 * t13);
    t21 = (t18 * t13);
    if (t21 <= t20)
        goto LAB7;

LAB9:
LAB1:    return;
LAB3:    *((char **)t7) = t2;
    goto LAB2;

LAB5:    *((char **)t9) = t3;
    goto LAB4;

LAB7:    t22 = (t4 + 0U);
    t23 = *((int *)t22);
    t24 = (t4 + 8U);
    t25 = *((int *)t24);
    t26 = (t18 - t23);
    t27 = (t26 * t25);
    t28 = (1U * t27);
    t29 = (0 + t28);
    t30 = (t3 + t29);
    t31 = *((unsigned char *)t30);
    work_p_4054474977_sub_3758139270282891836_1800819092(t0, t1, t2, t31);
    t12 = (t4 + 0U);
    t15 = *((int *)t12);
    t14 = (t4 + 8U);
    t17 = *((int *)t14);
    t20 = (t18 - t15);
    t27 = (t20 * t17);
    t28 = (1U * t27);
    t29 = (0 + t28);
    t16 = (t3 + t29);
    t8 = *((unsigned char *)t16);
    t10 = (t8 == (unsigned char)10);
    if (t10 != 0)
        goto LAB10;

LAB12:
LAB11:
LAB8:    if (t18 == t19)
        goto LAB9;

LAB14:    t15 = (t18 + t13);
    t18 = t15;
    goto LAB6;

LAB10:    goto LAB9;

LAB13:    goto LAB11;

}


extern void work_p_4054474977_init()
{
	static char *se[] = {(void *)work_p_4054474977_sub_139404078134298855_1800819092,(void *)work_p_4054474977_sub_1914570909748075741_1800819092,(void *)work_p_4054474977_sub_9806269716244591205_1800819092,(void *)work_p_4054474977_sub_1544710075999088019_1800819092,(void *)work_p_4054474977_sub_1324089442196103547_1800819092,(void *)work_p_4054474977_sub_806112259833254140_1800819092,(void *)work_p_4054474977_sub_10123136052646600953_1800819092,(void *)work_p_4054474977_sub_3848912576313210135_1800819092,(void *)work_p_4054474977_sub_895122493602968861_1800819092,(void *)work_p_4054474977_sub_1991549367214789767_1800819092,(void *)work_p_4054474977_sub_1218922380805091609_1800819092,(void *)work_p_4054474977_sub_1218922369151045923_1800819092,(void *)work_p_4054474977_sub_9066030637531271026_1800819092,(void *)work_p_4054474977_sub_9066004450162279423_1800819092,(void *)work_p_4054474977_sub_9666642923616660399_1800819092,(void *)work_p_4054474977_sub_10753423040196883069_1800819092,(void *)work_p_4054474977_sub_9172743049448807586_1800819092,(void *)work_p_4054474977_sub_1368629771300680975_1800819092,(void *)work_p_4054474977_sub_6205399195240504445_1800819092,(void *)work_p_4054474977_sub_16286008207252954496_1800819092,(void *)work_p_4054474977_sub_18128735684734754531_1800819092,(void *)work_p_4054474977_sub_13627294910037070387_1800819092,(void *)work_p_4054474977_sub_5434987555110971454_1800819092,(void *)work_p_4054474977_sub_16102273466969797619_1800819092,(void *)work_p_4054474977_sub_15061112934082860375_1800819092,(void *)work_p_4054474977_sub_12291005972952596459_1800819092,(void *)work_p_4054474977_sub_6024527269204825312_1800819092,(void *)work_p_4054474977_sub_1621482321996872493_1800819092,(void *)work_p_4054474977_sub_3758139270282891836_1800819092,(void *)work_p_4054474977_sub_17157678992489980629_1800819092};
	xsi_register_didat("work_p_4054474977", "isim/TB_MATRIX_MUL_IP_CORE_S_INT_isim_beh.exe.sim/work/p_4054474977.didat");
	xsi_register_subprogram_executes(se);
}
