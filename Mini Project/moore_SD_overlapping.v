
module moore_SD_overlapping ( //moore_sequence_detector_overlapping
    input clk,
    input reset,
    input x,  
    output reg y
);
    // One-hot encoding
    localparam  A=7'b0000001,
                B=7'b0000010,
                C=7'b0000100,
                D=7'b0001000,
                E=7'b0010000,
                F=7'b0100000,
                G=7'b1000000;
    reg [6:0]cs,ns;

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
                if(x)
                    ns = G;
                else 
                    ns = A;
            G:begin
                y = 1;
                if(x)
                    ns = C;
                else 
                    ns = A;
            end
            default: ns = A;
        endcase
    end

endmodule

