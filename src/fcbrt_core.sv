import fcbrt_defs::*;

module fcbrt_core(
    input logic clk_i,
    input logic rst_ni,
    
    input logic fmt_sel_i,
    input logic start_i,
    input logic start_dly_i,

    input logic [C_MANT_FP64+3:0] mant_norm_i,  // 一位整数位+若干小数位
    input logic [C_EXP_FP64-1:0] exp_bias_i,
    input logic [1:0] shift_num_i,

    input logic [C_LZCNT-1:0] lzcnt_i,
    input logic is_subnormal_i,

    input logic special_case_i,

    output logic ready_o,
    output logic start_o,
    output logic [C_MANT_FP64+3:0] mant_o,
    output logic [C_EXP_FP64-1:0] exp_bias_o
);

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            ready_o <= 1'b1;
        end else if (start_i&&ready_o) begin
            ready_o <= 1'b0;
        end else if (1) begin         // 待修改
            ready_o <= 1'b1;
        end else begin
            ready_o <= ready_o;
        end
    end

    logic fcbrt_en;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            fcbrt_en <= 1'b0;
        end else if (start_i&&ready_o) begin
            fcbrt_en <= 1'b1;
        end else if (1) begin        // 待修改
            fcbrt_en <= 1'b0;
        end else begin
            fcbrt_en <= fcbrt_en;
        end
    end


    // ML-PLAC Initial
    logic [C_INIT_IW-1:0] mant_init_i;  // 不带整数位
    logic [C_INIT_OW-1:0] mant_init_o;  // 带有一位的整数位      、

    assign mant_init_i = (start_dly_i)?mant_norm_i[C_MANT_FP64+2-:C_INIT_IW]:'0;             

    fcbrt_ML_PLAC u_fcbrt_ML_PLAC(
        .x_in  	( mant_init_i  ),
        .y_out 	( mant_init_o  )
    );



endmodule