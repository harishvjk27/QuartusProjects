module instruction_decoder ( 


input logic [7:0] instruction,

output logic [2:0] opcode,
output logic [1:0] rd,
output logic [1:0] rs

);

assign opcode = instruction[7:5];
assign rd = instruction[4:0];
assign rs = instruction[2:1];

endmodule