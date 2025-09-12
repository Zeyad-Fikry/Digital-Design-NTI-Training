module baud_counter_TX (
    input clk,
    input reset,
    input frame_ready,
    output reg baud_tick,
    output reg done
);

// Baud rate calculation: 100MHz / 9600 baud = 10417
parameter BAUD_DIV = 10417;
parameter BITS_PER_FRAME = 10;   // 10 bits per UART frame (start + 8 bit data + stop)

reg [13:0] baud_count;
reg [3:0] bit_count;

// Reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        baud_count <= 14'b00000000000000;
        bit_count <= 4'b0000;
        baud_tick <= 1'b0;
        done <= 1'b0;
    end
end


always @(posedge clk) begin
    if (frame_ready) begin

        if (baud_count < BAUD_DIV - 1) begin
            baud_count <= baud_count + 1'b1;
            baud_tick <= 1'b0;
        end 
        else begin
            baud_count <= 14'b00000000000000;
            baud_tick <= 1'b1;
        end
        
    end 
    else begin
        baud_count <= 14'b00000000000000;
        baud_tick <= 1'b0;
    end
end


always @(posedge clk) begin
    if (reset) begin
        bit_count <= 4'b0000;
        done <= 1'b0;
    end 
    else if (frame_ready) begin
        if (baud_tick) begin
            if (bit_count < BITS_PER_FRAME - 2) begin
                bit_count <= bit_count + 1'b1;
                done <= 1'b0;
            end 
            else begin
                bit_count <= 4'b0000;
                done <= 1'b1;
            end
        end
    end 
    else begin
        bit_count <= 4'b0000;
        done <= 1'b0;
    end
end

endmodule

//
//
//