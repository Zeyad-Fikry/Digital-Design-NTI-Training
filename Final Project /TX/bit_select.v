module bit_select (
    input clk,
    input reset,
    input baud_tick,
    input frame_ready,
    output reg [3:0] bit_select
);

// Reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        bit_select <= 4'b0000;
    end
end

// Bit selection logic
always @(posedge clk) begin
    if (frame_ready) begin
        if (baud_tick) begin
            if (bit_select >= 4'd1 && bit_select <= 4'd8) begin
                bit_select <= bit_select + 1'b1;
            end 
            else if (bit_select == 4'd8) begin
                bit_select <= 4'd1;
            end 
            else begin
                bit_select <= 4'd1;
            end
        end
    end 
    else begin
        bit_select <= 4'b0000;
    end
end

endmodule
