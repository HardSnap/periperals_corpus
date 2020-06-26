#
# Author  : Corteggiani Nassim
# Company : EURECOM
# DATA    : 2019

proc usage {} {
	puts "usage: vivado -mode batch -source <script> -tclargs <rootdir> <builddir>"
	puts "  <rootdir>:  absolute path of usb2jtag root directory"
	puts "  <builddir>: absolute path of build directory"
	exit -1
}

if { $argc == 2 } {
	set rootdir [lindex $argv 0]
	set builddir [lindex $argv 1]
} else {
	usage
}

cd $builddir

###################
# Create DISPATCHER 
###################
create_project -part xc7z020clg484-1 -force t0 t0_ip
set sources [glob -directory ../hdl *.v]
foreach f $sources {
        add_files $builddir$f
}
import_files -force -norecurse
ipx::package_project -root_dir t0_ip -vendor www.eurecom.fr -library ip -force t0
close_project

set top top
create_project -part xc7z020clg484-1 -force $top .
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
set_property ip_repo_paths { ./t0_ip } [current_fileset]
update_ip_catalog
create_bd_design "$top"

create_bd_cell -type ip -vlnv www.eurecom.fr:ip:aes_ctr:1.0 t0
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_0

make_bd_pins_external  [get_bd_pins t0/interrupt] [get_bd_pins axi_vip_0/aresetn] [get_bd_pins axi_vip_0/aclk]
connect_bd_net [get_bd_ports aclk_0] [get_bd_pins t0/s00_axi_aclk]
connect_bd_net [get_bd_ports aresetn_0] [get_bd_pins t0/s00_axi_aresetn]

set_property -dict [list CONFIG.PROTOCOL {AXI4LITE}] [get_bd_cells axi_vip_0]
set_property -dict [list CONFIG.PROTOCOL.VALUE_SRC USER] [get_bd_cells axi_vip_0]
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.INTERFACE_MODE {MASTER}] [get_bd_cells axi_vip_0]

connect_bd_intf_net [get_bd_intf_pins axi_vip_0/M_AXI] [get_bd_intf_pins t0/s00_axi]

assign_bd_address [get_bd_addr_segs {axi_vip_0/S_AXI/Reg }]
set_property offset 0x00000000 [get_bd_addr_segs {axi_vip_0/Master_AXI/SEG_t0_reg0}]
set_property range 4G [get_bd_addr_segs {axi_vip_0/Master_AXI/SEG_t0_reg0}]

make_wrapper -files [get_files $builddir/top.srcs/sources_1/bd/top/top.bd] -top
add_files -norecurse $builddir/top.srcs/sources_1/bd/top/hdl/top_wrapper.v

set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $builddir/../tb/testbench.sv
update_compile_order -fileset sim_1

save_bd_design

generate_target Simulation [get_files $builddir/top.srcs/sources_1/bd/top/top.bd]
export_ip_user_files -of_objects [get_files $builddir/top.srcs/sources_1/bd/top/top.bd] -no_script -sync -force -quiet
export_simulation -of_objects [get_files $builddir/top.srcs/sources_1/bd/top/top.bd] -directory $builddir/top.ip_user_files/sim_scripts -ip_user_files_dir $builddir/top.ip_user_files -ipstatic_source_dir $builddir/top.ip_user_files/ipstatic -lib_map_path [list {modelsim=$builddir/top.cache/compile_simlib/modelsim} {questa=$builddir/top.cache/compile_simlib/questa} {ies=$builddir/top.cache/compile_simlib/ies} {xcelium=$builddir/top.cache/compile_simlib/xcelium} {vcs=$builddir/top.cache/compile_simlib/vcs} {riviera=$builddir/top.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet

launch_simulation

#start_gui

