
module SIPO_shift_register #(
    parameter WIDTH = 8
)(
    input clk,
    input reset,
    input baud_out,
    input enable_SIPO,
    input rx,
    output reg [WIDTH-1:0] data,
    output reg busy,
    output reg byte_complete
);

    reg [WIDTH-1:0] shift_reg;
    reg [3:0] bit_count; // 0-7


    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= {WIDTH{1'b0}};
            bit_count <= 4'd0;
            busy <= 1'b0;
            byte_complete <= 1'b0;
        end 
        else if (enable_SIPO && baud_out) begin
            // LSB-first: newest bit enters MSB side via right shift
            shift_reg <= {rx, shift_reg[WIDTH-1:1]};
            //---
            if (bit_count == 4'd0)
                busy <= 1'b1;
            //---
            if (bit_count == WIDTH-1) begin
                bit_count <= 4'd0;
                busy <= 1'b0;
                byte_complete <= 1'b1;  // Signal completion
            end 
            else begin
                bit_count <= bit_count + 1'd1;
            end
        end
    end


    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= {WIDTH{1'b0}};
        end else if (enable_SIPO && baud_out && (bit_count == WIDTH-1)) begin
            data <= {rx, shift_reg[WIDTH-1:1]};
        end
    end


endmodule


