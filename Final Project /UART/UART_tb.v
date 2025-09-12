module UART_tb;

parameter CLK_PERIOD = 10;  // 10ns period = 100 MHz
parameter WIDTH = 8;

// Testbench signals
reg clk;
reg reset;
reg [WIDTH-1:0] tx_data;
reg tx_en;
wire tx;
wire tx_busy;
wire tx_done;

wire [WIDTH-1:0] rx_data;
wire rx_data_valid;
wire rx_busy;

// Connect rx to tx 
wire rx = tx;

// Instantiate UART module
UART #(.WIDTH(WIDTH)) uut (
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .tx(tx),
    .tx_data(tx_data),
    .tx_en(tx_en),
    .tx_busy(tx_busy),
    .tx_done(tx_done),
    .rx_data(rx_data),
    .rx_data_valid(rx_data_valid),
    .rx_busy(rx_busy)
);

// Clock generation
initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end

// Test stimulus
initial begin
    // Initialize signals
    reset = 1'b1;
    tx_data = 8'b00000000;
    tx_en = 1'b0;
    
    // Wait for a few clock cycles
    #(5 * CLK_PERIOD);
    
    // Release reset
    reset = 1'b0;
    #(5 * CLK_PERIOD);
    
    // Test: Transmit one frame
    $display("=== Test: Transmitting ===");
    tx_data = 8'b11011011;
    tx_en = 1'b1;
    wait (tx_done);              // wait for TX to finish
    tx_en = 1'b0;
    wait (rx_data_valid);       // Wait until RX data valid

    $display("=== Test Completed ===");
    $display("Final TX state: tx=%b, tx_busy=%b, tx_done=%b", tx, tx_busy, tx_done);
    $display("Final RX state: rx_data=0x%b, rx_valid=%b, rx_busy=%b", rx_data, rx_data_valid, rx_busy);
    $display("Time: %0t, tx=%b, tx_busy=%b, tx_done=%b, rx_data=0x%b, rx_valid=%b, rx_busy=%b", 
             $time, tx, tx_busy, tx_done, rx_data, rx_data_valid, rx_busy);
    $display("TEST COMPLETED: RX = %b, TX = %b,", rx_data , tx_data);
    $stop;
end



always @(posedge tx_done) begin
    $display("*** TX DONE at time %0t", $time);
end

always @(posedge rx_data_valid ) begin
    $display("*** RX DATA VALID at %0t: 0x%b ", $time, rx_data, );
    if (rx_data === tx_data)
        $display("  PASS: RX matches TX ");
    else
        $display("  waiting for TX to finish ");
end

// // Monitor signals
// initial begin
//     $monitor("Time: %0t, tx=%b, tx_busy=%b, tx_done=%b, rx_data=0x%h, rx_valid=%b, rx_busy=%b", 
//              $time, tx, tx_busy, tx_done, rx_data, rx_data_valid, rx_busy);
// end

endmodule
