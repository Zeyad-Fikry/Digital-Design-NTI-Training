module Data_Driver #(
    parameter WIDTH = 8
)(
    input  [WIDTH-1:0] data_in,
    input          data_en,
    output reg [WIDTH-1:0] data_out
);

always @(*) begin
    case (data_en)
        1'b0: data_out = 8'bzzzzzzzz;
        1'b1: data_out = data_in;
    endcase
end

endmodule
