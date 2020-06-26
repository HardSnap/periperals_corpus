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
create_project -part xc7z020clg484-1 -force dispatcher dispatcher_ip
set sources {dispatcher}
foreach f $sources {
        add_files $rootdir/hardsnap_ip/$f.vhd
}
import_files -force -norecurse
ipx::package_project -root_dir dispatcher_ip -vendor www.eurecom.fr -library ip -force dispatcher
close_project

###################
# Create MEMAP
###################
create_project -part xc7z020clg484-1 -force memap memap_ip
set sources { memap }
foreach f $sources {
        add_files $rootdir/hardsnap_ip/$f.v
}
import_files -force -norecurse
ipx::package_project -root_dir memap_ip -vendor www.eurecom.fr -library ip -force memap
close_project

###################
# Create gpif
###################
create_project -part xc7z020clg484-1 -force gpif gpif_ip
set sources { gpif oddr2 tristate}
foreach f $sources {
        add_files $rootdir/hardsnap_ip/$f.vhd
}
import_files -force -norecurse
ipx::package_project -root_dir gpif_ip -vendor www.eurecom.fr -library ip -force gpif
close_project

set top top
create_project -part xc7z020clg484-1 -force $top .
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
set_property ip_repo_paths { ./dispatcher_ip ./gpif_ip ./memap_ip } [current_fileset]
update_ip_catalog
create_bd_design "$top"


create_bd_cell -type ip -vlnv www.eurecom.fr:ip:MemAP:1.0 MemAP_0
create_bd_cell -type ip -vlnv www.eurecom.fr:ip:Dispatcher:1.0 Dispatcher_0
create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0
create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_1
create_bd_cell -type ip -vlnv www.eurecom.fr:ip:GPIF:1.0 GPIF_0

set_property -dict [list CONFIG.Input_Data_Width {32} CONFIG.Input_Depth {4096} CONFIG.Output_Data_Width {64} CONFIG.Output_Depth {2048} CONFIG.Reset_Pin {false} CONFIG.Reset_Type {Asynchronous_Reset} CONFIG.Use_Dout_Reset {false} CONFIG.Use_Extra_Logic {true} CONFIG.Data_Count_Width {12} CONFIG.Write_Data_Count_Width {13} CONFIG.Read_Data_Count_Width {12} CONFIG.Full_Threshold_Assert_Value {4093} CONFIG.Full_Threshold_Negate_Value {4092}] [get_bd_cells fifo_generator_0]
set_property -dict [list CONFIG.Input_Data_Width {32} CONFIG.Input_Depth {4096} CONFIG.Output_Data_Width {64} CONFIG.Output_Depth {2048} CONFIG.Reset_Pin {false} CONFIG.Reset_Type {Asynchronous_Reset} CONFIG.Use_Dout_Reset {false} CONFIG.Use_Extra_Logic {true} CONFIG.Data_Count_Width {12} CONFIG.Write_Data_Count_Width {13} CONFIG.Read_Data_Count_Width {12} CONFIG.Full_Threshold_Assert_Value {4093} CONFIG.Full_Threshold_Negate_Value {4092}] [get_bd_cells fifo_generator_1]
# Flop FIFO dout to get 2 cycles of latency and to reduce constraint between FIFO and Tristate
#set_property -dict [list CONFIG.Use_Embedded_Registers {true} CONFIG.Output_Register_Type {Embedded_Reg}] [get_bd_cells fifo_generator_1]

connect_bd_net [get_bd_pins fifo_generator_0/full] [get_bd_pins Dispatcher_0/full]
connect_bd_net [get_bd_pins fifo_generator_0/din] [get_bd_pins Dispatcher_0/din]
connect_bd_net [get_bd_pins fifo_generator_0/wr_en] [get_bd_pins Dispatcher_0/wr_en]

connect_bd_net [get_bd_pins MemAP_0/start_single_read] [get_bd_pins Dispatcher_0/target_start_read]
connect_bd_net [get_bd_pins MemAP_0/start_single_write] [get_bd_pins Dispatcher_0/target_start_write]
connect_bd_net [get_bd_pins MemAP_0/data] [get_bd_pins Dispatcher_0/data]
connect_bd_net [get_bd_pins MemAP_0/addr] [get_bd_pins Dispatcher_0/addr]
connect_bd_net [get_bd_pins MemAP_0/busy] [get_bd_pins Dispatcher_0/target_busy]
connect_bd_net [get_bd_pins MemAP_0/res] [get_bd_pins Dispatcher_0/target_res]

