module instruction_memory (

input logic [3:0] address,

output logic [7:0] instruction

);

logic [7:0] rom [0:15]; //16 possible instructions

initial begin

    rom[0] = 8'b000_01_10_0; // ADD R1,R2
    rom[1] = 8'b001_10_01_0; // SUB R2,R1
    rom[2] = 8'b010_11_00_0; // AND R3,R0
    rom[3] = 8'b011_00_11_0; // OR  R0,R3
    rom[4] = 8'b100_01_11_0; // XOR R1,R3

    rom[5]  = 8'b000_00_00_0;
    rom[6]  = 8'b000_00_00_0;
    rom[7]  = 8'b000_00_00_0;
    rom[8]  = 8'b000_00_00_0;
    rom[9]  = 8'b000_00_00_0;
    rom[10] = 8'b000_00_00_0;
    rom[11] = 8'b000_00_00_0;
    rom[12] = 8'b000_00_00_0;
    rom[13] = 8'b000_00_00_0;
    rom[14] = 8'b000_00_00_0;
    rom[15] = 8'b000_00_00_0;

end



assign instruction = rom[address];

endmodule