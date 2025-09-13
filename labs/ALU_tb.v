module ALU_tb;

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


 reg [WIDTH-1:0]        a,
 reg [WIDTH-1:0]        b,
 reg [OPCODE_WIDTH-1:0] opcode,
 wire  [RESULT_WIDTH-1:0] result,
 wire                    zero
    // Unit Under Test
ALU #(.WIDTH(WIDTH)) uut (
    .a(a),
    .b(b),
    .opcode(opcode),
    .result(result)
);


task re_checker;
input [RESULT_WIDTH-1:0] exp_result;
input                     exp_zero;
    begin
        if (expec_res == result && expec_flag == zero )
            $display("pass")
        else
            $display("fail")
    end

endtask


task drive_inputs;
input [WIDTH-1:0]        ain;
input [WIDTH-1:0]        bin;
input [OPCODE_WIDTH-1:0] op;
    begin
        a = op1 ;
        b = op2 ;
        opcode = opcode ;
    end

endtask

    initial 
    begin
        Drive(1 , 2 , 0 );
        re_checker(3 , 0);
        #10
        Drive(5 , 2 , 0 );
        re_checker(7 , 0);
        #10

        $stop; 
    end
endmodule
