`timescale 1ns/1ps

module top (
    input  logic        clk,
    input  logic        rst_n,

    input  logic [31:0] ins_i,
    input  logic        ins_vld,

    input  logic [31:0] data_i,
    input  logic [31:0] data_addr_i,
    input  logic        data_vld
);   

logic   [31:0]      data_wr;
logic               data_wr_en;
logic   [31:0]      data_addr;
logic   [31:0]      ins_addr;

logic   [31:0]      ins_rd_core;
logic   [31:0]      ins_addr_core;
logic   [31:0]      data_rd_core;
logic   [31:0]      data_wr_core;
logic   [31:0]      data_addr_core;
logic               data_wr_en_core;
logic               core_rst_n;

logic   [31:0]      ins_wr_pro;
logic   [31:0]      ins_addr_pro;
logic               ins_wr_en_pro;
logic   [31:0]      data_wr_pro;
logic   [31:0]      data_addr_pro;
logic               data_wr_en_pro;
logic               programing;


mips_core mips_core_inst(
    .clk            (   clk         ),
    .rst_n          (   core_rst_n  ),
    .ins_rd         (   ins_rd_core     ),
    .ins_addr       (   ins_addr_core   ),

    .data_rd        (   data_rd_core    ),
    .data_wr        (   data_wr_core    ),
    .data_wr_en     (   data_wr_en_core ),
    .data_addr      (   data_addr_core  )
);

program_ctrl program_ctrl_inst(
    .clk            (   clk         ),
    .rst_n          (   rst_n       ),

    .ins_i          (   ins_i       ),
    .ins_vld        (   ins_vld     ),

    .data_i         (   data_i      ),
    .data_addr_i    (   data_addr_i ),
    .data_vld       (   data_vld    ),

    .ins_wr_pro     (   ins_wr_pro      ),
    .ins_addr_pro   (   ins_addr_pro    ),
    .ins_wr_en_pro  (   ins_wr_en_pro   ),

    .data_wr_pro    (   data_wr_pro     ),
    .data_addr_pro  (   data_addr_pro   ),
    .data_wr_en_pro (   data_wr_en_pro  ),

    .programing     (   programing      )
);

assign ins_addr     = programing? ins_addr_pro   : ins_addr_core;

assign data_wr      = programing? data_wr_pro    : data_wr_core;
assign data_wr_en   = programing? data_wr_en_pro : data_wr_en_core;
assign data_addr    = programing? data_addr_pro  : data_addr_core;

assign core_rst_n   = rst_n & (~programing);

ram_single #(
    .DATA_WIDTH   ( 32  ),
    .ADDR_WIDTH   ( 5   ),
    .READ_LATENCY ( 1   )
) instruction_ram_inst (
    .clk    (  clk     ),
    .rst_n  (  rst_n   ),
    .wr_en  (  ins_wr_en_pro),
    .din    (  ins_wr_pro   ),
    .addr   (  ins_addr >> 2),
    .dout   (  ins_rd_core  )
);

ram_single #(
    .DATA_WIDTH   ( 32  ),
    .ADDR_WIDTH   ( 5   ),
    .READ_LATENCY ( 1   )
) data_ram_inst (
    .clk    (  clk     ),
    .rst_n  (  rst_n   ),
    .wr_en  (  data_wr_en       ),
    .din    (  data_wr          ),
    .addr   (  data_addr >> 2   ),
    .dout   (  data_rd_core     )
);

endmodule