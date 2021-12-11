`timescale 1ns/1ps

module mips_core (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [31:0] ins_rd,
    output logic [31:0] ins_addr,   
    input  logic [31:0] data_rd,
    output logic [31:0] data_wr,
    output logic        data_wr_en,
    output logic [31:0] data_addr
);

localparam S_IF     = 0;
localparam S_ID     = 1;
localparam S_EX     = 2;
localparam S_MEM    = 3;
localparam S_WB     = 4;

logic [31:0]    pc;
logic [31:0]    pc_puls_4;
logic [31:0]    byte_addr;

logic [31:0]    alu_in_0;
logic [31:0]    alu_in_1;
logic [31:0]    alu_out;
logic           alu_zero_flag;

logic  [4:0]    reg_wr      ;
logic  [31:0]   reg_data_wr ;
logic           reg_wr_en   ;
logic  [4:0]    reg_rd_0    ;
logic  [4:0]    reg_rd_1    ;
logic  [31:0]   reg_data_rd_0;
logic  [31:0]   reg_data_rd_1;

logic           RegDst     ;
logic           Jump       ;
logic           Branch     ;
logic           MemtoReg   ;
logic [3:0]     alu_control;
logic           MemWrite   ;
logic           ALUSrc     ;
logic           RegWrite   ;

logic [5:0]         opcode;
logic [4:0]         rs;
logic [4:0]         rt;
logic [4:0]         rd;
logic [4:0]         shamt;
logic [5:0]         funct;
logic signed [15:0] immed_val;
logic [25:0]        word_addr;

logic signed [31:0] immed_val_ext;

logic [2:0]         next_state;
logic [2:0]         current_state;

//state mechine
always_comb begin
    case (current_state)
        S_IF: 
            next_state = S_ID;
        S_ID: 
            next_state = S_EX;
        S_EX: begin
            if(Jump)
                next_state = S_IF;
            else if(MemtoReg)
                next_state = S_MEM;
            else
                next_state = S_WB;
        end
        S_MEM: 
            next_state = S_WB;
        S_WB: 
            next_state = S_IF;
    endcase
end

always_ff @( posedge clk ) begin
    if(~rst_n)
        current_state <= S_IF;
    else
        current_state <= next_state;
end

//instruction devide
assign {opcode, rs, rt, rd, shamt, funct} = ins_rd;
assign immed_val = ins_rd[15:0];
assign word_addr = ins_rd[25:0];

//program conuter
assign ins_addr = pc;
assign pc_puls_4 = pc + 4;
assign byte_addr = word_addr << 2;

always_ff @( posedge clk ) begin
    if(~rst_n)
        pc <= 0;
    else if(next_state == S_IF)
        if(Jump)
            pc <= {pc_puls_4[31:28], byte_addr};
        else
            pc <= (alu_zero_flag & Branch)? ((immed_val_ext <<< 2) + pc_puls_4) : pc_puls_4;
end

//rd_reg
assign reg_rd_0 = rs;
assign reg_rd_1 = rt;

//signed extend
assign immed_val_ext = immed_val;

//alu part
assign alu_in_0 = reg_data_rd_0;
assign alu_in_1 = ALUSrc? immed_val_ext : reg_data_rd_1;

//write back
assign reg_wr = RegDst? rd : rt;
assign reg_data_wr = MemtoReg? data_rd : alu_out;
assign reg_wr_en = (current_state == S_WB) & RegWrite;

assign data_wr_en = (current_state == S_WB) & MemWrite;
assign data_addr = alu_out;
assign data_wr = reg_rd_1;

reg_file reg_file_inst(
    .clk            (   clk     ),
    .rst_n          (   rst_n   ),

    .reg_wr_en      (   reg_wr_en       ),
    .reg_wr         (   reg_wr          ),
    .reg_data_wr    (   reg_data_wr     ),

    .reg_rd_0       (   reg_rd_0        ),
    .reg_rd_1       (   reg_rd_1        ),

    .reg_data_rd_0  (   reg_data_rd_0   ),
    .reg_data_rd_1  (   reg_data_rd_1   )
);

ins_decoder ins_decoder_inst(
    .clk        (   clk         ),
    .rst_n      (   rst_n       ),
    .ins        (   ins_rd      ),
    .RegDst     (   RegDst      ),
    .Jump       (   Jump        ),
    .Branch     (   Branch      ),
    .MemtoReg   (   MemtoReg    ),
    .alu_control(   alu_control ),
    .MemWrite   (   MemWrite    ),
    .ALUSrc     (   ALUSrc      ),
    .RegWrite   (   RegWrite    )
);

alu_signed alu_signed_inst(
    .clk        (   clk     ),
    .rst_n      (   rst_n   ),
    .alu_control(   alu_control ),
    .alu_in_0   (   alu_in_0    ),
    .alu_in_1   (   alu_in_1    ),

    .alu_out    (   alu_out         ),
    .zero_flag  (   alu_zero_flag   )
);

endmodule