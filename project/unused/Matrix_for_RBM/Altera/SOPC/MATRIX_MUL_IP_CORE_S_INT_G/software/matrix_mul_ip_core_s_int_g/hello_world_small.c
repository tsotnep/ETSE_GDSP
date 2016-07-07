/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */


/* 					PLS READ ME !!!  Instructions
 *
 * configuration register = MATRIX_MUL_IP_S_INT_0_BASE
 * status register = MATRIX_MUL_IP_S_INT_0_BASE + 4
 * Data in register = MATRIX_MUL_IP_S_INT_0_BASE + 8
 * Data out register = MATRIX_MUL_IP_S_INT_0_BASE + 12
 *
 *
 * configuration register
 * bit[2:0] = 000 = Initialize IP
 * 			  001 = LOAD G RAM
 * 			  010 = LOAD P RAM
 * 			  011 = UN_LOAD P RAM
 * 			  1xx = P * G
 * bit[3] = Bank select (for P RAM)
 * when configured for LOADING if bit[3] = 0 (data is loaded to upper bank else lower bank)
 * when configured for UN_LOAD P if bit[3] = 0 (data is offloaded from lower bank else upper bank) please take note of the inverse.
 *
 * bit[5:4] 00 = P*G
 * 			01 = Pt*G
 * 			10 = P*Gt
 * 			11 = Pt*Gt
 *
 * 			for example if config data = 3; then it means unload P RAM from upper bank
 * 						   config data = 11; means unload P RAM data from lower bank
 * 						   config data = 12; means P*G, save result in lower bank
 * 						   config data = 28; means Pt*G, save result in lower bank
 */


#include "sys/alt_stdio.h"
#include <system.h>
#include <io.h>

int temp = 97;
int status =0;
int config=0;
int DIN[16];
int DOUT[16];


void delay(int cycles);
char * numToChar(int num);



int main()
{

	IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,0,0);// Inititialize IP core
	IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,0,1);// load GRAM command


	int i;

	for(i=1; i<=100; i++)
	{
		IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,8,i);
	}

	while((IORD_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,4) & 4) != 4); // wait for GRAM to finish loading

	IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,0,0);// Inititialize IP core
	IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,0,2);// load P matrix data to upper bank

	alt_printf("DIN:");
	for(i=1; i<=100; i++)
	{
		IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,8,i);
		DIN[i-1] = IORD_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,8);
		alt_printf("%s,", numToChar(DIN[i-1]));
	}


	while((IORD_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,4) & 4) != 4); // wait for BRAM to finish loading

	IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,0,0);//Inititialize IP core
	//delay(10);
	IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,0,12);// send P * G command

	while((IORD_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,4) & 8) != 8); // wait for operation to complete

	IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,0,0);//Inititialize IP core
	alt_printf("\n");
	IOWR_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,0,3);// offload data from lower bank. set change value to 11 to offload from upper bank
	alt_printf("DOUT:\n");


	char cnt = 0;
	char j=0;
	char offset=0;
	for(i=0; i<=100; i++)
		{

			if (i == 0)
				{IORD_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,12);}
			else
			{
				while((IORD_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,4) & 32) != 32); //wait until data is ready

				DOUT[i-1] = IORD_32DIRECT(MATRIX_MUL_IP_S_INT_0_BASE,12);
					if(cnt == 9)
						{cnt = 0;
							for(j=9;j>=0;j--)
							{
								alt_printf("%s,", numToChar(DOUT[j+offset]));
							}
							alt_printf("\n\r");
							offset = offset + 10;
						}
					else
						cnt++;
			}
			//delay(10);
		}


	alt_printf("\n");
	return 0;
}


void delay(int cycles)
{
	int i = 0;
	for (i=0;i<cycles;i++);
}

char * numToChar(int anInteger)
{
	int flag = 0;
		static char str[10] = { 0 };
		    //char str[10] = { 0 }; // large enough for an int even on 64-bit
		    int i = 8;
		    if (anInteger < 0) {
		        flag = 1;
		        anInteger = -anInteger;
		    }

		    while (anInteger != 0) {
		        str[i--] = (anInteger % 10) + '0';
		        anInteger /= 10;
		    }

		    if (flag) str[i--] = '-';

		    return (str + i + 1);
}
