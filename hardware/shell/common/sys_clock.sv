//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// sys_clock.sv
// 
// Description:
// Clock wizard wrapper.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.20  Fanfei      Initial version
//****************************************************************

`timescale 1ns/1ps
`include "pre_proc.vh"

module sys_clock #(
    parameter   SYS_CLK_NUM
) (
    input                       ext_clk,
    output  [SYS_CLK_NUM-1:0]   sys_clk
);

clk_wiz_0 clk_wiz_0_inst (
    `ifdef USE_CLK_0
    .clk_out1   (   sys_clk[0]  ),
    `endif
    `ifdef USE_CLK_1
    .clk_out2   (   sys_clk[1]  ),
    `endif
    `ifdef USE_CLK_2
    .clk_out3   (   sys_clk[2]  ),
    `endif
    `ifdef USE_CLK_3
    .clk_out4   (   sys_clk[3]  ),
    `endif
    `ifdef USE_CLK_4
    .clk_out5   (   sys_clk[4]  ),
    `endif
    `ifdef USE_CLK_5
    .clk_out6   (   sys_clk[5]  ),
    `endif
    `ifdef USE_CLK_6
    .clk_out7   (   sys_clk[6]  ),
    `endif

    .clk_in1    (   ext_clk     )
);
    
endmodule