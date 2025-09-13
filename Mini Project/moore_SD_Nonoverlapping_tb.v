`timescale 1ps/1ps
module moore_SD_Nonoverlapping_tb; 

    reg clk;
    reg reset;
    reg x;
    wire y;

    // Instantiate the DUT
    moore_SD_Nonoverlapping dut(
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
        
        // Test case 2: Non-overlapping sequence "110101110101"
        #10 x = 1;  // B (reset to start new sequence)
        #10 x = 1;  // C
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
        
        // Test case 5: Multiple sequences with gaps
        #10 x = 0;  // A
        #10 x = 1;  // B
        #10 x = 1;  // C
        #10 x = 0;  // D
        #10 x = 1;  // E
        #10 x = 0;  // F
        #10 x = 1;  // G (Detection state, y=1)
        
        // Test case 6: Test state G behavior
        #10 x = 0;  // A (from G with x=0)
        #10 x = 1;  // B
        #10 x = 1;  // C
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
