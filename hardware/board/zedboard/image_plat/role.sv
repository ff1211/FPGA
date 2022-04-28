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
    input           pl_clk,
    input [`SYS_CLK_NUM-1:0]    sys_clk,
    input [`SYS_CLK_NUM-1:0]    ic_rst_n,
    input [`SYS_CLK_NUM-1:0]    perif_rst_n
);

logic pix_clk;
clk_wiz_0 instance_name
(
// Clock out ports
.clk_out1(pix_clk),     // output clk_out1
// Clock in ports
.clk_in1(pl_clk)
);      // input clk_in1

logic [3:0] vga_r;
logic [3:0] vga_g;
logic [3:0] vga_b;
logic       vga_hsync;
logic       vga_vsync;
logic       rst_n;

assign rst_n = ~btn_c;

localparam H_SYNC_PULSE     = 96;
localparam H_BACK_PORCH     = 48;
localparam H_FRONT_PORCH    = 16;
localparam WHOLE_LINE       = 800;

localparam V_SYNC_PULSE     = 2;
localparam V_BACK_PORCH     = 33;
localparam V_FRONT_PORCH    = 10;
localparam WHOLE_FRAME      = 525;

logic [9:0] h_cnt;
logic [9:0] v_cnt;

// Horizon cnt.
always @(posedge pix_clk) begin
    if(~rst_n) begin
        h_cnt <= 10'b0;
        v_cnt <= 10'b0;
    end else begin
        if(h_cnt < WHOLE_LINE-1)
            h_cnt <= h_cnt + 1;
        else begin
            h_cnt <= 10'b0;
            if(v_cnt < WHOLE_FRAME-1)
                v_cnt <= v_cnt + 1;
            else
                v_cnt <= 10'b0;
        end
    end
end

// hsync and vhsync.
assign vga_hsync = (h_cnt < H_SYNC_PULSE);
assign vga_vsync = (v_cnt < V_SYNC_PULSE);

logic h_en;
logic v_en;
logic en;
assign h_en = (H_SYNC_PULSE+H_BACK_PORCH <= h_cnt && h_cnt < WHOLE_LINE-H_FRONT_PORCH);
assign v_en = (V_SYNC_PULSE+V_BACK_PORCH <= v_cnt && v_cnt < WHOLE_FRAME-V_FRONT_PORCH);
assign en = h_en && v_en;

always_comb begin
    vga_r = 4'b0;
    vga_g = 4'b0;
    vga_b = 4'b0;
    if(en) begin
        vga_r = (h_cnt - (H_SYNC_PULSE + H_BACK_PORCH)) % 32;
        vga_g = 4'b0;
        vga_b = 4'b0;
    end else begin
        vga_r = 4'b0;
        vga_g = 4'b0;
        vga_b = 4'b0;
    end 
end

endmodule