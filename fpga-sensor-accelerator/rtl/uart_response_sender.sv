module uart_response_sender (

input logic help_cmd,

input logic debug_cmd,

input  logic filter_cmd,

input logic led_cmd,

output logic response_tx_start,

output logic [7:0] response_tx_data

);

always_comb begin 

response_tx_start = 0;
response_tx_data = 0;

if (help_cmd) begin
	response_tx_start = 1'b1;
	response_tx_data = "H";
	
	end
end

endmodule