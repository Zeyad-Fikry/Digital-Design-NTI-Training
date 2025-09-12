module UART #(
    parameter WIDTH = 8
)(
    // Clock and Reset
    input clk,
    input reset,
    
    // UART Interface
    input rx,                    // Serial receive input
    output tx,                   // Serial transmit output
    
    // Transmit Interface
    input [WIDTH-1:0] tx_data,   // Data to transmit
    input tx_en,                 // Transmit enable
    output tx_busy,              // Transmit busy signal
    output tx_done,              // Transmit done signal
    
    // Receive Interface
    output [WIDTH-1:0] rx_data,  // Received data
    output rx_data_valid,        // Received data valid
    output rx_busy               // Receive busy signal
);

// UART TX Module Instantiation
UART_TX uart_tx (
    .clk(clk),
    .reset(reset),
    .data(tx_data),
    .tx_en(tx_en),
    .tx(tx),
    .busy(tx_busy),
    .done(tx_done)
);

// UART RX Module Instantiation
UART_RX #(.WIDTH(WIDTH)) uart_rx (
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .data(rx_data),
    .data_valid(rx_data_valid),
    .busy(rx_busy)
);

endmodule
