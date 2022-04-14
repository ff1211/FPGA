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
    parameter DATA_WIDTH = 32
) (
);
logic                       awready;
logic                       awvalid;
logic [DATA_WIDTH-1:0]      awaddr ;
logic [1:0]                 awprot ;

logic                       wready ;
logic                       wvalid ;
logic [DATA_WIDTH-1:0]      wdata  ;
logic [DATA_WIDTH/8-1:0]    wstrb  ;

logic                       bready ;
logic                       bvalid ;
logic [1:0]                 bresp  ;

logic                       arready;
logic                       arvalid;
logic [DATA_WIDTH-1:0]      araddr ;

logic                       rready ;
logic                       rvalid ;
logic [DATA_WIDTH-1:0]      rdata  ;
logic [1:0]                 rresp  ;

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
    output awready,
    input  awvalid,
    input  awaddr,
    input  awprot,

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
    parameter DATA_WIDTH    = 32,
    parameter ID_WIDTH      = 1,
    parameter DEST_WIDTH    = 1,
    parameter USER_WIDTH    = 1
) (
);
logic                       tvalid;
logic                       tready;
logic [DATA_WIDTH-1:0]      tdata;
logic [DATA_WIDTH/8-1:0]    tstrb;
logic [DATA_WIDTH/8-1:0]    tkeep;
logic                       tlast;
logic [ID_WIDTH-1:0]        tid;
logic [DEST_WIDTH-1:0]      tdest;
logic [USER_WIDTH-1:0]      tuser;

modport master (
    output  tvalid;
    input   tready;
    output  tdata;
    output  tstrb;
    output  tkeep;
    output  tlast;
    output  tid;
    output  tdest;
    output  tuser;
);

modport slave (
    input   tvalid;
    output  tready;
    input   tdata;
    input   tstrb;
    input   tkeep;
    input   tlast;
    input   tid;
    input   tdest;
    input   tuser;
);
    
endinterface //axi_stream