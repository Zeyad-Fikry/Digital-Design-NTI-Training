module UART_RX #( // TOP LEVEL MODULE
    parameter WIDTH = 8
)(
    input clk,
    input reset,
    input rx,
    output [WIDTH-1:0] data,
    output data_valid,
    output busy
);

    // Wires
    wire edge_out;
    wire baud_out;
    wire enable_baud;
    wire enable_SIPO;
    wire start_counting;
    wire byte_complete;

    // Edge detector:
    edge_detector u_edge_detector (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .edge_out(edge_out)
    );

    // Baud counter:
    baud_counter u_baud_counter (
        .clk(clk),
        .reset(reset),
        .enable(enable_baud),
        .start_counting(start_counting),
        .baud_out(baud_out)
    );

    // FSM:
    FSM u_fsm (
        .clk(clk),
        .reset(reset),
        .edge_out(edge_out),
        .baud_out(baud_out),
        .byte_complete(byte_complete),
        .rx(rx),
        .enable_baud(enable_baud),
        .enable_SIPO(enable_SIPO),
        .start_counting(start_counting),
        .data_valid(data_valid)
    );

    // SIPO shift register:
    SIPO_shift_register #(.WIDTH(WIDTH)) u_SIPO_shift_register  (
        .clk(clk),
        .reset(reset),
        .baud_out(baud_out),
        .enable_SIPO(enable_SIPO),
        .rx(rx),
        .data(data),
        .busy(busy),
        .byte_complete(byte_complete)
    );

endmodule


