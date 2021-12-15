`timescale 1ns/1ps

module program_ctrl(
    input  logic    clk,
    input  logic    rst_n,

    axi_lite        pro_ctrl_if,
    output logic    programing

    // input  logic [31:0] ins_i,
    // input  logic        ins_vld,

    // input  logic [31:0] data_i,
    // input  logic [31:0] data_addr_i,
    // input  logic        data_vld,

    // output logic [31:0] ins_wr_pro,
    // output logic [31:0] ins_addr_pro,
    // output logic        ins_wr_en_pro,

    // output logic [31:0] data_wr_pro,
    // output logic [31:0] data_addr_pro,
    // output logic        data_wr_en_pro,


);

parameter S_IDLE            = 0;
parameter S_WAIT_CPU_RST    = 1;
parameter S_PROGRAM_INS     = 2;
parameter S_PROGRAM_DATA    = 3;

assign programing = ins_vld | data_vld;

//instruction
assign ins_wr_pro = ins_i;
assign ins_wr_en_pro = ins_vld;

always_ff @( posedge clk ) begin
    if(~rst_n)
        ins_addr_pro <= 0;
    else if(~ins_vld)
        ins_addr_pro <= 0;
    else if(ins_vld)
        ins_addr_pro <= ins_addr_pro + 4;
end

//data
assign data_wr_pro = data_i;
assign data_addr_pro = data_addr_i;
assign data_wr_en_pro = data_vld;

endmodule