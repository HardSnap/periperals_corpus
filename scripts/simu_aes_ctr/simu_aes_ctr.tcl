#start_gui
create_project aes_ctr_simu /home/nasm/Projects/fpga_ip/aes_ctr_simu -part xc7z020clg484-1
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
set_property  ip_repo_paths /home/nasm/Projects/fpga_ip/ip/aes_ctr/AES_CTR_1.0 [current_project]
update_ip_catalog
create_bd_design "design_1"
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv user.org:user:AES_CTR:1.0 aes_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_0
endgroup
set_property -dict [list CONFIG.PROTOCOL.VALUE_SRC USER] [get_bd_cells axi_vip_0]
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.INTERFACE_MODE {MASTER}] [get_bd_cells axi_vip_0]
startgroup
make_bd_pins_external  [get_bd_pins axi_vip_0/aresetn] [get_bd_pins axi_vip_0/aclk]
endgroup
connect_bd_net [get_bd_ports aclk_0] [get_bd_pins aes_0/s00_axi_aclk]
connect_bd_net [get_bd_ports aresetn_0] [get_bd_pins aes_0/s00_axi_aresetn]
connect_bd_intf_net [get_bd_intf_pins aes_0/S00_AXI] [get_bd_intf_pins axi_vip_0/M_AXI]
regenerate_bd_layout
regenerate_bd_layout -routing
save_bd_design
make_wrapper -files [get_files /home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse /home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
assign_bd_address [get_bd_addr_segs {aes_0/S00_AXI/S00_AXI_reg }]
save_bd_design
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse /home/nasm/Projects/fpga_ip/scripts/simu_aes_ctr/tb_aes_ctr.sv
update_compile_order -fileset sim_1
update_compile_order -fileset sim_1
generate_target Simulation [get_files /home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.srcs/sources_1/bd/design_1/design_1.bd]
export_ip_user_files -of_objects [get_files /home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.srcs/sources_1/bd/design_1/design_1.bd] -no_script -sync -force -quiet
export_simulation -of_objects [get_files /home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.srcs/sources_1/bd/design_1/design_1.bd] -directory /home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.ip_user_files/sim_scripts -ip_user_files_dir /home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.ip_user_files -ipstatic_source_dir /home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.ip_user_files/ipstatic -lib_map_path [list {modelsim=/home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.cache/compile_simlib/modelsim} {questa=/home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.cache/compile_simlib/questa} {ies=/home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.cache/compile_simlib/ies} {xcelium=/home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.cache/compile_simlib/xcelium} {vcs=/home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.cache/compile_simlib/vcs} {riviera=/home/nasm/Projects/fpga_ip/aes_ctr_simu/aes_ctr_simu.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
add_files -fileset sim_1 -norecurse /home/nasm/Projects/fpga_ip/scripts/simu_aes_ctr/tb_aes_ctr.wcfg
set_property xsim.view /home/nasm/Projects/fpga_ip/scripts/simu_aes_ctr/tb_aes_ctr.wcfg [get_filesets sim_1]
launch_simulation
