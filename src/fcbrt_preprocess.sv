import fcbrt_defs::*;

module fcbrt_preprocess(
    input logic clk_i,
    input logic rst_ni,

    input logic fmt_sel_i,                          
    input logic start_i,
    input logic ready_i,
    input logic [C_RM-1:0] rm_i,

    input logic [C_OP_FP64-1:0] operand_i,

    output logic start_dly_o,
    output logic [C_RM-1:0] rm_o,
    output logic fmt_sel_o,
    
    output logic sign_o,
    output logic [1:0] shift_num_o,                 // 尾数右移位数，即指数需要加上的位数
    output logic [C_EXP_FP64-1:0] exp_bias_o,       // 带有偏置的
    output logic [C_MANT_FP64+3:0] mant_norm_o,     // 归一化尾数，0.125-1

    output logic [C_LZCNT-1:0] lzcnt_o,             // 前导零计数
    output logic is_subnormal_o,                    // 1'b0是规格化数，1'b1是次规格化数

    output logic is_inf_o,
    output logic is_zero_o,
    output logic is_NaN_o,                          // 暂时不区分qNaN与sNaN    
    output logic special_case_o

);

    logic sign_operand;
    logic [C_EXP_FP64-1:0] exp_operand;
    logic [C_MANT_FP64-1:0] mant_operand_nonh;

    always_comb begin
        case(fmt_sel_i)
            C_FS_SP: begin
                sign_operand = operand_i[C_OP_FP32-1];
                // fp32 
                // ......
                // ......
            end
            C_FS_DP: begin
                sign_operand = operand_i[C_OP_FP64-1];
                exp_operand = operand_i[C_OP_FP64-2:C_MANT_FP64];
                mant_operand_nonh = operand_i[C_MANT_FP64-1:0];
            end
            default: begin
                sign_operand = '0;
                exp_operand = '0;
                mant_operand_nonh = '0;
            end
        endcase
    end

    logic is_NaN_N;
    logic is_zero_N;
    logic is_inf_N;
    logic is_NaN_P;
    logic is_zero_P;
    logic is_inf_P;
    logic is_subnormal_N;
    logic is_subnormal_P;

    assign is_zero_N = (start_i&&ready_i)?((~(|exp_operand))&&(~(|mant_operand_nonh))):is_zero_P;
    assign is_inf_N = (start_i&&ready_i)?((&exp_operand)&&(~(|mant_operand_nonh))):is_inf_P;
    assign is_NaN_N = (start_i&&ready_i)?((&exp_operand)&&(|mant_operand_nonh)):is_NaN_P;
    assign is_subnormal_N = (start_i&&ready_i)?((~(|exp_operand))&&(|mant_operand_nonh)):is_subnormal_P;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            is_zero_P <= '0;
            is_inf_P <= '0;
            is_NaN_P <= '0;
            is_subnormal_P <= '0;
        end else begin
            is_zero_P<= is_zero_N;
            is_inf_P <= is_inf_N;
            is_NaN_P <= is_NaN_N;
            is_subnormal_P <= is_subnormal_N;
        end
    end

    logic special_case_N;
    logic special_case_P;

    assign special_case_N = (start_i&&ready_i)?(is_zero_N||is_inf_N||is_NaN_N):special_case_P;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            special_case_P <= '0;
        end else begin
            special_case_P <= special_case_N;
        end
    end


    logic sign_N;
    logic sign_P;

    assign sign_N = (start_i&&ready_i)?sign_operand:sign_P;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            sign_P <= '0;
        end else begin
            sign_P <= sign_N;
        end
    end

    logic [C_EXP_FP64-1:0] exp_operand_N;
    logic [C_EXP_FP64-1:0] exp_operand_P;

    assign exp_operand_N = (start_i&&ready_i)?exp_operand:exp_operand_P;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            exp_operand_P <= '0;
        end else begin
            exp_operand_P <= exp_operand_N;
        end
    end

    logic [C_RM-1:0] rm_N;
    logic [C_RM-1:0] rm_P;

    assign rm_N = (start_i&&ready_i)?rm_i:rm_P;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            rm_P <= '0;
        end else begin
            rm_P <= rm_N;
        end
    end

    logic fmt_sel_N;
    logic fmt_sel_P;

    assign fmt_sel_N = (start_i&&ready_i)?fmt_sel_i:fmt_sel_P;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            fmt_sel_P <= '0;
        end else begin
            fmt_sel_P <= fmt_sel_N;
        end
    end

    logic start_N, start_P;

    assign start_N = (start_i&&ready_i)?1'b1:1'b0;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            start_P <= 'b0;
        end else begin
            start_P <= start_N;
        end
    end

    logic [C_LZCNT-1:0] lzcnt;
    logic [C_LZCNT-1:0] lzcnt_N;
    logic [C_LZCNT-1:0] lzcnt_P;

    lzc #(
        .WIDTH ( C_MANT_FP64 ),
        .MODE  ( 1           )
    ) u1_lzc (
        .in_i    ( mant_operand_nonh ),
        .cnt_o   ( lzcnt ),
        .empty_o (      )
    ); 
    assign lzcnt_N = (start_i&&ready_i)?lzcnt:lzcnt_P;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            lzcnt_P <= '0;
        end else begin
            lzcnt_P <= lzcnt_N;
        end
    end

    logic [C_MANT_FP64:0] mant_operand_norm;

    assign mant_operand_norm = is_subnormal_N?{mant_operand_nonh << lzcnt_N, 1'b0}:{1'b1,mant_operand_nonh};

    logic [C_EXP_FP64-1:0] mod3_i;
    logic [1:0] mod3_o;

    assign mod3_i = is_subnormal_N?{{(C_EXP_FP64-C_LZCNT){1'b0}}, lzcnt_N}:exp_operand_N;
 
    logic [3:0] even_cnt;
    logic [3:0] odd_cnt;
    logic signed [4:0] diff;

    always_comb begin
        // bit[0], bit[2], bit[4], bit[6], bit[8], bit[10]
        even_cnt = {3'b0, mod3_i[0]}
                   + {3'b0, mod3_i[2]}
                   + {3'b0, mod3_i[4]}
                   + {3'b0, mod3_i[6]}
                   + {3'b0, mod3_i[8]}
                   + {3'b0, mod3_i[10]};

        // bit[1], bit[3], bit[5], bit[7], bit[9]
        odd_cnt = {3'b0, mod3_i[1]}
                   + {3'b0, mod3_i[3]}
                   + {3'b0, mod3_i[5]}
                   + {3'b0, mod3_i[7]}
                   + {3'b0, mod3_i[9]};

        diff = $signed({1'b0, even_cnt}) - $signed({1'b0, odd_cnt});

        case(diff)
            -5, -2, 1, 4: mod3_o = 2'd1;
            -4, -1, 2, 5: mod3_o = 2'd2;
            -3,  0, 3, 6: mod3_o = 2'd0;
            default: mod3_o = 2'd0;
        endcase
    end

    logic [1:0] shift_num_N;
    logic [1:0] shift_num_P;
    logic [C_MANT_FP64+3:0] mant_norm_N;
    logic [C_MANT_FP64+3:0] mant_norm_P;

    always_comb begin
        if (start_i&&ready_i) begin
            if (is_subnormal_N) begin
                case(mod3_o)
                    2'd0: begin
                        shift_num_N = 2'd3;
                        mant_norm_N = {3'b0, mant_operand_norm};
                    end
                    2'd1: begin
                        shift_num_N = 2'd1;
                        mant_norm_N = {1'b0, mant_operand_norm,2'b0};
                    end
                    2'd2: begin
                        shift_num_N = 2'd2;
                        mant_norm_N = {2'b0, mant_operand_norm,1'b0};
                    end
                    default: begin
                        shift_num_N = 2'd0;
                        mant_norm_N = '0;
                    end
                endcase
            end else begin
                case(mod3_o)
                    2'd0: begin
                        shift_num_N = 2'd3;
                        mant_norm_N = {3'b0, mant_operand_norm};
                    end
                    2'd1: begin
                        shift_num_N = 2'd2;
                        mant_norm_N = {2'b0, mant_operand_norm,1'b0};
                    end
                    2'd2: begin
                        shift_num_N = 2'd1;
                        mant_norm_N = {1'b0, mant_operand_norm,2'b0};
                    end
                    default: begin
                        shift_num_N = 2'd0;
                        mant_norm_N = '0;
                    end
                endcase
            end
        end else begin
            shift_num_N = shift_num_P;
            mant_norm_N = mant_norm_P;
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            shift_num_P <= '0;
        end else begin
            shift_num_P <= shift_num_N;
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            mant_norm_P <= '0;
        end else begin
            mant_norm_P <= mant_norm_N;
        end
    end


    // 输出
    assign sign_o = sign_P;
    assign rm_o = rm_P;
    assign start_dly_o = start_P;
    assign is_subnormal_o = is_subnormal_P;
    assign special_case_o = special_case_P;
    assign is_inf_o = is_inf_P;
    assign is_zero_o = is_zero_P;
    assign is_NaN_o = is_NaN_P;
    assign lzcnt_o = lzcnt_P;
    assign exp_bias_o = exp_operand_P;
    assign shift_num_o = shift_num_P;
    assign mant_norm_o = mant_norm_P;
    assign fmt_sel_o = fmt_sel_P;

endmodule