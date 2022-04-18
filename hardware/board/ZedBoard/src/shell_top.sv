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

// Processing system AXI general slave port config.
`ifdef USE_AXI_GP_PORT
axi4 #(.CHANNEL(AXI_GP_PORT_NUM), .DATA_WIDTH(32), .ADDR_WIDTH(32), .ID_WIDTH(6)) axi_gp_if();
`endif

// Processing system AXI high profermance slave port config.
`ifdef USE_AXI_HP_PORT
axi4 #(.CHANNEL(AXI_HP_PORT_NUM), .DATA_WIDTH(AXI_HP_PORT_DW), .ADDR_WIDTH(32), .ID_WIDTH(6)) axi_hp_if();
`endif

// Processing system hard core.
ps #(
    
) processing_sys_inst (
    `ifdef USE_AXI_GP_PORT
    .s_axi_gp           (   s_axi_gp_if.slave   ),
    `endif
    `ifdef USE_AXI_HP_PORT
    .s_axi_hp           (   s_axi_hp_if.slave   ),
    `endif

    .m_axi_gp           (   m_axi_gp.master     ),
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

proc_sys_reset_0 proc_sys_reset_inst (
    .slowest_sync_clk       (   slowest_sync_clk),        
    .ext_reset_in           (   ext_reset_in),                
    .aux_reset_in           (   aux_reset_in),                
    .mb_debug_sys_rst       (   mb_debug_sys_rst),        
    .dcm_locked             (   dcm_locked),                    
    .mb_reset               (   mb_reset),                        
    .bus_struct_reset       (   bus_struct_reset),        
    .peripheral_reset       (   peripheral_reset),        
    .interconnect_aresetn   (   interconnect_aresetn),
    .peripheral_aresetn     (   peripheral_aresetn)     
);

// AXI DMA inst.
`ifdef USE_AXI_DMA
axi4 #(.CHANNEL(1), .DATA_WIDTH(AXI_DMA_MM_DW), .ADDR_WIDTH(AXI_DMA_AW), .ID_WIDTH(6)) adma_axi();
axi_lite #(.CHANNEL(1), .DATA_WIDTH(AXI_DMA_MM_DW)) adma_axil();
`ifdef USE_AXI_DMA_WRITE
axis #(.CHANNEL(1), .DATA_WIDTH(AAXI_DMA_S_DW), .ID_WIDTH(6)) adma_axis_s2mm();
`endif
`ifdef USE_AXI_DMA_READ
axis #(.CHANNEL(1), .DATA_WIDTH(AXI_DMA_S_DW), .ID_WIDTH(6)) adma_axis_mm2s();
`endif
axi_dma axi_dma_inst(
    .m_axi_clk      (   adma_axi_clk    ),
    .m_axil_clk     (   adma_axil_clk   ),
    .axi_rst_n      (   adma_rst_n      ),
    `ifdef USE_AXI_DMA_WRITE
    .s_axis_s2mm    (   adma_axis_s2mm.slave    ),
    .mm2s_introut   (   adma_mm2s_intr          ),
    `endif
    `ifdef USE_AXI_DMA_READ
    .m_axis_mm2s    (   adma_axis_mm2s.master   ),
    .mm2s_introut   (   adma_mm2s_intr          ),
    `endif
    .s_axil         (   adma_axil.slave         ),
    .m_axi          (   adma_axi.master         )
);
`endif

// Role.
role #(

) role_inst (

);

endmodule