connect_bd_net [get_bd_pins fifo_generator_1/empty] [get_bd_pins Dispatcher_0/empty]
connect_bd_net [get_bd_pins fifo_generator_1/dout] [get_bd_pins Dispatcher_0/dout]
connect_bd_net [get_bd_pins fifo_generator_1/rd_en] [get_bd_pins Dispatcher_0/rd_en]

create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1}] [get_bd_cells processing_system7_0]

connect_bd_net [get_bd_pins GPIF_0/wr_en] [get_bd_pins fifo_generator_1/wr_en]
connect_bd_net [get_bd_pins GPIF_0/rd_en] [get_bd_pins fifo_generator_0/rd_en]
connect_bd_net [get_bd_pins GPIF_0/din] [get_bd_pins fifo_generator_1/din]
connect_bd_net [get_bd_pins GPIF_0/full] [get_bd_pins fifo_generator_1/full]
connect_bd_net [get_bd_pins GPIF_0/dout] [get_bd_pins fifo_generator_0/dout]
connect_bd_net [get_bd_pins GPIF_0/empty] [get_bd_pins fifo_generator_0/empty]

# Slave FIFO
create_bd_port -dir O clk_out
connect_bd_net [get_bd_pins /GPIF_0/clk_out] [get_bd_ports clk_out]

create_bd_port -dir IO -from 31 -to 0 fdata
connect_bd_net [get_bd_pins /GPIF_0/data] [get_bd_ports fdata]

create_bd_port -dir O -from 1 -to 0 sladdr
connect_bd_net [get_bd_pins /GPIF_0/addr] [get_bd_ports sladdr]

create_bd_port -dir O sloe
connect_bd_net [get_bd_pins /GPIF_0/oe] [get_bd_ports sloe]

create_bd_port -dir O slop
connect_bd_net [get_bd_pins /GPIF_0/op] [get_bd_ports slop]

create_bd_port -dir I slwr_rdy
connect_bd_net [get_bd_pins /GPIF_0/wr_rdy] [get_bd_ports slwr_rdy]

create_bd_port -dir I slrd_rdy
connect_bd_net [get_bd_pins /GPIF_0/rd_rdy] [get_bd_ports slrd_rdy]

# Primary IOs
create_bd_port -dir O -from 7 -to 0 led
connect_bd_net [get_bd_pins /GPIF_0/status] [get_bd_ports led]

apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (100 MHz)" }  [get_bd_pins Dispatcher_0/aclk]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (100 MHz)" }  [get_bd_pins fifo_generator_0/clk]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (100 MHz)" }  [get_bd_pins fifo_generator_1/clk]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (100 MHz)" }  [get_bd_pins GPIF_0/aclk]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/MemAP_0/m00_axi} Slave {/processing_system7_0/S_AXI_HP0} intc_ip {Auto} master_apm {0}}  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
set_property -dict [list CONFIG.PCW_USE_M_AXI_GP0 {0} CONFIG.PCW_USE_S_AXI_GP0 {0} CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1}] [get_bd_cells processing_system7_0]

# Synthesis flow
validate_bd_design
set files [get_files *$top.bd]
generate_target all $files
add_files -norecurse -force [make_wrapper -files $files -top]
save_bd_design
set run [get_runs synth*]
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none $run
launch_runs $run
wait_on_run $run
open_run $run

# IOs
#        "mem_ap_busy"   { "F22"  "LVCMOS25"}

