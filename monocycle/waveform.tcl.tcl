# SimVision Command Script (sex mar 07 11:49:58 -03 2025)
#
# Version 24.09.s001
#
# You can restore this configuration with:
#
#      xrun -sv monociclo_top.sv control.sv main_control.sv ALU_control.sv instr_memory.sv data_memory.sv datapath.sv program_counter.sv register_file.sv signal_extend.sv ALU.sv monociclo_top_tb.sv -timescale 1ns/10ps +access+rwc -input waveform.tcl
#


#
# Preferences
#
preferences set toolbar-Standard-WatchWindow {
  usual
  shown 0
}
preferences set script-input-warning 0
preferences set txe-locate-add-fibers 1
preferences set signal-type-colors {assertion #FF0000 output #FFA500 group #0099FF inout #00FFFF input #FFFF00 fiber #00EEEE errorsignal #FF0000 unknown #FFFFFF overlay #0099FF internal #00FF00 reference #FFFFFF}
preferences set waveform-print-time range
preferences set txe-navigate-search-locate 0
preferences set txe-view-hold 0
preferences set expand-attributes begin_time
preferences set plugin-enable-svdatabrowser-new 1
preferences set toolbar-Windows-WatchWindow {
  usual
  shown 0
}
preferences set verilog-colors {Su #ff0099 0 {} 1 {} HiZ #ff9900 We #00ffff Pu #9900ff Sm #00ff99 X #ff0000 StrX #ff0000 other #ffff00 Z #ff9900 Me #0000ff La #ff00ff St {}}
preferences set toolbar-sendToIndago-WaveWindow {
  usual
  position -pos 1
}
preferences set txe-navigate-waveform-locate 1
preferences set txe-view-hidden 0
preferences set exportdlg-startFormat vcd
preferences set waveform-print-paper {A4 (210mm x 297mm)}
preferences set toolbar-Standard-Console {
  usual
  position -pos 1
}
preferences set exportdlg-file somador_layout_10kns
preferences set txe-search-show-linenumbers 1
preferences set toolbar-Search-Console {
  usual
  position -pos 2
}
preferences set exportdlg-rangeTo 10,000,000,000
preferences set toolbar-txe_waveform_toggle-WaveWindow {
  usual
  position -pos 1
}
preferences set plugin-enable-groupscope 0
preferences set plugin-enable-interleaveandcompare 0
preferences set plugin-enable-waveformfrequencyplot 0
preferences set toolbar-SimControl-WatchWindow {
  usual
  shown 0
}
preferences set toolbar-Windows-WaveWindow {
  usual
  position -pos 2
}
preferences set txe-navigate-waveform-next-child 1
preferences set vhdl-colors {X #ff0000 0 {} L #00ffff H #00ffff U #9900ff 1 {} - {} Z #ff9900 W #ff0000}
preferences set txe-locate-scroll-x 1
preferences set txe-locate-scroll-y 1
preferences set txe-locate-pop-waveform 1
preferences set whats-new-dont-show-at-startup 1
preferences set toolbar-TimeSearch-WatchWindow {
  usual
  shown 0
}
preferences set exportdlg-rangeFrom 0

#
# Simulator
#
database require simulator -hints {
	simulator "xrun -sv monociclo_top.sv control.sv main_control.sv ALU_control.sv instr_memory.sv data_memory.sv datapath.sv program_counter.sv register_file.sv signal_extend.sv ALU.sv monociclo_top_tb.sv -timescale 1ns/10ps +access+rwc -gui -input waveform.tcl"
}

#
# Mnemonic Maps
#
mmap new  -reuse -name {Boolean as Logic} -radix %b -contents {{%c=FALSE -edgepriority 1 -shape low}
{%c=TRUE -edgepriority 1 -shape high}}
mmap new  -reuse -name {Example Map} -radix %x -contents {{%b=11???? -bgcolor orange -label REG:%x -linecolor yellow -shape bus}
{%x=1F -bgcolor red -label ERROR -linecolor white -shape EVENT}
{%x=2C -bgcolor red -label ERROR -linecolor white -shape EVENT}
{%x=* -label %x -linecolor gray -shape bus}}

#
# Design Browser windows
#
if {[catch {window new WatchList -name "Design Browser 1" -geometry 730x500+261+33}] != ""} {
    window geometry "Design Browser 1" 730x500+261+33
}
window target "Design Browser 1" on
browser using {Design Browser 1}
browser set -scope [subst  {simulator::[format {monociclo_tb}]} ]
browser set \
    -signalsort name
browser yview see [subst  {simulator::[format {monociclo_tb}]} ]
browser timecontrol set -lock 0

#
# Waveform windows
#
if {[catch {window new WaveWindow -name "Waveform 1" -geometry 1920x1043+-1+-1}] != ""} {
    window geometry "Waveform 1" 1920x1043+-1+-1
}
window target "Waveform 1" on
waveform using {Waveform 1}
waveform sidebar visibility partial
waveform set \
    -primarycursor TimeA \
    -signalnames name \
    -signalwidth 175 \
    -units ps \
    -valuewidth 126
waveform baseline set -time 0

set id [waveform add -signals [subst  {
	{simulator::[format {monociclo_tb.clk}]}
	} ]]
set id [waveform add -signals [subst  {
	{simulator::[format {monociclo_tb.reset}]}
	} ]]
set id [waveform add -signals [subst  {
	{simulator::[format {monociclo_tb.DUT.DTP.pc_out[31:0]}]}
	} ]]
waveform format $id -radix %d
set id [waveform add -signals [subst  {
	{simulator::[format {monociclo_tb.DUT.DTP.instruction[31:0]}]}
	} ]]
set id [waveform add -signals [subst  {
	{simulator::[format {monociclo_tb.DUT.DTP.RF.registers[0:31]}]}
	} ]]
waveform hierarchy collapse $id
set id [waveform add -signals [subst  {
	{simulator::[format {monociclo_tb.DUT.DM.memory[0:255]}]}
	} ]]
waveform hierarchy collapse $id

waveform xview limits 0 160000ps

#
# Waveform Window Links
#

#
# Console windows
#
console set -windowname Console
window geometry Console 730x250+261+564

#
# Layout selection
#

