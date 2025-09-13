module tri_state_buffer_tb;

    parameter WIDTH_tb = 5;
    reg  [WIDTH_tb-1:0] data_in_tb;
    reg  [WIDTH_tb-1:0] data_en_tb;
    wire [WIDTH_tb-1:0] data_out_tb;

    tri_state_buffer #(.WIDTH(WIDTH_tb)) uut (
    .data_in(data_in_tb),
    .data_en(data_en_tb),
    .data_out(data_out_tb)
);


    initial 
    begin
        // Test case 1
        $display("Test case 1:");
        data_en = 0; data_in = xxxxxxxx;
        #10
        $display("At time 1 data_en=%b data_in=%b data_out=%b", data_en, data_in, data_out);

        // Test case 2
        $display("Test case 2:");
        data_en = 1; data_in = 01010101;
        #10 
        $display("At time 2 data_en=%b data_in=%b data_out=%b", data_en, data_in, data_out);

        // Test case 3
        $display("Test case 3:");
        data_en = 1; data_in = 10101010;
        #10 
        $display("At time 3 data_en=%b data_in=%b data_out=%b", data_en, data_in, data_out);
        $stop; 
    end
endmodule
