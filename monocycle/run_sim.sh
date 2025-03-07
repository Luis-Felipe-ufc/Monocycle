#./run_sim.sh

# Compila e executa com GUI e configuração personalizada
xrun \
  -sv \
  monociclo_top.sv \
  control.sv \
  main_control.sv \
  ALU_control.sv \
  instr_memory.sv \
  data_memory.sv \
  datapath.sv \
  program_counter.sv \
  register_file.sv \
  signal_extend.sv \
  ALU.sv \
  monociclo_top_tb.sv \
  -timescale 1ns/10ps \
  +access+rwc \
  -gui \
  -input waveform.tcl \
