

 
 
 



 

window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"

      waveform add -signals /BRAM18x1k_tb/status
      waveform add -signals /BRAM18x1k_tb/BRAM18x1k_synth_inst/bmg_port/CLKA
      waveform add -signals /BRAM18x1k_tb/BRAM18x1k_synth_inst/bmg_port/ADDRA
      waveform add -signals /BRAM18x1k_tb/BRAM18x1k_synth_inst/bmg_port/DINA
      waveform add -signals /BRAM18x1k_tb/BRAM18x1k_synth_inst/bmg_port/WEA
      waveform add -signals /BRAM18x1k_tb/BRAM18x1k_synth_inst/bmg_port/RSTB
      waveform add -signals /BRAM18x1k_tb/BRAM18x1k_synth_inst/bmg_port/CLKB
      waveform add -signals /BRAM18x1k_tb/BRAM18x1k_synth_inst/bmg_port/ADDRB
      waveform add -signals /BRAM18x1k_tb/BRAM18x1k_synth_inst/bmg_port/DOUTB

console submit -using simulator -wait no "run"
