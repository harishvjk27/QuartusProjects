module tb_seven_seg_decoder;

logic [3:0] value;
logic [6:0] segment;

seven_seg_decoder dut (

.val(value),
.seg(segment)

);

initial begin 

$monitor ("time = %0t, value = %0d, seg = %0b", $time, value, segment);

value = 0;
#20


value = 1;
#20


value = 2;
#20


value = 3;
#20;



$stop;
end


endmodule

