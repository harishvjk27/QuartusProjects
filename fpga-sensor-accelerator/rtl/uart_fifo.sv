module uart_fifo ( //fifo is a fundamental for every fpga, it takes in a value and reads it and writes it out just as how it was entered, 
						// FIFO stands for First-In, First-Out. FIFO has specific states.

input logic 		 clk,
input logic 		 write_en,
input logic 		 read_en,
input logic  [7:0] data_in,

output logic [7:0] data_out,
output logic 		 full,
output logic 		 empty

);

//internal wires

logic [7:0] mem[0:7]; //8 memory locations which each store 8 bits, the [7:0] represents the width for each element while the [0:7] is the amount of elements
logic [2:0] write_ptr = 0;
logic [2:0] read_ptr = 0;
logic [3:0] count = 0; //is 4 bits because it needs to go from 0 to 8, not 0 to 7. The FIFO depth is 8.

always_comb begin

full = 1'b0;
empty = 1'b0;

	if (count == 0) begin
		empty = 1'b1;
		end

	if (count == 8) begin

		full = 1'b1;
		end
end
		

always_ff @(posedge clk) begin

	

	if ((write_en && !full) && !(read_en && !empty)) begin //when write is enabled and full is not true, then write the data from current write_ptr to the memory

		mem[write_ptr] <= data_in;
	
		write_ptr <= write_ptr + 1;
		
		count <= count + 1;

	end
	
	else if ((read_en && !empty) && !(write_en && !full)) begin//when read is enabled and empty is not true, read the data from current read_ptr memory and store it into data_out

		data_out <= mem[read_ptr];
		read_ptr <= read_ptr + 1;
		count <= count - 1;
		
		end
		
	else if((write_en && !full) && (read_en && !empty)) begin //when both cases are true
	
		mem[write_ptr] <= data_in;
      write_ptr <= write_ptr + 1;

      data_out <= mem[read_ptr];
      read_ptr <= read_ptr + 1;
	
	
	count <= count; //doesnt change
	
	end
		
	end

endmodule