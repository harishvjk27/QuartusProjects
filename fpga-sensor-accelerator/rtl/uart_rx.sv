module uart_rx (

input logic clk, //fpga clock

input logic rx, //the current bit that is inputted from the wire

output logic [7:0] data_out, //the final output

output logic done = 0 //once full frame is done, this is set to 1

);

logic [9:0] shift_reg = 0; //full uart frame with start and stop bits

logic [3:0] bit_counter = 0; //counts how many bits we get, so we know to stop at 10

logic busy = 0; //shows if we are currently recieving data for transmission

//baud timing is 434, calculated by 50,000,000 / 115200
	
localparam BAUD_DIV = 434;

logic [9:0] baud_counter = 0;

logic baud_tick = 0;

always_ff @(posedge clk) begin

	if (rx == 0 && !busy) begin //checking the start bit, if we are not busy and the rx is 0, then this is the start bit

		busy <= 1; //we have recieved the first bit
		bit_counter <= 0; //set to 0 because this is new uart transmission


	end
	
	//shifting incoming bits and storing in shift reg
	else if (busy && baud_tick) begin
	
	shift_reg[bit_counter] <= rx; //we are inputting the bit into its correct place, skipping the start bit
	
	//finished recieving
	
		if (bit_counter == 9) begin
	$display("shift_reg = %b", shift_reg);
			bit_counter <= 10;
		
		end
		
		else begin
		
		bit_counter <= bit_counter + 1;
		end
	
	
	end
	
		if (bit_counter == 10) begin
	
		busy <= 0;
		done <= 1;
		
		data_out <= shift_reg[8:1];
		end

		end
	
	
	//baud counter logic
	
	always_ff @(posedge clk) begin 

	if (baud_counter == BAUD_DIV-1) begin //if baud_counter is going to hit the BAUD_DIV-1 because the counter starts at 0, so 434 ticks is 0-433.

	baud_counter <= 0; //reset counter
	baud_tick <= 1; //set baud_tick to 1
	
end
	else begin //if not at baud_DIV
	
		baud_counter <= baud_counter + 1; //Keep incrementing baud_counter
		baud_tick <= 0; //tick is still 0
		
	end

end
	

endmodule