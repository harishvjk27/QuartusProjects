module clock_divider (

input logic clk, //the de10lite is 50Mhz so its 50Million ticks per second

output logic slow_clk

);


logic [24:0]counter = 0; //since counter goes to up 25million, we need 25 bits for 25 positions, a 25 bit # can store up to 33,554,431

always_ff @(posedge clk) begin //this is like a while loop

counter <= counter + 1;

if (counter == 25_000_000) begin //once counter gets to 25Million, (every half second)

slow_clk <= ~slow_clk; //we flip our output clock every half second
counter <= 0; //and we reset counter

	end


end


//remember the clock is just a 1 bit value going 0 or 1 every tick (here its 50millions ticks per second), if we want to make that tick slower, we create a clock value which 
//only activates at a specific amount of ticks, here we make it go every half second, because we wait for 25million ticks before we flip the clock!
//

endmodule
