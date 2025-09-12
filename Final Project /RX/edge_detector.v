module edge_detector (  //Falling Edge Detection 
    input clk,
    input reset,
    input rx,
    output reg edge_out
);

    // State +_
    localparam IDLE = 1'b0;
    localparam START = 1'b1; 

    reg cs, ns; 

    // Always block 1
    always @(posedge clk or posedge reset) begin
        if (reset)
            cs <= IDLE;
        else
            cs <= ns;
    end

    // Always block 2: Next state logic
    always @(*) begin
        case (cs)
            IDLE: begin
                if (~rx)  
                    ns = START;
                else
                    ns = IDLE;
            end
            
            START: begin
                if (rx)   
                    ns = IDLE;
                else
                    ns = START;
            end
            
            default: ns = IDLE;
        endcase
    end

    // Always block 3: Output logic (Mealy: depends on state + input)
    always @(*) begin
        case (cs)
            IDLE: begin
                edge_out = (~rx) ? 1'b1 : 1'b0;
            end
            
            START: begin
                edge_out = 1'b0;
            end
            
            default: edge_out = 1'b0;
        endcase
    end

endmodule