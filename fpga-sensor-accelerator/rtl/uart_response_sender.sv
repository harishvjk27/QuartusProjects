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
} cmd_type;

//creating new object to represent letters in the states for HELP, DEBUG, FILTER, LED
typedef enum logic [19:0]  {

IDLE,

	 // HELP
    HELP_SEND_H,
    HELP_WAIT_H,

    HELP_SEND_E,
    HELP_WAIT_E,

    HELP_SEND_L,
    HELP_WAIT_L,

    HELP_SEND_P,
    HELP_WAIT_P,

    // DEBUG
    DEBUG_SEND_D,
    DEBUG_WAIT_D,

    DEBUG_SEND_E,
    DEBUG_WAIT_E,

    DEBUG_SEND_B,
    DEBUG_WAIT_B,

    DEBUG_SEND_U,
    DEBUG_WAIT_U,

    DEBUG_SEND_G,
    DEBUG_WAIT_G,

	// FILTER
    FILTER_SEND_F,
    FILTER_WAIT_F,

    FILTER_SEND_I,
    FILTER_WAIT_I,

    FILTER_SEND_L,
    FILTER_WAIT_L,

    FILTER_SEND_T,
    FILTER_WAIT_T,
	 
	 FILTER_SEND_E,
    FILTER_WAIT_E,
	 
	 FILTER_SEND_R,
    FILTER_WAIT_R,

    // LED
    LED_SEND_L,
    LED_WAIT_L,

    LED_SEND_E,
    LED_WAIT_E,

    LED_SEND_D,
    LED_WAIT_D


} state_t;

//two state_t objects to hold current and next state

state_t current_state = IDLE;
state_t next_state;


//HELP CASE CODE

// case logic for the next-state with current state defaulting at IDLE, for each command
always_comb begin

    next_state = current_state;

    case(current_state)

        IDLE: begin
            if(help_cmd)
                next_state = HELP_SEND_H;
            else if(debug_cmd)
                next_state = DEBUG_SEND_D;
				else if(filter_cmd)
					 next_state = FILTER_SEND_F;
				else if(led_cmd)
					 next_state = LED_SEND_L;
        end

        // HELP

        HELP_SEND_H:
            next_state = HELP_WAIT_H;

        HELP_WAIT_H:
            if(tx_done)
                next_state = HELP_SEND_E;

        HELP_SEND_E:
            next_state = HELP_WAIT_E;

        HELP_WAIT_E:
            if(tx_done)
                next_state = HELP_SEND_L;

        HELP_SEND_L:
            next_state = HELP_WAIT_L;

        HELP_WAIT_L:
            if(tx_done)
                next_state = HELP_SEND_P;

        HELP_SEND_P:
            next_state = HELP_WAIT_P;

        HELP_WAIT_P:
            if(tx_done)
                next_state = IDLE;

        // DEBUG

        DEBUG_SEND_D:
            next_state = DEBUG_WAIT_D;

        DEBUG_WAIT_D:
            if(tx_done)
                next_state = DEBUG_SEND_E;

        DEBUG_SEND_E:
            next_state = DEBUG_WAIT_E;

        DEBUG_WAIT_E:
            if(tx_done)
                next_state = DEBUG_SEND_B;

        DEBUG_SEND_B:
            next_state = DEBUG_WAIT_B;

        DEBUG_WAIT_B:
            if(tx_done)
                next_state = DEBUG_SEND_U;

        DEBUG_SEND_U:
            next_state = DEBUG_WAIT_U;

        DEBUG_WAIT_U:
            if(tx_done)
                next_state = DEBUG_SEND_G;

        DEBUG_SEND_G:
            next_state = DEBUG_WAIT_G;

        DEBUG_WAIT_G:
            if(tx_done)
                next_state = IDLE;
					 
		  //FILTER
			FILTER_SEND_F:
            next_state = FILTER_WAIT_F;
				
			FILTER_WAIT_F:
				if(tx_done)
            next_state = FILTER_SEND_I;
				
			FILTER_SEND_I:
            next_state = FILTER_WAIT_I;
				
			FILTER_WAIT_I:
				if(tx_done)
            next_state = FILTER_SEND_L;
				
			FILTER_SEND_L:
            next_state = FILTER_WAIT_L;
				
			FILTER_WAIT_L:
				if(tx_done)
            next_state = FILTER_SEND_T;
				
			FILTER_SEND_T:
            next_state = FILTER_WAIT_T;
				
			FILTER_WAIT_T:
				if(tx_done)
            next_state = FILTER_SEND_E;
				
			FILTER_SEND_E:
            next_state = FILTER_WAIT_E;
				
			FILTER_WAIT_E:
				if(tx_done)
            next_state = FILTER_SEND_R;
				
			FILTER_SEND_R:
            next_state = FILTER_WAIT_R;
				
			FILTER_WAIT_R:
				if(tx_done)
            next_state = IDLE;
			
			//LED
			LED_SEND_L:
            next_state = LED_WAIT_L;
				
			LED_WAIT_L:
				if(tx_done)
            next_state = LED_SEND_E;
				
			LED_SEND_E:
            next_state = LED_WAIT_E;
				
			LED_WAIT_E:
				if(tx_done)
            next_state = LED_SEND_D;
				
			LED_SEND_D:
            next_state = LED_WAIT_D;
				
			LED_WAIT_D:
				if(tx_done)
            next_state = IDLE;
			
        
        default:
            next_state = IDLE;

    endcase

