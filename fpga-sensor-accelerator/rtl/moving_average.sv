module moving_average ( //average of 4 moving sample in relation to the clock
    input logic clk,
    input logic rst,
    input logic valid_in, //valid in should be 1 bit
    input logic signed [15:0] sample_in, 

    output logic signed [15:0] average_out //average is the one being outputted

);

	
	logic signed [15:0] sample0;
   logic signed [15:0] sample1;
   logic signed [15:0] sample2;
   logic signed [15:0] sample3;
	
	logic signed [17:0] sum_out; //sum has to be a bigger bit width than the values within it, since we are adding 16 bit values, it must be more
   
	always_ff @(posedge clk) begin
    
  
        if (!rst) begin
		  
        sample0 <= 0;
        sample1 <= 0;
        sample2 <= 0;
        sample3 <= 0;
        end 

        else if (valid_in) begin
        sample3 <= sample2;
        sample2 <= sample1;
        sample1 <= sample0;
        sample0 <= sample_in;
        end
    
    end
    
    always_comb begin
        
    sum_out = sample0 + sample1 + sample2 + sample3;
    average_out = sum_out >>> 2; //arithmetic shift right, rounds up and sign extends
    
    end

    endmodule