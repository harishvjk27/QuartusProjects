module tb_uart_fifo();


logic clk = 0;

logic write_en;
logic read_en;
logic [7:0] data_in;

logic [7:0] data_out;
logic full;
logic empty;


uart_fifo dut(

	.clk(clk),
	.write_en(write_en),
	.read_en(read_en),
	.data_in(data_in),
	.data_out(data_out),
	.full(full),
	.empty(empty)

);

always #10 clk = ~clk;


initial begin

write_en = 1'b0;
read_en = 1'b0;


#20;
data_in = "A";
write_en = 1'b1;

#20

data_in = "B";
write_en = 1'b1;

#20
data_in = "C";
write_en = 1'b1;

#20
read_en = 1'b1;

#20 
read_en = 1'b1;

#20
read_en = 1'b1;

#20;
read_en = 1'b1; //empty read

#20
data_in = "AB";
write_en = 1'b1;

#20
write_en = 1'b1; //full write

#20
read_en = 1'b1;
write_en = 1'b1;

#60
$stop;


end

endmodule