#start_gui
#create_project sha256_intctrl_scan_ip /home/nasm/Projects/fpga_ip/sha256_intctrl_scan_ip -part xc7z020clg484-1
#set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
#create_bd_design "design_1"
#update_compile_order -fileset sources_1
#set_property  ip_repo_paths  /home/nasm/Projects/fpga_ip/sha256_scannable_1.0 [current_project]
#update_ip_catalog
#set_property  ip_repo_paths  {/home/nasm/Projects/fpga_ip/sha256_scannable_1.0 /home/nasm/Projects/fpga_ip/int_ctrl_1.0} [current_project]
#update_ip_catalog
#open_bd_design {/home/nasm/Projects/fpga_ip/sha256_intctrl_scan_ip/sha256_intctrl_scan_ip.srcs/sources_1/bd/design_1/design_1.bd}
#startgroup
#create_bd_cell -type ip -vlnv user.org:user:sha256_scannable:1.0 sha256_scannable_0
#endgroup
#startgroup
#create_bd_cell -type ip -vlnv user.org:user:int_ctrl:1.0 int_ctrl_0
#endgroup
#set_property location {1 63 -107} [get_bd_cells int_ctrl_0]
#update_compile_order -fileset sources_1
#set_property source_mgmt_mode DisplayOnly [current_project]
#current_project sha256_intctrl_scan_ip
#close_bd_design [get_bd_designs design_1]
#close_project
#set_property core_revision 4 [ipx::current_core]
#close_project -delete

create_project -force int_cntrl_fpga /home/nasm/Projects/fpga_ip/int_cntrl_fpga -part xc7z020clg484-1
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
create_bd_design "design_1"
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
startgroup
set_property -dict [list CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1}] [get_bd_cells processing_system7_0]
endgroup
set_property  ip_repo_paths  /home/nasm/Projects/fpga_ip/ip_repo/int_ctrl_1.0 [current_project]
update_ip_catalog
startgroup
create_bd_cell -type ip -vlnv user.org:user:int_ctrl:1.0 int_ctrl_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/int_ctrl_0/S00_AXI} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins int_ctrl_0/S00_AXI]
save_bd_design
make_wrapper -files [get_files /home/nasm/Projects/fpga_ip/int_cntrl_fpga/int_cntrl_fpga.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse /home/nasm/Projects/fpga_ip/int_cntrl_fpga/int_cntrl_fpga.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

file mkdir /home/nasm/Projects/fpga_ip/int_cntrl_fpga/int_cntrl_fpga.sdk
file copy -force /home/nasm/Projects/fpga_ip/int_cntrl_fpga/int_cntrl_fpga.runs/impl_1/design_1_wrapper.sysdef /home/nasm/Projects/fpga_ip/int_cntrl_fpga/int_cntrl_fpga.sdk/design_1_wrapper.hdf

open_hw
connect_hw_server
open_hw_target
set_property PROGRAM.FILE {/home/nasm/Projects/fpga_ip/int_cntrl_fpga/int_cntrl_fpga.runs/impl_1/design_1_wrapper.bit} [get_hw_devices xc7z020_1]
current_hw_device [get_hw_devices xc7z020_1]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7z020_1] 0]
set_property PROBES.FILE {} [get_hw_devices xc7z020_1]
set_property FULL_PROBES.FILE {} [get_hw_devices xc7z020_1]
set_property PROGRAM.FILE {/home/nasm/Projects/fpga_ip/int_cntrl_fpga/int_cntrl_fpga.runs/impl_1/design_1_wrapper.bit} [get_hw_devices xc7z020_1]
program_hw_devices [get_hw_devices xc7z020_1]
refresh_hw_device [lindex [get_hw_devices xc7z020_1] 0]
launch_sdk -workspace /home/nasm/Projects/fpga_ip/int_cntrl_fpga/int_cntrl_fpga.sdk -hwspec /home/nasm/Projects/fpga_ip/int_cntrl_fpga/int_cntrl_fpga.sdk/design_1_wrapper.hdf


