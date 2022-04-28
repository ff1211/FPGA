//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// sync_reg.sv
// 
// Description:
// Register to synchronize signal.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.28  fanfei      Initial version
//****************************************************************

`timescale 1ns/1ps

module sync_reg #(
    parameter DATA_WIDTH    = 1,
    parameter DELAY         = 3
) (
    input   clk_d,
    input  [DATA_WIDTH-1:0] d_i,
    output [DATA_WIDTH-1:0] d_o,
);

logic [DATA_WIDTH*DELAY-1:0]    delay_r;

always_ff @(posedge clk_d) begin
    delay_r[DATA_WIDTH-1:0] <= d_i;
end

genvar i;
generate
always_ff @(posedge clk_d) begin
    for (i = 1; i < DELAY; ++i) begin
        delay_r[DATA_WIDTH*i+:DATA_WIDTH] <= delay_r[DATA_WIDTH*(i-1)+:DATA_WIDTH];
    end
end

assign d_o = delay_r[DATA_WIDTH*DELAY-1:DATA_WIDTH*(DELAY-1)];

endgenerate


    
endmodule