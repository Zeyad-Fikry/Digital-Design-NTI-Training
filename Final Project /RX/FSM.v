module FSM (
    input clk,     
    input reset,        
    input edge_out,        
    input baud_out,
    input byte_complete,
    input rx,        
    output reg enable_baud,       
    output reg enable_SIPO,   
    output reg start_counting,
    output reg data_valid

);
    localparam  IDLE  = 3'b000,
                START = 3'b001, 
                DATA  = 3'b010,
                STOP  = 3'b011,
                ERR   = 3'b100, 
                DONE  = 3'b101;

    reg [2:0] cs, ns;


    always @ (posedge clk or posedge reset) begin
        if (reset)begin
            cs <= IDLE;
        end else begin
            cs <= ns;
        end
    end

    
    always @(*) begin
        case (cs)
            IDLE: begin
                if (edge_out)
                    ns = START;
                else
                    ns = IDLE;
            end

            START: begin
                if (baud_out)
                    ns = DATA;
                else
                    ns = START;
            end

            DATA: begin
                if (byte_complete)
                    ns = STOP;
                else
                    ns = DATA;
            end

            STOP: begin
                if (baud_out) begin
                    if (rx == 1'b1)
                        ns = DONE;  // Stop bit is correct (high)
                    else
                        ns = ERR;   // Stop bit is wrong (low)
                end else
                    ns = STOP;
            end

            ERR:begin
                ns=ERR;
            end

            DONE:begin
                ns=DONE;
            end

            default: begin
                ns = IDLE;
            end
        endcase
    end

    
    always @(*) begin
        // Default outputs
        enable_baud    = 1'b0;
        enable_SIPO    = 1'b0;
        start_counting = 1'b0;
        data_valid     = 1'b0;
        
        case (cs)
            IDLE: begin
                enable_baud     = 1'b0;
                enable_SIPO     = 1'b0;
                start_counting  = 1'b0;
                data_valid      = 1'b0;
            end
            
            START: begin
                enable_baud     = 1'b1;
                enable_SIPO     = 1'b0;
                start_counting  = 1'b1;  // start down counting
                data_valid      = 1'b0;
            end
            
            DATA: begin
                enable_baud     = 1'b1;
                enable_SIPO     = 1'b1;  // Enable shift register
                start_counting  = 1'b0;
                data_valid      = 1'b0;
            end
            
            STOP: begin
                enable_baud     = 1'b1;
                enable_SIPO     = 1'b0; 
                start_counting  = 1'b0;
                data_valid      = 1'b0;
            end
            
            ERR: begin
                enable_baud     = 1'b0;
                enable_SIPO     = 1'b0;
                start_counting  = 1'b0;
                data_valid      = 1'b0;  // No valid data on error
            end
            
            DONE: begin
                enable_baud     = 1'b0;
                enable_SIPO     = 1'b0;
                start_counting  = 1'b0;
                data_valid      = 1'b1;  // Valid data only in DONE state
            end
        endcase
    end    
endmodule

//
//
//
//