create_project aes_ctr_scannable_simu /home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu -part xc7z020clg484-1
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
set_property  ip_repo_paths  /home/nasm/Projects/fpga_scan_ip/ip_repo/fast_ip_scanner_1.0 [current_project]
set_property  ip_repo_paths  {/home/nasm/Projects/fpga_scan_ip/ip_repo/fast_ip_scanner_1.0 /home/nasm/Projects/fpga_ip/ip/aes_ctr/aes_ctr_scannable_1.0} [current_project]
update_ip_catalog
create_bd_design "design_1"
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv user.org:user:aes_ctr_scannable:1.0 aes_ctr_scannable_0
endgroup
startgroup
create_bd_cell -type ip -vlnv user.org:user:fast_ip_scanner:1.0 fast_ip_scanner_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_0
endgroup
set_property location {0.5 -25 -224} [get_bd_cells axi_vip_0]
set_property -dict [list CONFIG.PROTOCOL.VALUE_SRC USER] [get_bd_cells axi_vip_0]
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.INTERFACE_MODE {MASTER}] [get_bd_cells axi_vip_0]
startgroup
make_bd_pins_external  [get_bd_pins axi_vip_0/aresetn] [get_bd_pins axi_vip_0/aclk]
endgroup
copy_bd_objs /  [get_bd_cells {axi_vip_0}]
set_property location {1 -49 -76} [get_bd_cells axi_vip_1]
connect_bd_net [get_bd_ports aclk_0] [get_bd_pins axi_vip_1/aclk]
connect_bd_net [get_bd_ports aresetn_0] [get_bd_pins axi_vip_1/aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_vip_0/M_AXI] [get_bd_intf_pins fast_ip_scanner_0/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins axi_vip_1/M_AXI] [get_bd_intf_pins aes_ctr_scannable_0/S00_AXI]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_2
endgroup
set_property -dict [list CONFIG.PROTOCOL.VALUE_SRC USER] [get_bd_cells axi_vip_2]
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.INTERFACE_MODE {SLAVE}] [get_bd_cells axi_vip_2]
connect_bd_intf_net [get_bd_intf_pins axi_vip_2/S_AXI] [get_bd_intf_pins fast_ip_scanner_0/M00_AXI]
connect_bd_net [get_bd_ports aclk_0] [get_bd_pins axi_vip_2/aclk]
connect_bd_net [get_bd_ports aresetn_0] [get_bd_pins axi_vip_2/aresetn]
connect_bd_net [get_bd_pins fast_ip_scanner_0/scan_output] [get_bd_pins aes_ctr_scannable_0/scan_output]
connect_bd_net [get_bd_pins fast_ip_scanner_0/scan_input] [get_bd_pins aes_ctr_scannable_0/scan_input]
connect_bd_net [get_bd_pins fast_ip_scanner_0/scan_ck_en] [get_bd_pins aes_ctr_scannable_0/scan_ck_en]
connect_bd_net [get_bd_pins fast_ip_scanner_0/scan_enable] [get_bd_pins aes_ctr_scannable_0/scan_enable]
connect_bd_net [get_bd_ports aclk_0] [get_bd_pins fast_ip_scanner_0/s00_axi_aclk]
connect_bd_net [get_bd_ports aresetn_0] [get_bd_pins fast_ip_scanner_0/s00_axi_aresetn]
connect_bd_net [get_bd_ports aclk_0] [get_bd_pins fast_ip_scanner_0/m00_axi_aclk]
connect_bd_net [get_bd_ports aresetn_0] [get_bd_pins fast_ip_scanner_0/m00_axi_aresetn]
regenerate_bd_layout
save_bd_design
connect_bd_net [get_bd_ports aclk_0] [get_bd_pins aes_ctr_scannable_0/s00_axi_aclk]
connect_bd_net [get_bd_ports aresetn_0] [get_bd_pins aes_ctr_scannable_0/s00_axi_aresetn]
save_bd_design
make_wrapper -files [get_files /home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse /home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
assign_bd_address
set_property offset 0x00000000 [get_bd_addr_segs {fast_ip_scanner_0/M00_AXI/SEG_axi_vip_2_Reg}]
set_property offset 0x44C00000 [get_bd_addr_segs {axi_vip_1/Master_AXI/SEG_aes_ctr_scannable_0_S00_AXI_reg}]
set_property range 4K [get_bd_addr_segs {axi_vip_1/Master_AXI/SEG_aes_ctr_scannable_0_S00_AXI_reg}]
set_property range 4K [get_bd_addr_segs {axi_vip_0/Master_AXI/SEG_fast_ip_scanner_0_S00_AXI_reg}]
set_property range 512M [get_bd_addr_segs {fast_ip_scanner_0/M00_AXI/SEG_axi_vip_2_Reg}]
save_bd_design
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse /home/nasm/Projects/fpga_ip/scripts/simu_aes_ctr/tb_scannable_aes_ctr.sv
update_compile_order -fileset sim_1
update_compile_order -fileset sim_1
generate_target Simulation [get_files /home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.srcs/sources_1/bd/design_1/design_1.bd]
export_ip_user_files -of_objects [get_files /home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.srcs/sources_1/bd/design_1/design_1.bd] -no_script -sync -force -quiet
export_simulation -of_objects [get_files /home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.srcs/sources_1/bd/design_1/design_1.bd] -directory /home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.ip_user_files/sim_scripts -ip_user_files_dir /home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.ip_user_files -ipstatic_source_dir /home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.ip_user_files/ipstatic -lib_map_path [list {modelsim=/home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.cache/compile_simlib/modelsim} {questa=/home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.cache/compile_simlib/questa} {ies=/home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.cache/compile_simlib/ies} {xcelium=/home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.cache/compile_simlib/xcelium} {vcs=/home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.cache/compile_simlib/vcs} {riviera=/home/nasm/Projects/fpga_ip/aes_ctr_scannable_simu/aes_ctr_scannable_simu.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
launch_simulation
