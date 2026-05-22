module uart_tx(

input logic [7:0] hex_input,

input logic clk,

input logic send,

output logic tx, //the output is usually in the form of 
					 // stop, 8 bits data, start from left to right
					 
output logic done

);

logic [9:0] shift_reg = 10'b1111111111;
logic [3:0] bit_counter = 10;

// baud div is 50,000,000 / 115200 baud = ~434
localparam BAUD_DIV = 434; //localparam is like a static final variable in a class
logic [9:0] baud_counter = 0;
logic baud_tick = 0;

//busy state
logic busy = 0;

//this module sets the output to each bit of the frame, and returns it when send is not 1 until the full uart input is done
//uart stands for universal asynchronous reciever transmitter
// it translates data from the fpga to the computer, so if the fpga wants to send 123, uart sends it as bits 00110001, 00110010, 00110011
// uart sends ascii values, that why the binary bits have extra 1s, its its ascii translation as a CHARACTER

always_ff @(posedge clk) begin

	if (send && !busy) begin //if send input is 1
	
	busy <= 1'b1; //setting busy to 1 because send is 1, so register is transmitting
	done <= 1'b0; //not finished
	shift_reg <= {1'b1, hex_input, 1'b0}; //filling out the full uart response
	bit_counter<= 0; //resetting the bit counter
	tx <= 1'b0; //output the start bit  which is 0

	end

	else if(bit_counter < 10 && baud_tick) begin //if send is not 1 AND baud_tick is 1(we are at the correct baud)
	
	tx <= shift_reg[0]; //setting the output tx to the shift register
	
	shift_reg <= shift_reg >> 1; //shifting the register right by 1, (diving by 2 in decimal)
	
	bit_counter <= bit_counter + 1; //adding 1 to the bit counter
	end
	
	else if(bit_counter ==10) begin //if send is not 1 and bit counter is 10 or greater (meaning we have finished going through the values)
	busy <= 1'b0; //no  longer busy, and values are finished transmitting
	done <= 1'b1; //label to show transmitting has finished
	tx <= 1'b1; //output is just 1 (stop bit is 1 when done)
	
	end
	
	else begin
		done <= 1'b0;
	end
	
end


//baud counter
//updates the baud_tick as if it were a clock, only when the baud_div is hit on the positive edge of a clk


always_ff @(posedge clk) begin 

if (baud_counter == BAUD_DIV-1) begin //if baud_counter is going to hit the BAUD_DIV-1 because the counter starts at 0, so 434 ticks is 0-433.

	baud_counter<= 0; //reset counter
	baud_tick <= 1; //set baud_tick to 1
	
end
	else begin //if not at baud_DIV
	
		baud_counter <= baud_counter + 1; //Keep incrementing baud_counter
		baud_tick <= 0; //tick is still 0
		
	end

end

endmodule