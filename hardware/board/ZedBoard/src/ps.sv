//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// ps.sv
// 
// Description:
// Top module of processing system.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.17  Fanfei      Initial version
//****************************************************************

module ps #(

) (
    `ifdef USE_AXI_GP_PORT
    axi4            s_axi_gp,
    `endif
    `ifdef USE_AXI_HP_PORT
    axi4            s_axi_hp,
    `endif
    // Fixed IO.
    inout           fixed_io_ddr_vrn,
    inout           fixed_io_ddr_vrp,
    inout [53:0]    fixed_io_mio,
    inout           fixed_io_ps_clk,
    inout           fixed_io_ps_porb,
    inout           fixed_io_ps_srstb,
    // DDR ports.
    inout [14:0]    ddr_addr,
    inout [2:0]     ddr_ba,
    inout           ddr_cas_n,
    inout           ddr_ck_n,
    inout           ddr_ck_p,
    inout           ddr_cke,
    inout           ddr_cs_n,
    inout [3:0]     ddr_dm,
    inout [31:0]    ddr_dq,
    inout [3:0]     ddr_dqs_n,
    inout [3:0]     ddr_dqs_p,
    inout           ddr_odt,
    inout           ddr_ras_n,
    inout           ddr_reset_n,
    inout           ddr_we_n
);

