module uart_processor (

input logic[7:0] rx_data,

output logic [7:0] tx_data

); 

always_comb begin

tx_data = rx_data;

if (rx_data >= 8'd97 && rx_data <= 8'd122) begin
		tx_data = rx_data - 32;
	
	end

end

endmodule