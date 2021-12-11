`timescale 1ns/1ps

module alu_signed (
    input  logic                clk,
    input  logic                rst_n,
    input  logic        [3:0]   alu_control,
    input  logic signed [31:0]  alu_in_0,
    input  logic signed [31:0]  alu_in_1,

    output logic signed [31:0]  alu_out,
    output logic                zero_flag
);

localparam ALU_AND  = 4'b0000;
localparam ALU_OR   = 4'b0001;
localparam ALU_ADD  = 4'b0010;
localparam ALU_SUB  = 4'b0110;
localparam ALU_SLT  = 4'b0111;
localparam ALU_NOR  = 4'b1100;

// 0000    AND
// 0001    OR
// 0010    add
// 0110    subtract
// 0111    set on less than
// 1100    NOR

//assign zero_flag = (alu_out == 0);

always_ff @( posedge clk ) begin
    if(~rst_n) begin
        alu_out <= 0;
        zero_flag <= 0;
    end else begin
        case (alu_control)
            ALU_AND: alu_out <= alu_in_0 & alu_in_1;
            ALU_OR : alu_out <= alu_in_0 | alu_in_1;
            ALU_ADD: alu_out <= alu_in_0 + alu_in_1;
            ALU_SUB: alu_out <= alu_in_0 - alu_in_1;
            ALU_SLT: alu_out <= (alu_in_0 < alu_in_1)? 1 : 0;
            ALU_NOR: alu_out <= ~(alu_in_0 | alu_in_1);
            default: alu_out <= 0;
        endcase

        zero_flag <= (alu_control == ALU_SUB) & (alu_in_0 - alu_in_1 == 0);
    end
end

// always_comb begin
//     case (alu_control)
//         ALU_AND: alu_out = alu_in_0 & alu_in_1;
//         ALU_OR : alu_out = alu_in_0 | alu_in_1;
//         ALU_ADD: alu_out = alu_in_0 + alu_in_1;
//         ALU_SUB: alu_out = alu_in_0 - alu_in_1;
//         ALU_SLT: alu_out = (alu_in_0 < alu_in_1)? 1 : 0;
//         ALU_NOR: alu_out = ~(alu_in_0 | alu_in_1);
//         default: alu_out = 0;
//     endcase
// end

endmodule