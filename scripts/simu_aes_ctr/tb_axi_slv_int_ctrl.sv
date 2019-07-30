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

initial begin

    master_agent = new("slave vip agent",DUT.design_1_i.axi_vip_0.inst.IF);

    master_agent.set_agent_tag("Master VIP");

    master_agent.set_verbosity(400);

    //Start the agent
    master_agent.start_master();

    aresetn = 0;
    #175ns
    aresetn = 1;

    #10ns
    // Mask Table
    master_agent.AXI4LITE_WRITE_BURST(32'H44A0_0004, prot, 32'B00000000000000000000000000000001, resp);

    #10ns
    // Priorities Table : 4, 3, 1
    master_agent.AXI4LITE_WRITE_BURST(32'H44A0_0008, prot, 32'D92, resp);

    #10ns
    // Control and Status register
    master_agent.AXI4LITE_WRITE_BURST(32'H44A0_0000, prot, 32'H0000_0002, resp);

    #10ns
    // Trig interrupt number 4, 3 , 1
    master_agent.AXI4LITE_WRITE_BURST(32'H44A0_000C, prot, 32'D13, resp);

    #10ns
    // pulse
    master_agent.AXI4LITE_WRITE_BURST(32'H44A0_000C, prot, 32'D0, resp);

    #50ns
    // Ack Current IRQ
    master_agent.AXI4LITE_WRITE_BURST(32'H44A0_0000, prot, 32'D14, resp);

    #200us
    aresetn = 1;

end

endmodule
