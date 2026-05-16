module top(
	//YOU CANNOT ASSIGN TO INPUTS, THEY ARE READ ONLY
	input logic MAX10_CLK1_50,
	input logic [9:0]SW,
	
	output logic [9:0]LEDR //output goes to LEDS
	
	);

	
	
	logic signed[31:0] counter = 0;
	logic valid;
	logic signed[15:0] average_out;
	
	
	always_ff @(posedge MAX10_CLK1_50) begin //do not need to use assign
	
	counter <= counter + 1;
	
	end

	
	assign valid = 1'b1;
	
	
	moving_average filter0 (
	
	.clk(MAX10_CLK1_50),
	.rst(1'b1),
	.valid_in(valid),
	
	.sample_in(counter[31:16]),
	
	.average_out(average_out)
	);

	
	always_comb begin //do not need to use assign within comb
	
	
	if (SW[0])
	
		LEDR = average_out[15:6]; // filtered version of top 9 bits from counter
	
	else
			LEDR = counter[29:20]; // raw from bits 20-29
	end

	endmodule