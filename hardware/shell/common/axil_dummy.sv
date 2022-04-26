//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// axil_dummy.sv
// 
// Description:
// AXI lite dummy mode. Used for assign spare axi lite port.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.26  fanfei      Initial version
//****************************************************************

`timescale 1ns/1ps

module axil_dummy #(
    parameter MAGIC_NUM = 32'h114514
) (
    axi_lite.slave s_axil
);
assign s_axil.awready   = {s_axil.CHANNEL{1'b1}};
assign s_axil.wready    = {s_axil.CHANNEL{1'b1}};
assign s_axil.bvalid    = {s_axil.CHANNEL{1'b1}};
assign s_axil.bresp     = {s_axil.CHANNEL{2'b00}};
assign s_axil.arready   = {s_axil.CHANNEL{1'b1}};
assign s_axil.rvalid    = {s_axil.CHANNEL{1'b1}};
assign s_axil.rresp     = {s_axil.CHANNEL{2'b00}};

genvar i;
generate
for(i = 0; i < s_axil.CHANNEL; ++i)
    assign s_axil.rdata = MAGIC_NUM;
endgenerate

endmodule