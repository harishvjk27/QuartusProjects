module uart_response_sender (

input logic clk,

input logic help_cmd,

input logic debug_cmd,

input  logic filter_cmd,

input logic led_cmd,

input logic tx_done,

output logic response_tx_start,

output logic [7:0] response_tx_data

);

//creating new object to represent states
typedef enum logic [3:0]  {

IDLE,
SEND_H,
WAIT_H,

SEND_E,
WAIT_E,

SEND_L,
WAIT_L,

SEND_P,
WAIT_P

} state_t;

//two state_t objects to hold current and next state

state_t current_state = IDLE;
state_t next_state;


// case logic for the next-state with current state defaulting at IDLE, for each letter in help
always_comb begin 

next_state = current_state;

case(current_state)


	IDLE: //the default starting, so once help_cmd is true, this starts
		if(help_cmd)
		next_state = SEND_H;
		
	SEND_H:
		next_state = WAIT_H;
	
	WAIT_H:
		if(tx_done)
		next_state = SEND_E;
		
	SEND_E:
		next_state = WAIT_E;
	
	WAIT_E:
		if(tx_done)
		next_state = SEND_L;
		
	SEND_L:
		next_state = WAIT_L;
	
	WAIT_L:
		if(tx_done)
		next_state = SEND_P;
		
	SEND_P:
		next_state = WAIT_P;
	
	WAIT_P:
		if(tx_done)
		next_state = IDLE;
		
	endcase
	
end


//Outputting the letters depending on the state

always_comb begin
response_tx_start = 1'b0;
response_tx_data = 8'h00;

case(current_state)

	SEND_H: begin
	
		response_tx_start = 1'b1;
		response_tx_data = "H";
	end
	
	SEND_E: begin
	
		response_tx_start = 1'b1;
		response_tx_data = "E";
	end
	
	SEND_L: begin
	
		response_tx_start = 1'b1;
		response_tx_data = "L";
	end
	
	SEND_P: begin
	
		response_tx_start = 1'b1;
		response_tx_data = "P";
	end
	
	endcase


end

//when clock ticks positive, current state equals next state
always_ff @(posedge clk) begin
current_state <= next_state;

end


endmodule