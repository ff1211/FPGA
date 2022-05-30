//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// sys.sv
// 
// Description:
// sys_bd wrapper.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.25  ff          Initial version
//****************************************************************
`timescale 1ns/1ps
`include "pre_proc.vh"
`include "interconnect.vh"

module sys #(
) (
    axi_lite.master m_axil_check,

    // axi dma
    `ifdef USE_AXI_DMA_WRITE_0
    axis.slave      s_axis_adma_s2mm_0,
    `endif
    `ifdef USE_AXI_DMA_READ_0
    axis.master     m_axis_adma_mm2s_0,
    `endif
    `ifdef USE_AXI_DMA_WRITE_1
    axis.slave      s_axis_adma_s2mm_1,
    `endif
    `ifdef USE_AXI_DMA_READ_1
    axis.master     m_axis_adma_mm2s_1,
    `endif
    `ifdef USE_AXI_DMA_WRITE_2
    axis.slave      s_axis_adma_s2mm_2,
    `endif
    `ifdef USE_AXI_DMA_READ_2
    axis.master     m_axis_adma_mm2s_2,
    `endif
    `ifdef USE_AXI_DMA_WRITE_3
    axis.slave      s_axis_adma_s2mm_3,
    `endif
    `ifdef USE_AXI_DMA_READ_3
    axis.master     m_axis_adma_mm2s_3,
    `endif

    `ifdef USE_M_AXIL_USER
    axi_lite.master m_axil_user,
    `endif

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
    inout           ddr_we_n,
    output [`SYS_CLK_NUM-1:0]   sys_clk,
    output [`SYS_CLK_NUM-1:0]   ic_rst_n,
    output [`SYS_CLK_NUM-1:0]   perif_rst_n
);

`ifdef USE_M_AXIL_USER_0 axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) m_axil_user0(); `CON_AXIL_M2N(m_axil_user0, m_axil_user, 0, 0); `endif
`ifdef USE_M_AXIL_USER_1 axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) m_axil_user1(); `CON_AXIL_M2N(m_axil_user1, m_axil_user, 0, 1); `endif
`ifdef USE_M_AXIL_USER_2 axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) m_axil_user2(); `CON_AXIL_M2N(m_axil_user2, m_axil_user, 0, 2); `endif
`ifdef USE_M_AXIL_USER_3 axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) m_axil_user3(); `CON_AXIL_M2N(m_axil_user3, m_axil_user, 0, 3); `endif

