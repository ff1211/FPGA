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
// 1.0      2022.04.14  Fanfei      Initial version
//****************************************************************

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

// System clk.
logic                       fclk;
logic [`SYS_CLK_NUM-1:0]    sys_clk;
sys_clock #(
    .SYS_CLK_NUM    (   `SYS_CLK_NUM    )
) sys_clock_inst (
    .ext_clk        (   fclk            ),
    .sys_clk        (   sys_clk         )
);

// System reset.
logic                       fclk_rst_n;
logic [`SYS_CLK_NUM-1:0]    ic_rst_n;
logic [`SYS_CLK_NUM-1:0]    perif_rst_n;
sys_reset #(
    .SYS_CLK_NUM        (   `SYS_CLK_NUM    )
) sys_reset_inst (
    .slowest_sync_clk   (   sys_clk         ),
    .ext_rst_n          (   fclk_rst_n      ),
    .ic_rst_n           (   ic_rst_n        ),
    .perif_rst_n        (   perif_rst_n     )
);

`ifdef USE_M_AXI_GP
// Processing system AXI general purpose master port.
axi4 #(.CHANNEL(`M_AXI_GP_NUM), .DATA_WIDTH(32), .ADDR_WIDTH(32), .ID_WIDTH(12)) ps_m_axi_gp();
`endif
// Processing system AXI general purpose slave port.
`ifdef USE_S_AXI_GP
axi4 #(.CHANNEL(`S_AXI_GP_NUM), .DATA_WIDTH(32), .ADDR_WIDTH(32), .ID_WIDTH(6)) ps_s_axi_gp();
`endif
// Processing system AXI high profermance slave port.
`ifdef USE_S_AXI_HP
axi4 #(.CHANNEL(`S_AXI_HP_NUM), .DATA_WIDTH(`S_AXI_HP_DW), .ADDR_WIDTH(32), .ID_WIDTH(6)) ps_s_axi_hp();
`endif

// Processing system hard core.
ps_7 #(

) processing_sys_inst (
    `ifdef USE_M_AXI_GP
    .m_axi_gp           (   ps_m_axi_gp.master  ),
    .m_axi_gp_aclk      (   {`M_AXI_GP_NUM{sys_clk[0]}}),
    `endif
    `ifdef USE_S_AXI_GP
    .s_axi_gp           (   ps_s_axi_gp.slave   ),
    .s_axi_gp_aclk      (   {`S_AXI_GP_NUM{sys_clk[0]}}),
    `endif
    `ifdef USE_S_AXI_HP
    .s_axi_hp           (   ps_s_axi_hp.slave   ),
    .s_axi_hp_aclk      (   {`M_AXI_GP_NUM{sys_clk[1]}}),
    `endif

    .fclk               (   fclk                ),
    .fclk_rst_n         (   fclk_rst_n          ),

    .fixed_io_ddr_vrn   (   fixed_io_ddr_vrn    ),
    .fixed_io_ddr_vrp   (   fixed_io_ddr_vrp    ),
    .fixed_io_mio       (   fixed_io_mio        ),
    .fixed_io_ps_clk    (   fixed_io_ps_clk     ),
    .fixed_io_ps_porb   (   fixed_io_ps_porb    ),
    .fixed_io_ps_srstb  (   fixed_io_ps_srstb   ),

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

`ifdef USE_AXI_INTERCONNECT
// AXI interconnect.
axi_lite #(.CHANNEL(`AXIL_NUM), .ADDR_WIDTH(32)) ps_m_axil();
axi4 #(.CHANNEL(1), .DATA_WIDTH(32), .ADDR_WIDTH(32), .ID_WIDTH(12)) ps_m_axi_gp_0();
`CON_AXI4_M2N(ps_m_axi_gp, ps_m_axi_gp_0, 0, 0);
axi_int (
    .s_axi_gp       (   ps_m_axi_gp_0   ),
    .s_axi_gp_aclk  (   sys_clk[0]      ),
    .s_axi_gp_rst_n (   ic_rst_n[0]     ),

    .m_axil         (   ps_m_axil   ),
    .m_axil_aclk    (   sys_clk[2]  ),
    .m_axil_rst_n   (   ic_rst_n[2] )
);
`endif

// AXI DMA inst.
`ifdef USE_AXI_DMA
axi4 #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_MM_DW), .ADDR_WIDTH(`AXI_DMA_AW), .ID_WIDTH(6)) adma_m_axi();
axi_lite #(.CHANNEL(1), .ADDR_WIDTH(32)) adma_s_axil();
`ifdef USE_AXI_DMA_WRITE
axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW), .ID_WIDTH(6)) adma_s_axis_s2mm();
`endif
`ifdef USE_AXI_DMA_READ
axis #(.CHANNEL(1), .DATA_WIDTH(`AXI_DMA_S_DW), .ID_WIDTH(6)) adma_m_axis_mm2s();
`endif

`CON_AXI4_M2N(adma_m_axi, ps_s_axi_hp, 0, 0);
`CON_AXIL_M2N(ps_m_axil, adma_s_axil, 0, 0);

logic adma_s2mm_intr;
logic adma_mm2s_intr;
axi_dma axi_dma_inst(
    .axi_rst_n      (   perif_rst_n[2]          ),
    `ifdef USE_AXI_DMA_WRITE
    .s_axis_s2mm    (   adma_s_axis_s2mm.slave  ),
    .s2mm_introut   (   adma_s2mm_intr          ),
    `endif
    `ifdef USE_AXI_DMA_READ
    .m_axis_mm2s    (   adma_m_axis_mm2s.master ),
    .mm2s_introut   (   adma_mm2s_intr          ),
    `endif
    .s_axil         (   adma_s_axil.slave       ),
    .m_axil_aclk    (   sys_clk[2]              ),
    .m_axi          (   adma_m_axi.master       ),
    .m_axi_aclk     (   sys_clk[1]              )
);
`endif

// Role.
role #(

) role_inst (

);

endmodule