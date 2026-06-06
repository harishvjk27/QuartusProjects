module uart_processor (

input logic[7:0] rx_data,

input logic rx_done,

output logic [7:0] tx_data,

output logic help_cmd,

output logic debug_cmd,

output logic filter_cmd,

output logic led_cmd

); 

always_comb begin

tx_data = rx_data;

	if (rx_data >= 8'd97 && rx_data <= 8'd122) begin
		tx_data = rx_data - 32;
	
		end
		
	help_cmd = 1'b0;
	if (rx_done && (rx_data == "H" || rx_data == "h")) begin
		help_cmd = 1'b1;
		
	end
	
	debug_cmd = 1'b0;
	if (rx_data == "D" || rx_data == "d") begin
		debug_cmd = 1'b1;
		
	end
	
	filter_cmd = 1'b0;
	if (rx_data == "F" || rx_data == "f") begin
		filter_cmd = 1'b1;
		
	end
	
	led_cmd = 1'b0;
	if (rx_data == "L" || rx_data == "l") begin
		led_cmd = 1'b1;
		
	end
	

end

endmodule