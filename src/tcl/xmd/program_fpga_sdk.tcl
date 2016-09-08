xdisconnect -cable
connect arm hw
rst -srst
fpga -f /home/tsotne/workspaceVivado/LEARN_AXI_DMA_1/LEARN_AXI_DMA_1.runs/impl_1/design_1_wrapper.bit
source /home/tsotne/workspaceVivado/xP_DMA/xP_DMA.sdk/Block_Design_wrapper_hw_platform_0/ps7_init.tcl
ps7_init
ps7_post_config
dow /home/tsotne/workspaceVivado/LEARN_AXI_DMA_1/LEARN_AXI_DMA_1.sdk/fsbl/Debug/fsbl.elf
dow /home/tsotne/workspaceVivado/LEARN_AXI_DMA_1/LEARN_AXI_DMA_1.sdk/simple_transfer/Debug/simple_transfer.elf
run


#rst -processor