end


//Outputting the letters depending on the state

always_comb begin

    response_tx_start = 1'b0;
    response_tx_data  = 8'h00;

    case(current_state)

        HELP_SEND_H: begin
            response_tx_start = 1'b1;
            response_tx_data  = "H";
        end

        HELP_SEND_E: begin
            response_tx_start = 1'b1;
            response_tx_data  = "E";
        end

        HELP_SEND_L: begin
            response_tx_start = 1'b1;
            response_tx_data  = "L";
        end

        HELP_SEND_P: begin
            response_tx_start = 1'b1;
            response_tx_data  = "P";
        end

        DEBUG_SEND_D: begin
            response_tx_start = 1'b1;
            response_tx_data  = "D";
        end

        DEBUG_SEND_E: begin
            response_tx_start = 1'b1;
            response_tx_data  = "E";
        end

        DEBUG_SEND_B: begin
            response_tx_start = 1'b1;
            response_tx_data  = "B";
        end

        DEBUG_SEND_U: begin
            response_tx_start = 1'b1;
            response_tx_data  = "U";
        end

        DEBUG_SEND_G: begin
            response_tx_start = 1'b1;
            response_tx_data  = "G";
        end
		  
		  //FILTER
		  
		  FILTER_SEND_F: begin
            response_tx_start = 1'b1;
            response_tx_data  = "F";
        end
		  
		  FILTER_SEND_I: begin
            response_tx_start = 1'b1;
            response_tx_data  = "I";
        end
		  
		  FILTER_SEND_L: begin
            response_tx_start = 1'b1;
            response_tx_data  = "L";
        end
		  
		  FILTER_SEND_T: begin
            response_tx_start = 1'b1;
            response_tx_data  = "T";
        end
		  
		  FILTER_SEND_E: begin
            response_tx_start = 1'b1;
            response_tx_data  = "E";
        end
		  
		  FILTER_SEND_R: begin
            response_tx_start = 1'b1;
            response_tx_data  = "R";
        end
		  
		  LED_SEND_L: begin
            response_tx_start = 1'b1;
            response_tx_data  = "L";
        end
		  
		  LED_SEND_E: begin
            response_tx_start = 1'b1;
            response_tx_data  = "E";
        end
		  
		  LED_SEND_D: begin
            response_tx_start = 1'b1;
            response_tx_data  = "D";
        end

    endcase

end

//when clock ticks positive, current state equals next state
always_ff @(posedge clk) begin
current_state <= next_state;

end


endmodule