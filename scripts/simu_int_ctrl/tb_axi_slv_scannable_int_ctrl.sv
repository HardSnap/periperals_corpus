`timescale 1ns / 1ps

import design_1_axi_vip_0_0_pkg::*;
import design_1_axi_vip_0_1_pkg::*;
import design_1_axi_vip_0_2_pkg::*;
import axi_vip_pkg::*;

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2019 01:37:46 PM
// Design Name: 
// Module Name: tb_axi_slv_int_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_axi_slv_int_ctrl(

    );

reg aclk = 0;
reg aresetn = 0;

design_1_wrapper DUT(
    .s00_axi_aclk_0(aclk),
    .s00_axi_aresetn_0(aresetn));

always #1ns aclk = ~aclk;

design_1_axi_vip_0_0_mst_t master_agent_scan_ip;
design_1_axi_vip_0_1_mst_t master_agent_int_ctrl;
design_1_axi_vip_0_2_slv_mem_t slv_mem_agent;

xil_axi_prot_t  prot = 0;
xil_axi_resp_t  resp;

initial begin

    slv_mem_agent = new("slave vip agent",DUT.design_1_i.axi_vip_2.inst.IF);
    master_agent_scan_ip = new("slave vip agent",DUT.design_1_i.axi_vip_0.inst.IF);
    master_agent_int_ctrl = new("slave vip agent",DUT.design_1_i.axi_vip_1.inst.IF);

    slv_mem_agent.mem_model.set_memory_fill_policy(XIL_AXI_MEMORY_FILL_FIXED);
    slv_mem_agent.mem_model.set_default_memory_value(32'HFFFFFFFF);
    slv_mem_agent.set_agent_tag("Slave VIP");
    slv_mem_agent.set_verbosity(400);

    master_agent_scan_ip.set_agent_tag("Master VIP");
    master_agent_int_ctrl.set_agent_tag("Master VIP");

    master_agent_scan_ip.set_verbosity(400);
    master_agent_int_ctrl.set_verbosity(400);

    //Start the agent
    master_agent_scan_ip.start_master();
    master_agent_int_ctrl.start_master();
    slv_mem_agent.start_slave();

    aresetn = 0;
    #175ns
    aresetn = 1;

    #10ns
    // Mask Table
    master_agent_int_ctrl.AXI4LITE_WRITE_BURST(32'H44C0_0004, prot, 32'B00000000000000000000000000000001, resp);

    #10ns
    // Priorities Table : 4, 3, 1
    master_agent_int_ctrl.AXI4LITE_WRITE_BURST(32'H44C0_0008, prot, 32'D92, resp);

    #10ns
    // Control and Status register
    master_agent_int_ctrl.AXI4LITE_WRITE_BURST(32'H44C0_0000, prot, 32'H0000_0002, resp);

    #10ns
    // Trig interrupt number 4, 3 , 1
    master_agent_int_ctrl.AXI4LITE_WRITE_BURST(32'H44C0_000C, prot, 32'D13, resp);

    #10ns
    // pulse
    master_agent_int_ctrl.AXI4LITE_WRITE_BURST(32'H44C0_000C, prot, 32'D0, resp);

    #10ns
    master_agent_scan_ip.AXI4LITE_WRITE_BURST(32'H44A0_0000, prot, 32'H0000_0000, resp);
    #10ns
    master_agent_scan_ip.AXI4LITE_WRITE_BURST(32'H44A0_0004, prot, 32'H0000_0400, resp);
    #10ns
    master_agent_scan_ip.AXI4LITE_WRITE_BURST(32'H44A0_0008, prot, 32'D64, resp);
    #10ns
    master_agent_scan_ip.AXI4LITE_WRITE_BURST(32'H44A0_000C, prot, 32'D1, resp);
    #2ns
    master_agent_scan_ip.AXI4LITE_WRITE_BURST(32'H44A0_000C, prot, 32'D0, resp);

    #400ns
    master_agent_scan_ip.AXI4LITE_WRITE_BURST(32'H44A0_0000, prot, 32'H0000_0400, resp);
    #10ns
    master_agent_scan_ip.AXI4LITE_WRITE_BURST(32'H44A0_0004, prot, 32'H0000_0000, resp);

    #10ns
    master_agent_scan_ip.AXI4LITE_WRITE_BURST(32'H44A0_000C, prot, 32'D1, resp);
    #2ns
    master_agent_scan_ip.AXI4LITE_WRITE_BURST(32'H44A0_000C, prot, 32'D0, resp);

    #50ns
    // Ack Current IRQ
    master_agent_int_ctrl.AXI4LITE_WRITE_BURST(32'H44C0_0000, prot, 32'D14, resp);

    #200us
    aresetn = 1;

end

endmodule
