`timescale 1ns/1ps

module UART_RX_tb;

    // Parameters
    localparam WIDTH = 8;
    localparam CLK_PERIOD = 10; // 100 MHz clock
    localparam BAUD_PERIOD = 10417; // 9600 baud = 10417 clock cycles

    // DUT ports
    reg clk;
    reg reset;
    reg rx;
    wire [WIDTH-1:0] data;
    wire data_valid;
    wire busy;

    // Instantiate DUT
    UART_RX #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data(data),
        .data_valid(data_valid),
        .busy(busy)
    );



    // Clock generation
    initial clk = 1'b0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Monitor for data reception
    always @(*) begin
        if (data_valid) begin
            $display("Time %0t: *** DATA RECEIVED: %b ***", $time, data);
        end
    end
     
     always @(* ) begin
         case (dut.u_fsm.cs)
             3'b000: $display("Time %0t: FSM State = IDLE", $time);
             3'b001: $display("Time %0t: FSM State = START", $time);
             3'b010: $display("Time %0t: FSM State = DATA (bit_count=%d, byte_complete=%b)", $time, dut.u_SIPO_shift_register.bit_count, dut.u_SIPO_shift_register.byte_complete);
             3'b011: $display("Time %0t: FSM State = STOP (rx=%b)", $time, rx);
             3'b100: $display("Time %0t: FSM State = ERR", $time);
             3'b101: $display("Time %0t: FSM State = DONE", $time);
             default: $display("Time %0t: FSM State = UNKNOWN (%b)", $time, dut.u_fsm.cs);
         endcase
     end

    // Main test sequence
    initial begin
        $display("=== UART_RX Simple Testbench ===");
        
        // Initialize
        reset = 1'b1;
        rx = 1'b1; 
        repeat(BAUD_PERIOD) @(posedge clk);
        // Reset sequence
        repeat(10) @(posedge clk);
        reset = 1'b0;
        repeat(10) @(posedge clk);
        //---------------------------------------------------------------

        $display("Time %0t: Sending 10101010 ", $time);
        
        // Start bit (0)
        rx = 1'b0;
        repeat(BAUD_PERIOD) @(posedge clk);
        
        // Data bits (LSB first)  10101010 
        rx = 1'b0; // bit 0
        repeat(BAUD_PERIOD) @(posedge clk);
        rx = 1'b1; // bit 1
        repeat(BAUD_PERIOD) @(posedge clk);
        rx = 1'b0; // bit 2
        repeat(BAUD_PERIOD) @(posedge clk);
        rx = 1'b1; // bit 3
        repeat(BAUD_PERIOD) @(posedge clk);
        rx = 1'b0; // bit 4
        repeat(BAUD_PERIOD) @(posedge clk);
        rx = 1'b1; // bit 5
        repeat(BAUD_PERIOD) @(posedge clk);
        rx = 1'b0; // bit 6
        repeat(BAUD_PERIOD) @(posedge clk);
        rx = 1'b1; // bit 7
        repeat(BAUD_PERIOD) @(posedge clk);
        
        // Stop bit (1)
        rx = 1'b1;
        repeat(BAUD_PERIOD) @(posedge clk);
        
        $display("Time %0t: Frame transmission complete", $time);
        repeat(20) @(posedge clk);

        //---------------------------------------------------------------


        // $display("Time %0t: Sending frame with wrong stop bit", $time);
        
        // // Start bit (0)
        // rx = 1'b0;
        // repeat(BAUD_PERIOD) @(posedge clk);
        
        // // Data bits (LSB first) 
        // rx = 1'b0; // bit 0
        // repeat(BAUD_PERIOD) @(posedge clk);
        // rx = 1'b1; // bit 1
        // repeat(BAUD_PERIOD) @(posedge clk);
        // rx = 1'b0; // bit 2
        // repeat(BAUD_PERIOD) @(posedge clk);
        // rx = 1'b1; // bit 3
        // repeat(BAUD_PERIOD) @(posedge clk);
        // rx = 1'b0; // bit 4
        // repeat(BAUD_PERIOD) @(posedge clk);
        // rx = 1'b1; // bit 5
        // repeat(BAUD_PERIOD) @(posedge clk);
        // rx = 1'b0; // bit 6
        // repeat(BAUD_PERIOD) @(posedge clk);
        // rx = 1'b1; // bit 7
        // repeat(BAUD_PERIOD) @(posedge clk);
        
        // // Wrong stop bit (0 instead of 1)
        // rx = 1'b0;  // This should cause ERR state
        // repeat(BAUD_PERIOD) @(posedge clk);

        //-------------------------------------------------------------
        $display("Time %0t: Frame with wrong stop bit complete", $time);
        repeat(20) @(posedge clk);
        
        $display("=== Testbench Completed ===");
        $stop;
    end


endmodule
