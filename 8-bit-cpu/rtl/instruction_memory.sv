module instruction_memory (

input logic [7:0] address,

output logic [7:0] instruction

);

logic [7:0] rom [0:15]; //16 possible instructions

assign instruction = rom[address];

endmodule