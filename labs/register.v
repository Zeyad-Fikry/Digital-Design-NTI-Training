module register #(parameter WIDTH = 8) (
    input  rst,
    input  clk,
    input [WIDTH-1:0]data_in,
    input load,
    output reg [WIDTH-1:0]data_out
);
    always @(posedge clk )
        begin 
            if(!rst && load == 1)
                data_out = data_in ;
            else
                data_out = {WIDTH{1'b0}};

    end
endmodule