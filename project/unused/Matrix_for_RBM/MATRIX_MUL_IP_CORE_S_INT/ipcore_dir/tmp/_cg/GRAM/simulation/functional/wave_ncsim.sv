

 
 
 

 



window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"

      waveform add -signals /GRAM_tb/status
      waveform add -signals /GRAM_tb/GRAM_synth_inst/bmg_port/CLKA
      waveform add -signals /GRAM_tb/GRAM_synth_inst/bmg_port/ADDRA
      waveform add -signals /GRAM_tb/GRAM_synth_inst/bmg_port/DINA
      waveform add -signals /GRAM_tb/GRAM_synth_inst/bmg_port/WEA
      waveform add -signals /GRAM_tb/GRAM_synth_inst/bmg_port/ENA
      waveform add -signals /GRAM_tb/GRAM_synth_inst/bmg_port/DOUTA

console submit -using simulator -wait no "run"
