module Multiplexor_tb;

    parameter n_tb = 5;
    reg  [n_tb-1:0] in0_tb;
    reg  [n_tb-1:0] in1_tb;
    reg             sel_tb;
    wire [n_tb-1:0] mux_out_tb;

    // Unit Under Test
Multiplexor #(.n(n_tb)) uut (
    .in0(in0_tb),
    .in1(in1_tb),
    .sel(sel_tb),
    .mux_out(mux_out_tb)
);


    initial 
    begin
        // Test case 1
        $display("Test case 1:");
        sel_tb = 0; in0_tb = 5'b10101; in1_tb = 5'b00000;
        #10 
	$display("sel=%b, in0=%b, in1=%b, out=%b", sel_tb, in0_tb, in1_tb, mux_out_tb);

        // Test case 2
        $display("Test case 2:");
        sel_tb = 0; in0_tb = 5'b01010; in1_tb = 5'b00000;
        #10 
	$display("sel=%b, in0=%b, in1=%b, out=%b", sel_tb, in0_tb, in1_tb, mux_out_tb);

        // Test case 3
        $display("Test case 3:");
        sel_tb = 1; in0_tb = 5'b00000; in1_tb = 5'b10101;
        #10 
	$display("sel=%b, in0=%b, in1=%b, out=%b", sel_tb, in0_tb, in1_tb, mux_out_tb);

        // Test case 4
        $display("Test case 4:");
        sel_tb = 1; in0_tb = 5'b00000; in1_tb = 5'b01010;
        #10 
	$display("sel=%b, in0=%b, in1=%b, out=%b", sel_tb, in0_tb, in1_tb, mux_out_tb);

        $stop; 
    end
endmodule
