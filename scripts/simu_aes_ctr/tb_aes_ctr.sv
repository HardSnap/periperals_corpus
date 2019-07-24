`timescale 1ns / 1ps

import design_1_axi_vip_0_0_pkg::*;
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
    .aclk_0(aclk),
    .aresetn_0(aresetn));

always #1ns aclk = ~aclk;

design_1_axi_vip_0_0_mst_t master_agent;

xil_axi_prot_t  prot = 0;
xil_axi_resp_t  resp;

localparam AES_BASE = 32'H44A0_0000;

initial begin

    master_agent = new("slave vip agent",DUT.design_1_i.axi_vip_0.inst.IF);

    master_agent.set_agent_tag("Master VIP");

    master_agent.set_verbosity(400);

    //Start the agent
    master_agent.start_master();

    aresetn = 0;
    #175ns
    aresetn = 1;

    // SET KEY
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D24, prot, 32'h2b7e1516, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D28, prot, 32'h28aed2a6, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D32, prot, 32'habf71588, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D36, prot, 32'h09cf4f3c, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D40, prot, 32'h00000000, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D44, prot, 32'h00000000, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D48, prot, 32'h00000000, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D52, prot, 32'h00000000, resp);
    #10ns
    
    // SET CONFIG
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D4, prot, 32'h00000001, resp);
    #10ns
    
    // SET CONTROL -> INIT
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D0, prot, 32'h00000001, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D0, prot, 32'h00000000, resp);
    #10ns
    
    #100
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D56, prot, 32'h6bc1bee2, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D60, prot, 32'h2e409f96, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D64, prot, 32'he93d7e11, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D68, prot, 32'h7393172a, resp);
    #10ns

    // SET CONTROL -> NEXT
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D0, prot, 32'h00000002, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_BASE+32'D0, prot, 32'h00000000, resp);
    #10ns
    
    #100

    #200us
    aresetn = 1;
end

endmodule


