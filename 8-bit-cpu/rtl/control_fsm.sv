module control_fsm (

input logic clk,
input logic reset,

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


endmodule