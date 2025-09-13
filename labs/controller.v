module controller #(
    parameter WIDTH        = 3,
    parameter OPCODE_WIDTH = 3,
 
    // Opcodes
    parameter [OPCODE_WIDTH-1:0] INST_ADDR = 3'b000,
    parameter [OPCODE_WIDTH-1:0] INST_FETCH = 3'b001,
    parameter [OPCODE_WIDTH-1:0] INST_LOAD = 3'b010,
    parameter [OPCODE_WIDTH-1:0] IDLE = 3'b011,
    parameter [OPCODE_WIDTH-1:0] OP_ADDR= 3'b100,
    parameter [OPCODE_WIDTH-1:0] OP_FETCH = 3'b101,
    parameter [OPCODE_WIDTH-1:0] ALU_OP = 3'b110,
    parameter [OPCODE_WIDTH-1:0] STORE = 3'b111
)(
    input  wire [WIDTH-1:0]        phase,
    input  wire [OPCODE_WIDTH-1:0] opcode,
    input  wire                    zero,
    output reg sel, rd, ld_ir, inc_pc, halt, ld_pc, data_e, ld_ac, wr         
);
    always @* begin
        
        sel    = 0 ;
        rd     = 0 ;
        ld_ir  = 0 ;
        inc_pc = 0 ;
        halt   = 0 ;
        ld_pc  = 0 ;
        data_e = 0 ;
        ld_ac  = 0 ;
        wr     = 0 ;
        case (phase)
            INST_ADDR  :
                sel    = 1 ;     
            INST_FETCH  : 
                sel    = 1 ; 
                ld_ir  = 1 ;     
            INST_LOAD  : 
                sel    = 1 ; 
                ld_ir  = 1 ;  
                inc_pc = 1 ;   
            IDLE  : 
                sel    = 1 ; 
                ld_ir  = 1 ;  
                inc_pc = 1 ; 
            OP_ADDR  : 
                if (opcode == OP_HLT)
                    halt = 1;
                ld_pc  = 1 ;
            OP_FETCH  : 
                if (opcode == OP_ADD || opcode == OP_AND || opcode == OP_XOR || opcode == OP_LDA )
                    rd = 1;
                data_e = 1 ;
            ALU_OP  : 
                if (opcode == OP_ADD || opcode == OP_AND || opcode == OP_XOR || opcode == OP_LDA )
                    rd = 1;
                else if (opcode == OP_SKZ &&  zero )
                    inc_pc = 1;
                else if (opcode == OP_JMP )
                    ld_pc = 1;
                else if (opcode == OP_STO)
                    data_e = 1;
            STORE  : 
                if (opcode == OP_ADD || opcode == OP_AND || opcode == OP_XOR || opcode == OP_LDA )
                    rd = 1;
                else if (opcode == OP_ADD || opcode == OP_AND || opcode == OP_XOR || opcode == OP_LDA )
                        ld_ac = 1;
                else if (opcode == OP_JMP )
                    ld_pc = 1;
                else if (opcode == OP_STO)
                    wr = 1;
                else if (opcode == OP_STO)
                    data_e = 1;
                
        endcase
    end
// assign a_is_zero = (in_a == {WIDTH{1'b0}});


 
endmodule