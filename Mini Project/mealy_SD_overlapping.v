module mealy_SD_overlapping ( //mealy_sequence_detector_overlapping
    input clk,
    input reset,
    input x,  
    output reg y
);
    // One-hot encoding
    localparam  A=6'b000001,
                B=6'b000010,
                C=6'b000100,
                D=6'b001000,
                E=6'b010000,
                F=6'b100000;
    reg [5:0] cs, ns;
    
    always @ (posedge clk or posedge reset)begin
        if(reset)
            cs <= A;
        else 
            cs <= ns;
        end

    always @ * begin
        y = 0;
        case(cs)
            A: 
                if(x)
                    ns = B;
                else 
                    ns = A;
            B: 
                if(x)
                    ns = C;
                else 
                    ns = A;
            C: 
                if(x)
                    ns = C;
                else 
                    ns = D;
            D: 
                if(x)
                    ns = E;
                else 
                    ns = A;
            E: 
                if(x)
                    ns = C;
                else 
                    ns = F;
            F: 
                if(x)begin
                    ns = B;
                    y = 1;
                end
                else 
                    ns = A;
            
            default: ns = A;
        endcase
    end

endmodule
