`timescale 1ns / 1ps

import design_1_axi_vip_0_0_pkg::*;
import design_1_axi_vip_0_1_pkg::*;
import design_1_axi_vip_2_0_pkg::*;
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


module tb_scannable_aes_ctr(

    );

reg aclk = 0;
reg aresetn = 0;

design_1_wrapper DUT(
    .aclk_0(aclk),
    .aresetn_0(aresetn));

always #1ns aclk = ~aclk;


design_1_axi_vip_0_0_mst_t master_agent_scan_ip;
design_1_axi_vip_0_1_mst_t master_agent_aes_ctr;
design_1_axi_vip_2_0_slv_mem_t slv_mem_agent;

xil_axi_prot_t  prot = 0;
xil_axi_resp_t  resp;

localparam AES_BASE = 32'H44C0_0000;

initial begin

    slv_mem_agent = new("slave vip agent",DUT.design_1_i.axi_vip_2.inst.IF);
    master_agent_scan_ip = new("slave vip agent",DUT.design_1_i.axi_vip_0.inst.IF);
    master_agent_aes_ctr = new("slave vip agent",DUT.design_1_i.axi_vip_1.inst.IF);

    slv_mem_agent.mem_model.set_memory_fill_policy(XIL_AXI_MEMORY_FILL_FIXED);
    slv_mem_agent.mem_model.set_default_memory_value(32'HFFFFFFFF);
    slv_mem_agent.set_agent_tag("Slave VIP");
    slv_mem_agent.set_verbosity(400);

    master_agent_scan_ip.set_agent_tag("Master VIP");
    master_agent_aes_ctr.set_agent_tag("Master VIP");

    master_agent_scan_ip.set_verbosity(400);
    master_agent_aes_ctr.set_verbosity(400);

    //Start the agent
    master_agent_scan_ip.start_master();
    master_agent_aes_ctr.start_master();
    slv_mem_agent.start_slave();

    aresetn = 0;
    #175ns
    aresetn = 1;

    // SET KEY
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D20, prot, 32'h2b7e1516, resp);
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D24, prot, 32'h28aed2a6, resp);
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D28, prot, 32'habf71588, resp);
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D32, prot, 32'h09cf4f3c, resp);
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D36, prot, 32'h00000000, resp);
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D40, prot, 32'h00000000, resp);
    
    #100
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D4, prot, 32'h6bc1bee2, resp);
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D8, prot, 32'h2e409f96, resp);
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D12, prot, 32'he93d7e11, resp);
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D16, prot, 32'h7393172a, resp);
    #10ns

    // SET CONTROL -> NEXT
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D0, prot, 32'h00000001, resp);
    #10ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_BASE+32'D0, prot, 32'h00000000, resp);
    #10ns
    
    #100

    #200us
    aresetn = 1;
end

endmodule


