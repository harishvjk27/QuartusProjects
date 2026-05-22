module tb_uart_tx();

logic [7:0] hex;
logic clk = 0; //if not initialized it is X
logic send = 0;
logic out;
logic done = 0;

uart_tx dut (

.hex_input(hex),
.clk(clk),
.send(send),
.tx(out),
.done(done)
);

//clock generation
always begin //always runs

#10
clk = ~clk;

end


initial begin

send = 0;

hex = 8'h41;
#20

send = 1;

#20

send = 0;

#100000

$stop;

end



endmodule


