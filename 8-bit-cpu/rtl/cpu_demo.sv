module cpu_demo (

input logic MAX10_CLK1_50,

input logic [9:0]SW,

output logic [9:0]LEDR, 
output logic [6:0]HEX0,  
output logic [6:0]HEX1 

);

logic [7:0] pc;
logic [7:0] instruction;

logic [2:0] opcode;
logic [1:0] rd;
logic [1:0] rs;

logic [7:0] reg_write_data;
logic reg_write_en;
logic [7:0] reg_data1;
logic [7:0] reg_data2;

logic [7:0]alu_result;
logic zero_flag;



//small divider for slower clock, it sets slow enable to true only when slow_count is 0, and since slow_count increases on each clock cycle, its goes 50million times per second (50Mhz)
//, but since slow_count is 25 bits, it resets to 0 every time it hits 2^25(3355432), so slow_enable is only 0 every 50million/3355432 seconds, which is about 1.5seconds. 
//Making a mini 1.5 second clock.

logic [24:0] slow_count = 0;
logic slow_enable;

always_ff @(posedge MAX10_CLK1_50) begin

slow_count <= slow_count + 1;
end

assign slow_enable = (slow_count == 0);

assign reg_write_data = alu_result;
assign reg_write_en = SW[2]; 




program_counter pc1 (

.clk(MAX10_CLK1_50),
.reset(SW[0]),
.enable(SW[1] && slow_enable),

.pc(pc)

);


instruction_memory im1 (

.address(pc[3:0]),
.instruction(instruction)

);


instruction_decoder id1 (

.instruction(instruction),

.opcode(opcode),
.rd(rd),
.rs(rs)

);

register_file rf1 (

.clk(MAX10_CLK1_50),
.write_en(reg_write_en),
.write_data(reg_write_data),
.write_addr(rd),

.read_addr1(rd),
.read_addr2(rs),

.read_data1(reg_data1),
.read_data2(reg_data2)

);

alu a1 ( 

.a(reg_data1),
.b(reg_data2),
.opcode(opcode),
.result(alu_result),
.zero_flag(zero_flag)


);

assign LEDR[2:0] = opcode;
assign LEDR[4:3] = rd;
assign LEDR[6:5] = rs;
assign LEDR[7]   = zero_flag;
assign LEDR[8]   = reg_write_en;


seven_seg_decoder ssd0 (

.val(pc[3:0]),

.seg(HEX0)

);

seven_seg_decoder ssd1 (

.val(pc[7:4]),

.seg(HEX1)

);

endmodule