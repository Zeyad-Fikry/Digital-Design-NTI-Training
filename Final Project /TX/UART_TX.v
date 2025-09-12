module UART_TX (
    input clk,
    input reset,
    input [7:0] data,
    input tx_en,
    output tx,
    output busy,
    output done
);

// wires
wire [9:0] frame_data;
wire frame_ready;
wire baud_tick;
wire [3:0] bit_select;

// Frame module instantiation
frame u_frame  (
    .clk(clk),
    .reset(reset),
    .data(data),
    .tx_en(tx_en),
    .frame_out(frame_data),
    .frame_ready(frame_ready)
);

// Baud counter module instantiation
baud_counter_TX u_baud_counter_TX  (
    .clk(clk),
    .reset(reset),
    .frame_ready(frame_ready),
    .baud_tick(baud_tick),
    .done(done)
);

// Bit select module instantiation
bit_select u_bit_select  (
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick),
    .frame_ready(frame_ready),
    .bit_select(bit_select)
);

// Multiplexer module instantiation
multiplexer u_multiplexer  (
    .clk(clk),
    .reset(reset),
    .frame_data(frame_data),
    .bit_select(bit_select),
    .frame_ready(frame_ready),
    .tx_out(tx),
    .busy(busy)
);

endmodule
