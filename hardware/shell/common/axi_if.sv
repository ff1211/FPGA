//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// axi_if.sv
// 
// Description:
// AXI interface define.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.14  fanfei      Initial version
//****************************************************************
`timescale 1ns/1ps

interface axi_lite #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter CHANNEL = 1
) (
);
logic [CHANNEL-1:0]                 awready;
logic [CHANNEL-1:0]                 awvalid;
logic [CHANNEL*ADDR_WIDTH-1:0]      awaddr ;
logic [CHANNEL*3-1:0]               awprot ;

logic [CHANNEL-1:0]                 wready ;
logic [CHANNEL-1:0]                 wvalid ;
logic [CHANNEL*DATA_WIDTH-1:0]      wdata  ;
logic [CHANNEL*DATA_WIDTH/8-1:0]    wstrb  ;

logic [CHANNEL-1:0]                 bready ;
logic [CHANNEL-1:0]                 bvalid ;
logic [CHANNEL*2-1:0]               bresp  ;

logic [CHANNEL-1:0]                 arready;
logic [CHANNEL-1:0]                 arvalid;
logic [CHANNEL*ADDR_WIDTH-1:0]      araddr ;
logic [CHANNEL*3-1:0]               arprot ;

logic [CHANNEL-1:0]                 rready ;
logic [CHANNEL-1:0]                 rvalid ;
logic [CHANNEL*DATA_WIDTH-1:0]      rdata  ;
logic [CHANNEL*2-1:0]               rresp  ;

modport master (
    input   awready,
    output  awvalid,
    output  awaddr,
    output  awprot,

    input   wready, 
    output  wvalid, 
    output  wdata,
    output  wstrb,

    output  bready, 
    input   bvalid, 
    input   bresp, 

    input   arready,
    output  arvalid,
    output  araddr,
    output  arprot,

    output  rready,
    input   rvalid, 
    input   rdata,  
    input   rresp
);

modport slave (
    output  awready,
    input   awvalid,
    input   awaddr,
    input   awprot,

    output  wready, 
    input   wvalid, 
    input   wdata,
    input   wstrb,

    input   bready, 
    output  bvalid, 
    output  bresp, 

    output  arready,
    input   arvalid,
    input   araddr,
    input   arprot,

    input   rready,
    output  rvalid, 
    output  rdata,  
    output  rresp
);
    
endinterface //axi_lite

//axi-stream
interface axis #(
    parameter CHANNEL       = 1,
    parameter DATA_WIDTH    = 32,
    parameter ID_WIDTH      = 1,
    parameter DEST_WIDTH    = 1,
    parameter USER_WIDTH    = 1
) (
);
logic [CHANNEL-1:0]                 tvalid;
logic [CHANNEL-1:0]                 tready;
logic [CHANNEL*DATA_WIDTH-1:0]      tdata;
logic [CHANNEL*DATA_WIDTH/8-1:0]    tstrb;
logic [CHANNEL*DATA_WIDTH/8-1:0]    tkeep;
logic [CHANNEL-1:0]                 tlast;
logic [CHANNEL*ID_WIDTH-1:0]        tid;
logic [CHANNEL*DEST_WIDTH-1:0]      tdest;
logic [CHANNEL*USER_WIDTH-1:0]      tuser;

modport master (
    output  tvalid,
    input   tready,
    output  tdata,
    output  tstrb,
    output  tkeep,
    output  tlast,
    output  tid,
    output  tdest,
    output  tuser
);

modport slave (
    input   tvalid,
    output  tready,
    input   tdata,
    input   tstrb,
    input   tkeep,
    input   tlast,
    input   tid,
    input   tdest,
    input   tuser
);
    
endinterface //axi_stream

// axi4
interface axi4 #(
    parameter CHANNEL       = 1,
    parameter DATA_WIDTH    = 32,
    parameter ADDR_WIDTH    = 32,
    parameter ID_WIDTH      = 1,
    parameter USER_WIDTH    = 1
) (
);
logic [CHANNEL*ID_WIDTH-1:0]        awid    ;
logic [CHANNEL*ADDR_WIDTH-1:0]      awaddr  ;
logic [CHANNEL*8-1:0]               awlen   ;
logic [CHANNEL*3-1:0]               awsize  ;
logic [CHANNEL*2-1:0]               awburst ;
logic [CHANNEL*2-1:0]               awlock  ;
logic [CHANNEL*4-1:0]               awcache ;
logic [CHANNEL*3-1:0]               awprot  ;
logic [CHANNEL*4-1:0]               awregion;
logic [CHANNEL*4-1:0]               awqos   ;
logic [CHANNEL*USER_WIDTH-1:0]      awuser  ;
logic [CHANNEL-1:0]                 awvalid ;
logic [CHANNEL-1:0]                 awready ;

logic [CHANNEL*ID_WIDTH-1:0]        arid    ;
logic [CHANNEL*ADDR_WIDTH-1:0]      araddr  ;
logic [CHANNEL*8-1:0]               arlen   ;
logic [CHANNEL*3-1:0]               arsize  ;
logic [CHANNEL*2-1:0]               arburst ;
logic [CHANNEL*2-1:0]               arlock  ;
logic [CHANNEL*4-1:0]               arcache ;
logic [CHANNEL*3-1:0]               arprot  ;
logic [CHANNEL*4-1:0]               arregion;
logic [CHANNEL*4-1:0]               arqos   ;
logic [CHANNEL*USER_WIDTH-1:0]      aruser  ;
logic [CHANNEL-1:0]                 arvalid ;
logic [CHANNEL-1:0]                 arready ;

logic [CHANNEL*ID_WIDTH-1:0]        bid     ;
logic [CHANNEL-1:0]                 bready  ;
logic [CHANNEL*2-1:0]               bresp   ;
logic [CHANNEL-1:0]                 bvalid  ;
logic [CHANNEL*USER_WIDTH-1:0]      buser   ;

logic [CHANNEL*DATA_WIDTH-1:0]      rdata   ;
logic [CHANNEL*ID_WIDTH-1:0]        rid     ;
logic [CHANNEL-1:0]                 rlast   ;
logic [CHANNEL-1:0]                 rready  ;
logic [CHANNEL*2-1:0]               rresp   ;
logic [CHANNEL-1:0]                 rvalid  ;

logic [CHANNEL*DATA_WIDTH-1:0]      wdata   ;
logic [CHANNEL*ID_WIDTH-1:0]        wid     ;
logic [CHANNEL-1:0]                 wlast   ;
logic [CHANNEL-1:0]                 wready  ;
logic [CHANNEL*DATA_WIDTH/8-1:0]    wstrb   ;
logic [CHANNEL-1:0]                 wvalid  ;

modport master (
    output awid    ,
    output awaddr  ,
    output awlen   ,
    output awsize  ,
    output awburst ,
    output awlock  ,
    output awcache ,
    output awprot  ,
    output awregion,
    output awqos   ,
    output awuser  ,
    output awvalid ,
    input  awready ,

    output arid    ,
    output araddr  ,
    output arlen   ,
    output arsize  ,
    output arburst ,
    output arlock  ,
    output arcache ,
    output arprot  ,
    output arregion,
    output arqos   ,
    output aruser  ,
    output arvalid ,
    input  arready ,

    input  bid     ,
    output bready  ,
    input  bresp   ,
    input  bvalid  ,
    input  buser   ,

    input  rdata   ,
    input  rid     ,
    input  rlast   ,
    output rready  ,
    input  rresp   ,
    input  rvalid  ,

    output wdata   ,
    output wid     ,
    output wlast   ,
    input  wready  ,
    output wstrb   ,
    output wvalid  
);

modport slave (
    input  awid    ,
    input  awaddr  ,
    input  awlen   ,
    input  awsize  ,
    input  awburst ,
    input  awlock  ,
    input  awcache ,
    input  awprot  ,
    input  awregion,
    input  awqos   ,
    input  awuser  ,
    input  awvalid ,
    output awready ,

    input  arid    ,
    input  araddr  ,
    input  arlen   ,
    input  arsize  ,
    input  arburst ,
    input  arlock  ,
    input  arcache ,
    input  arprot  ,
    input  arregion,
    input  arqos   ,
    input  aruser  ,
    input  arvalid ,
    output arready ,

    output bid     ,
    input  bready  ,
    output bresp   ,
    output bvalid  ,
    output buser   ,

    output rdata   ,
    output rid     ,
    output rlast   ,
    input  rready  ,
    output rresp   ,
    output rvalid  ,

    input  wdata   ,
    input  wid     ,
    input  wlast   ,
    output wready  ,
    input  wstrb   ,
    input  wvalid  
);
endinterface // axi4