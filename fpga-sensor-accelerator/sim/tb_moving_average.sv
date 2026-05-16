module tb_moving_average; //cause there is no input

logic clk;
logic rst;
logic valid_in;
logic signed[15:0] sample_in;

logic signed[15:0] average_out;


moving_average dut( //dut is just the instance name, dut is device under test
    .clk(clk),
    .rst(rst),
    .valid_in(valid_in),
    .sample_in(sample_in),
    .average_out(average_out)
);

initial begin
    clk = 0;
end

always #10 clk = ~clk; //every 10 simulation units, the clk changes

initial begin // initial means it runs at start 
    rst = 0;
    valid_in = 0;
    sample_in = 0;

    #25; //for simulation delay. so wait 25 simulation units

    rst = 1;
    valid_in = 1;

    sample_in = -16'sd10;
    #20;

    sample_in = -16'sd20;
    #20;

    sample_in = -16'sd30;
    #20

    sample_in = -16'sd40;
    #20;

    sample_in = -16'sd50;
    #20;

    $stop;
    end

    always @(posedge clk) begin

        $display(
            "time = %0t sample = %0d average = %0d",
            $time,
            sample_in,
            average_out,
        );

    end
endmodule