#this script can be used to create xilinx IPs of DSP and BRAM

source ../generics.tcl


#create DSP and generate DSP
    create_ip -name xbip_dsp48_macro -vendor xilinx.com -library ip -version 3.0 -module_name DSP_INPUT_C
    set_property -dict [list
        CONFIG.instruction1 {A}
        CONFIG.instruction2 {A*B}
        CONFIG.instruction3 {A*B+P}
        CONFIG.instruction4 {A*B+C}
        CONFIG.instruction5 {A*B+P>>17}
        CONFIG.instruction6 {B*A}
        CONFIG.instruction7 {C}
        CONFIG.areg_1 {true}
        CONFIG.areg_2 {true}
        CONFIG.areg_3 {true}
        CONFIG.areg_4 {true}
        CONFIG.breg_1 {true}
        CONFIG.breg_2 {true}
        CONFIG.breg_3 {true}
        CONFIG.breg_4 {true}
        CONFIG.creg_1 {true}
        CONFIG.creg_2 {true}
        CONFIG.creg_3 {true}
        CONFIG.creg_4 {true}
        CONFIG.creg_5 {true}
        CONFIG.pipeline_options {Expert}
        CONFIG.creg_1 {false}
        CONFIG.creg_2 {false}
        CONFIG.creg_3 {false}
        CONFIG.creg_4 {false}
        CONFIG.creg_5 {false}
        CONFIG.opreg_1 {true}
        CONFIG.opreg_2 {true}
        CONFIG.opreg_3 {true}
        CONFIG.opreg_4 {true}
        CONFIG.opreg_5 {true}
        CONFIG.mreg_5 {true}
        CONFIG.preg_6 {true}
        CONFIG.d_width {18}
        CONFIG.a_width {18}
        CONFIG.a_binarywidth {0}
        CONFIG.b_width {18}
        CONFIG.b_binarywidth {0}
        CONFIG.concat_width {48}
        CONFIG.concat_binarywidth {0}
        CONFIG.c_width {48}
        CONFIG.c_binarywidth {0}
        CONFIG.pcin_binarywidth {0}
        CONFIG.p_full_width {48}
        CONFIG.p_width {48}
        CONFIG.p_binarywidth {0}] [get_ips DSP_INPUT_C]
    generate_target {instantiation_template} [get_files $ORIGIN/project/vivado/s_int/s_int.srcs/sources_1/ip/DSP_INPUT_C/DSP_INPUT_C.xci]
    update_compile_order -fileset sources_1
    #generate_target all [get_files  $ORIGIN/project/vivado/s_int/s_int.srcs/sources_1/ip/DSP_INPUT_C/DSP_INPUT_C.xci]
    #create_ip_run [get_files -of_objects [get_fileset sources_1] $ORIGIN/project/vivado/s_int/s_int.srcs/sources_1/ip/DSP_INPUT_C/DSP_INPUT_C.xci]
    #launch_run -jobs 2 DSP_INPUT_C_synth_1


#create BRAM and generate BRAM
    create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.2 -module_name BRAM18x1k
    set_property -dict [list
        CONFIG.Memory_Type {Simple_Dual_Port_RAM}
        CONFIG.Write_Width_A {18}
        CONFIG.Write_Depth_A {1024}
        CONFIG.Enable_A {Always_Enabled}
        CONFIG.Enable_B {Always_Enabled}
        CONFIG.Use_RSTB_Pin {true}
        CONFIG.Reset_Memory_Latch_B {true}
        CONFIG.Read_Width_A {18}
        CONFIG.Operating_Mode_A {NO_CHANGE}
        CONFIG.Write_Width_B {18}
        CONFIG.Read_Width_B {18}
        CONFIG.Register_PortA_Output_of_Memory_Primitives {false}
        CONFIG.Register_PortB_Output_of_Memory_Primitives {true}
        CONFIG.Port_B_Clock {100}
        CONFIG.Port_B_Enable_Rate {100}] [get_ips BRAM18x1k]
    generate_target {instantiation_template} [get_files $ORIGIN/project/vivado/s_int/s_int.srcs/sources_1/ip/BRAM18x1k/BRAM18x1k.xci]
    update_compile_order -fileset sources_1
    #generate_target all [get_files  $ORIGIN/project/vivado/s_int/s_int.srcs/sources_1/ip/BRAM18x1k/BRAM18x1k.xci]
    #create_ip_run [get_files -of_objects [get_fileset sources_1] $ORIGIN/project/vivado/s_int/s_int.srcs/sources_1/ip/BRAM18x1k/BRAM18x1k.xci]
    #launch_run -jobs 2 BRAM18x1k_synth_1
