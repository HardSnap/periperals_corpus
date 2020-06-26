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

top_axi_vip_0_0_mst_t master_agent_sha256;

xil_axi_prot_t  prot = 0;
xil_axi_resp_t  resp;

localparam SHA_START = 32'H44B0_0000;

localparam BITS_PER_BYTE  = 8;
localparam BYTES_PER_WORD =  4;
localparam BITS_PER_WORD = (BITS_PER_BYTE * BYTES_PER_WORD);

initial begin

    master_agent_sha256 = new("slave vip agent",DUT.top_i.axi_vip_0.inst.IF);
    master_agent_sha256.set_agent_tag("Master VIP");
    master_agent_sha256.set_verbosity(400);
    master_agent_sha256.start_master();

    aresetn = 0;
    #175ns
    aresetn = 1;

    #2ns
    init_sha;
    #2ns
    hash;

    wait(DUT.top_i.t0.inst.sha256_v1_0_S00_AXI_inst.core.digest_valid == 1'b1);

    assert(DUT.top_i.t0.inst.sha256_v1_0_S00_AXI_inst.core.digest == 256'Hba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad);

end

task init_sha;
begin
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D20, prot, 32'h61626380, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D24, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D28, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D32, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D36, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D40, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D44, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D48, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D52, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D56, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D60, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D64, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D68, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D72, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D76, prot, 32'h00000000, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D80, prot, 32'h00000018, resp);
end
endtask

task hash;
begin
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D4, prot, 32'h00000005, resp);
    #2ns
    master_agent_sha256.AXI4LITE_WRITE_BURST(SHA_START+32'D4, prot, 32'h00000004, resp);
end
endtask

endmodule
