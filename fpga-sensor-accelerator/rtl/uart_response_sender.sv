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

//enum to represent current command type
typedef enum logic [1:0] {
CMD_HELP,
CMD_DEBUG,
CMD_FILTER,
CMD_LED
} command_t;

//current state 
command_t current_command;

//creating new states to represent what is currently going on 
typedef enum logic [1:0]  {

	 IDLE,
	 SEND_CHAR,
	 WAIT_DONE,
	 NEXT_CHAR

} state_t;

//state enums
state_t next_state;
state_t current_state = IDLE;

//internal wires to hold values
logic[3:0] char_index;
logic[3:0] message_length;
logic[7:0] current_char;

//Outputting the letters depending on the state
always_comb begin 

	current_char = 8'h00;
	
	case (current_command) 
	
	
	CMD_HELP:
	
	
			case(char_index)
			0: current_char = "H";
			1: current_char = "E";
			2: current_char = "L";
			3: current_char = "P";
			endcase
	
	CMD_DEBUG:
	
	
		case(char_index)
			0: current_char = "D";
			1: current_char = "E";
			2: current_char = "B";
			3: current_char = "U";
			4: current_char = "G";
			endcase
			
	CMD_FILTER:
	
	
		case(char_index)
			0: current_char = "F";
			1: current_char = "I";
			2: current_char = "L";
			3: current_char = "T";
			4: current_char = "E";
			5: current_char = "R";
			endcase
			
	CMD_LED:

	
		case(char_index)
			0: current_char = "L";
			1: current_char = "E";
			2: current_char = "D";
		endcase
		
	endcase

end


//logic for message length
always_comb begin

message_length = 4'h0;

	case (current_command)
		
		CMD_HELP:
		
		message_length = 4;
		
		CMD_DEBUG:
		
		message_length = 5;
		
		CMD_FILTER:
		
		message_length = 6;
		
		CMD_LED:
		
		message_length = 3;
			
	endcase
end

//updating values sequentially so correct char is set at the correct time
always_ff @(posedge clk) begin


current_state <= next_state;

if(current_state == IDLE) begin

	if(help_cmd) begin
	current_command <= CMD_HELP;
	char_index<=0;
	
	end
	
	if(debug_cmd) begin
	current_command <= CMD_DEBUG;
	char_index<=0;
	
	end
	
	if(filter_cmd) begin
	current_command <= CMD_FILTER;
	char_index<=0;
	
	end
	
	if(led_cmd) begin
	current_command <= CMD_LED;
	char_index<=0;
	
	end
end

else if(current_state == NEXT_CHAR && char_index < message_length-1)

char_index <= char_index + 1;


end

//state transitions
always_comb begin 

next_state = current_state;

case(current_state)

	IDLE: begin
	
		if(help_cmd)
			next_state = SEND_CHAR;
			
		else if(debug_cmd) 
			next_state = SEND_CHAR;
			
		else if(filter_cmd)
			next_state = SEND_CHAR;
			
		else if(led_cmd)
			next_state = SEND_CHAR;
			
		
	end
	
	SEND_CHAR:
		next_state = WAIT_DONE;
		
	WAIT_DONE: begin
	
		if(tx_done)
		
		next_state = NEXT_CHAR;
		
		end
		
	NEXT_CHAR: begin
		
		if (char_index == message_length -1)
		
			next_state = IDLE;
			
		else 
			next_state = SEND_CHAR;
			
	end
	
endcase

end

//setting the data to the current output

always_comb begin

response_tx_start = 0;
response_tx_data = 0;

case(current_state)

	SEND_CHAR: begin
	
	response_tx_start = 1;
	response_tx_data = current_char;
	end

	endcase
end

endmodule


