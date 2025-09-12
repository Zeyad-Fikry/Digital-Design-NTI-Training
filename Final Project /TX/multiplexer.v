module multiplexer (
    input clk,
    input reset,
    input [9:0] frame_data,
    input [3:0] bit_select,
    input frame_ready,
    output reg tx_out,
    output reg busy
);


always @(posedge clk or posedge reset) begin
    if (reset) begin
        tx_out <= 1'b1;   // default
        busy <= 1'b0;
    end
end



always @(posedge clk) begin
    if (frame_ready) begin
        case (bit_select)
            4'b0000: tx_out <= frame_data[0];   // start bit
            4'b0001: tx_out <= frame_data[1];   // data bit 0
            4'b0010: tx_out <= frame_data[2];   // data bit 1
            4'b0011: tx_out <= frame_data[3];   // data bit 2
            4'b0100: tx_out <= frame_data[4];   // data bit 3
            4'b0101: tx_out <= frame_data[5];   // data bit 4
            4'b0110: tx_out <= frame_data[6];   // data bit 5
            4'b0111: tx_out <= frame_data[7];   // data bit 6
            4'b1000: tx_out <= frame_data[8];   // data bit 7
            4'b1001: tx_out <= frame_data[9];   // stop bit
            default: tx_out <= 1'b1;            // default to idle
        endcase
    end else begin
        tx_out <= 1'b1;
        busy <= 1'b0;     // idle state when no frame ready
    end
end

always @(posedge clk) begin
    if (reset) begin
        busy <= 1'b0;
    end else if (frame_ready) begin
        busy <= 1'b1;
    end else begin
        busy <= 1'b0;
    end
end

endmodule
