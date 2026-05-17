module top(
	//YOU CANNOT ASSIGN TO INPUTS, THEY ARE READ ONLY
	input logic MAX10_CLK1_50,
	input logic [9:0]SW,
	
	output logic [9:0]LEDR, //output goes to LEDS
	output logic [6:0]HEX0,  //first hex display
	output logic [6:0]HEX1 // second hex display
	
	);

	
	//internal wires
	logic signed [31:0]counter = 0;
	logic valid;
	logic signed [15:0]average_out;
	
	logic signed [15:0]sample_source;
	
	//counter logic	
	always_ff @(posedge MAX10_CLK1_50) begin //do not need to use assign
	
	counter <= counter + 1;
	
	end

	
	assign valid = 1'b1;
	
	always_comb begin //changing input for filter
	
		if(SW[1])
			sample_source = {SW[9:6], 12'b0};
		
		else
			sample_source = counter[31:16];
	end
	
	
	
	//moving average filter
	moving_average filter0 (
	
	.clk(MAX10_CLK1_50),
	.rst(1'b1),
	.valid_in(valid),
	
	.sample_in(sample_source),
	
	.average_out(average_out)
	);

	
	//led visuals for moving average filter
	
	always_comb begin //do not need to use assign within comb
	
	if (SW[0])
	
		LEDR = average_out[15:6]; // filtered version of top 9 bits from counter
	
	else
			LEDR = counter[29:20]; // raw from bits 20-29
	end
	
	
	
	
	
	
	//seven segment display for hex0
	seven_seg_decoder hex_decoder0(
	.val(SW[3:0]),
	.seg(HEX0)
);

	//seven seg display for hex1
	seven_seg_decoder hex_decoder1(
	.val(SW[7:4]),
	.seg(HEX1)
);
	
	

	
	endmodule