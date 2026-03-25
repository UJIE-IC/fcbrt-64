import fcbrt_defs::*;

module fcbrt_top(
    input logic clk_i,
    input logic rst_ni,

    input logic fmt_sel_i,                  // 现只实现FP64通路
    input logic start_i,
    input logic [C_RM-1:0] rm_i,            // 现只实现向偶数舍入

    input logic [C_OP_FP64-1:0] operand_i,

    output logic [C_OP_FP64-1:0] result_o,

    output logic ready_o,
    output logic done_o
);

    logic [C_RM-1:0] rm_o;
    logic [1:0] shift_num_o;
    logic [C_EXP_FP64-1:0] exp_bias_o;
    logic [C_MANT_FP64+3:0] mant_norm_o;
    logic [C_LZCNT-1:0] lzcnt_o;

    logic is_subnormal_o;
    logic is_inf_o;
    logic is_zero_o;
    logic is_NaN_o;
    logic special_case_o;

    logic start_dly_o;
    logic fmt_sel_o;
    logic sign_o;

    logic start_o;

    logic [C_MANT_FP64+4:0] mant_o;
    logic [C_EXP_FP64-1:0] exp_bias_core_o;
    logic special_case_core_o;
    logic sticky_o;

    fcbrt_preprocess u_fcbrt_preprocess(
        .clk_i          	( clk_i           ),
        .rst_ni         	( rst_ni          ),
        .fmt_sel_i      	( fmt_sel_i       ),
        .start_i        	( start_i         ),
        .ready_i        	( ready_o         ),
        .rm_i           	( rm_i            ),
        .operand_i      	( operand_i       ),
        .start_dly_o        ( start_dly_o     ),
        .rm_o           	( rm_o            ), 
        .fmt_sel_o      	( fmt_sel_o       ),
        .sign_o         	( sign_o          ),
        .shift_num_o    	( shift_num_o     ),
        .exp_bias_o     	( exp_bias_o      ),
        .mant_norm_o    	( mant_norm_o     ),
        .lzcnt_o        	( lzcnt_o         ),
        .is_subnormal_o 	( is_subnormal_o  ),
        .is_inf_o       	( is_inf_o        ),
        .is_zero_o      	( is_zero_o       ),
        .is_NaN_o       	( is_NaN_o        ), //QNaN & SNaN
        .special_case_o 	( special_case_o  )
    );

    fcbrt_core u_fcbrt_core(
        .clk_i          	( clk_i           ),
        .rst_ni         	( rst_ni          ),
        .fmt_sel_i      	( fmt_sel_o       ),
        .start_i        	( start_i         ),
        .start_dly_i    	( start_dly_o     ),
        .mant_norm_i    	( mant_norm_o     ),
        .exp_bias_i     	( exp_bias_o      ),
        .shift_num_i    	( shift_num_o     ),
        .lzcnt_i        	( lzcnt_o         ),
        .is_subnormal_i 	( is_subnormal_o  ),
        .special_case_i 	( special_case_o  ),
        .ready_o        	( ready_o         ),
        .start_o        	( start_o         ),
        .mant_o         	( mant_o          ),
        .exp_bias_o     	( exp_bias_core_o      ),
        .special_case_o 	( special_case_core_o  ),
        .sticky_o       	( sticky_o        )
    );

    fcbrt_postprocess u_fcbrt_postprocess(
        .clk_i           	( clk_i            ),
        .rst_ni          	( rst_ni           ),
        .start_i         	( start_o          ),
        .fmt_sel_i       	( fmt_sel_o        ),
        .rm_i            	( rm_o             ),
        .is_inf_i        	( is_inf_o         ),
        .is_NaN_i        	( is_NaN_o         ),
        .is_zero_i       	( is_zero_o        ),
        .special_case_i  	( special_case_core_o   ),
        .sign_i             ( sign_o           ),
        .mant_core_i     	( mant_o      ),
        .exp_bias_core_i 	( exp_bias_core_o  ),
        .sticky_i        	( sticky_o         ),
        .fcbrt_result_o  	( result_o   ),
        .done_o          	( done_o           )
    );


endmodule