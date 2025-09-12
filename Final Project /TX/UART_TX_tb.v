module UART_TX_tb;

parameter CLK_PERIOD = 10;  // 10ns period = 100 MHz


reg clk;
reg reset;
reg [7:0] data;
reg tx_en;
wire tx;
wire busy;
wire done;

// Instantiate UART_TX module
UART_TX uut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .tx_en(tx_en),
    .tx(tx),
    .busy(busy),
    .done(done)
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
    data = 8'b11111111;
    tx_en = 1'b0;
    
    #(5 * CLK_PERIOD);
    reset = 1'b0;
    #(5 * CLK_PERIOD);
    
    // Test: Transmit byte 
    $display("Test: Transmitting data=%b",data );
    #(1* 10417 *CLK_PERIOD);
    data = 8'b10101001;  
    tx_en = 1'b1;
    #CLK_PERIOD;
    
    // Wait for transmission to complete (10 bits * 10417 cycles per bit)
    #(10 * 10417 * CLK_PERIOD);
    // #( 10417 *CLK_PERIOD);
    reset = 1'b1;    
    #(5 * CLK_PERIOD);
    reset = 1'b0;
    #(5 * CLK_PERIOD);
    $display("Transmission complete");
    $display("Test completed");
    $stop;
end

// Monitor signals
initial begin
    $monitor("Time: %0t, tx=%b, busy=%b, done=%b, data=%b", 
             $time, tx, busy, done, data);
end

endmodule
