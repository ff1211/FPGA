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
// 1.0      2022.04.28  fanfei      Initial version
//****************************************************************
`timescale 1ns/1ps
`include "pre_proc.vh"

module ov5640_rst #(

) (
    input   s_axil_aclk,  
    input   s_axil_arst_n,
    output  cam_rst_n,
    output  cam_pwdn
);

localparam S_RST    = 0;
localparam S_WORK   = 1;

localparam RST_CNT  = ;
localparam PWDN_CNT = ;

logic           c_state;
logic           n_state;
logic [31:0]    rst_cnt;

always @(posedge s_axil_aclk) begin
    if(~s_axil_arst_n)
        c_state <= S_RST;
    else
        c_state <= n_state;
end


    
endmodule