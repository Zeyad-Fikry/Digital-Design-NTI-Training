`timescale 1ps/1ps
module moore_SD_overlapping_tb; 

    reg clk;
    reg reset;
    reg x;
    wire y;

    // Instantiate the DUT
    moore_SD_overlapping dut(
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y)
    );

    // Clock generation
    initial clk=0;
    always #5 clk=~clk;
    
    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        x = 0;
        
        // Apply reset
        #10 reset = 0;
        
        // Test case 1: Exact sequence "110101" - should detect once
        #10 x = 1;  // B
        #10 x = 1;  // C
        #10 x = 0;  // D
        #10 x = 1;  // E
        #10 x = 0;  // F
        #10 x = 1;  // G (Detection state, y=1)
        
        // Test case 2: Overlapping sequence "1101011" - should detect twice
        #10 x = 1;  // C (overlapping - from G with x=1)
        #10 x = 0;  // D
        #10 x = 1;  // E
        #10 x = 0;  // F
        #10 x = 1;  // G (Detection state, y=1)
        
        // Test case 3: No match sequence
        #10 x = 0;  // A
        #10 x = 1;  // B
        #10 x = 0;  // A
        #10 x = 0;  // A
        #10 x = 1;  // B
        #10 x = 1;  // C
        
        // Test case 4: Partial match then complete
        #10 x = 1;  // C
        #10 x = 0;  // D
        #10 x = 1;  // E
        #10 x = 1;  // C (reset due to wrong bit)
        #10 x = 0;  // D
        #10 x = 1;  // E
        #10 x = 0;  // F
        #10 x = 1;  // G (Detection state, y=1)
        
        // Test case 5: Multiple overlapping sequences
        #10 x = 1;  // C (overlapping)
        #10 x = 0;  // D
        #10 x = 1;  // E
        #10 x = 0;  // F
        #10 x = 1;  // G (Detection state, y=1)
        
        // Test case 6: Test state G behavior with overlapping
        #10 x = 1;  // C (from G with x=1 - overlapping)
        #10 x = 0;  // D
        #10 x = 1;  // E
        #10 x = 0;  // F
        #10 x = 1;  // G (Detection state, y=1)
        
        // Test case 7: Long sequence with multiple overlaps
        #10 x = 1;  // C (overlapping)
        #10 x = 1;  // C (stay in C)
        #10 x = 0;  // D
        #10 x = 1;  // E
        #10 x = 0;  // F
        #10 x = 1;  // G (Detection state, y=1)
        
        // End simulation
        #100 $finish;
    end
    
    // Monitor to display results
    initial begin
        $monitor("Time=%0t, x=%b, State=%b, y=%b", $time, x, dut.cs, y);
    end
endmodule
