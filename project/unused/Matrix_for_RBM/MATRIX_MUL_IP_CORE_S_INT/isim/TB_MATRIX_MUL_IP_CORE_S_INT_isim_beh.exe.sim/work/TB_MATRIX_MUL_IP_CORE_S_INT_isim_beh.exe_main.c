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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *IEEE_P_3499444699;
char *STD_TEXTIO;
char *IEEE_P_3620187407;
char *IEEE_P_0774719531;
char *XILINXCORELIB_P_1837083571;
char *IEEE_P_1242562249;
char *XILINXCORELIB_P_3381355550;
char *XILINXCORELIB_P_1521474790;
char *XILINXCORELIB_P_3155556343;
char *WORK_P_4054474977;
char *WORK_P_1834709993;
char *WORK_P_3197120514;
char *IEEE_P_3564397177;
char *XILINXCORELIB_P_3743709326;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_1242562249_init();
    std_textio_init();
    work_p_4054474977_init();
    work_p_1834709993_init();
    work_p_3197120514_init();
    work_a_3175912120_3212880686_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    ieee_p_3564397177_init();
    xilinxcorelib_a_1194184697_2959432447_init();
    xilinxcorelib_a_1460919093_2959432447_init();
    xilinxcorelib_a_0143741456_1709443946_init();
    xilinxcorelib_a_2008297547_0543512595_init();
    xilinxcorelib_a_3305966798_3212880686_init();
    work_a_2282909094_4258264813_init();
    work_a_3391381884_3212880686_init();
    work_a_0195739324_3212880686_init();
    work_a_2454247613_3212880686_init();
    ieee_p_0774719531_init();
    xilinxcorelib_p_1837083571_init();
    xilinxcorelib_p_3381355550_init();
    xilinxcorelib_p_3155556343_init();
    xilinxcorelib_p_1521474790_init();
    xilinxcorelib_p_3743709326_init();
    xilinxcorelib_a_1836722241_3212880686_init();
    xilinxcorelib_a_2995454174_3212880686_init();
    xilinxcorelib_a_3985260382_3212880686_init();
    xilinxcorelib_a_0846927809_3212880686_init();
    xilinxcorelib_a_4138043366_3212880686_init();
    xilinxcorelib_a_0693415801_3212880686_init();
    xilinxcorelib_a_3725427157_3212880686_init();
    xilinxcorelib_a_0033335626_3212880686_init();
    xilinxcorelib_a_0298167591_3212880686_init();
    xilinxcorelib_a_3459548600_3212880686_init();
    xilinxcorelib_a_4034251063_3212880686_init();
    xilinxcorelib_a_0797237672_3212880686_init();
    xilinxcorelib_a_2493194524_3212880686_init();
    xilinxcorelib_a_1896190570_3212880686_init();
    xilinxcorelib_a_0032241033_3212880686_init();
    xilinxcorelib_a_3832891135_3212880686_init();
    xilinxcorelib_a_3287447484_3212880686_init();
    xilinxcorelib_a_0469983011_3212880686_init();
    xilinxcorelib_a_1555612650_3212880686_init();
    work_a_3610279713_1016265084_init();
    work_a_4234116168_3212880686_init();
    work_a_1751990263_3212880686_init();
    work_a_3510005016_2372691052_init();


    xsi_register_tops("work_a_3510005016_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_0774719531 = xsi_get_engine_memory("ieee_p_0774719531");
    XILINXCORELIB_P_1837083571 = xsi_get_engine_memory("xilinxcorelib_p_1837083571");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    XILINXCORELIB_P_3381355550 = xsi_get_engine_memory("xilinxcorelib_p_3381355550");
    XILINXCORELIB_P_1521474790 = xsi_get_engine_memory("xilinxcorelib_p_1521474790");
    XILINXCORELIB_P_3155556343 = xsi_get_engine_memory("xilinxcorelib_p_3155556343");
    WORK_P_4054474977 = xsi_get_engine_memory("work_p_4054474977");
    WORK_P_1834709993 = xsi_get_engine_memory("work_p_1834709993");
    WORK_P_3197120514 = xsi_get_engine_memory("work_p_3197120514");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");
    XILINXCORELIB_P_3743709326 = xsi_get_engine_memory("xilinxcorelib_p_3743709326");

    return xsi_run_simulation(argc, argv);

}
