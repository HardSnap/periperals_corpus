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


localparam AES_BASE = 32'H44C0_0000;

localparam BITS_PER_BYTE  = 8;
localparam BYTES_PER_WORD =  4;
localparam BITS_PER_WORD = (BITS_PER_BYTE * BYTES_PER_WORD);

// AES peripheral
localparam AES_NO_KEYS = 3;
localparam AES_PT_BITS =  128;
localparam AES_ST_BITS =  128;
localparam AES_KEY_BITS =  192;
localparam AES_CT_BITS =  128;
localparam AES_START_WORDS = 1;
localparam AES_DONE_WORDS =  1;
localparam AES_PT_WORDS = (AES_PT_BITS / BITS_PER_WORD);
localparam AES_ST_WORDS = (AES_ST_BITS / BITS_PER_WORD);
localparam AES_KEY_WORDS = (AES_KEY_BITS / BITS_PER_WORD);
localparam AES_CT_WORDS = (AES_CT_BITS / BITS_PER_WORD);

localparam AES_START   =  AES_BASE;
localparam AES_PT_BASE   = ( AES_START     + 4*AES_START_WORDS );
localparam AES_KEY0_BASE = ( AES_PT_BASE   + 4*AES_PT_WORDS );
localparam AES_DONE      = ( AES_KEY0_BASE + 4*AES_KEY_WORDS );
localparam AES_CT_BASE   = ( AES_DONE      + 4*AES_DONE_WORDS );
localparam AES_ST_BASE   = ( AES_CT_BASE   + 4*AES_CT_WORDS );
localparam AES_KEY1_BASE = ( AES_ST_BASE   + 4*AES_ST_WORDS );
localparam AES_KEY2_BASE = ( AES_KEY1_BASE + 4*AES_KEY_WORDS );
localparam AES_KEY_SEL   = ( AES_KEY2_BASE + 4*AES_KEY_WORDS );

initial begin

    master_agent = new("slave vip agent",DUT.design_1_i.axi_vip_0.inst.IF);

    master_agent.set_agent_tag("Master VIP");

    master_agent.set_verbosity(400);

    //Start the agent
    master_agent.start_master();

    aresetn = 0;
    #175ns
    aresetn = 1;

    // SET KEY 0
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY0_BASE, prot, 32'h28aed2a6, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D4, prot, 32'h2b7e1516, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D8, prot, 32'h09cf4f3c, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D12, prot, 32'habf71588, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D16, prot, 32'h28aed2a6, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D20, prot, 32'h2b7e1516, resp);

    // SET KEY 1
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY1_BASE, prot, 32'h28aed2a6, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D4, prot, 32'h2b7e1516, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D8, prot, 32'h09cf4f3c, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D12, prot, 32'habf71588, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D16, prot, 32'h28aed2a6, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D20, prot, 32'h2b7e1516, resp);

    // SET KEY 2
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY2_BASE, prot, 32'h28aed2a6, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D4, prot, 32'h2b7e1516, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D8, prot, 32'h09cf4f3c, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D12, prot, 32'habf71588, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D16, prot, 32'h28aed2a6, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D20, prot, 32'h2b7e1516, resp);
    
    //Set key select
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_KEY_SEL, prot, 32'h00000000, resp);
    // Set PT
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_PT_BASE, prot, 32'h66667777, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_PT_BASE+32'D4, prot, 32'h44445555, resp);
    #10ns
    
    master_agent.AXI4LITE_WRITE_BURST(AES_PT_BASE+32'D8, prot, 32'h22223333, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_PT_BASE+32'D12, prot, 32'h00001111, resp);
    // Set st
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_ST_BASE, prot, 32'h3243f6a8, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_ST_BASE+32'D4, prot, 32'h885a308d, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_ST_BASE+32'D8, prot, 32'h313198a2, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_ST_BASE+32'D12, prot, 32'he0370734, resp);
    
    // SET CONTROL -> NEXT
    master_agent.AXI4LITE_WRITE_BURST(AES_START, prot, 32'h00000000, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_START, prot, 32'h00000001, resp);
    #10ns
    master_agent.AXI4LITE_WRITE_BURST(AES_START, prot, 32'h00000000, resp);
    #10ns

    #100

    #200us
    aresetn = 1;
end

endmodule

