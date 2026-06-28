module program_counter (

input logic clk,
input logic reset,
input logic enable,


output logic [7:0] pc
);



always_ff @(posedge clk) begin 

if (reset == 1'b1) begin
	pc <= 0;
	
	end
	
	
else if (enable == 1'b1) begin

	pc <= pc + 1;
	end

end


endmodule
