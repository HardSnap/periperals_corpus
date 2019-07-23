#start_gui
create_project -force int_ctrl_simu /home/nasm/Projects/fpga_ip/int_ctrl_simu -part xc7z020clg484-1
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
create_bd_design "design_1"
update_compile_order -fileset sources_1
set_property  ip_repo_paths  /home/nasm/Projects/fpga_ip/int_ctrl_1.0 [current_project]
update_ip_catalog
set_property  ip_repo_paths  {} [current_project]
update_ip_catalog
set_property  ip_repo_paths  /home/nasm/Projects/fpga_ip/ip_repo/int_ctrl_1.0 [current_project]
update_ip_catalog
startgroup
create_bd_cell -type ip -vlnv user.org:user:int_ctrl:1.0 int_ctrl_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_0
endgroup
set_property location {1 31 -149} [get_bd_cells axi_vip_0]
connect_bd_intf_net [get_bd_intf_pins int_ctrl_0/S00_AXI] [get_bd_intf_pins axi_vip_0/M_AXI]
startgroup
set_property -dict [list CONFIG.PROTOCOL.VALUE_SRC USER] [get_bd_cells axi_vip_0]
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.INTERFACE_MODE {MASTER}] [get_bd_cells axi_vip_0]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins axi_vip_0/aresetn] [get_bd_pins axi_vip_0/aclk]
endgroup
connect_bd_net [get_bd_ports aresetn_0] [get_bd_pins int_ctrl_0/s00_axi_aresetn]
connect_bd_net [get_bd_ports aclk_0] [get_bd_pins int_ctrl_0/s00_axi_aclk]
regenerate_bd_layout
save_bd_design
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse /home/nasm/Projects/fpga_ip/scripts/simu_int_ctrl/tb_axi_slv_int_ctrl.sv
make_wrapper -files [get_files /home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse /home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
assign_bd_address
save_bd_design

update_compile_order -fileset sources_1
generate_target Simulation [get_files /home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.srcs/sources_1/bd/design_1/design_1.bd]
export_ip_user_files -of_objects [get_files /home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.srcs/sources_1/bd/design_1/design_1.bd] -no_script -sync -force -quiet
export_simulation -of_objects [get_files /home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.srcs/sources_1/bd/design_1/design_1.bd] -directory /home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.ip_user_files/sim_scripts -ip_user_files_dir /home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.ip_user_files -ipstatic_source_dir /home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.ip_user_files/ipstatic -lib_map_path [list {modelsim=/home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.cache/compile_simlib/modelsim} {questa=/home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.cache/compile_simlib/questa} {ies=/home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.cache/compile_simlib/ies} {xcelium=/home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.cache/compile_simlib/xcelium} {vcs=/home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.cache/compile_simlib/vcs} {riviera=/home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
set_property top design_1_wrapper [current_fileset]
#set_property top tb_axi_slv_int_ctrl [current_fileset]
#set_property top_file {C:/Data/sources/tb_axi_slv_int_ctrl.sv} [current_fileset]

launch_simulation
source /home/nasm/Projects/fpga_ip/int_ctrl_simu/int_ctrl_simu.sim/sim_1/behav/xsim/xsim.dir/tb_axi_slv_int_ctrl_behav/webtalk/xsim_webtalk.tcl -notrace
source tb_axi_slv_int_ctrl.tcl
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

