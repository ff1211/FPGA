//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// ov5640.sv
// 
// Description:
// ov5640 camera top 
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.28  fanfei      Initial version
//****************************************************************
`timescale 1ns/1ps
`include "pre_proc.vh"
`include "interconnect.vh"

module ov5640 #(

) (
    input           s_axil_aclk,  
    input           s_axil_arst_n,
    axi_lite.slave  s_axil_cam

    input           cam_pclk,
    input           cam_vsync,
    input           cam_href,
    input  [7:0]    cam_data,
    output          cam_rst_n,
    output          cam_pwdn,
    output          cam_scl,
    input           cam_sda_i,
    output          cam_sda_o,
    output          cam_sda_t,
);

// Axi lite to iic convert. For configuring ov5640.
axi_iic_ov5640 axi_iic_ov5640_inst (
    .s_axi_aclk     (   s_axil_aclk     ),      // input wire s_axi_aclk
    .s_axi_aresetn  (   s_axil_arst_n   ),      // input wire s_axi_aresetn
    .iic2intc_irpt  (   iic2intc_irpt   ),      // output wire iic2intc_irpt
    .s_axi_awaddr   (   s_axil_cam.awaddr   ),  // input wire [8 : 0] s_axi_awaddr
    .s_axi_awvalid  (   s_axil_cam.awvalid  ),  // input wire s_axi_awvalid
    .s_axi_awready  (   s_axil_cam.awready  ),  // output wire s_axi_awready
    .s_axi_wdata    (   s_axil_cam.wdata    ),  // input wire [31 : 0] s_axi_wdata
    .s_axi_wstrb    (   s_axil_cam.wstrb    ),  // input wire [3 : 0] s_axi_wstrb
    .s_axi_wvalid   (   s_axil_cam.wvalid   ),  // input wire s_axi_wvalid
    .s_axi_wready   (   s_axil_cam.wready   ),  // output wire s_axi_wready
    .s_axi_bresp    (   s_axil_cam.bresp    ),  // output wire [1 : 0] s_axi_bresp
    .s_axi_bvalid   (   s_axil_cam.bvalid   ),  // output wire s_axi_bvalid
    .s_axi_bready   (   s_axil_cam.bready   ),  // input wire s_axi_bready
    .s_axi_araddr   (   s_axil_cam.araddr   ),  // input wire [8 : 0] s_axi_araddr
    .s_axi_arvalid  (   s_axil_cam.arvalid  ),  // input wire s_axi_arvalid
    .s_axi_arready  (   s_axil_cam.arready  ),  // output wire s_axi_arready
    .s_axi_rdata    (   s_axil_cam.rdata    ),  // output wire [31 : 0] s_axi_rdata
    .s_axi_rresp    (   s_axil_cam.rresp    ),  // output wire [1 : 0] s_axi_rresp
    .s_axi_rvalid   (   s_axil_cam.rvalid   ),  // output wire s_axi_rvalid
    .s_axi_rready   (   s_axil_cam.rready   ),  // input wire s_axi_rready
    .sda_i          (   cam_sda_i           ),  // input wire sda_i
    .sda_o          (   cam_sda_o           ),  // output wire sda_o
    .sda_t          (   cam_sda_t           ),  // output wire sda_t
    .scl_i          (                       ),  // input wire scl_i
    .scl_o          (   cam_scl             ),  // output wire scl_o
    .scl_t          (                       ),  // output wire scl_t
    .gpo            (                       )   // output wire [0 : 0] gpo
);


endmodule