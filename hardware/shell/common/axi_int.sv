//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// axi_int.sv
// 
// Description:
// AXI interconncet wrapper.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.22  fanfei      Initial version
//****************************************************************

`timescale 1ns/1ps
`include "pre_proc.vh"

module axi_int #(
) (
    axi4            s_axi_gp,
    input           s_axi_gp_aclk,
    input           s_axi_gp_rst_n,

    axi_lite        m_axil,
    input           m_axil_aclk,
    input           m_axil_rst_n
);

`ifdef USE_AXIL_0
axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_0();
`endif
`ifdef USE_AXIL_1
axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_1();
`endif
`ifdef USE_AXIL_2
axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_2();
`endif
`ifdef USE_AXIL_3
axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_3();
`endif
`ifdef USE_AXIL_4
axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_4();
`endif
`ifdef USE_AXIL_5
axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_5();
`endif
`ifdef USE_AXIL_6
axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_6();
`endif
`ifdef USE_AXIL_7
axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_7();
`endif

interconncet interconncet_inst (
    `ifdef USE_AXIL_0
    .M00_AXI_0_araddr   (   axil_0.araddr   ),
    .M00_AXI_0_arprot   (   axil_0.arprot   ),
    .M00_AXI_0_arready  (   axil_0.arready  ),
    .M00_AXI_0_arvalid  (   axil_0.arvalid  ),
    .M00_AXI_0_awaddr   (   axil_0.awaddr   ),
    .M00_AXI_0_awprot   (   axil_0.awprot   ),
    .M00_AXI_0_awready  (   axil_0.awready  ),
    .M00_AXI_0_awvalid  (   axil_0.awvalid  ),
    .M00_AXI_0_bready   (   axil_0.bready   ),
    .M00_AXI_0_bresp    (   axil_0.bresp    ),
    .M00_AXI_0_bvalid   (   axil_0.bvalid   ),
    .M00_AXI_0_rdata    (   axil_0.rdata    ),
    .M00_AXI_0_rready   (   axil_0.rready   ),
    .M00_AXI_0_rresp    (   axil_0.rresp    ),
    .M00_AXI_0_rvalid   (   axil_0.rvalid   ),
    .M00_AXI_0_wdata    (   axil_0.wdata    ),
    .M00_AXI_0_wready   (   axil_0.wready   ),
    .M00_AXI_0_wstrb    (   axil_0.wstrb    ),
    .M00_AXI_0_wvalid   (   axil_0.wvalid   ),
    `endif
    `ifdef USE_AXIL_1
    .M01_AXI_0_araddr   (   axil_1.araddr   ),
    .M01_AXI_0_arprot   (   axil_1.arprot   ),
    .M01_AXI_0_arready  (   axil_1.arready  ),
    .M01_AXI_0_arvalid  (   axil_1.arvalid  ),
    .M01_AXI_0_awaddr   (   axil_1.awaddr   ),
    .M01_AXI_0_awprot   (   axil_1.awprot   ),
    .M01_AXI_0_awready  (   axil_1.awready  ),
    .M01_AXI_0_awvalid  (   axil_1.awvalid  ),
    .M01_AXI_0_bready   (   axil_1.bready   ),
    .M01_AXI_0_bresp    (   axil_1.bresp    ),
    .M01_AXI_0_bvalid   (   axil_1.bvalid   ),
    .M01_AXI_0_rdata    (   axil_1.rdata    ),
    .M01_AXI_0_rready   (   axil_1.rready   ),
    .M01_AXI_0_rresp    (   axil_1.rresp    ),
    .M01_AXI_0_rvalid   (   axil_1.rvalid   ),
    .M01_AXI_0_wdata    (   axil_1.wdata    ),
    .M01_AXI_0_wready   (   axil_1.wready   ),
    .M01_AXI_0_wstrb    (   axil_1.wstrb    ),
    .M01_AXI_0_wvalid   (   axil_1.wvalid   ),
    `endif
    `ifdef USE_AXIL_2
    .M02_AXI_0_araddr   (   axil_2.araddr   ),
    .M02_AXI_0_arprot   (   axil_2.arprot   ),
    .M02_AXI_0_arready  (   axil_2.arready  ),
    .M02_AXI_0_arvalid  (   axil_2.arvalid  ),
    .M02_AXI_0_awaddr   (   axil_2.awaddr   ),
    .M02_AXI_0_awprot   (   axil_2.awprot   ),
    .M02_AXI_0_awready  (   axil_2.awready  ),
    .M02_AXI_0_awvalid  (   axil_2.awvalid  ),
    .M02_AXI_0_bready   (   axil_2.bready   ),
    .M02_AXI_0_bresp    (   axil_2.bresp    ),
    .M02_AXI_0_bvalid   (   axil_2.bvalid   ),
    .M02_AXI_0_rdata    (   axil_2.rdata    ),
    .M02_AXI_0_rready   (   axil_2.rready   ),
    .M02_AXI_0_rresp    (   axil_2.rresp    ),
    .M02_AXI_0_rvalid   (   axil_2.rvalid   ),
    .M02_AXI_0_wdata    (   axil_2.wdata    ),
    .M02_AXI_0_wready   (   axil_2.wready   ),
    .M02_AXI_0_wstrb    (   axil_2.wstrb    ),
    .M02_AXI_0_wvalid   (   axil_2.wvalid   ),
    `endif
    `ifdef USE_AXIL_3
    .M03_AXI_0_araddr   (   axil_3.araddr   ),
    .M03_AXI_0_arprot   (   axil_3.arprot   ),
    .M03_AXI_0_arready  (   axil_3.arready  ),
    .M03_AXI_0_arvalid  (   axil_3.arvalid  ),
    .M03_AXI_0_awaddr   (   axil_3.awaddr   ),
    .M03_AXI_0_awprot   (   axil_3.awprot   ),
    .M03_AXI_0_awready  (   axil_3.awready  ),
    .M03_AXI_0_awvalid  (   axil_3.awvalid  ),
    .M03_AXI_0_bready   (   axil_3.bready   ),
    .M03_AXI_0_bresp    (   axil_3.bresp    ),
    .M03_AXI_0_bvalid   (   axil_3.bvalid   ),
    .M03_AXI_0_rdata    (   axil_3.rdata    ),
    .M03_AXI_0_rready   (   axil_3.rready   ),
    .M03_AXI_0_rresp    (   axil_3.rresp    ),
    .M03_AXI_0_rvalid   (   axil_3.rvalid   ),
    .M03_AXI_0_wdata    (   axil_3.wdata    ),
    .M03_AXI_0_wready   (   axil_3.wready   ),
    .M03_AXI_0_wstrb    (   axil_3.wstrb    ),
    .M03_AXI_0_wvalid   (   axil_3.wvalid   ),
    `endif
    `ifdef USE_AXIL_4
    .M04_AXI_0_araddr   (   axil_4.araddr   ),
    .M04_AXI_0_arprot   (   axil_4.arprot   ),
    .M04_AXI_0_arready  (   axil_4.arready  ),
    .M04_AXI_0_arvalid  (   axil_4.arvalid  ),
    .M04_AXI_0_awaddr   (   axil_4.awaddr   ),
    .M04_AXI_0_awprot   (   axil_4.awprot   ),
    .M04_AXI_0_awready  (   axil_4.awready  ),
    .M04_AXI_0_awvalid  (   axil_4.awvalid  ),
    .M04_AXI_0_bready   (   axil_4.bready   ),
    .M04_AXI_0_bresp    (   axil_4.bresp    ),
    .M04_AXI_0_bvalid   (   axil_4.bvalid   ),
    .M04_AXI_0_rdata    (   axil_4.rdata    ),
    .M04_AXI_0_rready   (   axil_4.rready   ),
    .M04_AXI_0_rresp    (   axil_4.rresp    ),
    .M04_AXI_0_rvalid   (   axil_4.rvalid   ),
    .M04_AXI_0_wdata    (   axil_4.wdata    ),
    .M04_AXI_0_wready   (   axil_4.wready   ),
    .M04_AXI_0_wstrb    (   axil_4.wstrb    ),
    .M04_AXI_0_wvalid   (   axil_4.wvalid   ),
    `endif
    `ifdef USE_AXIL_5
    .M05_AXI_0_araddr   (   axil_5.araddr   ),
    .M05_AXI_0_arprot   (   axil_5.arprot   ),
    .M05_AXI_0_arready  (   axil_5.arready  ),
    .M05_AXI_0_arvalid  (   axil_5.arvalid  ),
    .M05_AXI_0_awaddr   (   axil_5.awaddr   ),
    .M05_AXI_0_awprot   (   axil_5.awprot   ),
    .M05_AXI_0_awready  (   axil_5.awready  ),
    .M05_AXI_0_awvalid  (   axil_5.awvalid  ),
    .M05_AXI_0_bready   (   axil_5.bready   ),
    .M05_AXI_0_bresp    (   axil_5.bresp    ),
    .M05_AXI_0_bvalid   (   axil_5.bvalid   ),
    .M05_AXI_0_rdata    (   axil_5.rdata    ),
    .M05_AXI_0_rready   (   axil_5.rready   ),
    .M05_AXI_0_rresp    (   axil_5.rresp    ),
    .M05_AXI_0_rvalid   (   axil_5.rvalid   ),
    .M05_AXI_0_wdata    (   axil_5.wdata    ),
    .M05_AXI_0_wready   (   axil_5.wready   ),
    .M05_AXI_0_wstrb    (   axil_5.wstrb    ),
    .M05_AXI_0_wvalid   (   axil_5.wvalid   ),
    `endif
    `ifdef USE_AXIL_5
    .M05_AXI_0_araddr   (   axil_5.araddr   ),
    .M05_AXI_0_arprot   (   axil_5.arprot   ),
    .M05_AXI_0_arready  (   axil_5.arready  ),
    .M05_AXI_0_arvalid  (   axil_5.arvalid  ),
    .M05_AXI_0_awaddr   (   axil_5.awaddr   ),
    .M05_AXI_0_awprot   (   axil_5.awprot   ),
    .M05_AXI_0_awready  (   axil_5.awready  ),
    .M05_AXI_0_awvalid  (   axil_5.awvalid  ),
    .M05_AXI_0_bready   (   axil_5.bready   ),
    .M05_AXI_0_bresp    (   axil_5.bresp    ),
    .M05_AXI_0_bvalid   (   axil_5.bvalid   ),
    .M05_AXI_0_rdata    (   axil_5.rdata    ),
    .M05_AXI_0_rready   (   axil_5.rready   ),
    .M05_AXI_0_rresp    (   axil_5.rresp    ),
    .M05_AXI_0_rvalid   (   axil_5.rvalid   ),
    .M05_AXI_0_wdata    (   axil_5.wdata    ),
    .M05_AXI_0_wready   (   axil_5.wready   ),
    .M05_AXI_0_wstrb    (   axil_5.wstrb    ),
    .M05_AXI_0_wvalid   (   axil_5.wvalid   ),
    `endif
    `ifdef USE_AXIL_6
    .M06_AXI_0_araddr   (   axil_6.araddr   ),
    .M06_AXI_0_arprot   (   axil_6.arprot   ),
    .M06_AXI_0_arready  (   axil_6.arready  ),
    .M06_AXI_0_arvalid  (   axil_6.arvalid  ),
    .M06_AXI_0_awaddr   (   axil_6.awaddr   ),
    .M06_AXI_0_awprot   (   axil_6.awprot   ),
    .M06_AXI_0_awready  (   axil_6.awready  ),
    .M06_AXI_0_awvalid  (   axil_6.awvalid  ),
    .M06_AXI_0_bready   (   axil_6.bready   ),
    .M06_AXI_0_bresp    (   axil_6.bresp    ),
    .M06_AXI_0_bvalid   (   axil_6.bvalid   ),
    .M06_AXI_0_rdata    (   axil_6.rdata    ),
    .M06_AXI_0_rready   (   axil_6.rready   ),
    .M06_AXI_0_rresp    (   axil_6.rresp    ),
    .M06_AXI_0_rvalid   (   axil_6.rvalid   ),
    .M06_AXI_0_wdata    (   axil_6.wdata    ),
    .M06_AXI_0_wready   (   axil_6.wready   ),
    .M06_AXI_0_wstrb    (   axil_6.wstrb    ),
    .M06_AXI_0_wvalid   (   axil_6.wvalid   ),
    `endif
    `ifdef USE_AXIL_7
    .M07_AXI_0_araddr   (   axil_7.araddr   ),
    .M07_AXI_0_arprot   (   axil_7.arprot   ),
    .M07_AXI_0_arready  (   axil_7.arready  ),
    .M07_AXI_0_arvalid  (   axil_7.arvalid  ),
    .M07_AXI_0_awaddr   (   axil_7.awaddr   ),
    .M07_AXI_0_awprot   (   axil_7.awprot   ),
    .M07_AXI_0_awready  (   axil_7.awready  ),
    .M07_AXI_0_awvalid  (   axil_7.awvalid  ),
    .M07_AXI_0_bready   (   axil_7.bready   ),
    .M07_AXI_0_bresp    (   axil_7.bresp    ),
    .M07_AXI_0_bvalid   (   axil_7.bvalid   ),
    .M07_AXI_0_rdata    (   axil_7.rdata    ),
    .M07_AXI_0_rready   (   axil_7.rready   ),
    .M07_AXI_0_rresp    (   axil_7.rresp    ),
    .M07_AXI_0_rvalid   (   axil_7.rvalid   ),
    .M07_AXI_0_wdata    (   axil_7.wdata    ),
    .M07_AXI_0_wready   (   axil_7.wready   ),
    .M07_AXI_0_wstrb    (   axil_7.wstrb    ),
    .M07_AXI_0_wvalid   (   axil_7.wvalid   ),
    `endif

    .S_AXI_0_araddr     (   s_axi_gp.araddr    ),
    .S_AXI_0_arburst    (   s_axi_gp.arburst   ),
    .S_AXI_0_arcache    (   s_axi_gp.arcache   ),
    .S_AXI_0_arid       (   s_axi_gp.arid      ),
    .S_AXI_0_arlen      (   s_axi_gp.arlen     ),
    .S_AXI_0_arlock     (   s_axi_gp.arlock    ),
    .S_AXI_0_arprot     (   s_axi_gp.arprot    ),
    .S_AXI_0_arqos      (   s_axi_gp.arqos     ),
    .S_AXI_0_arready    (   s_axi_gp.arready   ),
    .S_AXI_0_arregion   (   s_axi_gp.arregion   ),
    .S_AXI_0_arsize     (   s_axi_gp.arsize     ),
    .S_AXI_0_arvalid    (   s_axi_gp.arvalid    ),
    .S_AXI_0_awaddr     (   s_axi_gp.awaddr     ),
    .S_AXI_0_awburst    (   s_axi_gp.awburst    ),
    .S_AXI_0_awcache    (   s_axi_gp.awcache    ),
    .S_AXI_0_awid       (   s_axi_gp.awid       ),
    .S_AXI_0_awlen      (   s_axi_gp.awlen      ),
    .S_AXI_0_awlock     (   s_axi_gp.awlock     ),
    .S_AXI_0_awprot     (   s_axi_gp.awprot     ),
    .S_AXI_0_awqos      (   s_axi_gp.awqos      ),
    .S_AXI_0_awready    (   s_axi_gp.awready    ),
    .S_AXI_0_awregion   (   s_axi_gp.awregion   ),
    .S_AXI_0_awsize     (   s_axi_gp.awsize     ),
    .S_AXI_0_awvalid    (   s_axi_gp.awvalid    ),
    .S_AXI_0_bid        (   s_axi_gp.bid        ),
    .S_AXI_0_bready     (   s_axi_gp.bready     ),
    .S_AXI_0_bresp      (   s_axi_gp.bresp      ),
    .S_AXI_0_bvalid     (   s_axi_gp.bvalid     ),
    .S_AXI_0_rdata      (   s_axi_gp.rdata      ),
    .S_AXI_0_rid        (   s_axi_gp.rid        ),
    .S_AXI_0_rlast      (   s_axi_gp.rlast      ),
    .S_AXI_0_rready     (   s_axi_gp.rready     ),
    .S_AXI_0_rresp      (   s_axi_gp.rresp      ),
    .S_AXI_0_rvalid     (   s_axi_gp.rvalid     ),
    .S_AXI_0_wdata      (   s_axi_gp.wdata      ),
    .S_AXI_0_wlast      (   s_axi_gp.wlast      ),
    .S_AXI_0_wready     (   s_axi_gp.wready     ),
    .S_AXI_0_wstrb      (   s_axi_gp.wstrb      ),
    .S_AXI_0_wvalid     (   s_axi_gp.wvalid     ),
    .m_axi_aclk_0       (   m_axil_aclk     ),
    .m_axi_aresetn_0    (   m_axil_rst_n    ),
    .s_axi_aclk_0       (   s_axi_gp_aclk   ),
    .s_axi_aresetn_0    (   s_axi_gp_rst_n  )
);

assign s_axi_gp.buser = {s_axi_gp.USER_WIDTH{0}};
endmodule