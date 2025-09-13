module ram
#(parameter ADD_WIDTH = 4, DATA_WIDTH = 8, DEPTH = 16)
(
  input wire clk, rst_n,
  input wire we_a, we_b,
  input wire [ADD_WIDTH-1:0] addr_a, addr_b,
 
  input wire [DATA_WIDTH-1:0] din_a, din_b,
  output reg [DATA_WIDTH-1:0] dout_a, dout_b
 
);
 
  integer i;
  reg [DATA_WIDTH-1:0] RAM [0:DEPTH-1];
 
  always@(posedge clk, negedge rst_n)
    begin
	  if(~rst_n)
	    begin
		  dout_a <= 'b0;
		  dout_b <= 'b0;
		  for(i=0; i<DEPTH; i=i+1)
		    RAM[i] <= 'b0;
		end
	  else if(we_a && we_b && (addr_a !== addr_b))
	    begin
		  RAM[addr_a] <= din_a;
		  RAM[addr_b] <= din_b;
		end
	  else if(we_a && ~we_b && (addr_a !== addr_b))
	    begin
	      RAM[addr_a] <= din_a;
		  dout_b <= RAM[addr_b];
		end
	  else if(~we_a && we_b && (addr_a !== addr_b))
	    begin
	      RAM[addr_b] <= din_b;
		  dout_a <= RAM[addr_a];
		end
	  else if(~we_a && ~we_b)
	    begin
		  dout_a <= RAM[addr_a];
		  dout_b <= RAM[addr_b];
		end
	end
 
endmodule