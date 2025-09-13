module LFSR #(parameter WIDTH = 4) (
    input  arst_n,
    input  clk,
    input en,
    input si,
    output reg [WIDTH-1:0]q
);
always @(posedge clk or negedge arst_n)
    begin 
    if (!arst_n)
        q <= {4{1'b0}};
    else if (en)
        if (en == 0)
            si = q[0] ^ q[1];
            q <= {q[WIDTH-1:0], si};
        else 
            q <= {q[WIDTH-1:0], si};

    else 

    end
endmodule