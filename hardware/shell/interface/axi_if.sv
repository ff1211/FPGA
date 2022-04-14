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
// 1.0      2022.04.14  Fanfei      Initial version
//****************************************************************
`timescale 1ns/1ps

interface axi_lite #(
    parameter DATA_WIDTH = 32,
    parameter CHANNEL = 1
) (
);
logic [CHANNEL-1:0]                 awready;
logic [CHANNEL-1:0]                 awvalid;
logic [CHANNEL*DATA_WIDTH-1:0]      awaddr ;
logic [2*CHANNEL-1:0]               awprot ;

logic [CHANNEL-1:0]                 wready ;
logic [CHANNEL-1:0]                 wvalid ;
logic [CHANNEL*DATA_WIDTH-1:0]      wdata  ;
logic [CHANNEL*DATA_WIDTH/8-1:0]    wstrb  ;

logic [CHANNEL-1:0]                 bready ;
logic [CHANNEL-1:0]                 bvalid ;
logic [2*CHANNEL:0]                 bresp  ;

logic [CHANNEL-1:0]                 arready;
logic [CHANNEL-1:0]                 arvalid;
logic [CHANNEL*DATA_WIDTH-1:0]      araddr ;

logic [CHANNEL-1:0]                 rready ;
logic [CHANNEL-1:0]                 rvalid ;
logic [CHANNEL*DATA_WIDTH-1:0]      rdata  ;
logic [2*CHANNEL:0]                 rresp  ;

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