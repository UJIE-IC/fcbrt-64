import fcbrt_defs::*;

module fcbrt_top(
    input logic clk_i,
    input logic rst_ni,

    input logic fmt_sel_i,
    input logic start_i,
    input logic [C_RM-1:0] rm_i,

    input logic [C_OP_FP64-1:0] operand_i,

    output logic [C_OP_FP64-1:0] result_o,

    output logic [4:0] flags_o,
    output logic ready_o,
    output logic done_o
);
endmodule