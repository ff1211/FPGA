`timescale 1ns/1ps

module reg_file (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        reg_wr_en,
    input  logic [4:0]  reg_wr,
    input  logic [31:0] reg_data_wr,

    input  logic [4:0]  reg_rd_0,
    input  logic [4:0]  reg_rd_1,

    output logic [31:0] reg_data_rd_0,
    output logic [31:0] reg_data_rd_1

);

localparam zero     = 0;
localparam at       = 1;
localparam v0       = 2;
localparam v1       = 3;
localparam a0       = 4;
localparam a1       = 5;
localparam a2       = 6;
localparam a3       = 7;
localparam t0       = 8;
localparam t1       = 9;
localparam t2       = 10;
localparam t3       = 11;
localparam t4       = 12;
localparam t5       = 13;
localparam t6       = 14;
localparam t7       = 15;
localparam s0       = 16;
localparam s1       = 17;
localparam s2       = 18;
localparam s3       = 19;
localparam s4       = 20;
localparam s5       = 21;
localparam s6       = 22;
localparam s7       = 23;
localparam t8       = 24;
localparam t9       = 25;
localparam k0       = 26;
localparam k1       = 27;
localparam gp       = 28;
localparam sp       = 29;
localparam fp_s8    = 30;
localparam ra       = 31;

logic [31:0][31:0]  register;

always_ff @( posedge clk ) begin
    if(~rst_n)
        register <= 1024'd0;
    else begin
        reg_data_rd_0 <= register[reg_rd_0];
        reg_data_rd_1 <= register[reg_rd_1];

        if(reg_wr_en & (reg_wr != 0))
            register[reg_wr] <= reg_data_wr;
    end
end

endmodule