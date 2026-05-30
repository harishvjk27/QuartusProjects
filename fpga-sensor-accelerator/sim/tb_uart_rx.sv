module tb_uart_rx();

logic clk = 0;
logic curr = 0; //curent input
logic [7:0]out = 0; //output
logic done = 0;


uart_rx dut (

.clk(clk),
.rx(curr),
.data_out(out),
.done(done)

);

always begin 			// clock

#10
clk = ~clk; //so full clock cycle is 20


end

initial begin 
//inputting ascii 'A' which is 01000001, but LSB goes first.
// but with start and stop bit its 1010000010
// 									  stop        start                                  


//since uart baud waits 434 clock cycles, you have to increment time 434 * 20

//uart idles high
curr = 1;
#20000;

curr = 0; //start
#9000

curr = 1;
#9000


curr = 0;
#9000

curr = 0;
#9000

curr = 0;
#9000

curr = 0;
#9000

curr = 0;
#9000

curr = 1;
#9000

curr = 0;
#9000

curr = 1; //stop
#9000

$stop;


end


endmodule