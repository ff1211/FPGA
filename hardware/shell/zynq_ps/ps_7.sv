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

`timescale 1ns/1ps
`include "pre_proc.vh"
`include "interconnect.vh"

module ps_7 #(

) (
    `ifdef USE_M_AXI_GP
    axi4                        m_axi_gp,
    input [`M_AXI_GP_NUM-1:0]   m_axi_gp_aclk,
    `endif
    `ifdef USE_S_AXI_GP
    axi4                        s_axi_gp,
    input  [`S_AXI_GP_NUM-1:0]  s_axi_gp_aclk,
    `endif
    `ifdef USE_S_AXI_HP
    axi4                        s_axi_hp,
    input [`S_AXI_HP_NUM-1:0]   s_axi_hp_aclk,
    `endif

    // Clock and reset.
    output          fclk,
    output          fclk_rst_n,
    
    // Fixed IO.
    inout           fixed_io_ddr_vrn,
    inout           fixed_io_ddr_vrp,
    inout  [53:0]   fixed_io_mio,
    inout           fixed_io_ps_clk,
    inout           fixed_io_ps_porb,
    inout           fixed_io_ps_srstb,
    // DDR ports.
    inout  [14:0]   ddr_addr,
    inout  [2:0]    ddr_ba,
    inout           ddr_cas_n,
    inout           ddr_ck_n,
    inout           ddr_ck_p,
    inout           ddr_cke,
    inout           ddr_cs_n,
    inout  [3:0]    ddr_dm,
    inout  [31:0]   ddr_dq,
    inout  [3:0]    ddr_dqs_n,
    inout  [3:0]    ddr_dqs_p,
    inout           ddr_odt,
    inout           ddr_ras_n,
    inout           ddr_reset_n,
    inout           ddr_we_n
);

`ifdef USE_M_AXI_GP_0
axi4 #(.CHANNEL(1), .DATA_WIDTH(32), .ADDR_WIDTH(32), .ID_WIDTH(12)) m_axi_gp_0();
`CON_AXI4_M2N(m_axi_gp_0, m_axi_gp, 0, 0);
`endif
`ifdef USE_M_AXI_GP_1
axi4 #(.CHANNEL(1), .DATA_WIDTH(32), .ADDR_WIDTH(32), .ID_WIDTH(12)) m_axi_gp_1();
`CON_AXI4_M2N(m_axi_gp_1, m_axi_gp, 0, 1);
`endif

`ifdef USE_S_AXI_GP_0
axi4 #(.CHANNEL(1), .DATA_WIDTH(32), .ADDR_WIDTH(32), .ID_WIDTH(6)) s_axi_gp_0();
`CON_AXI4_M2N(s_axi_gp, s_axi_gp_0, 0, 0);
`endif
`ifdef USE_S_AXI_GP_1
axi4 #(.CHANNEL(1), .DATA_WIDTH(32), .ADDR_WIDTH(32), .ID_WIDTH(6)) s_axi_gp_1();
`CON_AXI4_M2N(s_axi_gp, s_axi_gp_1, 1, 0);
`endif

`ifdef USE_S_AXI_HP_0
axi4 #(.CHANNEL(1), .DATA_WIDTH(`S_AXI_HP_DW), .ADDR_WIDTH(32), .ID_WIDTH(6)) s_axi_hp_0();
`CON_AXI4_M2N(s_axi_hp, s_axi_hp_0, 0, 0);
`endif
`ifdef USE_S_AXI_HP_1
axi4 #(.CHANNEL(1), .DATA_WIDTH(`S_AXI_HP_DW), .ADDR_WIDTH(32), .ID_WIDTH(6)) s_axi_hp_1();
`CON_AXI4_M2N(s_axi_hp, s_axi_hp_1, 1, 0);
`endif
`ifdef USE_S_AXI_HP_2
axi4 #(.CHANNEL(1), .DATA_WIDTH(`S_AXI_HP_DW), .ADDR_WIDTH(32), .ID_WIDTH(6)) s_axi_hp_2();
`CON_AXI4_M2N(s_axi_hp, s_axi_hp_2, 2, 0);
`endif
`ifdef USE_S_AXI_HP_3
axi4 #(.CHANNEL(1), .DATA_WIDTH(`S_AXI_HP_DW), .ADDR_WIDTH(32), .ID_WIDTH(6)) s_axi_hp_3();
`CON_AXI4_M2N(s_axi_hp, s_axi_hp_3, 3, 0);
`endif