array set ios {
	"led[0]"        { "T22"  "LVCMOS33" }
	"led[1]"        { "T21"  "LVCMOS33" }
	"led[2]"        { "U22"  "LVCMOS33" }
	"led[3]"        { "U21"  "LVCMOS33" }
	"led[7]"   { "U14"  "LVCMOS33" }
	"led[6]"   { "U19"  "LVCMOS33" }
	"led[5]"   { "W22"  "LVCMOS33" }
	"led[4]"   { "V22"  "LVCMOS33" }
        "clk_out"       { "M19"  "LVCMOS25" }
        "sloe"          { "G21"  "LVCMOS25" }
        "slop"          { "G20"  "LVCMOS25" }
        "slwr_rdy"      { "F19"  "LVCMOS25" }
        "slrd_rdy"      { "C22"  "LVCMOS25" }
        "sladdr[0]"     { "B21"  "LVCMOS25" }
        "sladdr[1]"     { "B22"  "LVCMOS25" }
        "fdata[24]"      { "L18"  "LVCMOS25" }
        "fdata[25]"      { "P17"  "LVCMOS25" }
        "fdata[26]"      { "P18"  "LVCMOS25" }
        "fdata[27]"      { "M21"  "LVCMOS25" }
        "fdata[28]"      { "M22"  "LVCMOS25" }
        "fdata[29]"      { "T16"  "LVCMOS25" }
        "fdata[30]"      { "T17"  "LVCMOS25" }
        "fdata[31]"      { "N17"  "LVCMOS25" }
        "fdata[16]"      { "N18"  "LVCMOS25" }
        "fdata[17]"      { "J16"  "LVCMOS25" }
        "fdata[18]"     { "J17"  "LVCMOS25" }
        "fdata[19]"     { "G15"  "LVCMOS25" }
        "fdata[20]"     { "G16"  "LVCMOS25" }
        "fdata[21]"     { "E19"  "LVCMOS25" }
        "fdata[22]"     { "E20"  "LVCMOS25" }
        "fdata[23]"     { "A18"  "LVCMOS25" }
        "fdata[8]"     { "A19"  "LVCMOS25" }
        "fdata[9]"     { "A16"  "LVCMOS25" }
        "fdata[10]"     { "A17"  "LVCMOS25" }
        "fdata[11]"     { "C15"  "LVCMOS25" }
        "fdata[12]"     { "B15"  "LVCMOS25" }
        "fdata[13]"     { "A21"  "LVCMOS25" }
        "fdata[14]"     { "A22"  "LVCMOS25" }
        "fdata[15]"     { "D18"  "LVCMOS25" }
        "fdata[0]"     { "C19"  "LVCMOS25" }
        "fdata[1]"     { "N22"  "LVCMOS25" }
        "fdata[2]"     { "P22"  "LVCMOS25" }
        "fdata[3]"     { "J21"  "LVCMOS25" }
        "fdata[4]"     { "J22"  "LVCMOS25" }
        "fdata[5]"     { "P20"  "LVCMOS25" }
        "fdata[6]"     { "P21"  "LVCMOS25" }
        "fdata[7]"     { "J20"  "LVCMOS25" }
	}

foreach io [ array names ios ] {
	set pin [ lindex $ios($io) 0 ]
	set std [ lindex $ios($io) 1 ]
	set_property package_pin $pin [get_ports $io]
	set_property iostandard $std [get_ports [list $io]]
}

# Timing constraints
set clock [get_clocks]
set_false_path -from $clock -to [get_ports {led[*]}]
#set_false_path -from $clock -to [get_ports {jtag_state_led[*]}]
#set_false_path -from [get_ports {irq_in]}] -to $clock
#set_false_path -from [get_ports {irq_in}] -to $clock

create_generated_clock -source [get_pins -hierarchical GPIF_0/aclk] -master_clock [get_clocks] -add -name clk_out [get_ports clk_out] -edges {2 3 4}

set clock [get_clocks clk_fpga_0]
#set_output_delay -clock $clock 1 [get_ports irq_ack]
set_input_delay -clock $clock 1 [get_ports fdata]
set_input_delay -clock $clock 1 [get_ports slwr_rdy]
#set_input_delay -clock $clock 1 [get_ports slwrirq_rdy]
set_input_delay -clock $clock 1 [get_ports slrd_rdy]

#set clock [get_clocks clk_out]
set_output_delay -clock $clock 1 [get_ports fdata]
set_output_delay -clock $clock 1 [get_ports slop]
set_output_delay -clock $clock 1 [get_ports sloe]
set_output_delay -clock $clock 1 [get_ports sladdr]


# Implementation
save_constraints
set run [get_runs impl*]
reset_run $run
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true $run
launch_runs -to_step write_bitstream $run
wait_on_run $run

# Messages
set rundir ${builddir}/$top.runs/$run
puts ""
puts "\[VIVADO\]: done"
puts "  bitstream in $rundir/${top}_wrapper.bit"
puts "  resource utilization report in $rundir/${top}_wrapper_utilization_placed.rpt"
puts "  timing report in $rundir/${top}_wrapper_timing_summary_routed.rpt"


file mkdir $rundir/top.sdk
file copy -force $rundir/top.runs/impl_1/top_wrapper.sysdef $rundir/top.sdk/top_wrapper.hdf

