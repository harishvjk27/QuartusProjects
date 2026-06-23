module register_file (

input logic clk,

input logic write_en,

input logic [1:0] write_addr,
input logic [7:0] write_data,

input logic [1:0] read_addr1,
input logic [1:0] read_addr2,

output logic [7:0] read_data1,
output logic [7:0] read_data2 

);

logic [7:0] regs[0:3]; //internal 4 registers each with 8 bit widths.

always_ff @(posedge clk) begin

	if (write_en) begin
	
		regs[write_addr] <= write_data; //if write_en is enabled, then write the current write data to the spot where the current write_addr is pointing to in the registry
		
		end
		
end


 
 assign read_data1 = regs[read_addr1];
 assign read_data2 = regs[read_addr2];
 
 
 endmodule
 