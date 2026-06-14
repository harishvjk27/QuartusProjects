module top(
	//YOU CANNOT ASSIGN TO INPUTS, THEY ARE READ ONLY
	input logic MAX10_CLK1_50,
	input logic [9:0]SW,
	
	//send switch for uart
	input logic KEY1,
	
	output logic [9:0]LEDR, //LEDS

	//uart rx input
	input logic ARDUINO_IO0,
	
	//all 6 hex displays 
	
	output logic [6:0]HEX0,  
	output logic [6:0]HEX1, 
	output logic [6:0]HEX2, 
	output logic [6:0]HEX3, 
	output logic [6:0]HEX4, 
	output logic [6:0]HEX5,
	
	//uart tx output
	output logic ARDUINO_IO1
	
	
	);

	//internal wires
	logic signed [31:0]counter = 0;
	logic valid;
	assign valid = 1'b1;
	//filter
	logic signed [15:0]average_out;
	
	logic signed [15:0]sample_source;
	//clock divider
	logic slow_clk = 0;
	
	logic [3:0]debug;
	
	logic signed[31:0]counter2 = 0;
	
	logic [6:0] hex0_dsp;
	logic [6:0] hex1_dsp;
	
	// uart demo outputs

	logic [9:0] uart_leds;

	logic [6:0] uart_hex0;
	logic [6:0] uart_hex1;

	logic uart_tx_out;
	
	//assigning uart pins
	assign ARDUINO_IO1 = uart_tx_out;
	assign HEX0 = SW[9] ? uart_hex0 : hex0_dsp;
	assign HEX1 = SW[9] ? uart_hex1 : hex1_dsp;

	//slow clock (updates every half second, cycle of 1 second)
	
	clock_divider divider0 (
	.clk(MAX10_CLK1_50),
	.slow_clk(slow_clk)
	);
	
	//counter logic for normal clock	
	always_ff @(posedge MAX10_CLK1_50) begin //do not need to use assign
	
	counter <= counter + 1; 
	
	end

	always_ff @(posedge slow_clk) begin 
	
	counter2 <= counter2 + 1; //adds 1 every second! 
	
	end
	
	
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
	
	always_comb begin

	if (!SW[9]) begin

		// normal dsp display

		if (SW[0])
			LEDR = average_out[15:6];

		else
			LEDR = counter[29:20];

	end

	else begin

		LEDR = uart_leds;

	end

end
	
	
	//seven segment display for hex0
	seven_seg_decoder hex_decoder0(
	.val(counter2[3:0]), //since we are using slow clock, these values can be more easily visible
	.seg(hex0_dsp)
);

	//seven seg display for hex1
	seven_seg_decoder hex_decoder1(
	.val(counter2[7:4]),
	.seg(hex1_dsp)
);
	
	//hex2 shows first 4 bits of average
	
	seven_seg_decoder hex_decoder2 (
	.val(average_out[3:0]),
	.seg(HEX2)
	
	);
	
	
	//hex3 shows second 4 bits of average
	
	seven_seg_decoder hex_decoder3 (
	.val(average_out[7:4]),
	.seg(HEX3)
	
	);
	
	//hex4 shows last 4 bits of sample source
	
	seven_seg_decoder hex_decoder4 (
	.val(sample_source[15:12]),
	.seg(HEX4)
	
	);
	
	always_comb begin
	if (SW[0] && SW[1])	//if both switched on, debug is 1
	 debug = 4'h1;
	 
	 else
	 debug = 4'h0;
	 
	end
	seven_seg_decoder hex_decoder5 ( //hex5 shows state/debug
	
	.val(debug),
	.seg(HEX5)
	
	);
	

	//UART Demo when switch[9] is pressed
	
	uart_demo uart0(

	.clk(MAX10_CLK1_50),

	.switches(SW[3:0]),

	.send_button(KEY1),

	.uart_rx_pin(ARDUINO_IO0),

	.uart_tx_pin(uart_tx_out),

	.leds(uart_leds),

	.hex0(uart_hex0),
	.hex1(uart_hex1)

);
	
	endmodule