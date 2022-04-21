//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// interconnect.vh
// 
// Description:
// Macros for bus connection.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.14  Fanfei      Initial version
//****************************************************************

// Assign AXI4.
`define CON_AXI4_M2N(axi_s, axi_d, m, n) \
assign axi_d.awid    [n*axi_d.ID_WIDTH+:axi_d.ID_WIDTH]     = axi_s.awid [m*axi_s.ID_WIDTH+:axi_s.ID_WIDTH] | {axi_d.ID_WIDTH{0}}; \
assign axi_d.awaddr  [n*axi_d.ADDR_WIDTH+:axi_d.ADDR_WIDTH] = axi_s.awaddr [m*axi_s.ADDR_WIDTH+:axi_s.ADDR_WIDTH] | {axi_d.ADDR_WIDTH{0}}; \
assign axi_d.awlen   [n*8+:8] = axi_s.awlen   [m*8+:8] | 8'b0; \
assign axi_d.awsize  [n*3+:3] = axi_s.awsize  [m*3+:3] | 3'b0; \
assign axi_d.awburst [n*2+:2] = axi_s.awburst [m*2+:2] | 2'b0; \
assign axi_d.awlock  [n*2+:2] = axi_s.awlock  [m*2+:2] | 2'b0; \
assign axi_d.awcache [n*4+:4] = axi_s.awcache [m*4+:4] | 4'b0; \
assign axi_d.awprot  [n*3+:3] = axi_s.awprot  [m*3+:3] | 3'b0; \
assign axi_d.awregion[n*4+:4] = axi_s.awregion[m*4+:4] | 4'b0; \
assign axi_d.awqos   [n*4+:4] = axi_s.awqos   [m*4+:4] | 4'b0; \
assign axi_d.awuser  [n*axi_d.USER_WIDTH+:axi_d.USER_WIDTH] = axi_s.awuser [m*axi_s.USER_WIDTH+:axi_s.USER_WIDTH] | {axi_d.USER_WIDTH{0}}; \
assign axi_d.awvalid [n]      = axi_s.awvalid [m]; \  
assign axi_s.awready [m]      = axi_d.awready [n]; \
assign axi_d.arid    [n*axi_d.ID_WIDTH+:axi_d.ID_WIDTH]     = axi_s.arid [m*axi_s.ID_WIDTH+:axi_s.ID_WIDTH] | {axi_d.ID_WIDTH{0}}; \
assign axi_d.araddr  [n*axi_d.ADDR_WIDTH+:axi_d.ADDR_WIDTH] = axi_s.araddr [m*axi_s.ADDR_WIDTH+:axi_s.ADDR_WIDTH] | {axi_d.ADDR_WIDTH{0}}; \
assign axi_d.arlen   [n*8+:8] = axi_s.arlen   [m*8+:8] | 8'b0; \
assign axi_d.arsize  [n*3+:3] = axi_s.arsize  [m*3+:3] | 3'b0; \
assign axi_d.arburst [n*2+:2] = axi_s.arburst [m*2+:2] | 2'b0; \
assign axi_d.arlock  [n*2+:2] = axi_s.arlock  [m*2+:2] | 2'b0; \
assign axi_d.arcache [n*4+:4] = axi_s.arcache [m*4+:4] | 4'b0; \
assign axi_d.arprot  [n*3+:3] = axi_s.arprot  [m*3+:3] | 3'b0; \
assign axi_d.arregion[n*4+:4] = axi_s.arregion[m*4+:4] | 4'b0; \
assign axi_d.arqos   [n*4+:4] = axi_s.arqos   [m*4+:4] | 4'b0; \
assign axi_d.aruser  [n*axi_d.USER_WIDTH+:axi_d.USER_WIDTH] = axi_s.aruser [m*axi_s.USER_WIDTH+:axi_s.USER_WIDTH] | {axi_d.USER_WIDTH{0}}; \
assign axi_d.arvalid [n]      = axi_s.arvalid [m]; \  
assign axi_s.arready [m]      = axi_d.arready [n]; \
assign axi_s.bid     [m*axi_s.ID_WIDTH+:axi_s.ID_WIDTH]     = axi_d.bid [m*axi_d.ID_WIDTH+:axi_d.ID_WIDTH] | {axi_s.ID_WIDTH{0}}; \
assign axi_d.bready  [n]      = axi_s.bready [m]; \
assign axi_s.bresp   [m*2+:2] = axi_d.bresp  [n*2+:2] | 2'b0; \
assign axi_s.bvalid  [m]      = axi_d.bvalid [n]; \
assign axi_s.buser   [m*axi_s.USER_WIDTH+:axi_s.USER_WIDTH] = axi_d.buser [m*axi_d.USER_WIDTH+:axi_d.USER_WIDTH] | {axi_s.USER_WIDTH{0}}; \
assign axi_s.rdata   [m*axi_s.DATA_WIDTH+:axi_s.DATA_WIDTH] = axi_d.rdata [n*axi_d.DATA_WIDTH+:axi_d.DATA_WIDTH] | {axi_s.DATA_WIDTH{0}}; \
assign axi_s.rid     [m*axi_s.ID_WIDTH+:axi_s.ID_WIDTH]     = axi_d.rid [n*axi_d.ID_WIDTH+:axi_d.ID_WIDTH] | {axi_s.ID_WIDTH{0}}; \
assign axi_s.rlast   [m]      = axi_d.rlast  [n]; \
assign axi_d.rready  [n]      = axi_s.rready [m]; \
assign axi_s.rresp   [m*2+:2] = axi_d.rresp  [n*2+:2] | 2'b0; \
assign axi_s.rvalid  [m]      = axi_d.rvalid [n]; \
assign axi_d.wdata   [n*axi_d.DATA_WIDTH+:axi_d.DATA_WIDTH] = axi_s.wdata [m*axi_s.DATA_WIDTH+:axi_s.DATA_WIDTH] | {axi_d.DATA_WIDTH{0}}; \
assign axi_d.wid     [n*axi_d.ID_WIDTH+:axi_d.ID_WIDTH]     = axi_s.wid [m*axi_s.ID_WIDTH+:axi_s.ID_WIDTH] | {axi_d.ID_WIDTH{0}}; \
assign axi_d.wlast   [n]      = axi_s.wlast   [m]; \
assign axi_s.wready  [m]      = axi_d.wready  [n]; \
assign axi_d.wstrb   [n*axi_d.DATA_WIDTH/8+:axi_d.DATA_WIDTH/8] = axi_s.wstrb [m*axi_s.DATA_WIDTH/8+:axi_s.DATA_WIDTH/8] | {(axi_d.DATA_WIDTH/8){0}}; \
assign axi_d.wvalid  [n]      =axi_s.wvalid   [m]
