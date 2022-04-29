//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// cdc_array.sv
// 
// Description:
// Synchronize array signal.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.29  fanfei      Initial version
//****************************************************************

`timescale 1ns/1ps

module cdc_array #(
    parameter SRC_INPUT_REG = 1,
    parameter DATA_WIDTH    = 1,
    parameter SYNC_FF       = 4
) (
    input   clk_s,
    input   clk_d,
    input  [DATA_WIDTH-1:0] ds,
    output [DATA_WIDTH-1:0] dd,
);

xpm_cdc_array_single #(
    .DEST_SYNC_FF   (   SYNC_FF         ),  // DECIMAL; range: 2-10
    .INIT_SYNC_FF   (   0               ),  // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
    .SIM_ASSERT_CHK (   0               ),  // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
    .SRC_INPUT_REG  (   SRC_INPUT_REG   ),  // DECIMAL; 0=do not register input, 1=register input
    .WIDTH          (   DATA_WIDTH      )   // DECIMAL; range: 1-1024
)
xpm_cdc_array_single_inst (
    .dest_out       (   dd      ),  // WIDTH-bit output: src_in synchronized to the destination clock domain. This
                                    // output is registered.

    .dest_clk       (   clk_d   ),  // 1-bit input: Clock signal for the destination clock domain.
    .src_clk        (   clk_s   ),  // 1-bit input: optional; required when SRC_INPUT_REG = 1
    .src_in         (   ds      )   // WIDTH-bit input: Input single-bit array to be synchronized to destination clock
                                    // domain. It is assumed that each bit of the array is unrelated to the others. This
                                    // is reflected in the constraints applied to this macro. To transfer a binary value
                                    // losslessly across the two clock domains, use the XPM_CDC_GRAY macro instead.
);

endmodule



// XPM_CDC instantiation template for Single-bit Array Synchronizer configurations
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
// +---------------------------------------------------------------------------------------------------------------------+
// | INIT_SYNC_FF         | Integer            | Allowed values: 0, 1. Default value = 0.                                |
// |---------------------------------------------------------------------------------------------------------------------|
// | 0- Disable behavioral simulation initialization value(s) on synchronization registers.                              |
// | 1- Enable behavioral simulation initialization value(s) on synchronization registers.                               |
// +---------------------------------------------------------------------------------------------------------------------+
// | SIM_ASSERT_CHK       | Integer            | Allowed values: 0, 1. Default value = 0.                                |
// |---------------------------------------------------------------------------------------------------------------------|
// | 0- Disable simulation message reporting. Messages related to potential misuse will not be reported.                 |
// | 1- Enable simulation message reporting. Messages related to potential misuse will be reported.                      |
// +---------------------------------------------------------------------------------------------------------------------+
// | SRC_INPUT_REG        | Integer            | Allowed values: 1, 0. Default value = 1.                                |
// |---------------------------------------------------------------------------------------------------------------------|
// | 0- Do not register input (src_in)                                                                                   |
// | 1- Register input (src_in) once using src_clk                                                                       |
// +---------------------------------------------------------------------------------------------------------------------+
// | WIDTH                | Integer            | Range: 1 - 1024. Default value = 2.                                     |
// |---------------------------------------------------------------------------------------------------------------------|
// | Width of single-bit array (src_in) that will be synchronized to destination clock domain.                           |
// +---------------------------------------------------------------------------------------------------------------------+

// Port usage table, organized as follows:
// +---------------------------------------------------------------------------------------------------------------------+
// | Port name      | Direction | Size, in bits                         | Domain  | Sense       | Handling if unused     |
// |---------------------------------------------------------------------------------------------------------------------|
// | Description                                                                                                         |
// +---------------------------------------------------------------------------------------------------------------------+
// +---------------------------------------------------------------------------------------------------------------------+
// | dest_clk       | Input     | 1                                     | NA      | Rising edge | Required               |
// |---------------------------------------------------------------------------------------------------------------------|
// | Clock signal for the destination clock domain.                                                                      |
// +---------------------------------------------------------------------------------------------------------------------+
// | dest_out       | Output    | WIDTH                                 | dest_clk| NA          | Required               |
// |---------------------------------------------------------------------------------------------------------------------|
// | src_in synchronized to the destination clock domain. This output is registered.                                     |
// +---------------------------------------------------------------------------------------------------------------------+
// | src_clk        | Input     | 1                                     | NA      | Rising edge | Tie to 1'b0            |
// |---------------------------------------------------------------------------------------------------------------------|
// | Unused when SRC_INPUT_REG = 0. Input clock signal for src_in if SRC_INPUT_REG = 1.                                  |
// +---------------------------------------------------------------------------------------------------------------------+
// | src_in         | Input     | WIDTH                                 | src_clk | NA          | Required               |
// |---------------------------------------------------------------------------------------------------------------------|
// | Input single-bit array to be synchronized to destination clock domain. It is assumed that each bit of the array is  |
// | unrelated to the others. This is reflected in the constraints applied to this macro.                                |
// | To transfer a binary value losslessly across the two clock domains, use the XPM_CDC_GRAY macro instead.             |
// +---------------------------------------------------------------------------------------------------------------------+


// xpm_cdc_array_single : In order to incorporate this function into the design,
//       Verilog        : the following instance declaration needs to be placed
//       instance       : in the body of the design code.  The instance name
//     declaration      : (xpm_cdc_array_single_inst) and/or the port declarations within the
//         code         : parenthesis may be changed to properly reference and
//                      : connect this function to the design.  All inputs
//                      : and outputs must be connected.

//  Please reference the appropriate libraries guide for additional information on the XPM modules.
