module alu ( 

input logic [7:0] a,
input logic [7:0] b,
input logic [2:0] opcode,

output logic [7:0] result,
output logic zero_flag

);

always_comb begin

result = 8'b0;
zero_flag = 1'b0;

if (opcode == 3'b000) begin //ADD opcode

	result = a + b;
	end //add
	
else if (opcode == 3'b001) begin //SUB opcode

	result = a - b;
	end //sub

else if (opcode == 3'b010) begin //AND opcode

	result = a & b;
	end //and
	
else if (opcode == 3'b011) begin //OR opcode

	result = a | b;
	end //or
	
else if (opcode == 3'b100) begin //XOR opcode

	result = a ^ b;
	end  //xor
	
if (result == 8'b0) begin //if result is 0

	zero_flag = 1'b1;
	end //zero_flag

	end //comb 1


endmodule 