processing_system7_0 processing_system7_inst (
    .FCLK_CLK0          (   fclk                ),         // output wire FCLK_CLK0
    .FCLK_RESET0_N      (   fclk_rst_n          ),         // output wire FCLK_RESET0_N
    .MIO                (   fixed_io_mio        ),        // inout wire [53 : 0] MIO

    .TTC0_WAVE0_OUT     (                       ),            // output wire TTC0_WAVE0_OUT
    .TTC0_WAVE1_OUT     (                       ),            // output wire TTC0_WAVE1_OUT
    .TTC0_WAVE2_OUT     (                       ),            // output wire TTC0_WAVE2_OUT
    .USB0_PORT_INDCTL   (                       ),        // output wire [1 : 0] USB0_PORT_INDCTL
    .USB0_VBUS_PWRSELECT(                       ),  // output wire USB0_VBUS_PWRSELECT
    .USB0_VBUS_PWRFAULT (   1'b0                ),    // input wire USB0_VBUS_PWRFAULT

    `ifdef USE_M_AXI_GP_0
    .M_AXI_GP0_ARVALID  (   m_axi_gp_0.arvalid  ),                // output wire M_AXI_GP0_ARVALID
    .M_AXI_GP0_AWVALID  (   m_axi_gp_0.awvalid  ),                // output wire M_AXI_GP0_AWVALID
    .M_AXI_GP0_BREADY   (   m_axi_gp_0.bready   ),                  // output wire M_AXI_GP0_BREADY
    .M_AXI_GP0_RREADY   (   m_axi_gp_0.rready   ),                  // output wire M_AXI_GP0_RREADY
    .M_AXI_GP0_WLAST    (   m_axi_gp_0.wlast    ),                    // output wire M_AXI_GP0_WLAST
    .M_AXI_GP0_WVALID   (   m_axi_gp_0.wvalid   ),                  // output wire M_AXI_GP0_WVALID
    .M_AXI_GP0_ARID     (   m_axi_gp_0.arid     ),                      // output wire [11 : 0] M_AXI_GP0_ARID
    .M_AXI_GP0_AWID     (   m_axi_gp_0.awid     ),                      // output wire [11 : 0] M_AXI_GP0_AWID
    .M_AXI_GP0_WID      (   m_axi_gp_0.wid      ),                        // output wire [11 : 0] M_AXI_GP0_WID
    .M_AXI_GP0_ARBURST  (   m_axi_gp_0.arburst  ),                // output wire [1 : 0] M_AXI_GP0_ARBURST
    .M_AXI_GP0_ARLOCK   (   m_axi_gp_0.arlock   ),                  // output wire [1 : 0] M_AXI_GP0_ARLOCK
    .M_AXI_GP0_ARSIZE   (   m_axi_gp_0.arsize   ),                  // output wire [2 : 0] M_AXI_GP0_ARSIZE
    .M_AXI_GP0_AWBURST  (   m_axi_gp_0.awburst  ),                // output wire [1 : 0] M_AXI_GP0_AWBURST
    .M_AXI_GP0_AWLOCK   (   m_axi_gp_0.awlock   ),                  // output wire [1 : 0] M_AXI_GP0_AWLOCK
    .M_AXI_GP0_AWSIZE   (   m_axi_gp_0.awsize   ),                  // output wire [2 : 0] M_AXI_GP0_AWSIZE
    .M_AXI_GP0_ARPROT   (   m_axi_gp_0.arprot   ),                  // output wire [2 : 0] M_AXI_GP0_ARPROT
    .M_AXI_GP0_AWPROT   (   m_axi_gp_0.awprot   ),                  // output wire [2 : 0] M_AXI_GP0_AWPROT
    .M_AXI_GP0_ARADDR   (   m_axi_gp_0.araddr   ),                  // output wire [31 : 0] M_AXI_GP0_ARADDR
    .M_AXI_GP0_AWADDR   (   m_axi_gp_0.awaddr   ),                  // output wire [31 : 0] M_AXI_GP0_AWADDR
    .M_AXI_GP0_WDATA    (   m_axi_gp_0.wdata    ),                    // output wire [31 : 0] M_AXI_GP0_WDATA
    .M_AXI_GP0_ARCACHE  (   m_axi_gp_0.arcache  ),                // output wire [3 : 0] M_AXI_GP0_ARCACHE
    .M_AXI_GP0_ARLEN    (   m_axi_gp_0.arlen    ),                    // output wire [3 : 0] M_AXI_GP0_ARLEN
    .M_AXI_GP0_ARQOS    (   m_axi_gp_0.arqos    ),                    // output wire [3 : 0] M_AXI_GP0_ARQOS
    .M_AXI_GP0_AWCACHE  (   m_axi_gp_0.awcache  ),                // output wire [3 : 0] M_AXI_GP0_AWCACHE
    .M_AXI_GP0_AWLEN    (   m_axi_gp_0.awlen    ),                    // output wire [3 : 0] M_AXI_GP0_AWLEN
    .M_AXI_GP0_AWQOS    (   m_axi_gp_0.awqos    ),                    // output wire [3 : 0] M_AXI_GP0_AWQOS
    .M_AXI_GP0_WSTRB    (   m_axi_gp_0.wstrb    ),                    // output wire [3 : 0] M_AXI_GP0_WSTRB
    .M_AXI_GP0_ACLK     (   m_axi_gp_aclk[0]    ),                      // input wire M_AXI_GP0_ACLK
    .M_AXI_GP0_ARREADY  (   m_axi_gp_0.arready  ),                // input wire M_AXI_GP0_ARREADY
    .M_AXI_GP0_AWREADY  (   m_axi_gp_0.awready  ),                // input wire M_AXI_GP0_AWREADY
    .M_AXI_GP0_BVALID   (   m_axi_gp_0.bvalid   ),                  // input wire M_AXI_GP0_BVALID
    .M_AXI_GP0_RLAST    (   m_axi_gp_0.rlast    ),                    // input wire M_AXI_GP0_RLAST
    .M_AXI_GP0_RVALID   (   m_axi_gp_0.rvalid   ),                  // input wire M_AXI_GP0_RVALID
    .M_AXI_GP0_WREADY   (   m_axi_gp_0.wready   ),                  // input wire M_AXI_GP0_WREADY
    .M_AXI_GP0_BID      (   m_axi_gp_0.bid      ),                        // input wire [11 : 0] M_AXI_GP0_BID
    .M_AXI_GP0_RID      (   m_axi_gp_0.rid      ),                        // input wire [11 : 0] M_AXI_GP0_RID
    .M_AXI_GP0_BRESP    (   m_axi_gp_0.bresp    ),                    // input wire [1 : 0] M_AXI_GP0_BRESP
    .M_AXI_GP0_RRESP    (   m_axi_gp_0.rresp    ),                    // input wire [1 : 0] M_AXI_GP0_RRESP
    .M_AXI_GP0_RDATA    (   m_axi_gp_0.rdata    ),                    // input wire [31 : 0] M_AXI_GP0_RDATA
    `endif
    `ifdef USE_M_AXI_GP_1
    .M_AXI_GP1_ARVALID  (   m_axi_gp_1.arvalid  ),                // output wire M_AXI_GP1_ARVALID
    .M_AXI_GP1_AWVALID  (   m_axi_gp_1.awvalid  ),                // output wire M_AXI_GP1_AWVALID
    .M_AXI_GP1_BREADY   (   m_axi_gp_1.bready   ),                // output wire M_AXI_GP1_BREADY
    .M_AXI_GP1_RREADY   (   m_axi_gp_1.rready   ),                // output wire M_AXI_GP1_RREADY
    .M_AXI_GP1_WLAST    (   m_axi_gp_1.wlast    ),                // output wire M_AXI_GP1_WLAST
    .M_AXI_GP1_WVALID   (   m_axi_gp_1.wvalid   ),                // output wire M_AXI_GP1_WVALID
    .M_AXI_GP1_ARID     (   m_axi_gp_1.arid     ),                // output wire [11 : 0] M_AXI_GP1_ARID
    .M_AXI_GP1_AWID     (   m_axi_gp_1.awid     ),                // output wire [11 : 0] M_AXI_GP1_AWID
    .M_AXI_GP1_WID      (   m_axi_gp_1.wid      ),                // output wire [11 : 0] M_AXI_GP1_WID
    .M_AXI_GP1_ARBURST  (   m_axi_gp_1.arburst  ),                // output wire [1 : 0] M_AXI_GP1_ARBURST
    .M_AXI_GP1_ARLOCK   (   m_axi_gp_1.arlock   ),                // output wire [1 : 0] M_AXI_GP1_ARLOCK
    .M_AXI_GP1_ARSIZE   (   m_axi_gp_1.arsize   ),                // output wire [2 : 0] M_AXI_GP1_ARSIZE
    .M_AXI_GP1_AWBURST  (   m_axi_gp_1.awburst  ),                // output wire [1 : 0] M_AXI_GP1_AWBURST
    .M_AXI_GP1_AWLOCK   (   m_axi_gp_1.awlock   ),                // output wire [1 : 0] M_AXI_GP1_AWLOCK
    .M_AXI_GP1_AWSIZE   (   m_axi_gp_1.awsize   ),                // output wire [2 : 0] M_AXI_GP1_AWSIZE
    .M_AXI_GP1_ARPROT   (   m_axi_gp_1.arprot   ),                // output wire [2 : 0] M_AXI_GP1_ARPROT
    .M_AXI_GP1_AWPROT   (   m_axi_gp_1.awprot   ),                // output wire [2 : 0] M_AXI_GP1_AWPROT
    .M_AXI_GP1_ARADDR   (   m_axi_gp_1.araddr   ),                // output wire [31 : 0] M_AXI_GP1_ARADDR
    .M_AXI_GP1_AWADDR   (   m_axi_gp_1.awaddr   ),                // output wire [31 : 0] M_AXI_GP1_AWADDR
    .M_AXI_GP1_WDATA    (   m_axi_gp_1.wdata    ),                // output wire [31 : 0] M_AXI_GP1_WDATA
    .M_AXI_GP1_ARCACHE  (   m_axi_gp_1.arcache  ),                // output wire [3 : 0] M_AXI_GP1_ARCACHE
    .M_AXI_GP1_ARLEN    (   m_axi_gp_1.arlen    ),                // output wire [3 : 0] M_AXI_GP1_ARLEN
    .M_AXI_GP1_ARQOS    (   m_axi_gp_1.arqos    ),                // output wire [3 : 0] M_AXI_GP1_ARQOS
    .M_AXI_GP1_AWCACHE  (   m_axi_gp_1.awcache  ),                // output wire [3 : 0] M_AXI_GP1_AWCACHE
    .M_AXI_GP1_AWLEN    (   m_axi_gp_1.awlen    ),                // output wire [3 : 0] M_AXI_GP1_AWLEN
    .M_AXI_GP1_AWQOS    (   m_axi_gp_1.awqos    ),                // output wire [3 : 0] M_AXI_GP1_AWQOS
    .M_AXI_GP1_WSTRB    (   m_axi_gp_1.wstrb    ),                // output wire [3 : 0] M_AXI_GP1_WSTRB
    .M_AXI_GP1_ACLK     (   m_axi_gp_aclk[1]    ),                // input wire M_AXI_GP1_ACLK
    .M_AXI_GP1_ARREADY  (   m_axi_gp_1.arready  ),                // input wire M_AXI_GP1_ARREADY
    .M_AXI_GP1_AWREADY  (   m_axi_gp_1.awready  ),                // input wire M_AXI_GP1_AWREADY
    .M_AXI_GP1_BVALID   (   m_axi_gp_1.bvalid   ),                // input wire M_AXI_GP1_BVALID
    .M_AXI_GP1_RLAST    (   m_axi_gp_1.rlast    ),                // input wire M_AXI_GP1_RLAST
    .M_AXI_GP1_RVALID   (   m_axi_gp_1.rvalid   ),                // input wire M_AXI_GP1_RVALID
    .M_AXI_GP1_WREADY   (   m_axi_gp_1.wready   ),                // input wire M_AXI_GP1_WREADY
    .M_AXI_GP1_BID      (   m_axi_gp_1.bid      ),                // input wire [11 : 0] M_AXI_GP1_BID
    .M_AXI_GP1_RID      (   m_axi_gp_1.rid      ),                // input wire [11 : 0] M_AXI_GP1_RID
    .M_AXI_GP1_BRESP    (   m_axi_gp_1.bresp    ),                // input wire [1 : 0] M_AXI_GP1_BRESP
    .M_AXI_GP1_RRESP    (   m_axi_gp_1.rresp    ),                // input wire [1 : 0] M_AXI_GP1_RRESP
    .M_AXI_GP1_RDATA    (   m_axi_gp_1.rdata    ),                // input wire [31 : 0] M_AXI_GP1_RDATA
    `endif

    `ifdef USE_S_AXI_GP_0
    .S_AXI_GP0_ARREADY  (   s_axi_gp_0.arready  ),                // output wire S_AXI_GP0_ARREADY
    .S_AXI_GP0_AWREADY  (   s_axi_gp_0.awready  ),                // output wire S_AXI_GP0_AWREADY
    .S_AXI_GP0_BVALID   (   s_axi_gp_0.bvalid   ),                  // output wire S_AXI_GP0_BVALID
    .S_AXI_GP0_RLAST    (   s_axi_gp_0.rlast    ),                    // output wire S_AXI_GP0_RLAST
    .S_AXI_GP0_RVALID   (   s_axi_gp_0.rvalid   ),                  // output wire S_AXI_GP0_RVALID
    .S_AXI_GP0_WREADY   (   s_axi_gp_0.wready   ),                  // output wire S_AXI_GP0_WREADY
    .S_AXI_GP0_BRESP    (   s_axi_gp_0.bresp    ),                    // output wire [1 : 0] S_AXI_GP0_BRESP
    .S_AXI_GP0_RRESP    (   s_axi_gp_0.rresp    ),                    // output wire [1 : 0] S_AXI_GP0_RRESP
    .S_AXI_GP0_RDATA    (   s_axi_gp_0.rdata    ),                    // output wire [31 : 0] S_AXI_GP0_RDATA
    .S_AXI_GP0_BID      (   s_axi_gp_0.bid      ),                        // output wire [5 : 0] S_AXI_GP0_BID
    .S_AXI_GP0_RID      (   s_axi_gp_0.rid      ),                        // output wire [5 : 0] S_AXI_GP0_RID
    .S_AXI_GP0_ACLK     (   s_axi_gp_aclk[0]    )                  // input wire S_AXI_GP0_ACLK
    .S_AXI_GP0_ARVALID  (   s_axi_gp_0.arvalid  ),                // input wire S_AXI_GP0_ARVALID
    .S_AXI_GP0_AWVALID  (   s_axi_gp_0.awvalid  ),                // input wire S_AXI_GP0_AWVALID
    .S_AXI_GP0_BREADY   (   s_axi_gp_0.bready   ),                  // input wire S_AXI_GP0_BREADY
    .S_AXI_GP0_RREADY   (   s_axi_gp_0.rready   ),                  // input wire S_AXI_GP0_RREADY
    .S_AXI_GP0_WLAST    (   s_axi_gp_0.wlast    ),                    // input wire S_AXI_GP0_WLAST
    .S_AXI_GP0_WVALID   (   s_axi_gp_0.wvalid   ),                  // input wire S_AXI_GP0_WVALID
    .S_AXI_GP0_ARBURST  (   s_axi_gp_0.arburst  ),                // input wire [1 : 0] S_AXI_GP0_ARBURST
    .S_AXI_GP0_ARLOCK   (   s_axi_gp_0.arlock   ),                  // input wire [1 : 0] S_AXI_GP0_ARLOCK
    .S_AXI_GP0_ARSIZE   (   s_axi_gp_0.arsize   ),                  // input wire [2 : 0] S_AXI_GP0_ARSIZE
    .S_AXI_GP0_AWBURST  (   s_axi_gp_0.awburst  ),                // input wire [1 : 0] S_AXI_GP0_AWBURST
    .S_AXI_GP0_AWLOCK   (   s_axi_gp_0.awlock   ),                  // input wire [1 : 0] S_AXI_GP0_AWLOCK
    .S_AXI_GP0_AWSIZE   (   s_axi_gp_0.awsize   ),                  // input wire [2 : 0] S_AXI_GP0_AWSIZE
    .S_AXI_GP0_ARPROT   (   s_axi_gp_0.arprot   ),                  // input wire [2 : 0] S_AXI_GP0_ARPROT
    .S_AXI_GP0_AWPROT   (   s_axi_gp_0.awprot   ),                  // input wire [2 : 0] S_AXI_GP0_AWPROT
    .S_AXI_GP0_ARADDR   (   s_axi_gp_0.araddr   ),                  // input wire [31 : 0] S_AXI_GP0_ARADDR
    .S_AXI_GP0_AWADDR   (   s_axi_gp_0.awaddr   ),                  // input wire [31 : 0] S_AXI_GP0_AWADDR
    .S_AXI_GP0_WDATA    (   s_axi_gp_0.wdata    ),                    // input wire [31 : 0] S_AXI_GP0_WDATA
    .S_AXI_GP0_ARCACHE  (   s_axi_gp_0.arcache  ),                // input wire [3 : 0] S_AXI_GP0_ARCACHE
    .S_AXI_GP0_ARLEN    (   s_axi_gp_0.arlen    ),                    // input wire [3 : 0] S_AXI_GP0_ARLEN
    .S_AXI_GP0_ARQOS    (   s_axi_gp_0.arqos    ),                    // input wire [3 : 0] S_AXI_GP0_ARQOS
    .S_AXI_GP0_AWCACHE  (   s_axi_gp_0.awcache  ),                // input wire [3 : 0] S_AXI_GP0_AWCACHE
    .S_AXI_GP0_AWLEN    (   s_axi_gp_0.awlen    ),                    // input wire [3 : 0] S_AXI_GP0_AWLEN
    .S_AXI_GP0_AWQOS    (   s_axi_gp_0.awqos    ),                    // input wire [3 : 0] S_AXI_GP0_AWQOS
    .S_AXI_GP0_WSTRB    (   s_axi_gp_0.wstrb    ),                    // input wire [3 : 0] S_AXI_GP0_WSTRB
    .S_AXI_GP0_ARID     (   s_axi_gp_0.arid     ),                      // input wire [5 : 0] S_AXI_GP0_ARID
    .S_AXI_GP0_AWID     (   s_axi_gp_0.awid     ),                      // input wire [5 : 0] S_AXI_GP0_AWID
    .S_AXI_GP0_WID      (   s_axi_gp_0.wid      ),                        // input wire [5 : 0] S_AXI_GP0_WID
    `endif 
    
    `ifdef USE_S_AXI_GP_1
    .S_AXI_GP1_ARREADY  (   s_axi_gp_1.arready  ),                // output wire S_AXI_GP1_ARREADY
    .S_AXI_GP1_AWREADY  (   s_axi_gp_1.awready  ),                // output wire S_AXI_GP1_AWREADY
    .S_AXI_GP1_BVALID   (   s_axi_gp_1.bvalid   ),                // output wire S_AXI_GP1_BVALID
    .S_AXI_GP1_RLAST    (   s_axi_gp_1.rlast    ),                // output wire S_AXI_GP1_RLAST
    .S_AXI_GP1_RVALID   (   s_axi_gp_1.rvalid   ),                // output wire S_AXI_GP1_RVALID
    .S_AXI_GP1_WREADY   (   s_axi_gp_1.wready   ),                // output wire S_AXI_GP1_WREADY
    .S_AXI_GP1_BRESP    (   s_axi_gp_1.bresp    ),                // output wire [1 : 0] S_AXI_GP1_BRESP
    .S_AXI_GP1_RRESP    (   s_axi_gp_1.rresp    ),                // output wire [1 : 0] S_AXI_GP1_RRESP
    .S_AXI_GP1_RDATA    (   s_axi_gp_1.rdata    ),                // output wire [31 : 0] S_AXI_GP1_RDATA
    .S_AXI_GP1_BID      (   s_axi_gp_1.bid      ),                // output wire [5 : 0] S_AXI_GP1_BID
    .S_AXI_GP1_RID      (   s_axi_gp_1.rid      ),                // output wire [5 : 0] S_AXI_GP1_RID
    .S_AXI_GP1_ACLK     (   s_axi_gp_aclk[1]    ),                // input wire S_AXI_GP1_ACLK
    .S_AXI_GP1_ARVALID  (   s_axi_gp_1.arvalid  ),                // input wire S_AXI_GP1_ARVALID
    .S_AXI_GP1_AWVALID  (   s_axi_gp_1.awvalid  ),                // input wire S_AXI_GP1_AWVALID
    .S_AXI_GP1_BREADY   (   s_axi_gp_1.bready   ),                // input wire S_AXI_GP1_BREADY
    .S_AXI_GP1_RREADY   (   s_axi_gp_1.rready   ),                // input wire S_AXI_GP1_RREADY
    .S_AXI_GP1_WLAST    (   s_axi_gp_1.wlast    ),                // input wire S_AXI_GP1_WLAST
    .S_AXI_GP1_WVALID   (   s_axi_gp_1.wvalid   ),                // input wire S_AXI_GP1_WVALID
    .S_AXI_GP1_ARBURST  (   s_axi_gp_1.arburst  ),                // input wire [1 : 0] S_AXI_GP1_ARBURST
    .S_AXI_GP1_ARLOCK   (   s_axi_gp_1.arlock   ),                // input wire [1 : 0] S_AXI_GP1_ARLOCK
    .S_AXI_GP1_ARSIZE   (   s_axi_gp_1.arsize   ),                // input wire [2 : 0] S_AXI_GP1_ARSIZE
    .S_AXI_GP1_AWBURST  (   s_axi_gp_1.awburst  ),                // input wire [1 : 0] S_AXI_GP1_AWBURST
    .S_AXI_GP1_AWLOCK   (   s_axi_gp_1.awlock   ),                // input wire [1 : 0] S_AXI_GP1_AWLOCK
    .S_AXI_GP1_AWSIZE   (   s_axi_gp_1.awsize   ),                // input wire [2 : 0] S_AXI_GP1_AWSIZE
    .S_AXI_GP1_ARPROT   (   s_axi_gp_1.arprot   ),                // input wire [2 : 0] S_AXI_GP1_ARPROT
    .S_AXI_GP1_AWPROT   (   s_axi_gp_1.awprot   ),                // input wire [2 : 0] S_AXI_GP1_AWPROT
    .S_AXI_GP1_ARADDR   (   s_axi_gp_1.araddr   ),                // input wire [31 : 0] S_AXI_GP1_ARADDR
    .S_AXI_GP1_AWADDR   (   s_axi_gp_1.awaddr   ),                // input wire [31 : 0] S_AXI_GP1_AWADDR
    .S_AXI_GP1_WDATA    (   s_axi_gp_1.wdata    ),                // input wire [31 : 0] S_AXI_GP1_WDATA
    .S_AXI_GP1_ARCACHE  (   s_axi_gp_1.arcache  ),                // input wire [3 : 0] S_AXI_GP1_ARCACHE
    .S_AXI_GP1_ARLEN    (   s_axi_gp_1.arlen    ),                // input wire [3 : 0] S_AXI_GP1_ARLEN
    .S_AXI_GP1_ARQOS    (   s_axi_gp_1.arqos    ),                // input wire [3 : 0] S_AXI_GP1_ARQOS
    .S_AXI_GP1_AWCACHE  (   s_axi_gp_1.awcache  ),                // input wire [3 : 0] S_AXI_GP1_AWCACHE
    .S_AXI_GP1_AWLEN    (   s_axi_gp_1.awlen    ),                // input wire [3 : 0] S_AXI_GP1_AWLEN
    .S_AXI_GP1_AWQOS    (   s_axi_gp_1.awqos    ),                // input wire [3 : 0] S_AXI_GP1_AWQOS
    .S_AXI_GP1_WSTRB    (   s_axi_gp_1.wstrb    ),                // input wire [3 : 0] S_AXI_GP1_WSTRB
    .S_AXI_GP1_ARID     (   s_axi_gp_1.arid     ),                // input wire [5 : 0] S_AXI_GP1_ARID
    .S_AXI_GP1_AWID     (   s_axi_gp_1.awid     ),                // input wire [5 : 0] S_AXI_GP1_AWID
    .S_AXI_GP1_WID      (   s_axi_gp_1.wid      ),                // input wire [5 : 0] S_AXI_GP1_WID
    `endif

    `ifdef USE_S_AXI_HP_0
    .S_AXI_HP0_ARREADY  (   s_axi_hp_0.arready  ),                // output wire S_AXI_HP0_ARREADY
    .S_AXI_HP0_AWREADY  (   s_axi_hp_0.awready  ),                // output wire S_AXI_HP0_AWREADY
    .S_AXI_HP0_BVALID   (   s_axi_hp_0.bvalid   ),                  // output wire S_AXI_HP0_BVALID
    .S_AXI_HP0_RLAST    (   s_axi_hp_0.rlast    ),                    // output wire S_AXI_HP0_RLAST
    .S_AXI_HP0_RVALID   (   s_axi_hp_0.rvalid   ),                  // output wire S_AXI_HP0_RVALID
    .S_AXI_HP0_WREADY   (   s_axi_hp_0.wready   ),                  // output wire S_AXI_HP0_WREADY
    .S_AXI_HP0_BRESP    (   s_axi_hp_0.bresp    ),                    // output wire [1 : 0] S_AXI_HP0_BRESP
    .S_AXI_HP0_RRESP    (   s_axi_hp_0.rresp    ),                    // output wire [1 : 0] S_AXI_HP0_RRESP
    .S_AXI_HP0_BID      (   s_axi_hp_0.bid      ),                        // output wire [5 : 0] S_AXI_HP0_BID
    .S_AXI_HP0_RID      (   s_axi_hp_0.rid      ),                        // output wire [5 : 0] S_AXI_HP0_RID
    .S_AXI_HP0_RDATA    (   s_axi_hp_0.rdata    ),                    // output wire [63 : 0] S_AXI_HP0_RDATA
    .S_AXI_HP0_ACLK     (   s_axi_hp_aclk[0]    ),                      // input wire S_AXI_HP0_ACLK
    .S_AXI_HP0_ARVALID  (   s_axi_hp_0.arvalid  ),                // input wire S_AXI_HP0_ARVALID
    .S_AXI_HP0_AWVALID  (   s_axi_hp_0.awvalid  ),                // input wire S_AXI_HP0_AWVALID
    .S_AXI_HP0_BREADY   (   s_axi_hp_0.bready   ),                  // input wire S_AXI_HP0_BREADY
    .S_AXI_HP0_RREADY   (   s_axi_hp_0.rready   ),                  // input wire S_AXI_HP0_RREADY
    .S_AXI_HP0_WLAST    (   s_axi_hp_0.wlast    ),                    // input wire S_AXI_HP0_WLAST
    .S_AXI_HP0_WVALID   (   s_axi_hp_0.wvalid   ),                  // input wire S_AXI_HP0_WVALID
    .S_AXI_HP0_ARBURST  (   s_axi_hp_0.arburst  ),                // input wire [1 : 0] S_AXI_HP0_ARBURST
    .S_AXI_HP0_ARLOCK   (   s_axi_hp_0.arlock   ),                  // input wire [1 : 0] S_AXI_HP0_ARLOCK
    .S_AXI_HP0_ARSIZE   (   s_axi_hp_0.arsize   ),                  // input wire [2 : 0] S_AXI_HP0_ARSIZE
    .S_AXI_HP0_AWBURST  (   s_axi_hp_0.awburst  ),                // input wire [1 : 0] S_AXI_HP0_AWBURST
    .S_AXI_HP0_AWLOCK   (   s_axi_hp_0.awlock   ),                  // input wire [1 : 0] S_AXI_HP0_AWLOCK
    .S_AXI_HP0_AWSIZE   (   s_axi_hp_0.awsize   ),                  // input wire [2 : 0] S_AXI_HP0_AWSIZE
    .S_AXI_HP0_ARPROT   (   s_axi_hp_0.arprot   ),                  // input wire [2 : 0] S_AXI_HP0_ARPROT
    .S_AXI_HP0_AWPROT   (   s_axi_hp_0.awprot   ),                  // input wire [2 : 0] S_AXI_HP0_AWPROT
    .S_AXI_HP0_ARADDR   (   s_axi_hp_0.araddr   ),                  // input wire [31 : 0] S_AXI_HP0_ARADDR
    .S_AXI_HP0_AWADDR   (   s_axi_hp_0.awaddr   ),                  // input wire [31 : 0] S_AXI_HP0_AWADDR
    .S_AXI_HP0_ARCACHE  (   s_axi_hp_0.arcache  ),                // input wire [3 : 0] S_AXI_HP0_ARCACHE
    .S_AXI_HP0_ARLEN    (   s_axi_hp_0.arlen    ),                    // input wire [3 : 0] S_AXI_HP0_ARLEN
    .S_AXI_HP0_ARQOS    (   s_axi_hp_0.arqos    ),                    // input wire [3 : 0] S_AXI_HP0_ARQOS
    .S_AXI_HP0_AWCACHE  (   s_axi_hp_0.awcache  ),                // input wire [3 : 0] S_AXI_HP0_AWCACHE
    .S_AXI_HP0_AWLEN    (   s_axi_hp_0.awlen    ),                    // input wire [3 : 0] S_AXI_HP0_AWLEN
    .S_AXI_HP0_AWQOS    (   s_axi_hp_0.awqos    ),                    // input wire [3 : 0] S_AXI_HP0_AWQOS
    .S_AXI_HP0_ARID     (   s_axi_hp_0.arid     ),                      // input wire [5 : 0] S_AXI_HP0_ARID
    .S_AXI_HP0_AWID     (   s_axi_hp_0.awid     ),                      // input wire [5 : 0] S_AXI_HP0_AWID
    .S_AXI_HP0_WID      (   s_axi_hp_0.wid      ),                        // input wire [5 : 0] S_AXI_HP0_WID
    .S_AXI_HP0_WDATA    (   s_axi_hp_0.wdata    ),                    // input wire [63 : 0] S_AXI_HP0_WDATA
    .S_AXI_HP0_WSTRB    (   s_axi_hp_0.wstrb    ),                    // input wire [7 : 0] S_AXI_HP0_WSTRB
    .S_AXI_HP0_RCOUNT   (                       ),                  // output wire [7 : 0] S_AXI_HP0_RCOUNT
    .S_AXI_HP0_WCOUNT   (                       ),                  // output wire [7 : 0] S_AXI_HP0_WCOUNT
    .S_AXI_HP0_RACOUNT  (                       ),                // output wire [2 : 0] S_AXI_HP0_RACOUNT
    .S_AXI_HP0_WACOUNT  (                       ),                // output wire [5 : 0] S_AXI_HP0_WACOUNT
    .S_AXI_HP0_RDISSUECAP1_EN(                  ),        // input wire S_AXI_HP0_RDISSUECAP1_EN
    .S_AXI_HP0_WRISSUECAP1_EN(                  ),        // input wire S_AXI_HP0_WRISSUECAP1_EN
    `endif

    `ifdef USE_S_AXI_HP_1
    .S_AXI_HP1_ARREADY  (   s_axi_hp_1.arready  ),                    // output wire S_AXI_HP0_ARREADY
    .S_AXI_HP1_AWREADY  (   s_axi_hp_1.awready  ),                    // output wire S_AXI_HP0_AWREADY
    .S_AXI_HP1_BVALID   (   s_axi_hp_1.bvalid   ),                      // output wire S_AXI_HP0_BVALID
    .S_AXI_HP1_RLAST    (   s_axi_hp_1.rlast    ),                        // output wire S_AXI_HP0_RLAST
    .S_AXI_HP1_RVALID   (   s_axi_hp_1.rvalid   ),                      // output wire S_AXI_HP0_RVALID
    .S_AXI_HP1_WREADY   (   s_axi_hp_1.wready   ),                      // output wire S_AXI_HP0_WREADY
    .S_AXI_HP1_BRESP    (   s_axi_hp_1.bresp    ),                        // output wire [1 : 0] S_AXI_HP0_BRESP
    .S_AXI_HP1_RRESP    (   s_axi_hp_1.rresp    ),                        // output wire [1 : 0] S_AXI_HP0_RRESP
    .S_AXI_HP1_BID      (   s_axi_hp_1.bid      ),                            // output wire [5 : 0] S_AXI_HP0_BID
    .S_AXI_HP1_RID      (   s_axi_hp_1.rid      ),                            // output wire [5 : 0] S_AXI_HP0_RID
    .S_AXI_HP1_RDATA    (   s_axi_hp_1.rdata    ),                        // output wire [63 : 0] S_AXI_HP0_RDATA
    .S_AXI_HP1_ACLK     (   s_axi_hp_aclk[1]    ),                          // input wire S_AXI_HP0_ACLK
    .S_AXI_HP1_ARVALID  (   s_axi_hp_1.arvalid  ),                    // input wire S_AXI_HP0_ARVALID
    .S_AXI_HP1_AWVALID  (   s_axi_hp_1.awvalid  ),                    // input wire S_AXI_HP0_AWVALID
    .S_AXI_HP1_BREADY   (   s_axi_hp_1.bready   ),                      // input wire S_AXI_HP0_BREADY
    .S_AXI_HP1_RREADY   (   s_axi_hp_1.rready   ),                      // input wire S_AXI_HP0_RREADY
    .S_AXI_HP1_WLAST    (   s_axi_hp_1.wlast    ),                        // input wire S_AXI_HP0_WLAST
    .S_AXI_HP1_WVALID   (   s_axi_hp_1.wvalid   ),                      // input wire S_AXI_HP0_WVALID
    .S_AXI_HP1_ARBURST  (   s_axi_hp_1.arburst  ),                    // input wire [1 : 0] S_AXI_HP0_ARBURST
    .S_AXI_HP1_ARLOCK   (   s_axi_hp_1.arlock   ),                      // input wire [1 : 0] S_AXI_HP0_ARLOCK
    .S_AXI_HP1_ARSIZE   (   s_axi_hp_1.arsize   ),                      // input wire [2 : 0] S_AXI_HP0_ARSIZE
    .S_AXI_HP1_AWBURST  (   s_axi_hp_1.awburst  ),                    // input wire [1 : 0] S_AXI_HP0_AWBURST
    .S_AXI_HP1_AWLOCK   (   s_axi_hp_1.awlock   ),                      // input wire [1 : 0] S_AXI_HP0_AWLOCK
    .S_AXI_HP1_AWSIZE   (   s_axi_hp_1.awsize   ),                      // input wire [2 : 0] S_AXI_HP0_AWSIZE
    .S_AXI_HP1_ARPROT   (   s_axi_hp_1.arprot   ),                      // input wire [2 : 0] S_AXI_HP0_ARPROT
    .S_AXI_HP1_AWPROT   (   s_axi_hp_1.awprot   ),                      // input wire [2 : 0] S_AXI_HP0_AWPROT
    .S_AXI_HP1_ARADDR   (   s_axi_hp_1.araddr   ),                      // input wire [31 : 0] S_AXI_HP0_ARADDR
    .S_AXI_HP1_AWADDR   (   s_axi_hp_1.awaddr   ),                      // input wire [31 : 0] S_AXI_HP0_AWADDR
    .S_AXI_HP1_ARCACHE  (   s_axi_hp_1.arcache  ),                    // input wire [3 : 0] S_AXI_HP0_ARCACHE
    .S_AXI_HP1_ARLEN    (   s_axi_hp_1.arlen    ),                        // input wire [3 : 0] S_AXI_HP0_ARLEN
    .S_AXI_HP1_ARQOS    (   s_axi_hp_1.arqos    ),                        // input wire [3 : 0] S_AXI_HP0_ARQOS
    .S_AXI_HP1_AWCACHE  (   s_axi_hp_1.awcache  ),                    // input wire [3 : 0] S_AXI_HP0_AWCACHE
    .S_AXI_HP1_AWLEN    (   s_axi_hp_1.awlen    ),                        // input wire [3 : 0] S_AXI_HP0_AWLEN
    .S_AXI_HP1_AWQOS    (   s_axi_hp_1.awqos    ),                        // input wire [3 : 0] S_AXI_HP0_AWQOS
    .S_AXI_HP1_ARID     (   s_axi_hp_1.arid     ),                          // input wire [5 : 0] S_AXI_HP0_ARID
    .S_AXI_HP1_AWID     (   s_axi_hp_1.awid     ),                          // input wire [5 : 0] S_AXI_HP0_AWID
    .S_AXI_HP1_WID      (   s_axi_hp_1.wid      ),                            // input wire [5 : 0] S_AXI_HP0_WID
    .S_AXI_HP1_WDATA    (   s_axi_hp_1.wdata    ),                        // input wire [63 : 0] S_AXI_HP0_WDATA
    .S_AXI_HP1_WSTRB    (   s_axi_hp_1.wstrb    ),                        // input wire [7 : 0] S_AXI_HP0_WSTRB
    .S_AXI_HP1_RCOUNT   (                       ),                  // output wire [7 : 0] S_AXI_HP0_RCOUNT
    .S_AXI_HP1_WCOUNT   (                       ),                  // output wire [7 : 0] S_AXI_HP0_WCOUNT
    .S_AXI_HP1_RACOUNT  (                       ),                // output wire [2 : 0] S_AXI_HP0_RACOUNT
    .S_AXI_HP1_WACOUNT  (                       ),                // output wire [5 : 0] S_AXI_HP0_WACOUNT
    .S_AXI_HP1_RDISSUECAP1_EN(                  ),        // input wire S_AXI_HP0_RDISSUECAP1_EN
    .S_AXI_HP1_WRISSUECAP1_EN(                  ),        // input wire S_AXI_HP0_WRISSUECAP1_EN
    `endif
    `ifdef USE_S_AXI_HP_2
    .S_AXI_HP2_ARREADY  (   s_axi_hp_2.arready  ),         // output wire S_AXI_HP2_ARREADY
    .S_AXI_HP2_AWREADY  (   s_axi_hp_2.awready  ),         // output wire S_AXI_HP2_AWREADY
    .S_AXI_HP2_BVALID   (   s_axi_hp_2.bvalid   ),         // output wire S_AXI_HP2_BVALID
    .S_AXI_HP2_RLAST    (   s_axi_hp_2.rlast    ),         // output wire S_AXI_HP2_RLAST
    .S_AXI_HP2_RVALID   (   s_axi_hp_2.rvalid   ),         // output wire S_AXI_HP2_RVALID
    .S_AXI_HP2_WREADY   (   s_axi_hp_2.wready   ),         // output wire S_AXI_HP2_WREADY
    .S_AXI_HP2_BRESP    (   s_axi_hp_2.bresp    ),         // output wire [1 : 0] S_AXI_HP2_BRESP
    .S_AXI_HP2_RRESP    (   s_axi_hp_2.rresp    ),         // output wire [1 : 0] S_AXI_HP2_RRESP
    .S_AXI_HP2_BID      (   s_axi_hp_2.bid      ),         // output wire [5 : 0] S_AXI_HP2_BID
    .S_AXI_HP2_RID      (   s_axi_hp_2.rid      ),         // output wire [5 : 0] S_AXI_HP2_RID
    .S_AXI_HP2_RDATA    (   s_axi_hp_2.rdata    ),         // output wire [63 : 0] S_AXI_HP2_RDATA
    .S_AXI_HP2_ACLK     (   s_axi_hp_aclk[2]    ),         // output wire [7 : 0] S_AXI_HP2_RCOUNT
    .S_AXI_HP2_ARVALID  (   s_axi_hp_2.arvalid  ),         // output wire [7 : 0] S_AXI_HP2_WCOUNT
    .S_AXI_HP2_AWVALID  (   s_axi_hp_2.awvalid  ),         // output wire [2 : 0] S_AXI_HP2_RACOUNT
    .S_AXI_HP2_BREADY   (   s_axi_hp_2.bready   ),         // output wire [5 : 0] S_AXI_HP2_WACOUNT
    .S_AXI_HP2_RREADY   (   s_axi_hp_2.rready   ),         // input wire S_AXI_HP2_ACLK
    .S_AXI_HP2_WLAST    (   s_axi_hp_2.wlast    ),         // input wire S_AXI_HP2_ARVALID
    .S_AXI_HP2_WVALID   (   s_axi_hp_2.wvalid   ),         // input wire S_AXI_HP2_AWVALID
    .S_AXI_HP2_ARBURST  (   s_axi_hp_2.arburst  ),         // input wire S_AXI_HP2_BREADY
    .S_AXI_HP2_ARLOCK   (   s_axi_hp_2.arlock   ),         // input wire S_AXI_HP2_RDISSUECAP1_EN
    .S_AXI_HP2_ARSIZE   (   s_axi_hp_2.arsize   ),         // input wire S_AXI_HP2_RREADY
    .S_AXI_HP2_AWBURST  (   s_axi_hp_2.awburst  ),         // input wire S_AXI_HP2_WLAST
    .S_AXI_HP2_AWLOCK   (   s_axi_hp_2.awlock   ),         // input wire S_AXI_HP2_WRISSUECAP1_EN
    .S_AXI_HP2_AWSIZE   (   s_axi_hp_2.awsize   ),         // input wire S_AXI_HP2_WVALID
    .S_AXI_HP2_ARPROT   (   s_axi_hp_2.arprot   ),         // input wire [1 : 0] S_AXI_HP2_ARBURST
    .S_AXI_HP2_AWPROT   (   s_axi_hp_2.awprot   ),         // input wire [1 : 0] S_AXI_HP2_ARLOCK
    .S_AXI_HP2_ARADDR   (   s_axi_hp_2.araddr   ),         // input wire [2 : 0] S_AXI_HP2_ARSIZE
    .S_AXI_HP2_AWADDR   (   s_axi_hp_2.awaddr   ),         // input wire [1 : 0] S_AXI_HP2_AWBURST
    .S_AXI_HP2_ARCACHE  (   s_axi_hp_2.arcache  ),         // input wire [1 : 0] S_AXI_HP2_AWLOCK
    .S_AXI_HP2_ARLEN    (   s_axi_hp_2.arlen    ),         // input wire [2 : 0] S_AXI_HP2_AWSIZE
    .S_AXI_HP2_ARQOS    (   s_axi_hp_2.arqos    ),         // input wire [2 : 0] S_AXI_HP2_ARPROT
    .S_AXI_HP2_AWCACHE  (   s_axi_hp_2.awcache  ),         // input wire [2 : 0] S_AXI_HP2_AWPROT
    .S_AXI_HP2_AWLEN    (   s_axi_hp_2.awlen    ),         // input wire [31 : 0] S_AXI_HP2_ARADDR
    .S_AXI_HP2_AWQOS    (   s_axi_hp_2.awqos    ),         // input wire [31 : 0] S_AXI_HP2_AWADDR
    .S_AXI_HP2_ARID     (   s_axi_hp_2.arid     ),         // input wire [3 : 0] S_AXI_HP2_ARCACHE
    .S_AXI_HP2_AWID     (   s_axi_hp_2.awid     ),         // input wire [3 : 0] S_AXI_HP2_ARLEN
    .S_AXI_HP2_WID      (   s_axi_hp_2.wid      ),         // input wire [3 : 0] S_AXI_HP2_ARQOS
    .S_AXI_HP2_WDATA    (   s_axi_hp_2.wdata    ),         // input wire [3 : 0] S_AXI_HP2_AWCACHE
    .S_AXI_HP2_WSTRB    (   s_axi_hp_2.wstrb    ),         // input wire [3 : 0] S_AXI_HP2_AWLEN
    .S_AXI_HP2_RCOUNT   (                       ),     // input wire [3 : 0] S_AXI_HP2_AWQOS
    .S_AXI_HP2_WCOUNT   (                       ),     // input wire [5 : 0] S_AXI_HP2_ARID
    .S_AXI_HP2_RACOUNT  (                       ),     // input wire [5 : 0] S_AXI_HP2_AWID
    .S_AXI_HP2_WACOUNT  (                       ),     // input wire [5 : 0] S_AXI_HP2_WID
    .S_AXI_HP2_RDISSUECAP1_EN(                  ),      // input wire [63 : 0] S_AXI_HP2_WDATA
    .S_AXI_HP2_WRISSUECAP1_EN(                  ),      // input wire [7 : 0] S_AXI_HP2_WSTRB
    `endif

    `ifdef USE_S_AXI_HP_3
    .S_AXI_HP3_ARREADY  (   s_axi_hp_3.arready  ),      // output wire S_AXI_HP3_ARREADY
    .S_AXI_HP3_AWREADY  (   s_axi_hp_3.awready  ),      // output wire S_AXI_HP3_AWREADY
    .S_AXI_HP3_BVALID   (   s_axi_hp_3.bvalid   ),      // output wire S_AXI_HP3_BVALID
    .S_AXI_HP3_RLAST    (   s_axi_hp_3.rlast    ),      // output wire S_AXI_HP3_RLAST
    .S_AXI_HP3_RVALID   (   s_axi_hp_3.rvalid   ),      // output wire S_AXI_HP3_RVALID
    .S_AXI_HP3_WREADY   (   s_axi_hp_3.wready   ),      // output wire S_AXI_HP3_WREADY
    .S_AXI_HP3_BRESP    (   s_axi_hp_3.bresp    ),      // output wire [1 : 0] S_AXI_HP3_BRESP
    .S_AXI_HP3_RRESP    (   s_axi_hp_3.rresp    ),      // output wire [1 : 0] S_AXI_HP3_RRESP
    .S_AXI_HP3_BID      (   s_axi_hp_3.bid      ),      // output wire [5 : 0] S_AXI_HP3_BID
    .S_AXI_HP3_RID      (   s_axi_hp_3.rid      ),      // output wire [5 : 0] S_AXI_HP3_RID
    .S_AXI_HP3_RDATA    (   s_axi_hp_3.rdata    ),      // output wire [63 : 0] S_AXI_HP3_RDATA
    .S_AXI_HP3_ACLK     (   s_axi_hp_aclk[3]    ),      // output wire [7 : 0] S_AXI_HP3_RCOUNT
    .S_AXI_HP3_ARVALID  (   s_axi_hp_3.arvalid  ),      // output wire [7 : 0] S_AXI_HP3_WCOUNT
    .S_AXI_HP3_AWVALID  (   s_axi_hp_3.awvalid  ),      // output wire [2 : 0] S_AXI_HP3_RACOUNT
    .S_AXI_HP3_BREADY   (   s_axi_hp_3.bready   ),      // output wire [5 : 0] S_AXI_HP3_WACOUNT
    .S_AXI_HP3_RREADY   (   s_axi_hp_3.rready   ),      // input wire S_AXI_HP3_ACLK
    .S_AXI_HP3_WLAST    (   s_axi_hp_3.wlast    ),      // input wire S_AXI_HP3_ARVALID
    .S_AXI_HP3_WVALID   (   s_axi_hp_3.wvalid   ),      // input wire S_AXI_HP3_AWVALID
    .S_AXI_HP3_ARBURST  (   s_axi_hp_3.arburst  ),      // input wire S_AXI_HP3_BREADY
    .S_AXI_HP3_ARLOCK   (   s_axi_hp_3.arlock   ),      // input wire S_AXI_HP3_RDISSUECAP1_EN
    .S_AXI_HP3_ARSIZE   (   s_axi_hp_3.arsize   ),      // input wire S_AXI_HP3_RREADY
    .S_AXI_HP3_AWBURST  (   s_axi_hp_3.awburst  ),      // input wire S_AXI_HP3_WLAST
    .S_AXI_HP3_AWLOCK   (   s_axi_hp_3.awlock   ),      // input wire S_AXI_HP3_WRISSUECAP1_EN
    .S_AXI_HP3_AWSIZE   (   s_axi_hp_3.awsize   ),      // input wire S_AXI_HP3_WVALID
    .S_AXI_HP3_ARPROT   (   s_axi_hp_3.arprot   ),      // input wire [1 : 0] S_AXI_HP3_ARBURST
    .S_AXI_HP3_AWPROT   (   s_axi_hp_3.awprot   ),      // input wire [1 : 0] S_AXI_HP3_ARLOCK
    .S_AXI_HP3_ARADDR   (   s_axi_hp_3.araddr   ),      // input wire [2 : 0] S_AXI_HP3_ARSIZE
    .S_AXI_HP3_AWADDR   (   s_axi_hp_3.awaddr   ),      // input wire [1 : 0] S_AXI_HP3_AWBURST
    .S_AXI_HP3_ARCACHE  (   s_axi_hp_3.arcache  ),      // input wire [1 : 0] S_AXI_HP3_AWLOCK
    .S_AXI_HP3_ARLEN    (   s_axi_hp_3.arlen    ),      // input wire [2 : 0] S_AXI_HP3_AWSIZE
    .S_AXI_HP3_ARQOS    (   s_axi_hp_3.arqos    ),      // input wire [2 : 0] S_AXI_HP3_ARPROT
    .S_AXI_HP3_AWCACHE  (   s_axi_hp_3.awcache  ),      // input wire [2 : 0] S_AXI_HP3_AWPROT
    .S_AXI_HP3_AWLEN    (   s_axi_hp_3.awlen    ),      // input wire [31 : 0] S_AXI_HP3_ARADDR
    .S_AXI_HP3_AWQOS    (   s_axi_hp_3.awqos    ),      // input wire [31 : 0] S_AXI_HP3_AWADDR
    .S_AXI_HP3_ARID     (   s_axi_hp_3.arid     ),      // input wire [3 : 0] S_AXI_HP3_ARCACHE
    .S_AXI_HP3_AWID     (   s_axi_hp_3.awid     ),      // input wire [3 : 0] S_AXI_HP3_ARLEN
    .S_AXI_HP3_WID      (   s_axi_hp_3.wid      ),      // input wire [3 : 0] S_AXI_HP3_ARQOS
    .S_AXI_HP3_WDATA    (   s_axi_hp_3.wdata    ),      // input wire [3 : 0] S_AXI_HP3_AWCACHE
    .S_AXI_HP3_WSTRB    (   s_axi_hp_3.wstrb    ),      // input wire [3 : 0] S_AXI_HP3_AWLEN
    .S_AXI_HP3_RCOUNT   (                       ),      // input wire [3 : 0] S_AXI_HP3_AWQOS
    .S_AXI_HP3_WCOUNT   (                       ),      // input wire [5 : 0] S_AXI_HP3_ARID
    .S_AXI_HP3_RACOUNT  (                       ),      // input wire [5 : 0] S_AXI_HP3_AWID
    .S_AXI_HP3_WACOUNT  (                       ),      // input wire [5 : 0] S_AXI_HP3_WID
    .S_AXI_HP3_RDISSUECAP1_EN(                  ),      // input wire [63 : 0] S_AXI_HP3_WDATA
    .S_AXI_HP3_WRISSUECAP1_EN(                  ),      // input wire [7 : 0] S_AXI_HP3_WSTRB
    `endif

    .DDR_Addr           (   ddr_addr            ),                     // inout wire DDR_CAS_n
    .DDR_BankAddr       (   ddr_ba              ),                         // inout wire DDR_CKE
    .DDR_CAS_n          (   ddr_cas_n           ),                     // inout wire DDR_Clk_n
    .DDR_CKE            (   ddr_cke             ),                         // inout wire DDR_Clk
    .DDR_CS_n           (   ddr_cs_n            ),                       // inout wire DDR_CS_n
    .DDR_Clk            (   ddr_ck_p            ),                     // inout wire DDR_DRSTB
    .DDR_Clk_n          (   ddr_ck_n            ),                         // inout wire DDR_ODT
    .DDR_DM             (   ddr_dm              ),                     // inout wire DDR_RAS_n
    .DDR_DQ             (   ddr_dq              ),                          // inout wire DDR_WEB
    .DDR_DQS            (   ddr_dqs_p           ),               // inout wire [2 : 0] DDR_BankAddr
    .DDR_DQS_n          (   ddr_dqs_n           ),                       // inout wire [14 : 0] DDR_Addr
    .DDR_DRSTB          (   ddr_reset_n         ),                         // inout wire DDR_VRN
    .DDR_ODT            (   ddr_odt             ),                         // inout wire DDR_VRP
    .DDR_RAS_n          (   ddr_ras_n           ),             // inout wire [3 : 0] DDR_DM
    .DDR_VRN            (   fixed_io_ddr_vrn    ),             // inout wire [31 : 0] DDR_DQ
    .DDR_VRP            (   fixed_io_ddr_vrp    ),          // inout wire [3 : 0] DDR_DQS_n
    .DDR_WEB            (   ddr_we_n            ),            // inout wire [3 : 0] DDR_DQS
    .PS_SRSTB           (   fixed_io_ps_srstb   ),                        // inout wire PS_SRSTB
    .PS_CLK             (   fixed_io_ps_clk     ),                            // inout wire PS_CLK
    .PS_PORB            (   fixed_io_ps_porb    )                          // inout wire PS_PORB
);
    
endmodule