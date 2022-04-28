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
// 1.0      2022.04.14  fanfei      Initial version
//****************************************************************
`timescale 1ns/1ps
`include "pre_proc.vh"

module role #(
    
) (
    `ifdef USE_M_AXIL_USER
    axi_lite.slave  s_axil_user,
    `endif
    `ifdef USE_VGA
    output [3:0]    vga_r,
    output [3:0]    vga_g,
    output [3:0]    vga_b,
    output          vga_hsync,
    output          vga_vsync,
    `endif
    `ifdef USE_PL_BTN
    input           btn_c,
    input           btn_d,
    input           btn_l,
    input           btn_r,
    input           btn_u,
    `endif
    input [`SYS_CLK_NUM-1:0]    sys_clk,
    input [`SYS_CLK_NUM-1:0]    ic_rst_n,
    input [`SYS_CLK_NUM-1:0]    perif_rst_n
);
    
endmodule