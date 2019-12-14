# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Vivado/lab7/lab7.cache/wt [current_project]
set_property parent.project_path C:/Vivado/lab7/lab7.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Vivado/lab7/lab7.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Vivado/lab7/lab7.srcs/sources_1/new/alu.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/bcd_to_7seg.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/button_debouncer.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/clk_gen.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/control_unit.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/cu_dp.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/led_mux.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/mux2.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/mux4.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/register_file.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/sep_bcd.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/small_calculator_dp.v
  C:/Vivado/lab7/lab7.srcs/sources_1/new/cudp_FPGA.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Vivado/lab7/lab7.srcs/constrs_1/new/cudpFPGA.xdc
set_property used_in_implementation false [get_files C:/Vivado/lab7/lab7.srcs/constrs_1/new/cudpFPGA.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top cudp_FPGA -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef cudp_FPGA.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file cudp_FPGA_utilization_synth.rpt -pb cudp_FPGA_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
