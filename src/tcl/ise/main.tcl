#this scripts/notes are totally incomplete


#important links



#https://www.doulos.com/knowhow/fpga/Setting_Generics_Parameters_for_Synthesis/

project set "Generics, Parameters" "NBits=4 MaxCount=9" -process "Synthesize - XST"



#http://www.xilinx.com/tools/feature/14_1_isim_quick_reference_guide.pdf

 --generic_top arg Override generic or parameter of a top level design unit with
 specified value( Example: -generic_top "P1=10" )


  fuse –generic_top WIDTH=32 –generic_top DEVICE=VIRTEX5 –timescale 1us/1fs work.tb


 http://www.xilinx.com/support/documentation/sw_manuals/xilinx11/ism_r_entering_simulation_tcl_commands.htm

 http://www.mrc.uidaho.edu/mrc/people/jff/digital/xilinx_sim.html
