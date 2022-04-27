//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// ad4225.sv
// 
// Description:
// 125M ADC.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.27  yjt         Initial version
//****************************************************************

`timescale 1ns/1ps

module ad4225 (
    input           ad_clk,
    input  [11:0]   da_data,
    input  [11:0]   db_data,
    output          reset,
    output          pwr
);
    
endmodule