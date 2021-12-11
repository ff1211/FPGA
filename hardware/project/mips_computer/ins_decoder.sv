`timescale 1ns/1ps

module ins_decoder (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [31:0] ins,

    output logic        RegDst,
    output logic        Jump,
    output logic        Branch,
    output logic        MemtoReg,
    output logic [3:0]  alu_control,
    output logic        MemWrite,
    output logic        ALUSrc,
    output logic        RegWrite
);

localparam OP_R_TYPE    = 6'b000_000;
localparam OP_LOAD      = 6'b100_011;
localparam OP_STORE     = 6'b101_011;
localparam OP_BRANCH    = 6'b000_100;
localparam OP_JUMP      = 6'b000_010;
localparam OP_ADDI      = 6'b001_000;

localparam FUNCT_AND    = 6'b100_100;
localparam FUNCT_OR     = 6'b100_101;
localparam FUNCT_ADD    = 6'b100_000;
localparam FUNCT_SUB    = 6'b100_010;
localparam FUNCT_SLT    = 6'b101_010;

localparam ALU_AND      = 4'b0000;
localparam ALU_OR       = 4'b0001;
localparam ALU_ADD      = 4'b0010;
localparam ALU_SUB      = 4'b0110;
localparam ALU_SLT      = 4'b0111;
localparam ALU_NOR      = 4'b1100;
localparam ALU_FALSE    = 4'b1111;

logic [5:0]     opcode;
logic [4:0]     rs;
logic [4:0]     rt;
logic [4:0]     rd;
logic [4:0]     shamt;
logic [5:0]     funct;
logic [15:0]    immed_val;
logic [25:0]    word_addr;

assign {opcode, rs, rt, rd, shamt, funct} = ins;
assign immed_val = ins[15:0];
assign word_addr = ins[25:0];

always_ff @( posedge clk ) begin
    if(~rst_n) begin
        RegDst      <= 0;
        ALUSrc      <= 0;
        MemtoReg    <= 0;
        RegWrite    <= 0;
        MemWrite    <= 0;
        Branch      <= 0;
        Jump        <= 0;
        alu_control <= 0;
    end else begin
        RegDst   <= (opcode == OP_R_TYPE);
        ALUSrc   <= (opcode == OP_STORE) | (opcode == OP_LOAD) | (opcode == OP_ADDI);
        MemtoReg <= (opcode == OP_LOAD);
        RegWrite <= (opcode == OP_R_TYPE) | (opcode == OP_LOAD) | (opcode == OP_ADDI);
        MemWrite <= (opcode == OP_STORE);
        Branch   <= (opcode == OP_BRANCH);
        Jump     <= (opcode == OP_JUMP);

        if(opcode == OP_R_TYPE)
            case (funct)
                FUNCT_AND: alu_control = ALU_AND;
                FUNCT_OR : alu_control = ALU_OR;
                FUNCT_ADD: alu_control = ALU_ADD;
                FUNCT_SUB: alu_control = ALU_SUB;
                FUNCT_SLT: alu_control = ALU_SLT;
                default  : alu_control = ALU_FALSE;
            endcase
        else if(opcode == OP_BRANCH)
            alu_control = ALU_SUB;
        else
            alu_control = ALU_ADD;        
    end
end

// assign RegDst   = (opcode == OP_R_TYPE);
// assign ALUSrc   = opcode[5];
// assign MemtoReg = opcode[5];
// assign RegWrite = (opcode == OP_R_TYPE) | (opcode == OP_LOAD);
// assign MemRead  = (opcode == OP_LOAD);
// assign MemWrite = (opcode == OP_STORE);
// assign Branch   = (opcode == OP_BRANCH);
// assign Jump     = (opcode == OP_JUMP);

// always_comb begin
//     if(opcode == OP_R_TYPE)
//         case (funct)
//             FUNCT_AND: alu_control = ALU_AND;
//             FUNCT_OR : alu_control = ALU_OR;
//             FUNCT_ADD: alu_control = ALU_ADD;
//             FUNCT_SUB: alu_control = ALU_SUB;
//             FUNCT_SLT: alu_control = ALU_SLT;
//             default  : alu_control = ALU_FALSE;
//         endcase
//     else if(opcode == OP_BRANCH)
//         alu_control = ALU_SUB;
//     else
//         alu_control = ALU_ADD;
// end
    
endmodule