//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// sys_reset.sv
// 
// Description:
// Processing system reset wrapper.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.20  fanfei      Initial version
//****************************************************************

`timescale 1ns/1ps
`include "pre_proc.vh"

module sys_reset #(
    parameter   SYS_CLK_NUM
) (
    input   [SYS_CLK_NUM-1:0]   slowest_sync_clk,
    input                       ext_rst_n,
    output  [SYS_CLK_NUM-1:0]   ic_rst_n,
    output  [SYS_CLK_NUM-1:0]   perif_rst_n
);

genvar i;
generate
for (i = 0; i < SYS_CLK_NUM; ++i) begin
    proc_sys_reset_0 proc_sys_reset_inst (
        .slowest_sync_clk       (   slowest_sync_clk[i] ),
        .ext_reset_in           (   ext_rst_n           ),
        .aux_reset_in           (   1'b1                ),
        .mb_debug_sys_rst       (                       ),
        .dcm_locked             (                       ),
        .mb_reset               (                       ),
        .bus_struct_reset       (                       ),
        .peripheral_reset       (                       ),
        .interconnect_aresetn   (   ic_rst_n[i]         ),
        .peripheral_aresetn     (   perif_rst_n[i]      )
    );    
end

endgenerate

endmodule