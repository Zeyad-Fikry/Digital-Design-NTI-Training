module Alu #(
    parameter WIDTH        = 32,
    parameter RESULT_WIDTH = 32,
    parameter OPCODE_WIDTH = 3,
 
    // Opcodes
    parameter [OPCODE_WIDTH-1:0] OP_ADD = 3'b000,
    parameter [OPCODE_WIDTH-1:0] OP_SUB = 3'b001,
    parameter [OPCODE_WIDTH-1:0] OP_MUL = 3'b010,
    parameter [OPCODE_WIDTH-1:0] OP_AND = 3'b011,
    parameter [OPCODE_WIDTH-1:0] OP_OR  = 3'b100,
    parameter [OPCODE_WIDTH-1:0] OP_XOR = 3'b101
)(
    input  wire [WIDTH-1:0]        a,
    input  wire [WIDTH-1:0]        b,
    input  wire [OPCODE_WIDTH-1:0] opcode,
    output reg  [RESULT_WIDTH-1:0] result,
    output wire                    zero
);
 
    always @* begin
        case (opcode)
            OP_ADD  : result = a + b;     // direct add
            OP_SUB  : result = a - b;     // direct sub
            OP_MUL  : result = a * b;     // only LSBs kept if RESULT_WIDTH < 2*WIDTH
            OP_AND  : result = a & b;
            OP_OR   : result = a | b;
            OP_XOR  : result = a ^ b;
            default : result = {RESULT_WIDTH{1'b0}};
        endcase
    end
 
    assign zero = (result == {RESULT_WIDTH{1'b0}} && (opcode == OP_SUB));
 
 
endmodule