import fcbrt_defs::*;

module fcbrt_postprocess(
    input logic clk_i,
    input logic rst_ni,

    input logic start_i,

    input logic fmt_sel_i,     // 未作处理
    input logic [C_RM-1:0] rm_i,   // 未作处理
    input logic is_inf_i,
    input logic is_NaN_i,
    input logic is_zero_i,
    input logic special_case_i,

    input logic sign_i,
    input logic [C_MANT_FP64+4:0] mant_core_i,
    input logic [C_EXP_FP64-1:0] exp_bias_core_i,
    input logic sticky_i,

    output logic [C_OP_FP64-1:0] fcbrt_result_o,
    output logic done_o
);

    logic post_process_start;
    logic [C_OP_FP64-1:0] fcbrt_result;
    logic [C_OP_FP64-1:0] fcbrt_result_unspec;
    logic [C_OP_FP64-1:0] fcbrt_result_Reg;

    logic guard_bit;
    logic round_bit;
    logic sticky_bit;
    logic round_inc;

    logic [C_MANT_FP64+4:0] mant_round;
    logic [C_MANT_FP64-1:0] mant_norm;
    logic [C_EXP_FP64-1:0] exp_bias_norm;

    assign guard_bit = mant_core_i[2];
    assign round_bit = mant_core_i[1];
    assign sticky_bit = mant_core_i[0] || sticky_i;
    assign round_inc = guard_bit & (round_bit | sticky_bit | mant_core_i[3]);
    assign mant_round = (round_inc)?(mant_core_i+{{(C_MANT_FP64+1){1'b0}}, 1'b1, 3'b0}):mant_core_i;
    assign mant_norm = (mant_round[C_MANT_FP64+4])?(mant_round[C_MANT_FP64+3:4]):mant_round[C_MANT_FP64+2:3];
    assign exp_bias_norm = (mant_round[C_MANT_FP64+4])?(exp_bias_core_i+{{(C_EXP_FP64-1){1'b0}}, 1'b1}):exp_bias_core_i;
    assign fcbrt_result_unspec = {sign_i, exp_bias_norm, mant_norm};

    assign post_process_start = start_i || special_case_i;

    always_comb begin
        if (post_process_start) begin
            if (special_case_i) begin
                fcbrt_result = (is_inf_i)?(sign_i?C_FP64_NEG_INF:C_FP64_POS_INF):
                                          ((is_zero_i)?(sign_i?C_FP64_NEG_ZERO:C_FP64_POS_ZERO):
                                           ((is_NaN_i)?(sign_i?C_FP64_NEG_QNAN:C_FP64_POS_QNAN):'0));
            end else begin
                fcbrt_result = fcbrt_result_unspec;
            end
        end else begin
            fcbrt_result = '0;
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            done_o <= '0;
            fcbrt_result_Reg <= '0;
        end else if (post_process_start) begin
            done_o <= 1'b1;
            fcbrt_result_Reg <= fcbrt_result;
        end else begin
            done_o <= 1'b0;                               // done信号持续一个周期
            fcbrt_result_Reg <= fcbrt_result_Reg;
        end
    end

    assign fcbrt_result_o = fcbrt_result_Reg;

endmodule