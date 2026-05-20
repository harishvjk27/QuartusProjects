module uart_tx(

input logic [7:0] hex_input,

input logic clk,

input logic send,

output logic tx //the output is usually in the form of 
									 // stop, 8 bits data, start from left to right

);

logic [9:0] shift_reg = 10'b1111111111;
logic [3:0] bit_counter = 10;


always_ff @(posedge clk) begin

	if (send) begin //if send input is 1

	shift_reg <= {1'b1, hex_input, 1'b0}; //filling out the full uart response
	bit_counter<= 0; //resetting the bit counter
	tx <= 1'b0; //output the start bit
	end

	else if(bit_counter < 10) begin //if send is not 1
	tx <= shift_reg[0]; //setting the output tx to the shift register
	shift_reg <= shift_reg >> 1; //shifting the register right by 1, (diving by 2 in decimal)
	bit_counter <= bit_counter + 1; //adding 1 to the bit counter
	end
	
	else begin //if send is not 1 and bit counter is 10 or greater (meaning we have finished going through the values)
	tx <= 1'b1; //output is just 1

 //this module sets the output to each bit of the frame, and returns it when send is not 1 until the full uart input is done
//uart stands for universal asynchronous reciever transmitter
// it translates data from the fpga to the computer, so if the fpga wants to send 123, uart sends it as bits 00110001, 00110010, 00110011
// uart sends ascii values, that why the binary bits have extra 1s, its its ascii translation as a CHARACTER
	end
	
end
endmodule