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
// 1.0      2022.04.14  ff          Initial version
//****************************************************************

`ifndef INTERCONNECT
`define INTERCONNECT

// Assign AXI4.
`define CON_AXI4_M2N(s, d, m, n) \
assign d.awid    [n*d.ID_WIDTH+:d.ID_WIDTH] = s.awid [m*s.ID_WIDTH+:s.ID_WIDTH] | {d.ID_WIDTH{0}}; \
assign d.awaddr  [n*d.ADDR_WIDTH+:d.ADDR_WIDTH] = s.awaddr [m*s.ADDR_WIDTH+:s.ADDR_WIDTH] | {d.ADDR_WIDTH{0}}; \
assign d.awlen   [n*d.LEN_WIDTH+:d.LEN_WIDTH] = s.awlen [m*s.LEN_WIDTH+:s.LEN_WIDTH] | {d.LEN_WIDTH{0}}; \
assign d.awsize  [n*3+:3] = s.awsize  [m*3+:3]; \
assign d.awburst [n*2+:2] = s.awburst [m*2+:2]; \
assign d.awlock  [n*2+:2] = s.awlock  [m*2+:2]; \
assign d.awcache [n*4+:4] = s.awcache [m*4+:4]; \
assign d.awprot  [n*3+:3] = s.awprot  [m*3+:3]; \
assign d.awregion[n*4+:4] = s.awregion[m*4+:4]; \
assign d.awqos   [n*4+:4] = s.awqos   [m*4+:4]; \
assign d.awuser  [n*d.USER_WIDTH+:d.USER_WIDTH] = s.awuser [m*s.USER_WIDTH+:s.USER_WIDTH] | {d.USER_WIDTH{0}}; \
assign d.awvalid [n]      = s.awvalid [m]; \
assign s.awready [m]      = d.awready [n]; \
assign d.arid    [n*d.ID_WIDTH+:d.ID_WIDTH] = s.arid [m*s.ID_WIDTH+:s.ID_WIDTH] | {d.ID_WIDTH{0}}; \
assign d.araddr  [n*d.ADDR_WIDTH+:d.ADDR_WIDTH] = s.araddr [m*s.ADDR_WIDTH+:s.ADDR_WIDTH] | {d.ADDR_WIDTH{0}}; \
assign d.arlen   [n*d.LEN_WIDTH+:d.LEN_WIDTH] = s.arlen [m*s.LEN_WIDTH+:s.LEN_WIDTH] | {d.LEN_WIDTH{0}}; \
assign d.arsize  [n*3+:3] = s.arsize  [m*3+:3]; \
assign d.arburst [n*2+:2] = s.arburst [m*2+:2]; \
assign d.arlock  [n*2+:2] = s.arlock  [m*2+:2]; \
assign d.arcache [n*4+:4] = s.arcache [m*4+:4]; \
assign d.arprot  [n*3+:3] = s.arprot  [m*3+:3]; \
assign d.arregion[n*4+:4] = s.arregion[m*4+:4]; \
assign d.arqos   [n*4+:4] = s.arqos   [m*4+:4]; \
assign d.aruser  [n*d.USER_WIDTH+:d.USER_WIDTH] = s.aruser [m*s.USER_WIDTH+:s.USER_WIDTH] | {d.USER_WIDTH{0}}; \
assign d.arvalid [n]      = s.arvalid [m]; \
assign s.arready [m]      = d.arready [n]; \
assign s.bid     [m*s.ID_WIDTH+:s.ID_WIDTH]     = d.bid [m*d.ID_WIDTH+:d.ID_WIDTH] | {s.ID_WIDTH{0}}; \
assign d.bready  [n]      = s.bready [m]; \
assign s.bresp   [m*2+:2] = d.bresp  [n*2+:2]; \
assign s.bvalid  [m]      = d.bvalid [n]; \
assign s.buser   [m*d.USER_WIDTH+:d.USER_WIDTH] = d.buser [m*d.USER_WIDTH+:d.USER_WIDTH] | {d.USER_WIDTH{0}}; \
assign s.rdata   [m*s.DATA_WIDTH+:s.DATA_WIDTH] = d.rdata [n*d.DATA_WIDTH+:d.DATA_WIDTH] | {s.DATA_WIDTH{0}}; \
assign s.rid     [m*s.ID_WIDTH+:s.ID_WIDTH]     = d.rid [n*d.ID_WIDTH+:d.ID_WIDTH] | {s.ID_WIDTH{0}}; \
assign s.rlast   [m]      = d.rlast  [n]; \
assign d.rready  [n]      = s.rready [m]; \
assign s.rresp   [m*2+:2] = d.rresp  [n*2+:2]; \
assign s.rvalid  [m]      = d.rvalid [n]; \
assign d.wdata   [n*d.DATA_WIDTH+:d.DATA_WIDTH] = s.wdata [m*s.DATA_WIDTH+:s.DATA_WIDTH] | {d.DATA_WIDTH{0}}; \
assign d.wid     [n*d.ID_WIDTH+:d.ID_WIDTH]     = s.wid [m*s.ID_WIDTH+:s.ID_WIDTH] | {d.ID_WIDTH{0}}; \
assign d.wlast   [n]      = s.wlast   [m]; \
assign s.wready  [m]      = d.wready  [n]; \
assign d.wstrb   [n*d.DATA_WIDTH/8+:d.DATA_WIDTH/8] = s.wstrb [m*s.DATA_WIDTH/8+:s.DATA_WIDTH/8] | {(d.DATA_WIDTH/8){0}}; \
assign d.wvalid  [n]      =s.wvalid   [m]

// Assign axi lite.
`define CON_AXIL_M2N(s, d, m, n) \
assign s.awready[m] = d.awready[n]; \
assign d.awvalid[n] = s.awvalid[m]; \
assign d.awaddr [n*d.ADDR_WIDTH+:d.ADDR_WIDTH] = s.awaddr[m*s.ADDR_WIDTH+:s.ADDR_WIDTH] | {d.ADDR_WIDTH{0}}; \
assign d.awprot [n*3+:3] = s.awprot[m*3+:3]; \
assign s.wready [m] = d.wready[n]; \
assign d.wvalid [n] = s.wvalid[m]; \
assign d.wdata  [n*d.DATA_WIDTH+:d.DATA_WIDTH] = s.wdata[m*s.DATA_WIDTH+:s.DATA_WIDTH] | {d.DATA_WIDTH{0}}; \
assign d.wstrb  [n*4+:4] = s.wstrb[m*4+:4]; \
assign d.bready [n] = s.bready[m]; \
assign s.bvalid [m] = d.bvalid[n]; \
assign s.bresp  [m*2+:2] = d.bresp[n*2+:2]; \
assign s.arready[m] = d.arready[n]; \
assign d.arvalid[n] = s.arvalid[m]; \
assign d.araddr [n*d.ADDR_WIDTH+:d.ADDR_WIDTH] = s.araddr[m*s.ADDR_WIDTH+:s.ADDR_WIDTH] | {d.ADDR_WIDTH{0}}; \
assign d.arprot [n*3+:3] = d.arprot[m*3+:3]; \
assign d.rready [n] = s.rready[m]; \
assign s.rvalid [m] = d.rvalid[n]; \
assign s.rdata  [m*s.DATA_WIDTH+:s.DATA_WIDTH] = d.rdata[n*d.DATA_WIDTH+:d.DATA_WIDTH] | {d.DATA_WIDTH{0}}; \
assign s.rresp  [m*2+:2] = d.rresp[n*2+:2]