sys_bd sys_bd_inst
    (
    .FIXED_IO_ddr_vrn           (   fixed_io_ddr_vrn    ),
    .FIXED_IO_ddr_vrp           (   fixed_io_ddr_vrp    ),
    .FIXED_IO_mio               (   fixed_io_mio        ),
    .FIXED_IO_ps_clk            (   fixed_io_ps_clk     ),
    .FIXED_IO_ps_porb           (   fixed_io_ps_porb    ),
    .FIXED_IO_ps_srstb          (   fixed_io_ps_srstb   ),

    .M_AXIL_CHECK_araddr        (   m_axil_check.araddr     ),
    .M_AXIL_CHECK_arprot        (   m_axil_check.arprot     ),
    .M_AXIL_CHECK_arready       (   m_axil_check.arready    ),
    .M_AXIL_CHECK_arvalid       (   m_axil_check.arvalid    ),
    .M_AXIL_CHECK_awaddr        (   m_axil_check.awaddr     ),
    .M_AXIL_CHECK_awprot        (   m_axil_check.awprot     ),
    .M_AXIL_CHECK_awready       (   m_axil_check.awready    ),
    .M_AXIL_CHECK_awvalid       (   m_axil_check.awvalid    ),
    .M_AXIL_CHECK_bready        (   m_axil_check.bready     ),
    .M_AXIL_CHECK_bresp         (   m_axil_check.bresp      ),
    .M_AXIL_CHECK_bvalid        (   m_axil_check.bvalid     ),
    .M_AXIL_CHECK_rdata         (   m_axil_check.rdata      ),
    .M_AXIL_CHECK_rready        (   m_axil_check.rready     ),
    .M_AXIL_CHECK_rresp         (   m_axil_check.rresp      ),
    .M_AXIL_CHECK_rvalid        (   m_axil_check.rvalid     ),
    .M_AXIL_CHECK_wdata         (   m_axil_check.wdata      ),
    .M_AXIL_CHECK_wready        (   m_axil_check.wready     ),
    .M_AXIL_CHECK_wstrb         (   m_axil_check.wstrb      ),
    .M_AXIL_CHECK_wvalid        (   m_axil_check.wvalid     ),

    `ifdef USE_M_AXIL_USER_0
    .M_AXIL_USER0_araddr        (   m_axil_user0.araddr     ),
    .M_AXIL_USER0_arprot        (   m_axil_user0.arprot     ),
    .M_AXIL_USER0_arready       (   m_axil_user0.arready    ),
    .M_AXIL_USER0_arvalid       (   m_axil_user0.arvalid    ),
    .M_AXIL_USER0_awaddr        (   m_axil_user0.awaddr     ),
    .M_AXIL_USER0_awprot        (   m_axil_user0.awprot     ),
    .M_AXIL_USER0_awready       (   m_axil_user0.awready    ),
    .M_AXIL_USER0_awvalid       (   m_axil_user0.awvalid    ),
    .M_AXIL_USER0_bready        (   m_axil_user0.bready     ),
    .M_AXIL_USER0_bresp         (   m_axil_user0.bresp      ),
    .M_AXIL_USER0_bvalid        (   m_axil_user0.bvalid     ),
    .M_AXIL_USER0_rdata         (   m_axil_user0.rdata      ),
    .M_AXIL_USER0_rready        (   m_axil_user0.rready     ),
    .M_AXIL_USER0_rresp         (   m_axil_user0.rresp      ),
    .M_AXIL_USER0_rvalid        (   m_axil_user0.rvalid     ),
    .M_AXIL_USER0_wdata         (   m_axil_user0.wdata      ),
    .M_AXIL_USER0_wready        (   m_axil_user0.wready     ),
    .M_AXIL_USER0_wstrb         (   m_axil_user0.wstrb      ),
    .M_AXIL_USER0_wvalid        (   m_axil_user0.wvalid     ),
    `endif

    `ifdef USE_M_AXIL_USER_1
    .M_AXIL_USER1_araddr        (   m_axil_user1.araddr     ),
    .M_AXIL_USER1_arprot        (   m_axil_user1.arprot     ),
    .M_AXIL_USER1_arready       (   m_axil_user1.arready    ),
    .M_AXIL_USER1_arvalid       (   m_axil_user1.arvalid    ),
    .M_AXIL_USER1_awaddr        (   m_axil_user1.awaddr     ),
    .M_AXIL_USER1_awprot        (   m_axil_user1.awprot     ),
    .M_AXIL_USER1_awready       (   m_axil_user1.awready    ),
    .M_AXIL_USER1_awvalid       (   m_axil_user1.awvalid    ),
    .M_AXIL_USER1_bready        (   m_axil_user1.bready     ),
    .M_AXIL_USER1_bresp         (   m_axil_user1.bresp      ),
    .M_AXIL_USER1_bvalid        (   m_axil_user1.bvalid     ),
    .M_AXIL_USER1_rdata         (   m_axil_user1.rdata      ),
    .M_AXIL_USER1_rready        (   m_axil_user1.rready     ),
    .M_AXIL_USER1_rresp         (   m_axil_user1.rresp      ),
    .M_AXIL_USER1_rvalid        (   m_axil_user1.rvalid     ),
    .M_AXIL_USER1_wdata         (   m_axil_user1.wdata      ),
    .M_AXIL_USER1_wready        (   m_axil_user1.wready     ),
    .M_AXIL_USER1_wstrb         (   m_axil_user1.wstrb      ),
    .M_AXIL_USER1_wvalid        (   m_axil_user1.wvalid     ),
    `endif  

    `ifdef USE_M_AXIL_USER_2
    .M_AXIL_USER2_araddr        (   m_axil_user2.araddr     ),
    .M_AXIL_USER2_arprot        (   m_axil_user2.arprot     ),
    .M_AXIL_USER2_arready       (   m_axil_user2.arready    ),
    .M_AXIL_USER2_arvalid       (   m_axil_user2.arvalid    ),
    .M_AXIL_USER2_awaddr        (   m_axil_user2.awaddr     ),
    .M_AXIL_USER2_awprot        (   m_axil_user2.awprot     ),
    .M_AXIL_USER2_awready       (   m_axil_user2.awready    ),
    .M_AXIL_USER2_awvalid       (   m_axil_user2.awvalid    ),
    .M_AXIL_USER2_bready        (   m_axil_user2.bready     ),
    .M_AXIL_USER2_bresp         (   m_axil_user2.bresp      ),
    .M_AXIL_USER2_bvalid        (   m_axil_user2.bvalid     ),
    .M_AXIL_USER2_rdata         (   m_axil_user2.rdata      ),
    .M_AXIL_USER2_rready        (   m_axil_user2.rready     ),
    .M_AXIL_USER2_rresp         (   m_axil_user2.rresp      ),
    .M_AXIL_USER2_rvalid        (   m_axil_user2.rvalid     ),
    .M_AXIL_USER2_wdata         (   m_axil_user2.wdata      ),
    .M_AXIL_USER2_wready        (   m_axil_user2.wready     ),
    .M_AXIL_USER2_wstrb         (   m_axil_user2.wstrb      ),
    .M_AXIL_USER2_wvalid        (   m_axil_user2.wvalid     ),
    `endif

    `ifdef USE_M_AXIL_USER_3
    .M_AXIL_USER3_araddr        (   m_axil_user3.araddr     ),
    .M_AXIL_USER3_arprot        (   m_axil_user3.arprot     ),
    .M_AXIL_USER3_arready       (   m_axil_user3.arready    ),
    .M_AXIL_USER3_arvalid       (   m_axil_user3.arvalid    ),
    .M_AXIL_USER3_awaddr        (   m_axil_user3.awaddr     ),
    .M_AXIL_USER3_awprot        (   m_axil_user3.awprot     ),
    .M_AXIL_USER3_awready       (   m_axil_user3.awready    ),
    .M_AXIL_USER3_awvalid       (   m_axil_user3.awvalid    ),
    .M_AXIL_USER3_bready        (   m_axil_user3.bready     ),
    .M_AXIL_USER3_bresp         (   m_axil_user3.bresp      ),
    .M_AXIL_USER3_bvalid        (   m_axil_user3.bvalid     ),
    .M_AXIL_USER3_rdata         (   m_axil_user3.rdata      ),
    .M_AXIL_USER3_rready        (   m_axil_user3.rready     ),
    .M_AXIL_USER3_rresp         (   m_axil_user3.rresp      ),
    .M_AXIL_USER3_rvalid        (   m_axil_user3.rvalid     ),
    .M_AXIL_USER3_wdata         (   m_axil_user3.wdata      ),
    .M_AXIL_USER3_wready        (   m_axil_user3.wready     ),
    .M_AXIL_USER3_wstrb         (   m_axil_user3.wstrb      ),
    .M_AXIL_USER3_wvalid        (   m_axil_user3.wvalid     ),
    `endif
    
    `ifdef USE_AXI_DMA_WRITE_0
    .S_AXIS_ADMA_S2MM0_tdata    (   s_axis_adma_s2mm_0.tdata    ),
    .S_AXIS_ADMA_S2MM0_tkeep    (   s_axis_adma_s2mm_0.tkeep    ),
    .S_AXIS_ADMA_S2MM0_tlast    (   s_axis_adma_s2mm_0.tlast    ),
    .S_AXIS_ADMA_S2MM0_tready   (   s_axis_adma_s2mm_0.tready   ),
    .S_AXIS_ADMA_S2MM0_tvalid   (   s_axis_adma_s2mm_0.tvalid   ),
    `endif
    `ifdef USE_AXI_DMA_READ_0
    .M_AXIS_ADMA_MM2S0_tdata    (   m_axis_adma_mm2s_0.tdata    ),
    .M_AXIS_ADMA_MM2S0_tkeep    (   m_axis_adma_mm2s_0.tkeep    ),
    .M_AXIS_ADMA_MM2S0_tlast    (   m_axis_adma_mm2s_0.tlast    ),
    .M_AXIS_ADMA_MM2S0_tready   (   m_axis_adma_mm2s_0.tready   ),
    .M_AXIS_ADMA_MM2S0_tvalid   (   m_axis_adma_mm2s_0.tvalid   ),
    `endif

    `ifdef USE_AXI_DMA_WRITE_1
    .S_AXIS_ADMA_S2MM1_tdata    (   s_axis_adma_s2mm_1.tdata    ),
    .S_AXIS_ADMA_S2MM1_tkeep    (   s_axis_adma_s2mm_1.tkeep    ),
    .S_AXIS_ADMA_S2MM1_tlast    (   s_axis_adma_s2mm_1.tlast    ),
    .S_AXIS_ADMA_S2MM1_tready   (   s_axis_adma_s2mm_1.tready   ),
    .S_AXIS_ADMA_S2MM1_tvalid   (   s_axis_adma_s2mm_1.tvalid   ),
    `endif
    `ifdef USE_AXI_DMA_READ_1
    .M_AXIS_ADMA_MM2S1_tdata    (   m_axis_adma_mm2s_1.tdata    ),
    .M_AXIS_ADMA_MM2S1_tkeep    (   m_axis_adma_mm2s_1.tkeep    ),
    .M_AXIS_ADMA_MM2S1_tlast    (   m_axis_adma_mm2s_1.tlast    ),
    .M_AXIS_ADMA_MM2S1_tready   (   m_axis_adma_mm2s_1.tready   ),
    .M_AXIS_ADMA_MM2S1_tvalid   (   m_axis_adma_mm2s_1.tvalid   ),
    `endif

    `ifdef USE_AXI_DMA_WRITE_2
    .S_AXIS_ADMA_S2MM2_tdata    (   s_axis_adma_s2mm_2.tdata    ),
    .S_AXIS_ADMA_S2MM2_tkeep    (   s_axis_adma_s2mm_2.tkeep    ),
    .S_AXIS_ADMA_S2MM2_tlast    (   s_axis_adma_s2mm_2.tlast    ),
    .S_AXIS_ADMA_S2MM2_tready   (   s_axis_adma_s2mm_2.tready   ),
    .S_AXIS_ADMA_S2MM2_tvalid   (   s_axis_adma_s2mm_2.tvalid   ),
    `endif
    `ifdef USE_AXI_DMA_READ_2
    .M_AXIS_ADMA_MM2S2_tdata    (   m_axis_adma_mm2s_2.tdata    ),
    .M_AXIS_ADMA_MM2S2_tkeep    (   m_axis_adma_mm2s_2.tkeep    ),
    .M_AXIS_ADMA_MM2S2_tlast    (   m_axis_adma_mm2s_2.tlast    ),
    .M_AXIS_ADMA_MM2S2_tready   (   m_axis_adma_mm2s_2.tready   ),
    .M_AXIS_ADMA_MM2S2_tvalid   (   m_axis_adma_mm2s_2.tvalid   ),
    `endif

    `ifdef USE_AXI_DMA_WRITE_3
    .S_AXIS_ADMA_S2MM3_tdata    (   s_axis_adma_s2mm_3.tdata    ),
    .S_AXIS_ADMA_S2MM3_tkeep    (   s_axis_adma_s2mm_3.tkeep    ),
    .S_AXIS_ADMA_S2MM3_tlast    (   s_axis_adma_s2mm_3.tlast    ),
    .S_AXIS_ADMA_S2MM3_tready   (   s_axis_adma_s2mm_3.tready   ),
    .S_AXIS_ADMA_S2MM3_tvalid   (   s_axis_adma_s2mm_3.tvalid   ),
    `endif
    `ifdef USE_AXI_DMA_READ_3
    .M_AXIS_ADMA_MM2S3_tdata    (   m_axis_adma_mm2s_3.tdata    ),
    .M_AXIS_ADMA_MM2S3_tkeep    (   m_axis_adma_mm2s_3.tkeep    ),
    .M_AXIS_ADMA_MM2S3_tlast    (   m_axis_adma_mm2s_3.tlast    ),
    .M_AXIS_ADMA_MM2S3_tready   (   m_axis_adma_mm2s_3.tready   ),
    .M_AXIS_ADMA_MM2S3_tvalid   (   m_axis_adma_mm2s_3.tvalid   ),
    `endif

    .USBIND_port_indctl     (),
    .USBIND_vbus_pwrfault   (1'b0),
    .USBIND_vbus_pwrselect  (),

    `ifdef USE_CLK_0
    .clk_out1               (   sys_clk[0]      ),
    .interconnect_aresetn_0 (   ic_rst_n[0]     ),
    .peripheral_aresetn_0   (   perif_rst_n[0]  ),
    `endif
    `ifdef USE_CLK_1
    .clk_out2               (   sys_clk[1]      ),
    .interconnect_aresetn_1 (   ic_rst_n[1]     ),
    .peripheral_aresetn_1   (   perif_rst_n[1]  ),
    `endif
    `ifdef USE_CLK_2
    .clk_out3               (   sys_clk[2]      ),
    .interconnect_aresetn_2 (   ic_rst_n[2]     ),
    .peripheral_aresetn_2   (   perif_rst_n[2]  ),
    `endif
    `ifdef USE_CLK_3
    .clk_out4               (   sys_clk[3]      ),
    .interconnect_aresetn_3 (   ic_rst_n[3]     ),
    .peripheral_aresetn_3   (   perif_rst_n[3]  ),
    `endif
    `ifdef USE_CLK_4
    .clk_out5               (   sys_clk[4]      ),
    .interconnect_aresetn_4 (   ic_rst_n[4]     ),
    .peripheral_aresetn_4   (   perif_rst_n[4]  ),
    `endif
    `ifdef USE_CLK_5
    .clk_out6               (   sys_clk[5]      ),
    .interconnect_aresetn_5 (   ic_rst_n[5]     ),
    .peripheral_aresetn_5   (   perif_rst_n[5]  ),
    `endif
    `ifdef USE_CLK_6
    .clk_out7               (   sys_clk[6]      ),
    .interconnect_aresetn_6 (   ic_rst_n[6]     ),
    .peripheral_aresetn_6   (   perif_rst_n[6]  ),
    `endif

    .DDR_addr               (   ddr_addr        ),
    .DDR_ba                 (   ddr_ba          ),
    .DDR_cas_n              (   ddr_cas_n       ),
    .DDR_ck_n               (   ddr_ck_n        ),
    .DDR_ck_p               (   ddr_ck_p        ),
    .DDR_cke                (   ddr_cke         ),
    .DDR_cs_n               (   ddr_cs_n        ),
    .DDR_dm                 (   ddr_dm          ),
    .DDR_dq                 (   ddr_dq          ),
    .DDR_dqs_n              (   ddr_dqs_n       ),
    .DDR_dqs_p              (   ddr_dqs_p       ),
    .DDR_odt                (   ddr_odt         ),
    .DDR_ras_n              (   ddr_ras_n       ),
    .DDR_reset_n            (   ddr_reset_n     ),
    .DDR_we_n               (   ddr_we_n        )
);

`ifdef USE_AXI_DMA_READ_0
assign m_axis_adma_mm2s_0.tid   = 0;
assign m_axis_adma_mm2s_0.tstrb = m_axis_adma_mm2s_0.tkeep;
assign m_axis_adma_mm2s_0.tdest = 0;
assign m_axis_adma_mm2s_0.tuser = 0;
`endif

`ifdef USE_AXI_DMA_READ_1
assign m_axis_adma_mm2s_1.tid   = 0;
assign m_axis_adma_mm2s_1.tstrb = m_axis_adma_mm2s_1.tkeep;
assign m_axis_adma_mm2s_1.tdest = 0;
assign m_axis_adma_mm2s_1.tuser = 0;
`endif

`ifdef USE_AXI_DMA_READ_2
assign m_axis_adma_mm2s_2.tid   = 0;
assign m_axis_adma_mm2s_2.tstrb = m_axis_adma_mm2s_2.tkeep;
assign m_axis_adma_mm2s_2.tdest = 0;
assign m_axis_adma_mm2s_2.tuser = 0;
`endif

`ifdef USE_AXI_DMA_READ_3
assign m_axis_adma_mm2s_3.tid   = 0;
assign m_axis_adma_mm2s_3.tstrb = m_axis_adma_mm2s_3.tkeep;
assign m_axis_adma_mm2s_3.tdest = 0;
assign m_axis_adma_mm2s_3.tuser = 0;
`endif
    
endmodule

