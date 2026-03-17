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

    wire                   	start_dly_o;
    wire [C_RM-1:0]        	rm_o;
    wire                   	fmt_sel_o;
    wire                   	sign_o;
    wire [1:0]             	shift_num_o;
    wire [C_EXP_FP64-1:0]  	exp_bias_o;
    wire [C_MANT_FP64+3:0] 	mant_norm_o;
    wire [C_LZCNT-1:0]     	lzcnt_o;
    wire                   	is_subnormal_o;
    wire                   	is_inf_o;
    wire                   	is_zero_o;
    wire                   	is_NaN_o;
    wire                   	special_case_o;

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
        .is_NaN_o       	( is_NaN_o        ),
        .special_case_o 	( special_case_o  )
    );


endmodule