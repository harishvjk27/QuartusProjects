module control_fsm (

input logic clk,
input logic reset,
input logic enable,

output logic pc_enable,
output logic reg_write_en



);


typedef enum logic [2:0] {


RESET,
FETCH,
DECODE,
EXECUTE,
WRITEBACK

} state_t;

state_t current_state = RESET;
state_t next_state;

always_ff @(posedge clk) begin //updates current state every clock cycle

if (reset)

	current_state <= RESET;
	
else if(enable)
	current_state <= next_state;
end

always_comb begin


	next_state = current_state;
	
	case(current_state) 
	
		RESET : 
			next_state = FETCH;
			
		FETCH : 
			next_state = DECODE;
			
		DECODE : 
			next_state = EXECUTE;
			
		EXECUTE:
			next_state = WRITEBACK;
			
		WRITEBACK : 
			next_state = FETCH;
			
		endcase
		
	end

	always_comb begin
	
	pc_enable = 1'b0;
	reg_write_en = 1'b0;
	
	case (current_state)
	
		FETCH :
			pc_enable = 1'b1;
		WRITEBACK:
			reg_write_en = 1'b1;
		endcase
	end
	
	
endmodule