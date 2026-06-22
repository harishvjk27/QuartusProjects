module tb_alu ();

logic [7:0] a;
logic [7:0] b;
logic [2:0] opcode;

logic [7:0] result;
logic zero_flag;


alu dut (

.a(a),
.b(b),
.opcode(opcode),
.result(result),
.zero_flag(zero_flag)

);

initial begin

#20

a = 15;
b = 5;
opcode = 3'b0; //add

#20
a = 7'b10101010;
b = 7'b11110000;
opcode = 3'b100; //xor

#20
a = 15;
b = 5;
opcode = 3'b010; //and

#20
a = 5;
b = 5;
opcode = 3'b001; //sub / zero-flag check

#20 
a = 15;
b = 5;
opcode = 3'b011; // or

#20 
$stop;

	end

endmodule
