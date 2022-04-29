//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// dvp_img_cap.sv
// 
// Description:
// Image capture module for dvp port.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.29  fanfei      Initial version
//****************************************************************

module dvp_img_cap
    input           cam_pclk,
    input           rst_n,
    input           cam_vsync,
    input           cam_href,
    input  [7:0]    cam_data,
    
    output          video_clk,
    output [15:0]   video_data,
    output          video_hsync,
    output          video_vsync
);

// Generate video clock.
logic video_clk_cnt;
always @(posedge cam_pclk) begin
    if(~rst_n)
        video_clk_cnt <= 1'b0;
    else
        video_clk_cnt <= video_clk_cnt + 1;
end
assign video_clk = video_clk_cnt;

// Capture data.
always @(posedge cam_pclk) begin
end
endmodule