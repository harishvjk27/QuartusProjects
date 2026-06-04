module uart_demo(

input logic clk,

input logic [3:0] switches,

input logic send_button,

input logic uart_rx_pin,

output logic uart_tx_pin,

output logic [9:0] leds,

output logic [6:0] hex0,
output logic [6:0] hex1

);

	//internal wires

	//uart tx inputs
	logic uart_out;
	logic done;
	logic busy;
	logic key_prev = 1;
	logic send_pulse;

	//uart rx outputs
	logic [7:0] rx_data;
	logic rx_done;

	//uart tx output
	assign uart_tx_pin = uart_out;	
	
	// uart tx processed value
	logic [7:0]tx_data;

	//begin uart mode and assign values to onboard LEDS
	always_comb begin

		leds = 10'b0;

		leds[0] = busy;
		leds[1] = done;
		leds[2] = ~uart_out;
		leds[3] = rx_done;

	end

	// uart tx testing
	uart_tx tx0 (

		//.uart_in(rx_data), //made rx_data as the input for keyboard -> FPGA -> PC operation, it is currently processed by the uart_processor
		.uart_in(tx_data), //the processed rx_data, which becomes tx_data from the uart_processor is set as the input. 
		.clk(clk),
		.send(rx_done),
		.tx(uart_out),
		.done(done),
		.busy(busy)

	);

	// uart rx testing
	uart_rx rx0 (

		.clk(clk),
		.rx(uart_rx_pin),
		.data_out(rx_data),
		.done(rx_done)

	);

	// displaying uart rx output to hex displays

	seven_seg_decoder rx_decoder0 (

		.val(rx_data[3:0]),
		.seg(hex0)

	);

	seven_seg_decoder rx_decoder1 (

		.val(rx_data[7:4]),
		.seg(hex1)

	);

	// edge detection for uart tx, so one button press only sends one input

	always_ff @(posedge clk) begin

		key_prev <= send_button;
		
		
	end

	assign send_pulse = key_prev && ~send_button;
	
	//uart processor to convert lowercase letters to uppercase
	uart_processor uart_p1 (
	.rx_data(rx_data),
	.tx_data(tx_data)
	
		);
		
endmodule
