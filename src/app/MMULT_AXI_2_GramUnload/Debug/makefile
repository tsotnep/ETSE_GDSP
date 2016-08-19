################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
MMULT_AXI_2_GramUnload.elf.size \


# All Target
all: MMULT_AXI_2_GramUnload.elf secondary-outputs

# Tool invocations
MMULT_AXI_2_GramUnload.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: ARM gcc linker'
	arm-xilinx-eabi-gcc -Wl,-T -Wl,../src/lscript.ld -L../../MMULT_AXI_2_GramUnload_bsp/ps7_cortexa9_0/lib -o "MMULT_AXI_2_GramUnload.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

MMULT_AXI_2_GramUnload.elf.size: MMULT_AXI_2_GramUnload.elf
	@echo 'Invoking: ARM Print Size'
	arm-xilinx-eabi-size MMULT_AXI_2_GramUnload.elf  |tee "MMULT_AXI_2_GramUnload.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(S_UPPER_DEPS)$(C_DEPS)$(ELFSIZE) MMULT_AXI_2_GramUnload.elf
	-@echo ' '

secondary-outputs: $(ELFSIZE)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
