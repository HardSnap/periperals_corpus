`timescale 1ns / 1ps

import top_axi_vip_0_0_pkg::*;
import axi_vip_pkg::*;

module tb_axi_peripheral(

    );

reg aclk = 0;
reg aresetn = 0;
reg interrupt = 0;

top_wrapper DUT
   (.aclk_0(aclk),
    .aresetn_0(aresetn),
    .interrupt_0(interrupt));

always #1ns aclk = ~aclk;

top_axi_vip_0_0_mst_t master_agent_aes_ctr;

xil_axi_prot_t  prot = 0;
xil_axi_resp_t  resp;

localparam AES_BASE = 32'H44A0_0000;

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

    master_agent_aes_ctr = new("slave vip agent",DUT.top_i.axi_vip_0.inst.IF);
    master_agent_aes_ctr.set_agent_tag("Master VIP");
    master_agent_aes_ctr.set_verbosity(400);
    master_agent_aes_ctr.start_master();

    aresetn = 0;
    #175ns
    aresetn = 1;

    set_aes_key0;
    #2ns
    set_aes_key1;
    #2ns
    set_aes_key2;
    #2ns
    select_aes_key;
    #2ns
    set_aes_pt;
    #2ns
    set_aes_st;
    #2ns
    aes_encrypt;

    wait(DUT.top_i.t0.inst.AES_CTR_v1_0_S00_AXI_inst.aes.out_valid == 1'b1);

    assert(DUT.top_i.t0.inst.AES_CTR_v1_0_S00_AXI_inst.aes.out == 128'H75507505518797f60d24a303f5a79079);
end

task set_aes_key0;
begin
    // SET KEY 0
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY0_BASE, prot, 32'h28aed2a6, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D4, prot, 32'h2b7e1516, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D8, prot, 32'h09cf4f3c, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D12, prot, 32'habf71588, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D16, prot, 32'h28aed2a6, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY0_BASE+32'D20, prot, 32'h2b7e1516, resp);
end
endtask

task set_aes_key1;
begin
    // SET KEY 1
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY1_BASE, prot, 32'h28aed2a6, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D4, prot, 32'h2b7e1516, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D8, prot, 32'h09cf4f3c, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D12, prot, 32'habf71588, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D16, prot, 32'h28aed2a6, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY1_BASE+32'D20, prot, 32'h2b7e1516, resp);
end
endtask

task set_aes_key2;
begin
    // SET KEY 2
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY2_BASE, prot, 32'h28aed2a6, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D4, prot, 32'h2b7e1516, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D8, prot, 32'h09cf4f3c, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D12, prot, 32'habf71588, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D16, prot, 32'h28aed2a6, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY2_BASE+32'D20, prot, 32'h2b7e1516, resp);
end
endtask

task select_aes_key;
begin
    //Set key select
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_KEY_SEL, prot, 32'h00000000, resp);
end
endtask

task set_aes_pt;
begin
    // Set PT
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_PT_BASE, prot, 32'h66667777, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_PT_BASE+32'D4, prot, 32'h44445555, resp);
    #2ns   
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_PT_BASE+32'D8, prot, 32'h22223333, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_PT_BASE+32'D12, prot, 32'h00001111, resp);
end
endtask

task set_aes_st;
begin
    // Set st
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_ST_BASE, prot, 32'h3243f6a8, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_ST_BASE+32'D4, prot, 32'h885a308d, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_ST_BASE+32'D8, prot, 32'h313198a2, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_ST_BASE+32'D12, prot, 32'he0370734, resp);
end
endtask

task aes_encrypt;
begin
    // SET CONTROL -> NEXT
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_START, prot, 32'h00000000, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_START, prot, 32'h00000001, resp);
    #2ns
    master_agent_aes_ctr.AXI4LITE_WRITE_BURST(AES_START, prot, 32'h00000000, resp);
end
endtask

endmodule
