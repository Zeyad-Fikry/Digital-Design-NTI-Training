module alu1 #(
    parameter WIDTH        = 8,
    parameter RESULT_WIDTH = 8,
    parameter OPCODE_WIDTH = 3,
 
    // Opcodes
    parameter [OPCODE_WIDTH-1:0] OP_HLT = 3'b000,
    parameter [OPCODE_WIDTH-1:0] OP_SKZ = 3'b001,
    parameter [OPCODE_WIDTH-1:0] OP_ADD = 3'b010,
    parameter [OPCODE_WIDTH-1:0] OP_AND = 3'b011,
    parameter [OPCODE_WIDTH-1:0] OP_XOR = 3'b100,
    parameter [OPCODE_WIDTH-1:0] OP_LDA = 3'b101,
    parameter [OPCODE_WIDTH-1:0] OP_STO = 3'b110,
    parameter [OPCODE_WIDTH-1:0] OP_JMP = 3'b111
)(
    input  wire [WIDTH-1:0]        in_a,
    input  wire [WIDTH-1:0]        in_b,
    input  wire [OPCODE_WIDTH-1:0] opcode,
    output reg  [RESULT_WIDTH-1:0] alu_out,
    output wire                    a_is_zero
);
 
    always @* begin
        case (opcode)
            OP_HLT  : in_a => alu_out;     
            OP_SKZ  : in_a => alu_out;     
            OP_ADD  : in_a + in_b => alu_out;     
            OP_AND  : in_a & in_b => alu_out;
            OP_XOR  : in_a ^ in_b => alu_out;
            OP_LDA  : in_b => alu_out;
            OP_STO  : in_a => alu_out;
            OP_JMP  : in_a => alu_out;
        endcase
    end
 
    assign a_is_zero = (alu_out == {RESULT_WIDTH{1'b0}} && (opcode == OP_SUB));
 
 
endmodule