// Assign axi stream.
`define CON_AXIS_M2N(s, d, m, n) \
assign d.tvalid[n] = s.tvalid[m]; \
assign s.tready[m] = d.tready[n]; \
assign d.tdata [n*d.DATA_WIDTH+:d.DATA_WIDTH] = s.tdata [m*s.DATA_WIDTH+:s.DATA_WIDTH] | {d.DATA_WIDTH{0}}; \
assign d.tstrb [n*d.DATA_WIDTH/8+:d.DATA_WIDTH/8] = s.tstrb [m*d.DATA_WIDTH/8+:s.DATA_WIDTH/8] | {(d.DATA_WIDTH/8){0}}; \
assign d.tkeep [n*d.DATA_WIDTH/8+:d.DATA_WIDTH/8] = s.tkeep [m*d.DATA_WIDTH/8+:s.DATA_WIDTH/8] |{(d.DATA_WIDTH/8){0}}; \
assign d.tlast [n] = s.tlast [m]; \
assign d.tid   [n*d.ID_WIDTH+:d.ID_WIDTH] = s.tid [m*s.ID_WIDTH+:s.ID_WIDTH] | {d.ID_WIDTH{0}}; \
assign d.tdest [n*d.DEST_WIDTH+:d.DEST_WIDTH] = s.tdest [m*s.DEST_WIDTH+:s.DEST_WIDTH] | {d.DEST_WIDTH{0}}; \
assign d.tuser [n*d.USER_WIDTH+:d.USER_WIDTH] = s.tuser [m*d.USER_WIDTH+:s.USER_WIDTH] | {d.USER_WIDTH{0}}

`endif