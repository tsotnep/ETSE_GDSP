/*
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * 
 *
 * This file is a generated sample test application.
 *
 * This application is intended to test and/or illustrate some 
 * functionality of your system.  The contents of this file may
 * vary depending on the IP in your system and may use existing
 * IP driver functions.  These drivers will be generated in your
 * SDK application project when you run the "Generate Libraries" menu item.
 *
 */


#include <stdio.h>
#include "xparameters.h"
#include "xil_cache.h"
#include "uartlite_header.h"
#include "xbasic_types.h"
#include "xgpio.h"
#include "gpio_header.h"


int main() 
{

	int a;
   Xil_ICacheEnable();
   Xil_DCacheEnable();

   print("---Entering main---\n\r");
//
//
//
//   {
//      int status;
//
//      print("\r\nRunning UartLiteSelfTestExample() for debug_module...\r\n");
//      status = UartLiteSelfTestExample(XPAR_DEBUG_MODULE_DEVICE_ID);
//      if (status == 0) {
//         print("UartLiteSelfTestExample PASSED\r\n");
//      }
//      else {
//         print("UartLiteSelfTestExample FAILED\r\n");
//      }
//   }
//
//   /*
//    * Peripheral SelfTest will not be run for rs232_uart_1
//    * because it has been selected as the STDOUT device
//    */
//
//
//
//   {
//      u32 status;
//
//      print("\r\nRunning GpioInputExample() for dip_switches_8bits...\r\n");
//
//      u32 DataRead;
//
//      status = GpioInputExample(XPAR_DIP_SWITCHES_8BITS_DEVICE_ID, &DataRead);
//
//      if (status == 0) {
//         xil_printf("GpioInputExample PASSED. Read data:0x%X\r\n", DataRead);
//      }
//      else {
//         print("GpioInputExample FAILED.\r\n");
//      }
//   }
//
//
//   {
//      u32 status;
//
//      print("\r\nRunning GpioOutputExample() for leds_8bits...\r\n");
//
//      status = GpioOutputExample(XPAR_LEDS_8BITS_DEVICE_ID,8);
//
//      if (status == 0) {
//         print("GpioOutputExample PASSED.\r\n");
//      }
//      else {
//         print("GpioOutputExample FAILED.\r\n");
//      }
//   }
//
//
//   {
//      u32 status;
//
//      print("\r\nRunning GpioOutputExample() for leds_positions...\r\n");
//
//      status = GpioOutputExample(XPAR_LEDS_POSITIONS_DEVICE_ID,5);
//
//      if (status == 0) {
//         print("GpioOutputExample PASSED.\r\n");
//      }
//      else {
//         print("GpioOutputExample FAILED.\r\n");
//      }
//   }
//
//
//   {
//      u32 status;
//
//      print("\r\nRunning GpioInputExample() for push_buttons_5bits...\r\n");
//
//      u32 DataRead;
//
//      status = GpioInputExample(XPAR_PUSH_BUTTONS_5BITS_DEVICE_ID, &DataRead);
//
//      if (status == 0) {
//         xil_printf("GpioInputExample PASSED. Read data:0x%X\r\n", DataRead);
//      }
//      else {
//         print("GpioInputExample FAILED.\r\n");
//      }
//   }
//for(a=1; a < 5; a++){
   MATRIX_MUL_IP_CORE_SelfTest(XPAR_MATRIX_MUL_IP_CORE_S_INT_G_0_BASEADDR);

   print("---TEST PASSED!!!!\n\n\r---Exiting main---\n\r");
//}

   Xil_DCacheDisable();
   Xil_ICacheDisable();

   return 0;
}

