//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// cdc_rst.sv
// 
// Description:
// Synchronize reset signal.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.29  fanfei      Initial version
//****************************************************************

`timescale 1ns/1ps

module cdc_rst #(
    parameter DEST_SYNC_FF      = 4,
    parameter RST_ACTIVE_HIGH   = 0
) (
    input   rst_s,
    input   clk_d,
    output  rst_d
);

xpm_cdc_async_rst #(
    .DEST_SYNC_FF   (   DEST_SYNC_FF    ),  // DECIMAL; range: 2-10
    .INIT_SYNC_FF   (   0               ),  // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
    .RST_ACTIVE_HIGH(   RST_ACTIVE_HIGH )   // DECIMAL; 0=active low reset, 1=active high reset
)
xpm_cdc_async_rst_inst (
    .dest_arst  (   rst_d   ),  // 1-bit output: src_arst asynchronous reset signal synchronized to destination
                                // clock domain. This output is registered. NOTE: Signal asserts asynchronously
                                // but deasserts synchronously to dest_clk. Width of the reset signal is at least
                                // (DEST_SYNC_FF*dest_clk) period.

    .dest_clk   (   clk_d   ),  // 1-bit input: Destination clock.
    .src_arst   (   rst_s   )   // 1-bit input: Source asynchronous reset signal.
);

endmodule


// XPM_CDC instantiation template for Asynchronous Reset Synchronizer configurations
// Refer to the targeted device family architecture libraries guide for XPM_CDC documentation
// =======================================================================================================================

// Parameter usage table, organized as follows:
// +---------------------------------------------------------------------------------------------------------------------+
// | Parameter name       | Data type          | Restrictions, if applicable                                             |
// |---------------------------------------------------------------------------------------------------------------------|
// | Description                                                                                                         |
// +---------------------------------------------------------------------------------------------------------------------+
// +---------------------------------------------------------------------------------------------------------------------+
// | DEST_SYNC_FF         | Integer            | Range: 2 - 10. Default value = 4.                                       |
// |---------------------------------------------------------------------------------------------------------------------|
// | Number of register stages used to synchronize signal in the destination clock domain.                               |
// | This parameter also determines the minimum width of the asserted reset signal.                                      |
// +---------------------------------------------------------------------------------------------------------------------+
// | INIT_SYNC_FF         | Integer            | Allowed values: 0, 1. Default value = 0.                                |
// |---------------------------------------------------------------------------------------------------------------------|
// | 0- Disable behavioral simulation initialization value(s) on synchronization registers.                              |
// | 1- Enable behavioral simulation initialization value(s) on synchronization registers.                               |
// +---------------------------------------------------------------------------------------------------------------------+
// | RST_ACTIVE_HIGH      | Integer            | Allowed values: 0, 1. Default value = 0.                                |
// |---------------------------------------------------------------------------------------------------------------------|
// | Defines the polarity of the asynchronous reset signal.                                                              |
// |                                                                                                                     |
// |   0- Active low asynchronous reset signal                                                                           |
// |   1- Active high asynchronous reset signal                                                                          |
// +---------------------------------------------------------------------------------------------------------------------+

// Port usage table, organized as follows:
// +---------------------------------------------------------------------------------------------------------------------+
// | Port name      | Direction | Size, in bits                         | Domain  | Sense       | Handling if unused     |
// |---------------------------------------------------------------------------------------------------------------------|
// | Description                                                                                                         |
// +---------------------------------------------------------------------------------------------------------------------+
// +---------------------------------------------------------------------------------------------------------------------+
// | dest_arst      | Output    | 1                                     | dest_clk| NA          | Required               |
// |---------------------------------------------------------------------------------------------------------------------|
// | src_arst asynchronous reset signal synchronized to destination clock domain. This output is registered.             |
// | NOTE: Signal asserts asynchronously but deasserts synchronously to dest_clk. Width of the reset signal is at least  |
// | (DEST_SYNC_FF*dest_clk) period.                                                                                     |
// +---------------------------------------------------------------------------------------------------------------------+
// | dest_clk       | Input     | 1                                     | NA      | Rising edge | Required               |
// |---------------------------------------------------------------------------------------------------------------------|
// | Destination clock.                                                                                                  |
// +---------------------------------------------------------------------------------------------------------------------+
// | src_arst       | Input     | 1                                     | NA      | NA          | Required               |
// |---------------------------------------------------------------------------------------------------------------------|
// | Source asynchronous reset signal.                                                                                   |
// +---------------------------------------------------------------------------------------------------------------------+


// xpm_cdc_async_rst : In order to incorporate this function into the design,
//      Verilog      : the following instance declaration needs to be placed
//     instance      : in the body of the design code.  The instance name
//    declaration    : (xpm_cdc_async_rst_inst) and/or the port declarations within the
//       code        : parenthesis may be changed to properly reference and
//                   : connect this function to the design.  All inputs
//                   : and outputs must be connected.

//  Please reference the appropriate libraries guide for additional information on the XPM modules.