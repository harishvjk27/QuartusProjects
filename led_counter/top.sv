module top (
		
		input logic MAX10_CLK1_50,
		input logic [9:0] SW,
		output logic [9:0] LEDR
		
		);
		
		
			logic [31:0] counter = 0;

			
			always_ff @(posedge MAX10_CLK1_50) begin //if using clock, use always ff
			
			counter <= counter + 1;
			
			end
			
		
		always_comb begin //if using current inputs / no memory, use always comb
			
			if (SW[0]) 
				LEDR = counter[31:22];  //slowest
			
			else if (SW[1])
				LEDR = counter[29:20];  //fast
				
			else if(SW[2])
				LEDR = counter[27:18];	//very fast
			
			else if(SW[3]) 
				LEDR = counter[25:16];  //very very fast
				
			else
				LEDR = counter[23:14];	//very very very fast / DEFAULT
			
		end
			
			endmodule