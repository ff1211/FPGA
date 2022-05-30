//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// shell_top.sv
// 
// Description:
// Top module of zedboard.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.14  ff          Initial version
//****************************************************************
`timescale 1ns/1ps
`include "pre_proc.vh"
`include "interconnect.vh"

module shell_top (
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

logic [`SYS_CLK_NUM-1:0]    sys_clk;
logic [`SYS_CLK_NUM-1:0]    ic_rst_n;
logic [`SYS_CLK_NUM-1:0]    perif_rst_n;

axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_check();
`ifdef USE_M_AXIL_USER axi_lite #(.CHANNEL(`M_AXIL_USER_NUM), .DATA_WIDTH(32)) axil_user(); `endif

`ifdef USE_AXI_DMA_WRITE_0 axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW_0), .ID_WIDTH(6)) axis_adma_s2mm_0(); `endif
`ifdef USE_AXI_DMA_READ_0 axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW_0), .ID_WIDTH(6)) axis_adma_mm2s_0(); `endif
`ifdef USE_AXI_DMA_WRITE_1 axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW_1), .ID_WIDTH(6)) axis_adma_s2mm_1(); `endif
`ifdef USE_AXI_DMA_READ_1 axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW_1), .ID_WIDTH(6)) axis_adma_mm2s_1(); `endif
`ifdef USE_AXI_DMA_WRITE_2 axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW_2), .ID_WIDTH(6)) axis_adma_s2mm_2(); `endif
`ifdef USE_AXI_DMA_READ_2 axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW_2), .ID_WIDTH(6)) axis_adma_mm2s_2(); `endif
`ifdef USE_AXI_DMA_WRITE_3 axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW_3), .ID_WIDTH(6)) axis_adma_s2mm_3(); `endif
`ifdef USE_AXI_DMA_READ_3 axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW_3), .ID_WIDTH(6)) axis_adma_mm2s_3(); `endif

sys #(
) sys_inst (
    .sys_clk            (   sys_clk             ),
    .ic_rst_n           (   ic_rst_n            ),
    .perif_rst_n        (   perif_rst_n         ),

    .fixed_io_ddr_vrn   (   fixed_io_ddr_vrn    ),
    .fixed_io_ddr_vrp   (   fixed_io_ddr_vrp    ),
    .fixed_io_mio       (   fixed_io_mio        ),
    .fixed_io_ps_clk    (   fixed_io_ps_clk     ),
    .fixed_io_ps_porb   (   fixed_io_ps_porb    ),
    .fixed_io_ps_srstb  (   fixed_io_ps_srstb   ),

    .m_axil_check       (   axil_check.master   ),

    // adma0
    `ifdef USE_AXI_DMA_WRITE_0
    .s_axis_adma_s2mm_0 (   axis_adma_s2mm_0.slave  ),
    `endif
    `ifdef USE_AXI_DMA_READ_0
    .m_axis_adma_mm2s_0 (   axis_adma_mm2s_0.master ),
    `endif
    // adma1
    `ifdef USE_AXI_DMA_WRITE_1
    .s_axis_adma_s2mm_1 (   axis_adma_s2mm_1.slave  ),
    `endif
    `ifdef USE_AXI_DMA_READ_1
    .m_axis_adma_mm2s_1 (   axis_adma_mm2s_1.master ),
    `endif
    // adma2
    `ifdef USE_AXI_DMA_WRITE_2
    .s_axis_adma_s2mm_2 (   axis_adma_s2mm_2.slave  ),
    `endif
    `ifdef USE_AXI_DMA_READ_2
    .m_axis_adma_mm2s_2 (   axis_adma_mm2s_2.master ),
    `endif
    // adma3
    `ifdef USE_AXI_DMA_WRITE_3
    .s_axis_adma_s2mm_3 (   axis_adma_s2mm_3.slave  ),
    `endif
    `ifdef USE_AXI_DMA_READ_3
    .m_axis_adma_mm2s_3 (   axis_adma_mm2s_3.master ),
    `endif    

    `ifdef USE_M_AXIL_USER
    .m_axil_user        (   axil_user.master        ),
    `endif

    .ddr_addr           (   ddr_addr            ),
    .ddr_ba             (   ddr_ba              ),
    .ddr_cas_n          (   ddr_cas_n           ),
    .ddr_ck_n           (   ddr_ck_n            ),
    .ddr_ck_p           (   ddr_ck_p            ),
    .ddr_cke            (   ddr_cke             ),
    .ddr_cs_n           (   ddr_cs_n            ),
    .ddr_dm             (   ddr_dm              ),
    .ddr_dq             (   ddr_dq              ),
    .ddr_dqs_n          (   ddr_dqs_n           ),
    .ddr_dqs_p          (   ddr_dqs_p           ),
    .ddr_odt            (   ddr_odt             ),
    .ddr_ras_n          (   ddr_ras_n           ),
    .ddr_reset_n        (   ddr_reset_n         ),
    .ddr_we_n           (   ddr_we_n            )
);

axil_dummy #(
    .MAGIC_NUM  (   'h00114514  )
) axil_dummy_inst (
    .s_axil     (   axil_check.slave    )
);

role #(
) role_inst (
    `ifdef USE_AXI_DMA_WRITE_0
    .m_axis_s2mm_0  (   axis_adma_s2mm_0.master   ),
    `endif
    `ifdef USE_AXI_DMA_READ_0
    .s_axis_mm2s_0  (   axis_adma_mm2s_0.slave    ),
    `endif
    `ifdef USE_AXI_DMA_WRITE_1
    .m_axis_s2mm_1  (   axis_adma_s2mm_1.master   ),
    `endif
    `ifdef USE_AXI_DMA_READ_1
    .s_axis_mm2s_1  (   axis_adma_mm2s_1.slave    ),
    `endif
    `ifdef USE_AXI_DMA_WRITE_2
    .m_axis_s2mm_2  (   axis_adma_s2mm_2.master   ),
    `endif
    `ifdef USE_AXI_DMA_READ_2
    .s_axis_mm2s_2  (   axis_adma_mm2s_2.slave    ),
    `endif
    `ifdef USE_AXI_DMA_WRITE_3
    .m_axis_s2mm_3  (   axis_adma_s2mm_3.master   ),
    `endif
    `ifdef USE_AXI_DMA_READ_3
    .s_axis_mm2s_3  (   axis_adma_mm2s_3.slave    ),
    `endif
    `ifdef USE_M_AXIL_USER
    .s_axil_user    (   axil_user.slave     ),
    `endif    
    .sys_clk        (   sys_clk     ),
    .ic_rst_n       (   ic_rst_n    ),
    .perif_rst_n    (   perif_rst_n )
);

endmodule