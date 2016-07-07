################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/FPGA/Internship_Jobs/Codes/Virtex6_MUL_IP_CORE2/drivers/matrix_mul_ip_core_s_int_g_v1_00_a/src/matrix_mul_ip_core_s_int_g_selftest.c \
../src/testperiph.c \
../src/xgpio_tapp_example.c \
../src/xuartlite_selftest_example.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/matrix_mul_ip_core_s_int_g_selftest.o \
./src/testperiph.o \
./src/xgpio_tapp_example.o \
./src/xuartlite_selftest_example.o 

C_DEPS += \
./src/matrix_mul_ip_core_s_int_g_selftest.d \
./src/testperiph.d \
./src/xgpio_tapp_example.d \
./src/xuartlite_selftest_example.d 


# Each subdirectory must supply rules for building sources it contributes
src/matrix_mul_ip_core_s_int_g_selftest.o: C:/FPGA/Internship_Jobs/Codes/Virtex6_MUL_IP_CORE2/drivers/matrix_mul_ip_core_s_int_g_v1_00_a/src/matrix_mul_ip_core_s_int_g_selftest.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../hello_world_bsp/microblaze_0/include -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.50.c -mno-xl-soft-mul -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../hello_world_bsp/microblaze_0/include -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.50.c -mno-xl-soft-mul -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


