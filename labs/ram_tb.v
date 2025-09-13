`timescale 1ns / 1ps
module ram_tb;
  
  localparam ADD_WIDTH = 4;
  localparam DATA_WIDTH = 8;
  localparam DEPTH = 16;
  
  reg clk; 
  reg rst_n;
  reg we_a; 
  reg we_b;
  
  reg [ADD_WIDTH-1:0] addr_a;
  reg [ADD_WIDTH-1:0] addr_b;
  
  reg [DATA_WIDTH-1:0] din_a; 
  reg [DATA_WIDTH-1:0] din_b;
  
  wire [DATA_WIDTH-1:0] dout_a;
  wire [DATA_WIDTH-1:0] dout_b;
  
  ram
  #(
  .ADD_WIDTH(ADD_WIDTH), 
  .DATA_WIDTH(DATA_WIDTH), 
  .DEPTH(DEPTH)
  )
  dut
  (
  .clk(clk), 
  .rst_n(rst_n),
  .we_a(we_a), 
  .we_b(we_b),
  .addr_a(addr_a), 
  .addr_b(addr_b),
  .din_a(din_a), 
  .din_b(din_b), 
  .dout_a(dout_a), 
  .dout_b(dout_b)
  );
  
  initial clk=0;
  always #5 clk = ~clk;
  
  integer errors;
  
  
  task reset;
    begin
	  rst_n = 1'b0;
	  
	  repeat(2) @(negedge clk);
	  
	  rst_n = 1'b1;
	  
	  @(negedge clk);
	
	  $display ("Reset complete");
	end
  endtask
  
  
  task write_A (input [ADD_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data, input en);
    begin
	  addr_a = addr;
	  we_a = en;
	  din_a = data;
	  @(negedge clk);
	  
	  if(dut.RAM[addr] !== data)
	    begin
		  $display("Port A: Write operation failed to write %h mismatched at RAM[%0d] with %h", data, addr, dut.RAM[addr]);
		  errors = errors +1;
		end
	  else 
	    $display("Port A: Write operation Successeded to write %h at RAM[%0d] with value %h", data, addr, dut.RAM[addr]);
	end
  endtask
  
  
  task write_B (input [ADD_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data, input en);
    begin
	  addr_b = addr;
	  we_b = en;
	  din_b = data;
	  @(negedge clk);
	  
	  if(dut.RAM[addr] !== data)
	    begin
		  $display("Port B: Write operation failed to write %h mismatched at RAM[%0d] with %h", data, addr, dut.RAM[addr]);
		  errors = errors +1;
		end
	  else 
	    $display("Port B: Write operation Successeded to write %h at RAM[%0d] with value %h", data, addr, dut.RAM[addr]);
	end
  endtask  

  task read_A (input [ADD_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data, input en);
    begin
	  addr_a = addr;
	  we_a = en;
	  @(negedge clk);
	  
	  if(dout_a !== data)
	    begin
		  $display("Port A: Read operation failed to read %h at RAM[%0d] with %h", data, addr, dout_a);
		  errors = errors +1;
		end
	  else 
	    $display("Port A: Read operation Successeded with value %h at RAM[%0d] with value %h", dout_a, addr, dut.RAM[addr]);
	end
  endtask

  task read_B (input [ADD_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data, input en);
    begin
	  addr_b = addr;
	  we_b = en;
	  @(negedge clk);
	  
	  if(dout_b !== data)
	    begin
		  $display("Port B: Read operation failed to read %h at RAM[%0d] with %h", data, addr, dout_b);
		  errors = errors +1;
		end
	  else 
	    $display("Port B: Read operation Successeded with value %h at RAM[%0d] with value %h", dout_b, addr, dut.RAM[addr]);
	end
  endtask	
  
  initial 
    begin

      we_a = 0; 
      we_b = 0;
  
      addr_a = 0;
      addr_b = 0;
  
      din_a = 0; 
      din_b = 0;
	  
	  errors = 0;
	  reset;
	  
	  // Read A and B to check reset
	
	  read_A(4'hf, 8'hff, 1'b0);
	  @(negedge clk);
	  read_B(4'hf, 8'h00, 1'b0);
	  @(negedge clk);
	
	  write_A(4'hb, 8'h00, 1'b1);
	  @(negedge clk);
	  read_A(4'hb, 8'h00, 1'b0);
	  @(negedge clk);
	  
	  write_B(4'h1, 8'h05, 1'b1);
	  @(negedge clk);
	  read_B(4'h1, 8'h05, 1'b0);
	  @(negedge clk);
	  
	  write_B(4'h4, 8'h06, 1'b1);
	  write_A(4'h4, 8'h04, 1'b1);
	  @(negedge clk);
	  
	  read_B(4'h4, 8'h06, 1'b0);
	  read_A(4'h4, 8'h04, 1'b0);
	  
	  // Test vectors 2
	  write_B(4'h2, 8'hcc, 1'b1);
	  @(negedge clk);
	  write_A(4'h2, 8'hbb, 1'b1);
	  @(negedge clk);
	  
	  read_B(4'h2, 8'h06, 1'b0);
	  read_A(4'h2, 8'h04, 1'b0);
	  
	  if(errors == 0)
	    $display("All tests passed");
	  else 
	    $display("%0d tests failed", errors);
		
	  @(negedge clk);
	  
	  $stop;
	end
 
  
endmodule
  