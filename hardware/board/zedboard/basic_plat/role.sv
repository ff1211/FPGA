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
    `ifdef USE_AXI_DMA_WRITE
    axis.master     m_axis_s2mm,
    `endif
    `ifdef USE_AXI_DMA_READ
    axis.slave      s_axis_mm2s,
    `endif
    `ifdef USE_M_AXIL_USER
    axi_lite.slave  s_axil_user,
    `endif
    input [`SYS_CLK_NUM-1:0]    sys_clk,
    input [`SYS_CLK_NUM-1:0]    ic_rst_n,
    input [`SYS_CLK_NUM-1:0]    perif_rst_n
);

endmodule