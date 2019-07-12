#start_gui
open_project fpga_experiments/fpga_experiments.xpr
update_compile_order -fileset sources_1
launch_simulation
#xvlog --incr --relax -L axi_vip_v1_1_5 -L xilinx_vip -prj tb_sha256_scan_vlog.prj
#xelab -wto 0ccdcc0106a94e96823b881381a7f0e4 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_5 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_sha256_scan_behav xil_defaultlib.tb_sha256_scan xil_defaultlib.glbl -log elaborate.log
#open_wave_config /home/nasm/Projects/fpga_ip/fpga_experiments/tb_sha256_scan_behav.wcfg
#source tb_sha256_scan.tcl
 set curr_wave [current_wave_config]
 if { [string length $curr_wave] == 0 } {
   if { [llength [get_objects]] > 0} {
     add_wave /
     set_property needs_save false [current_wave_config]
   } else {
      send_msg_id Add_Wave-1 WARNING "No top level signals found. Simulator will start without a wave window. If you want to open a wave window go to 'File->New Waveform Configuration' or type 'create_wave_config' in the TCL console."
   }
 }
 run 2400ns
start_gui
#launch_simulation: Time (s): cpu = 00:00:10 ; elapsed = 00:00:06 . Memory (MB): peak = 6703.133 ; gain = 87.629 ; free physical = 6989 ; free virtual = 12181

