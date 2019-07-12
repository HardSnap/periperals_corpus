//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
//Date        : Fri Jul 12 10:47:41 2019
//Host        : kaby-lake-TERRA-PC running 64-bit Ubuntu 18.04.2 LTS
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=2,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (aclk_0,
    aresetn_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK_0, ASSOCIATED_RESET aresetn_0, CLK_DOMAIN design_1_aclk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input aclk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input aresetn_0;

  wire aclk_0_1;
  wire aresetn_0_1;
  wire [31:0]axi_vip_0_M_AXI_ARADDR;
  wire [2:0]axi_vip_0_M_AXI_ARPROT;
  wire axi_vip_0_M_AXI_ARREADY;
  wire axi_vip_0_M_AXI_ARVALID;
  wire [31:0]axi_vip_0_M_AXI_AWADDR;
  wire [2:0]axi_vip_0_M_AXI_AWPROT;
  wire axi_vip_0_M_AXI_AWREADY;
  wire axi_vip_0_M_AXI_AWVALID;
  wire axi_vip_0_M_AXI_BREADY;
  wire [1:0]axi_vip_0_M_AXI_BRESP;
  wire axi_vip_0_M_AXI_BVALID;
  wire [31:0]axi_vip_0_M_AXI_RDATA;
  wire axi_vip_0_M_AXI_RREADY;
  wire [1:0]axi_vip_0_M_AXI_RRESP;
  wire axi_vip_0_M_AXI_RVALID;
  wire [31:0]axi_vip_0_M_AXI_WDATA;
  wire axi_vip_0_M_AXI_WREADY;
  wire [3:0]axi_vip_0_M_AXI_WSTRB;
  wire axi_vip_0_M_AXI_WVALID;
  wire [31:0]axi_vip_1_M_AXI_ARADDR;
  wire [2:0]axi_vip_1_M_AXI_ARPROT;
  wire axi_vip_1_M_AXI_ARREADY;
  wire axi_vip_1_M_AXI_ARVALID;
  wire [31:0]axi_vip_1_M_AXI_AWADDR;
  wire [2:0]axi_vip_1_M_AXI_AWPROT;
  wire axi_vip_1_M_AXI_AWREADY;
  wire axi_vip_1_M_AXI_AWVALID;
  wire axi_vip_1_M_AXI_BREADY;
  wire [1:0]axi_vip_1_M_AXI_BRESP;
  wire axi_vip_1_M_AXI_BVALID;
  wire [31:0]axi_vip_1_M_AXI_RDATA;
  wire axi_vip_1_M_AXI_RREADY;
  wire [1:0]axi_vip_1_M_AXI_RRESP;
  wire axi_vip_1_M_AXI_RVALID;
  wire [31:0]axi_vip_1_M_AXI_WDATA;
  wire axi_vip_1_M_AXI_WREADY;
  wire [3:0]axi_vip_1_M_AXI_WSTRB;
  wire axi_vip_1_M_AXI_WVALID;
  wire [31:0]fast_ip_scanner_0_M00_AXI_ARADDR;
  wire [2:0]fast_ip_scanner_0_M00_AXI_ARPROT;
  wire fast_ip_scanner_0_M00_AXI_ARREADY;
  wire fast_ip_scanner_0_M00_AXI_ARVALID;
  wire [31:0]fast_ip_scanner_0_M00_AXI_AWADDR;
  wire [2:0]fast_ip_scanner_0_M00_AXI_AWPROT;
  wire fast_ip_scanner_0_M00_AXI_AWREADY;
  wire fast_ip_scanner_0_M00_AXI_AWVALID;
  wire fast_ip_scanner_0_M00_AXI_BREADY;
  wire [1:0]fast_ip_scanner_0_M00_AXI_BRESP;
  wire fast_ip_scanner_0_M00_AXI_BVALID;
  wire [31:0]fast_ip_scanner_0_M00_AXI_RDATA;
  wire fast_ip_scanner_0_M00_AXI_RREADY;
  wire [1:0]fast_ip_scanner_0_M00_AXI_RRESP;
  wire fast_ip_scanner_0_M00_AXI_RVALID;
  wire [31:0]fast_ip_scanner_0_M00_AXI_WDATA;
  wire fast_ip_scanner_0_M00_AXI_WREADY;
  wire [3:0]fast_ip_scanner_0_M00_AXI_WSTRB;
  wire fast_ip_scanner_0_M00_AXI_WVALID;
  wire fast_ip_scanner_0_scan_ck_en;
  wire fast_ip_scanner_0_scan_enable;
  wire fast_ip_scanner_0_scan_input;
  wire sha256_scannable_0_scan_output;

  assign aclk_0_1 = aclk_0;
  assign aresetn_0_1 = aresetn_0;
  design_1_axi_vip_0_0 axi_vip_0
       (.aclk(aclk_0_1),
        .aresetn(aresetn_0_1),
        .m_axi_araddr(axi_vip_0_M_AXI_ARADDR),
        .m_axi_arprot(axi_vip_0_M_AXI_ARPROT),
        .m_axi_arready(axi_vip_0_M_AXI_ARREADY),
        .m_axi_arvalid(axi_vip_0_M_AXI_ARVALID),
        .m_axi_awaddr(axi_vip_0_M_AXI_AWADDR),
        .m_axi_awprot(axi_vip_0_M_AXI_AWPROT),
        .m_axi_awready(axi_vip_0_M_AXI_AWREADY),
        .m_axi_awvalid(axi_vip_0_M_AXI_AWVALID),
        .m_axi_bready(axi_vip_0_M_AXI_BREADY),
        .m_axi_bresp(axi_vip_0_M_AXI_BRESP),
        .m_axi_bvalid(axi_vip_0_M_AXI_BVALID),
        .m_axi_rdata(axi_vip_0_M_AXI_RDATA),
        .m_axi_rready(axi_vip_0_M_AXI_RREADY),
        .m_axi_rresp(axi_vip_0_M_AXI_RRESP),
        .m_axi_rvalid(axi_vip_0_M_AXI_RVALID),
        .m_axi_wdata(axi_vip_0_M_AXI_WDATA),
        .m_axi_wready(axi_vip_0_M_AXI_WREADY),
        .m_axi_wstrb(axi_vip_0_M_AXI_WSTRB),
        .m_axi_wvalid(axi_vip_0_M_AXI_WVALID));
  design_1_axi_vip_0_1 axi_vip_1
       (.aclk(aclk_0_1),
        .aresetn(aresetn_0_1),
        .m_axi_araddr(axi_vip_1_M_AXI_ARADDR),
        .m_axi_arprot(axi_vip_1_M_AXI_ARPROT),
        .m_axi_arready(axi_vip_1_M_AXI_ARREADY),
        .m_axi_arvalid(axi_vip_1_M_AXI_ARVALID),
        .m_axi_awaddr(axi_vip_1_M_AXI_AWADDR),
        .m_axi_awprot(axi_vip_1_M_AXI_AWPROT),
        .m_axi_awready(axi_vip_1_M_AXI_AWREADY),
        .m_axi_awvalid(axi_vip_1_M_AXI_AWVALID),
        .m_axi_bready(axi_vip_1_M_AXI_BREADY),
        .m_axi_bresp(axi_vip_1_M_AXI_BRESP),
        .m_axi_bvalid(axi_vip_1_M_AXI_BVALID),
        .m_axi_rdata(axi_vip_1_M_AXI_RDATA),
        .m_axi_rready(axi_vip_1_M_AXI_RREADY),
        .m_axi_rresp(axi_vip_1_M_AXI_RRESP),
        .m_axi_rvalid(axi_vip_1_M_AXI_RVALID),
        .m_axi_wdata(axi_vip_1_M_AXI_WDATA),
        .m_axi_wready(axi_vip_1_M_AXI_WREADY),
        .m_axi_wstrb(axi_vip_1_M_AXI_WSTRB),
        .m_axi_wvalid(axi_vip_1_M_AXI_WVALID));
  design_1_axi_vip_0_2 axi_vip_2
       (.aclk(aclk_0_1),
        .aresetn(aresetn_0_1),
        .s_axi_araddr(fast_ip_scanner_0_M00_AXI_ARADDR),
        .s_axi_arprot(fast_ip_scanner_0_M00_AXI_ARPROT),
        .s_axi_arready(fast_ip_scanner_0_M00_AXI_ARREADY),
        .s_axi_arvalid(fast_ip_scanner_0_M00_AXI_ARVALID),
        .s_axi_awaddr(fast_ip_scanner_0_M00_AXI_AWADDR),
        .s_axi_awprot(fast_ip_scanner_0_M00_AXI_AWPROT),
        .s_axi_awready(fast_ip_scanner_0_M00_AXI_AWREADY),
        .s_axi_awvalid(fast_ip_scanner_0_M00_AXI_AWVALID),
        .s_axi_bready(fast_ip_scanner_0_M00_AXI_BREADY),
        .s_axi_bresp(fast_ip_scanner_0_M00_AXI_BRESP),
        .s_axi_bvalid(fast_ip_scanner_0_M00_AXI_BVALID),
        .s_axi_rdata(fast_ip_scanner_0_M00_AXI_RDATA),
        .s_axi_rready(fast_ip_scanner_0_M00_AXI_RREADY),
        .s_axi_rresp(fast_ip_scanner_0_M00_AXI_RRESP),
        .s_axi_rvalid(fast_ip_scanner_0_M00_AXI_RVALID),
        .s_axi_wdata(fast_ip_scanner_0_M00_AXI_WDATA),
        .s_axi_wready(fast_ip_scanner_0_M00_AXI_WREADY),
        .s_axi_wstrb(fast_ip_scanner_0_M00_AXI_WSTRB),
        .s_axi_wvalid(fast_ip_scanner_0_M00_AXI_WVALID));
  design_1_fast_ip_scanner_0_0 fast_ip_scanner_0
       (.m00_axi_aclk(aclk_0_1),
        .m00_axi_araddr(fast_ip_scanner_0_M00_AXI_ARADDR),
        .m00_axi_aresetn(aresetn_0_1),
        .m00_axi_arprot(fast_ip_scanner_0_M00_AXI_ARPROT),
        .m00_axi_arready(fast_ip_scanner_0_M00_AXI_ARREADY),
        .m00_axi_arvalid(fast_ip_scanner_0_M00_AXI_ARVALID),
        .m00_axi_awaddr(fast_ip_scanner_0_M00_AXI_AWADDR),
        .m00_axi_awprot(fast_ip_scanner_0_M00_AXI_AWPROT),
        .m00_axi_awready(fast_ip_scanner_0_M00_AXI_AWREADY),
        .m00_axi_awvalid(fast_ip_scanner_0_M00_AXI_AWVALID),
        .m00_axi_bready(fast_ip_scanner_0_M00_AXI_BREADY),
        .m00_axi_bresp(fast_ip_scanner_0_M00_AXI_BRESP),
        .m00_axi_bvalid(fast_ip_scanner_0_M00_AXI_BVALID),
        .m00_axi_rdata(fast_ip_scanner_0_M00_AXI_RDATA),
        .m00_axi_rready(fast_ip_scanner_0_M00_AXI_RREADY),
        .m00_axi_rresp(fast_ip_scanner_0_M00_AXI_RRESP),
        .m00_axi_rvalid(fast_ip_scanner_0_M00_AXI_RVALID),
        .m00_axi_wdata(fast_ip_scanner_0_M00_AXI_WDATA),
        .m00_axi_wready(fast_ip_scanner_0_M00_AXI_WREADY),
        .m00_axi_wstrb(fast_ip_scanner_0_M00_AXI_WSTRB),
        .m00_axi_wvalid(fast_ip_scanner_0_M00_AXI_WVALID),
        .s00_axi_aclk(aclk_0_1),
        .s00_axi_araddr(axi_vip_1_M_AXI_ARADDR[4:0]),
        .s00_axi_aresetn(aresetn_0_1),
        .s00_axi_arprot(axi_vip_1_M_AXI_ARPROT),
        .s00_axi_arready(axi_vip_1_M_AXI_ARREADY),
        .s00_axi_arvalid(axi_vip_1_M_AXI_ARVALID),
        .s00_axi_awaddr(axi_vip_1_M_AXI_AWADDR[4:0]),
        .s00_axi_awprot(axi_vip_1_M_AXI_AWPROT),
        .s00_axi_awready(axi_vip_1_M_AXI_AWREADY),
        .s00_axi_awvalid(axi_vip_1_M_AXI_AWVALID),
        .s00_axi_bready(axi_vip_1_M_AXI_BREADY),
        .s00_axi_bresp(axi_vip_1_M_AXI_BRESP),
        .s00_axi_bvalid(axi_vip_1_M_AXI_BVALID),
        .s00_axi_rdata(axi_vip_1_M_AXI_RDATA),
        .s00_axi_rready(axi_vip_1_M_AXI_RREADY),
        .s00_axi_rresp(axi_vip_1_M_AXI_RRESP),
        .s00_axi_rvalid(axi_vip_1_M_AXI_RVALID),
        .s00_axi_wdata(axi_vip_1_M_AXI_WDATA),
        .s00_axi_wready(axi_vip_1_M_AXI_WREADY),
        .s00_axi_wstrb(axi_vip_1_M_AXI_WSTRB),
        .s00_axi_wvalid(axi_vip_1_M_AXI_WVALID),
        .scan_ck_en(fast_ip_scanner_0_scan_ck_en),
        .scan_enable(fast_ip_scanner_0_scan_enable),
        .scan_input(fast_ip_scanner_0_scan_input),
        .scan_output(sha256_scannable_0_scan_output));
  design_1_sha256_scannable_0_0 sha256_scannable_0
       (.s00_axi_aclk(aclk_0_1),
        .s00_axi_araddr(axi_vip_0_M_AXI_ARADDR[7:0]),
        .s00_axi_aresetn(aresetn_0_1),
        .s00_axi_arprot(axi_vip_0_M_AXI_ARPROT),
        .s00_axi_arready(axi_vip_0_M_AXI_ARREADY),
        .s00_axi_arvalid(axi_vip_0_M_AXI_ARVALID),
        .s00_axi_awaddr(axi_vip_0_M_AXI_AWADDR[7:0]),
        .s00_axi_awprot(axi_vip_0_M_AXI_AWPROT),
        .s00_axi_awready(axi_vip_0_M_AXI_AWREADY),
        .s00_axi_awvalid(axi_vip_0_M_AXI_AWVALID),
        .s00_axi_bready(axi_vip_0_M_AXI_BREADY),
        .s00_axi_bresp(axi_vip_0_M_AXI_BRESP),
        .s00_axi_bvalid(axi_vip_0_M_AXI_BVALID),
        .s00_axi_rdata(axi_vip_0_M_AXI_RDATA),
        .s00_axi_rready(axi_vip_0_M_AXI_RREADY),
        .s00_axi_rresp(axi_vip_0_M_AXI_RRESP),
        .s00_axi_rvalid(axi_vip_0_M_AXI_RVALID),
        .s00_axi_wdata(axi_vip_0_M_AXI_WDATA),
        .s00_axi_wready(axi_vip_0_M_AXI_WREADY),
        .s00_axi_wstrb(axi_vip_0_M_AXI_WSTRB),
        .s00_axi_wvalid(axi_vip_0_M_AXI_WVALID),
        .scan_ck_en(fast_ip_scanner_0_scan_ck_en),
        .scan_enable(fast_ip_scanner_0_scan_enable),
        .scan_input(fast_ip_scanner_0_scan_input),
        .scan_output(sha256_scannable_0_scan_output));
endmodule
