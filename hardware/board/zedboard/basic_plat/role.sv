//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// role.sv
// 
// Description:
// Acceleration core.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.14  ff          Initial version
//****************************************************************
`timescale 1ns/1ps
`include "pre_proc.vh"

module role #(
    
) (
    `ifdef USE_AXI_DMA_WRITE_0
    axis.master     m_axis_s2mm_0,
    `endif
    `ifdef USE_AXI_DMA_READ_0
    axis.slave      s_axis_mm2s_0,
    `endif
    `ifdef USE_AXI_DMA_WRITE_1
    axis.master     m_axis_s2mm_1,
    `endif
    `ifdef USE_AXI_DMA_READ_1
    axis.slave      s_axis_mm2s_1,
    `endif
    `ifdef USE_AXI_DMA_WRITE_2
    axis.master     m_axis_s2mm_2,
    `endif
    `ifdef USE_AXI_DMA_READ_2
    axis.slave      s_axis_mm2s_2,
    `endif
    `ifdef USE_AXI_DMA_WRITE_3
    axis.master     m_axis_s2mm_3,
    `endif
    `ifdef USE_AXI_DMA_READ_3
    axis.slave      s_axis_mm2s_3,
    `endif
    `ifdef USE_M_AXIL_USER
    axi_lite.slave  s_axil_user,
    `endif
    input [`SYS_CLK_NUM-1:0]    sys_clk,
    input [`SYS_CLK_NUM-1:0]    ic_rst_n,
    input [`SYS_CLK_NUM-1:0]    perif_rst_n
);

axis_data_fifo_0 axis_data_fifo_inst_0 (
  .s_axis_aresetn   (   perif_rst_n[1]          ),
  .s_axis_aclk      (   sys_clk[1]              ),
  .s_axis_tvalid    (   s_axis_mm2s_0.tvalid    ),
  .s_axis_tready    (   s_axis_mm2s_0.tready    ),
  .s_axis_tdata     (   s_axis_mm2s_0.tdata     ),
  .s_axis_tkeep     (   s_axis_mm2s_0.tkeep     ),
  
  .m_axis_tvalid    (   m_axis_s2mm_0.tvalid    ),
  .m_axis_tready    (   m_axis_s2mm_0.tready    ),
  .m_axis_tdata     (   m_axis_s2mm_0.tdata     ),
  .m_axis_tkeep     (   m_axis_s2mm_0.tkeep     ) 
);
axis_data_fifo_0 axis_data_fifo_inst_1 (
  .s_axis_aresetn   (   perif_rst_n[1]          ),
  .s_axis_aclk      (   sys_clk[1]              ),
  .s_axis_tvalid    (   s_axis_mm2s_1.tvalid    ),
  .s_axis_tready    (   s_axis_mm2s_1.tready    ),
  .s_axis_tdata     (   s_axis_mm2s_1.tdata     ),
  .s_axis_tkeep     (   s_axis_mm2s_1.tkeep     ),
  
  .m_axis_tvalid    (   m_axis_s2mm_1.tvalid    ),
  .m_axis_tready    (   m_axis_s2mm_1.tready    ),
  .m_axis_tdata     (   m_axis_s2mm_1.tdata     ),
  .m_axis_tkeep     (   m_axis_s2mm_1.tkeep     ) 
);
axis_data_fifo_0 axis_data_fifo_inst_2 (
  .s_axis_aresetn   (   perif_rst_n[1]          ),
  .s_axis_aclk      (   sys_clk[1]              ),
  .s_axis_tvalid    (   s_axis_mm2s_2.tvalid    ),
  .s_axis_tready    (   s_axis_mm2s_2.tready    ),
  .s_axis_tdata     (   s_axis_mm2s_2.tdata     ),
  .s_axis_tkeep     (   s_axis_mm2s_2.tkeep     ),
  
  .m_axis_tvalid    (   m_axis_s2mm_2.tvalid    ),
  .m_axis_tready    (   m_axis_s2mm_2.tready    ),
  .m_axis_tdata     (   m_axis_s2mm_2.tdata     ),
  .m_axis_tkeep     (   m_axis_s2mm_2.tkeep     ) 
);
axis_data_fifo_0 axis_data_fifo_inst_3 (
  .s_axis_aresetn   (   perif_rst_n[1]          ),
  .s_axis_aclk      (   sys_clk[1]              ),
  .s_axis_tvalid    (   s_axis_mm2s_3.tvalid    ),
  .s_axis_tready    (   s_axis_mm2s_3.tready    ),
  .s_axis_tdata     (   s_axis_mm2s_3.tdata     ),
  .s_axis_tkeep     (   s_axis_mm2s_3.tkeep     ),
  
  .m_axis_tvalid    (   m_axis_s2mm_3.tvalid    ),
  .m_axis_tready    (   m_axis_s2mm_3.tready    ),
  .m_axis_tdata     (   m_axis_s2mm_3.tdata     ),
  .m_axis_tkeep     (   m_axis_s2mm_3.tkeep     ) 
);

endmodule