module tb_register_file ();


logic clk = 0;

logic write_en = 0;

logic [1:0] write_addr = 0;
logic [7:0] write_data = 0;

logic [1:0] read_addr1 = 0;
logic [1:0] read_addr2 = 0;

logic [7:0] read_data1 = 0;
logic [7:0] read_data2 = 0;


register_file dut (

.clk(clk),
.write_en(write_en),
.write_addr(write_addr),
.write_data(write_data),
.read_addr1(read_addr1),
.read_addr2(read_addr2),
.read_data1(read_data1),
.read_data2(read_data2)
);

always #10 clk = ~clk;

initial begin 

#20
write_data = 42; //test writing 42 to address 0
write_addr = 0;

write_en = 1;

#20 
write_en = 0;

#20 
write_data = 85; //test writing 85 to address 2
write_addr = 2;

write_en = 1;

#20 
write_en = 0;

#20 
read_addr1 = 0; //setting read addresses to 0 and 2, so read data becomes both data
read_addr2 = 2;

#20
write_data = 8'hAA;
write_addr = 0;

write_en = 1;

#20
write_en = 0;

#20 
$stop;

end

endmodule



