//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// ov5640_rst.sv
// 
// Description:
// Reset module for ov5640's reset.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.29  fanfei      Initial version
//****************************************************************
`timescale 1ns/1ps
`include "pre_proc.vh"

module ov5640_rst (
    input   clk,  
    input   rst_n,
    output  cam_rst_n,
    output  cam_pwdn
);

localparam S_RST    = 0;
localparam S_WORK   = 1;

localparam RST_CNT  = (1_000_000_000/`CLK_2_FREQ)/20;
localparam PWDN_CNT = (1_000_000_000/`CLK_2_FREQ)/40;

logic           c_state;
logic           n_state;
logic [31:0]    rst_cnt;

always@(posedge clk) begin
    if(~rst_n)
        rst_cnt <= 32'b0;
    else if(rst_cnt < RST_CNT)
        rst_cnt <= rst_cnt + 1;
end

assign cam_rst_n = (rst_cnt < RST_CNT)? 0 : 1;
assign cam_pwdn = (rst_cnt < PWDN_CNT)? 1 : 0;

endmodule