processing_system7_0 processing_system7_inst (
    .TTC0_WAVE0_OUT     (TTC0_WAVE0_OUT),            // output wire TTC0_WAVE0_OUT
    .TTC0_WAVE1_OUT     (TTC0_WAVE1_OUT),            // output wire TTC0_WAVE1_OUT
    .TTC0_WAVE2_OUT     (TTC0_WAVE2_OUT),            // output wire TTC0_WAVE2_OUT
    .USB0_PORT_INDCTL   (USB0_PORT_INDCTL),        // output wire [1 : 0] USB0_PORT_INDCTL
    .USB0_VBUS_PWRSELECT(USB0_VBUS_PWRSELECT),  // output wire USB0_VBUS_PWRSELECT
    .USB0_VBUS_PWRFAULT (USB0_VBUS_PWRFAULT),    // input wire USB0_VBUS_PWRFAULT
    .M_AXI_GP0_ARVALID  (M_AXI_GP0_ARVALID),      // output wire M_AXI_GP0_ARVALID
    .M_AXI_GP0_AWVALID  (M_AXI_GP0_AWVALID),      // output wire M_AXI_GP0_AWVALID
    .M_AXI_GP0_BREADY   (M_AXI_GP0_BREADY),        // output wire M_AXI_GP0_BREADY
    .M_AXI_GP0_RREADY   (M_AXI_GP0_RREADY),        // output wire M_AXI_GP0_RREADY
    .M_AXI_GP0_WLAST    (M_AXI_GP0_WLAST),          // output wire M_AXI_GP0_WLAST
    .M_AXI_GP0_WVALID   (M_AXI_GP0_WVALID),        // output wire M_AXI_GP0_WVALID
    .M_AXI_GP0_ARID     (M_AXI_GP0_ARID),            // output wire [11 : 0] M_AXI_GP0_ARID
    .M_AXI_GP0_AWID     (M_AXI_GP0_AWID),            // output wire [11 : 0] M_AXI_GP0_AWID
    .M_AXI_GP0_WID      (M_AXI_GP0_WID),              // output wire [11 : 0] M_AXI_GP0_WID
    .M_AXI_GP0_ARBURST  (M_AXI_GP0_ARBURST),      // output wire [1 : 0] M_AXI_GP0_ARBURST
    .M_AXI_GP0_ARLOCK   (M_AXI_GP0_ARLOCK),        // output wire [1 : 0] M_AXI_GP0_ARLOCK
    .M_AXI_GP0_ARSIZE   (M_AXI_GP0_ARSIZE),        // output wire [2 : 0] M_AXI_GP0_ARSIZE
    .M_AXI_GP0_AWBURST  (M_AXI_GP0_AWBURST),      // output wire [1 : 0] M_AXI_GP0_AWBURST
    .M_AXI_GP0_AWLOCK   (M_AXI_GP0_AWLOCK),        // output wire [1 : 0] M_AXI_GP0_AWLOCK
    .M_AXI_GP0_AWSIZE   (M_AXI_GP0_AWSIZE),        // output wire [2 : 0] M_AXI_GP0_AWSIZE
    .M_AXI_GP0_ARPROT   (M_AXI_GP0_ARPROT),        // output wire [2 : 0] M_AXI_GP0_ARPROT
    .M_AXI_GP0_AWPROT   (M_AXI_GP0_AWPROT),        // output wire [2 : 0] M_AXI_GP0_AWPROT
    .M_AXI_GP0_ARADDR   (M_AXI_GP0_ARADDR),        // output wire [31 : 0] M_AXI_GP0_ARADDR
    .M_AXI_GP0_AWADDR   (M_AXI_GP0_AWADDR),        // output wire [31 : 0] M_AXI_GP0_AWADDR
    .M_AXI_GP0_WDATA    (M_AXI_GP0_WDATA),          // output wire [31 : 0] M_AXI_GP0_WDATA
    .M_AXI_GP0_ARCACHE  (M_AXI_GP0_ARCACHE),      // output wire [3 : 0] M_AXI_GP0_ARCACHE
    .M_AXI_GP0_ARLEN    (M_AXI_GP0_ARLEN),          // output wire [3 : 0] M_AXI_GP0_ARLEN
    .M_AXI_GP0_ARQOS    (M_AXI_GP0_ARQOS),          // output wire [3 : 0] M_AXI_GP0_ARQOS
    .M_AXI_GP0_AWCACHE  (M_AXI_GP0_AWCACHE),      // output wire [3 : 0] M_AXI_GP0_AWCACHE
    .M_AXI_GP0_AWLEN    (M_AXI_GP0_AWLEN),          // output wire [3 : 0] M_AXI_GP0_AWLEN
    .M_AXI_GP0_AWQOS    (M_AXI_GP0_AWQOS),          // output wire [3 : 0] M_AXI_GP0_AWQOS
    .M_AXI_GP0_WSTRB    (M_AXI_GP0_WSTRB),          // output wire [3 : 0] M_AXI_GP0_WSTRB
    .M_AXI_GP0_ACLK     (M_AXI_GP0_ACLK),            // input wire M_AXI_GP0_ACLK
    .M_AXI_GP0_ARREADY  (M_AXI_GP0_ARREADY),      // input wire M_AXI_GP0_ARREADY
    .M_AXI_GP0_AWREADY  (M_AXI_GP0_AWREADY),      // input wire M_AXI_GP0_AWREADY
    .M_AXI_GP0_BVALID   (M_AXI_GP0_BVALID),        // input wire M_AXI_GP0_BVALID
    .M_AXI_GP0_RLAST    (M_AXI_GP0_RLAST),          // input wire M_AXI_GP0_RLAST
    .M_AXI_GP0_RVALID   (M_AXI_GP0_RVALID),        // input wire M_AXI_GP0_RVALID
    .M_AXI_GP0_WREADY   (M_AXI_GP0_WREADY),        // input wire M_AXI_GP0_WREADY
    .M_AXI_GP0_BID      (M_AXI_GP0_BID),              // input wire [11 : 0] M_AXI_GP0_BID
    .M_AXI_GP0_RID      (M_AXI_GP0_RID),              // input wire [11 : 0] M_AXI_GP0_RID
    .M_AXI_GP0_BRESP    (M_AXI_GP0_BRESP),          // input wire [1 : 0] M_AXI_GP0_BRESP
    .M_AXI_GP0_RRESP    (M_AXI_GP0_RRESP),          // input wire [1 : 0] M_AXI_GP0_RRESP
    .M_AXI_GP0_RDATA    (M_AXI_GP0_RDATA),          // input wire [31 : 0] M_AXI_GP0_RDATA
    .FCLK_CLK0          (FCLK_CLK0),                      // output wire FCLK_CLK0
    .FCLK_RESET0_N      (FCLK_RESET0_N),              // output wire FCLK_RESET0_N
    .MIO                (MIO),                                  // inout wire [53 : 0] MIO
    .DDR_CAS_n          (DDR_CAS_n),                      // inout wire DDR_CAS_n
    .DDR_CKE            (DDR_CKE),                          // inout wire DDR_CKE
    .DDR_Clk_n          (DDR_Clk_n),                      // inout wire DDR_Clk_n
    .DDR_Clk            (DDR_Clk),                          // inout wire DDR_Clk
    .DDR_CS_n           (DDR_CS_n),                        // inout wire DDR_CS_n
    .DDR_DRSTB          (DDR_DRSTB),                      // inout wire DDR_DRSTB
    .DDR_ODT            (DDR_ODT),                          // inout wire DDR_ODT
    .DDR_RAS_n(DDR_RAS_n),                      // inout wire DDR_RAS_n
    .DDR_WEB(DDR_WEB),                          // inout wire DDR_WEB
    .DDR_BankAddr(DDR_BankAddr),                // inout wire [2 : 0] DDR_BankAddr
    .DDR_Addr(DDR_Addr),                        // inout wire [14 : 0] DDR_Addr
    .DDR_VRN(DDR_VRN),                          // inout wire DDR_VRN
    .DDR_VRP(DDR_VRP),                          // inout wire DDR_VRP
    .DDR_DM(DDR_DM),                            // inout wire [3 : 0] DDR_DM
    .DDR_DQ(DDR_DQ),                            // inout wire [31 : 0] DDR_DQ
    .DDR_DQS_n(DDR_DQS_n),                      // inout wire [3 : 0] DDR_DQS_n
    .DDR_DQS(DDR_DQS),                          // inout wire [3 : 0] DDR_DQS
    .PS_SRSTB(PS_SRSTB),                        // inout wire PS_SRSTB
    .PS_CLK(PS_CLK),                            // inout wire PS_CLK
    .PS_PORB(PS_PORB)                          // inout wire PS_PORB
);
    
endmodule