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
    output logic [C_MANT_FP64+4:0] mant_o,
    output logic [C_EXP_FP64-1:0] exp_bias_o,
    output logic special_case_o,
    output logic sticky_o                       // 舍入粘滞位
);

    // 全局控制信号
    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            ready_o <= 1'b1;
        end else if (start_i&&ready_o) begin
            ready_o <= 1'b0;
        end else if (start_o||special_case_i) begin         
            ready_o <= 1'b1;
        end else begin
            ready_o <= ready_o;
        end
    end

    // special case 旁路
    logic core_start;
    assign core_start = start_dly_i && (~special_case_i);

    // ML-PLAC Init
    logic [C_INIT_IW-1:0] mant_init_i;  // 不带整数位
    logic [C_INIT_OW-1:0] mant_init_o;  // 带有一位的整数位      、

    assign mant_init_i = (core_start)?mant_norm_i[C_MANT_FP64+2-:C_INIT_IW]:'0;             

    fcbrt_ML_PLAC u_fcbrt_ML_PLAC(
        .x_in  	( mant_init_i  ),
        .y_out 	( mant_init_o  )
    );

    logic [2*(C_INIT_OW-1):0] init_sq_o; // U1.16
    logic [3*(C_INIT_OW-1):0] init_cb_o; // U1.24
    logic [7:0] lut_idx;

    assign lut_idx = mant_init_o - 9'h080;

    always_comb begin
        case(lut_idx)
            8'd  0: begin init_sq_o = 17'h04000; init_cb_o = 25'h0200000; end // x0 = 0.50000000
            8'd  1: begin init_sq_o = 17'h04101; init_cb_o = 25'h020c181; end // x0 = 0.50390625
            8'd  2: begin init_sq_o = 17'h04204; init_cb_o = 25'h0218608; end // x0 = 0.50781250
            8'd  3: begin init_sq_o = 17'h04309; init_cb_o = 25'h0224d9b; end // x0 = 0.51171875
            8'd  4: begin init_sq_o = 17'h04410; init_cb_o = 25'h0231840; end // x0 = 0.51562500
            8'd  5: begin init_sq_o = 17'h04519; init_cb_o = 25'h023e5fd; end // x0 = 0.51953125
            8'd  6: begin init_sq_o = 17'h04624; init_cb_o = 25'h024b6d8; end // x0 = 0.52343750
            8'd  7: begin init_sq_o = 17'h04731; init_cb_o = 25'h0258ad7; end // x0 = 0.52734375
            8'd  8: begin init_sq_o = 17'h04840; init_cb_o = 25'h0266200; end // x0 = 0.53125000
            8'd  9: begin init_sq_o = 17'h04951; init_cb_o = 25'h0273c59; end // x0 = 0.53515625
            8'd 10: begin init_sq_o = 17'h04a64; init_cb_o = 25'h02819e8; end // x0 = 0.53906250
            8'd 11: begin init_sq_o = 17'h04b79; init_cb_o = 25'h028fab3; end // x0 = 0.54296875
            8'd 12: begin init_sq_o = 17'h04c90; init_cb_o = 25'h029dec0; end // x0 = 0.54687500
            8'd 13: begin init_sq_o = 17'h04da9; init_cb_o = 25'h02ac615; end // x0 = 0.55078125
            8'd 14: begin init_sq_o = 17'h04ec4; init_cb_o = 25'h02bb0b8; end // x0 = 0.55468750
            8'd 15: begin init_sq_o = 17'h04fe1; init_cb_o = 25'h02c9eaf; end // x0 = 0.55859375
            8'd 16: begin init_sq_o = 17'h05100; init_cb_o = 25'h02d9000; end // x0 = 0.56250000
            8'd 17: begin init_sq_o = 17'h05221; init_cb_o = 25'h02e84b1; end // x0 = 0.56640625
            8'd 18: begin init_sq_o = 17'h05344; init_cb_o = 25'h02f7cc8; end // x0 = 0.57031250
            8'd 19: begin init_sq_o = 17'h05469; init_cb_o = 25'h030784b; end // x0 = 0.57421875
            8'd 20: begin init_sq_o = 17'h05590; init_cb_o = 25'h0317740; end // x0 = 0.57812500
            8'd 21: begin init_sq_o = 17'h056b9; init_cb_o = 25'h03279ad; end // x0 = 0.58203125
            8'd 22: begin init_sq_o = 17'h057e4; init_cb_o = 25'h0337f98; end // x0 = 0.58593750
            8'd 23: begin init_sq_o = 17'h05911; init_cb_o = 25'h0348907; end // x0 = 0.58984375
            8'd 24: begin init_sq_o = 17'h05a40; init_cb_o = 25'h0359600; end // x0 = 0.59375000
            8'd 25: begin init_sq_o = 17'h05b71; init_cb_o = 25'h036a689; end // x0 = 0.59765625
            8'd 26: begin init_sq_o = 17'h05ca4; init_cb_o = 25'h037baa8; end // x0 = 0.60156250
            8'd 27: begin init_sq_o = 17'h05dd9; init_cb_o = 25'h038d263; end // x0 = 0.60546875
            8'd 28: begin init_sq_o = 17'h05f10; init_cb_o = 25'h039edc0; end // x0 = 0.60937500
            8'd 29: begin init_sq_o = 17'h06049; init_cb_o = 25'h03b0cc5; end // x0 = 0.61328125
            8'd 30: begin init_sq_o = 17'h06184; init_cb_o = 25'h03c2f78; end // x0 = 0.61718750
            8'd 31: begin init_sq_o = 17'h062c1; init_cb_o = 25'h03d55df; end // x0 = 0.62109375
            8'd 32: begin init_sq_o = 17'h06400; init_cb_o = 25'h03e8000; end // x0 = 0.62500000
            8'd 33: begin init_sq_o = 17'h06541; init_cb_o = 25'h03fade1; end // x0 = 0.62890625
            8'd 34: begin init_sq_o = 17'h06684; init_cb_o = 25'h040df88; end // x0 = 0.63281250
            8'd 35: begin init_sq_o = 17'h067c9; init_cb_o = 25'h04214fb; end // x0 = 0.63671875
            8'd 36: begin init_sq_o = 17'h06910; init_cb_o = 25'h0434e40; end // x0 = 0.64062500
            8'd 37: begin init_sq_o = 17'h06a59; init_cb_o = 25'h0448b5d; end // x0 = 0.64453125
            8'd 38: begin init_sq_o = 17'h06ba4; init_cb_o = 25'h045cc58; end // x0 = 0.64843750
            8'd 39: begin init_sq_o = 17'h06cf1; init_cb_o = 25'h0471137; end // x0 = 0.65234375
            8'd 40: begin init_sq_o = 17'h06e40; init_cb_o = 25'h0485a00; end // x0 = 0.65625000
            8'd 41: begin init_sq_o = 17'h06f91; init_cb_o = 25'h049a6b9; end // x0 = 0.66015625
            8'd 42: begin init_sq_o = 17'h070e4; init_cb_o = 25'h04af768; end // x0 = 0.66406250
            8'd 43: begin init_sq_o = 17'h07239; init_cb_o = 25'h04c4c13; end // x0 = 0.66796875
            8'd 44: begin init_sq_o = 17'h07390; init_cb_o = 25'h04da4c0; end // x0 = 0.67187500
            8'd 45: begin init_sq_o = 17'h074e9; init_cb_o = 25'h04f0175; end // x0 = 0.67578125
            8'd 46: begin init_sq_o = 17'h07644; init_cb_o = 25'h0506238; end // x0 = 0.67968750
            8'd 47: begin init_sq_o = 17'h077a1; init_cb_o = 25'h051c70f; end // x0 = 0.68359375
            8'd 48: begin init_sq_o = 17'h07900; init_cb_o = 25'h0533000; end // x0 = 0.68750000
            8'd 49: begin init_sq_o = 17'h07a61; init_cb_o = 25'h0549d11; end // x0 = 0.69140625
            8'd 50: begin init_sq_o = 17'h07bc4; init_cb_o = 25'h0560e48; end // x0 = 0.69531250
            8'd 51: begin init_sq_o = 17'h07d29; init_cb_o = 25'h05783ab; end // x0 = 0.69921875
            8'd 52: begin init_sq_o = 17'h07e90; init_cb_o = 25'h058fd40; end // x0 = 0.70312500
            8'd 53: begin init_sq_o = 17'h07ff9; init_cb_o = 25'h05a7b0d; end // x0 = 0.70703125
            8'd 54: begin init_sq_o = 17'h08164; init_cb_o = 25'h05bfd18; end // x0 = 0.71093750
            8'd 55: begin init_sq_o = 17'h082d1; init_cb_o = 25'h05d8367; end // x0 = 0.71484375
            8'd 56: begin init_sq_o = 17'h08440; init_cb_o = 25'h05f0e00; end // x0 = 0.71875000
            8'd 57: begin init_sq_o = 17'h085b1; init_cb_o = 25'h0609ce9; end // x0 = 0.72265625
            8'd 58: begin init_sq_o = 17'h08724; init_cb_o = 25'h0623028; end // x0 = 0.72656250
            8'd 59: begin init_sq_o = 17'h08899; init_cb_o = 25'h063c7c3; end // x0 = 0.73046875
            8'd 60: begin init_sq_o = 17'h08a10; init_cb_o = 25'h06563c0; end // x0 = 0.73437500
            8'd 61: begin init_sq_o = 17'h08b89; init_cb_o = 25'h0670425; end // x0 = 0.73828125
            8'd 62: begin init_sq_o = 17'h08d04; init_cb_o = 25'h068a8f8; end // x0 = 0.74218750
            8'd 63: begin init_sq_o = 17'h08e81; init_cb_o = 25'h06a523f; end // x0 = 0.74609375
            8'd 64: begin init_sq_o = 17'h09000; init_cb_o = 25'h06c0000; end // x0 = 0.75000000
            8'd 65: begin init_sq_o = 17'h09181; init_cb_o = 25'h06db241; end // x0 = 0.75390625
            8'd 66: begin init_sq_o = 17'h09304; init_cb_o = 25'h06f6908; end // x0 = 0.75781250
            8'd 67: begin init_sq_o = 17'h09489; init_cb_o = 25'h071245b; end // x0 = 0.76171875
            8'd 68: begin init_sq_o = 17'h09610; init_cb_o = 25'h072e440; end // x0 = 0.76562500
            8'd 69: begin init_sq_o = 17'h09799; init_cb_o = 25'h074a8bd; end // x0 = 0.76953125
            8'd 70: begin init_sq_o = 17'h09924; init_cb_o = 25'h07671d8; end // x0 = 0.77343750
            8'd 71: begin init_sq_o = 17'h09ab1; init_cb_o = 25'h0783f97; end // x0 = 0.77734375
            8'd 72: begin init_sq_o = 17'h09c40; init_cb_o = 25'h07a1200; end // x0 = 0.78125000
            8'd 73: begin init_sq_o = 17'h09dd1; init_cb_o = 25'h07be919; end // x0 = 0.78515625
            8'd 74: begin init_sq_o = 17'h09f64; init_cb_o = 25'h07dc4e8; end // x0 = 0.78906250
            8'd 75: begin init_sq_o = 17'h0a0f9; init_cb_o = 25'h07fa573; end // x0 = 0.79296875
            8'd 76: begin init_sq_o = 17'h0a290; init_cb_o = 25'h0818ac0; end // x0 = 0.79687500
            8'd 77: begin init_sq_o = 17'h0a429; init_cb_o = 25'h08374d5; end // x0 = 0.80078125
            8'd 78: begin init_sq_o = 17'h0a5c4; init_cb_o = 25'h08563b8; end // x0 = 0.80468750
            8'd 79: begin init_sq_o = 17'h0a761; init_cb_o = 25'h087576f; end // x0 = 0.80859375
            8'd 80: begin init_sq_o = 17'h0a900; init_cb_o = 25'h0895000; end // x0 = 0.81250000
            8'd 81: begin init_sq_o = 17'h0aaa1; init_cb_o = 25'h08b4d71; end // x0 = 0.81640625
            8'd 82: begin init_sq_o = 17'h0ac44; init_cb_o = 25'h08d4fc8; end // x0 = 0.82031250
            8'd 83: begin init_sq_o = 17'h0ade9; init_cb_o = 25'h08f570b; end // x0 = 0.82421875
            8'd 84: begin init_sq_o = 17'h0af90; init_cb_o = 25'h0916340; end // x0 = 0.82812500
            8'd 85: begin init_sq_o = 17'h0b139; init_cb_o = 25'h093746d; end // x0 = 0.83203125
            8'd 86: begin init_sq_o = 17'h0b2e4; init_cb_o = 25'h0958a98; end // x0 = 0.83593750
            8'd 87: begin init_sq_o = 17'h0b491; init_cb_o = 25'h097a5c7; end // x0 = 0.83984375
            8'd 88: begin init_sq_o = 17'h0b640; init_cb_o = 25'h099c600; end // x0 = 0.84375000
            8'd 89: begin init_sq_o = 17'h0b7f1; init_cb_o = 25'h09beb49; end // x0 = 0.84765625
            8'd 90: begin init_sq_o = 17'h0b9a4; init_cb_o = 25'h09e15a8; end // x0 = 0.85156250
            8'd 91: begin init_sq_o = 17'h0bb59; init_cb_o = 25'h0a04523; end // x0 = 0.85546875
            8'd 92: begin init_sq_o = 17'h0bd10; init_cb_o = 25'h0a279c0; end // x0 = 0.85937500
            8'd 93: begin init_sq_o = 17'h0bec9; init_cb_o = 25'h0a4b385; end // x0 = 0.86328125
            8'd 94: begin init_sq_o = 17'h0c084; init_cb_o = 25'h0a6f278; end // x0 = 0.86718750
            8'd 95: begin init_sq_o = 17'h0c241; init_cb_o = 25'h0a9369f; end // x0 = 0.87109375
            8'd 96: begin init_sq_o = 17'h0c400; init_cb_o = 25'h0ab8000; end // x0 = 0.87500000
            8'd 97: begin init_sq_o = 17'h0c5c1; init_cb_o = 25'h0adcea1; end // x0 = 0.87890625
            8'd 98: begin init_sq_o = 17'h0c784; init_cb_o = 25'h0b02288; end // x0 = 0.88281250
            8'd 99: begin init_sq_o = 17'h0c949; init_cb_o = 25'h0b27bbb; end // x0 = 0.88671875
            8'd100: begin init_sq_o = 17'h0cb10; init_cb_o = 25'h0b4da40; end // x0 = 0.89062500
            8'd101: begin init_sq_o = 17'h0ccd9; init_cb_o = 25'h0b73e1d; end // x0 = 0.89453125
            8'd102: begin init_sq_o = 17'h0cea4; init_cb_o = 25'h0b9a758; end // x0 = 0.89843750
            8'd103: begin init_sq_o = 17'h0d071; init_cb_o = 25'h0bc15f7; end // x0 = 0.90234375
            8'd104: begin init_sq_o = 17'h0d240; init_cb_o = 25'h0be8a00; end // x0 = 0.90625000
            8'd105: begin init_sq_o = 17'h0d411; init_cb_o = 25'h0c10379; end // x0 = 0.91015625
            8'd106: begin init_sq_o = 17'h0d5e4; init_cb_o = 25'h0c38268; end // x0 = 0.91406250
            8'd107: begin init_sq_o = 17'h0d7b9; init_cb_o = 25'h0c606d3; end // x0 = 0.91796875
            8'd108: begin init_sq_o = 17'h0d990; init_cb_o = 25'h0c890c0; end // x0 = 0.92187500
            8'd109: begin init_sq_o = 17'h0db69; init_cb_o = 25'h0cb2035; end // x0 = 0.92578125
            8'd110: begin init_sq_o = 17'h0dd44; init_cb_o = 25'h0cdb538; end // x0 = 0.92968750
            8'd111: begin init_sq_o = 17'h0df21; init_cb_o = 25'h0d04fcf; end // x0 = 0.93359375
            8'd112: begin init_sq_o = 17'h0e100; init_cb_o = 25'h0d2f000; end // x0 = 0.93750000
            8'd113: begin init_sq_o = 17'h0e2e1; init_cb_o = 25'h0d595d1; end // x0 = 0.94140625
            8'd114: begin init_sq_o = 17'h0e4c4; init_cb_o = 25'h0d84148; end // x0 = 0.94531250
            8'd115: begin init_sq_o = 17'h0e6a9; init_cb_o = 25'h0daf26b; end // x0 = 0.94921875
            8'd116: begin init_sq_o = 17'h0e890; init_cb_o = 25'h0dda940; end // x0 = 0.95312500
            8'd117: begin init_sq_o = 17'h0ea79; init_cb_o = 25'h0e065cd; end // x0 = 0.95703125
            8'd118: begin init_sq_o = 17'h0ec64; init_cb_o = 25'h0e32818; end // x0 = 0.96093750
            8'd119: begin init_sq_o = 17'h0ee51; init_cb_o = 25'h0e5f027; end // x0 = 0.96484375
            8'd120: begin init_sq_o = 17'h0f040; init_cb_o = 25'h0e8be00; end // x0 = 0.96875000
            8'd121: begin init_sq_o = 17'h0f231; init_cb_o = 25'h0eb91a9; end // x0 = 0.97265625
            8'd122: begin init_sq_o = 17'h0f424; init_cb_o = 25'h0ee6b28; end // x0 = 0.97656250
            8'd123: begin init_sq_o = 17'h0f619; init_cb_o = 25'h0f14a83; end // x0 = 0.98046875
            8'd124: begin init_sq_o = 17'h0f810; init_cb_o = 25'h0f42fc0; end // x0 = 0.98437500
            8'd125: begin init_sq_o = 17'h0fa09; init_cb_o = 25'h0f71ae5; end // x0 = 0.98828125
            8'd126: begin init_sq_o = 17'h0fc04; init_cb_o = 25'h0fa0bf8; end // x0 = 0.99218750
            8'd127: begin init_sq_o = 17'h0fe01; init_cb_o = 25'h0fd02ff; end // x0 = 0.99609375
            8'd128: begin init_sq_o = 17'h10000; init_cb_o = 25'h1000000; end // x0 = 1.00000000
            default: begin init_sq_o = '0; init_cb_o = '0; end
        endcase
    end
        
    // S Init
    logic [C_MANT_FP64+4:0] S;  // U1.56
    logic [C_MANT_FP64+4:0] SM; // U1.56

    assign S = {mant_init_o, {(C_MANT_FP64+5-C_INIT_OW){1'b0}}};
    assign SM = {(mant_init_o - {{(C_INIT_OW-1){1'b0}}, 1'b1}), {(C_MANT_FP64+5-C_INIT_OW){1'b0}}};

    // S_Square Init
    logic [2*(C_MANT_FP64+4):0] S_Square; // U2.112  // U1.112 用后者
    assign S_Square = {init_sq_o, {(2*(C_MANT_FP64+4)-2*(C_INIT_OW-1)){1'b0}}};

    // Residual Init
    logic [2*(C_MANT_FP64+4)+4:0] Residual; // Q8.112 // Q5.112 用后者
    logic [C_MANT_FP64+3:0] Residual_Init; // Q1.55
    
    assign Residual_Init = mant_norm_i - {init_cb_o, 31'b0}; // X-S^3
    assign Residual = ({{4{Residual_Init[C_MANT_FP64+3]}}, Residual_Init, {(C_MANT_FP64+5){1'b0}}}) <<< 10;

    
    logic [C_MANT_FP64+4:0] S_init_N;  // U1.56
    logic [C_MANT_FP64+4:0] SM_init_N; // U1.56
    logic [2*(C_MANT_FP64+4):0] S_Square_init_N; // U2.112
    logic [2*(C_MANT_FP64+4)+4:0] Residual_init_N; // Q8.112

    logic [C_MANT_FP64+4:0] S_Reg;  // U1.56
    logic [C_MANT_FP64+4:0] SM_Reg; // U1.56
    // logic [2*(C_MANT_FP64+4):0] S_Square_Reg; // U2.112
    // logic signed [2*(C_MANT_FP64+4)+4:0] Residual_Reg; // Q8.112

    assign S_init_N = (core_start)?S:S_Reg;
    assign SM_init_N = (core_start)?SM:SM_Reg;
    assign S_Square_init_N = (core_start)?S_Square:'0;
    assign Residual_init_N = (core_start)?Residual:'0;

    // 迭代开始
    // 初始化FSM
    logic [2:0] Final_cycle;

    always_comb begin
        case(fmt_sel_i)
            // C_FS_SP: 
            C_FS_DP: Final_cycle = 'd7;
            default: Final_cycle = 'd0;
        endcase
    end

    // // 下一级控制信号
    // logic core_start;

    // always_ff @(posedge clk_i or negedge rst_ni) begin
    //     if (~rst_ni) begin
    //         core_start <= '0;
    //     end else begin
    //         core_start <= start_dly_i;
    //     end
    // end

    logic Fsm_enable; // 迭代单元有限状态机
    logic [2:0] cycle_cnt;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            Fsm_enable <= '0;
        end else if (core_start) begin
            Fsm_enable <= 1'b1;
        end else if (cycle_cnt == Final_cycle) begin
            Fsm_enable <= 1'b0;
        end else begin
            Fsm_enable <= Fsm_enable;
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            cycle_cnt <= '0;
        end else if (Fsm_enable) begin
            if(cycle_cnt == Final_cycle) begin
                cycle_cnt <= '0;
            end else begin
                cycle_cnt <= cycle_cnt + 3'b1;
            end
        end else begin
            cycle_cnt <= '0;
        end
    end


    // S/SM Ssquare Residual r64 path 
    logic [C_MANT_FP64+4:0] S1_mid_o;
    //logic [C_MANT_FP64+4:0] SM1_mid_o;
    logic [C_MANT_FP64+4:0] S2_mid_o;
    //logic [C_MANT_FP64+4:0] SM2_mid_o;
    logic [C_MANT_FP64+4:0] S_o; 
    logic [C_MANT_FP64+4:0] SM_o;

    logic [2*(C_MANT_FP64+4):0] Sq0_c_o;
    logic [2*(C_MANT_FP64+4):0] Sq0_s_o;
    logic [2*(C_MANT_FP64+4):0] Sq1_c_o;
    logic [2*(C_MANT_FP64+4):0] Sq1_s_o;
    logic [2*(C_MANT_FP64+4):0] Sq2_c_o;
    logic [2*(C_MANT_FP64+4):0] Sq2_s_o;

    logic [2*(C_MANT_FP64+4)+4:0] Residual0_c_o;
    logic [2*(C_MANT_FP64+4)+4:0] Residual0_s_o;
    logic [2*(C_MANT_FP64+4)+4:0] Residual1_c_o;
    logic [2*(C_MANT_FP64+4)+4:0] Residual1_s_o;
    logic [2*(C_MANT_FP64+4)+4:0] Residual2_c_o;
    logic [2*(C_MANT_FP64+4)+4:0] Residual2_s_o;
        
    logic signed [2:0] s_sel0_i;
    logic signed [2:0] s_sel1_i;
    logic signed [2:0] s_sel2_i;
    logic [6:0] SH0_i; 
    logic [6:0] SH1_i; 
    logic [6:0] SH2_i; 
    logic signed [8:0] ResidualH0_i;
    logic signed [8:0] ResidualH1_i;
    logic signed [8:0] ResidualH2_i;

    logic [2*(C_MANT_FP64+4):0] S_Square_c_Reg; // r64迭代后的Sq冗余表示
    logic [2*(C_MANT_FP64+4):0] S_Square_s_Reg;
    logic [2*(C_MANT_FP64+4)+4:0] Residual_c_Reg; // r64迭代后的residual冗余表示
    logic [2*(C_MANT_FP64+4)+4:0] Residual_s_Reg;

    assign SH0_i = S_Reg[C_MANT_FP64+4-:7];
    assign SH1_i = S1_mid_o[C_MANT_FP64+4-:7];
    assign SH2_i = S2_mid_o[C_MANT_FP64+4-:7];

    assign ResidualH0_i = Residual_c_Reg[2*(C_MANT_FP64+4)+4-:9] + Residual_s_Reg[2*(C_MANT_FP64+4)+4-:9];
    assign ResidualH1_i = Residual0_c_o[2*(C_MANT_FP64+4)+4-:9] + Residual0_s_o[2*(C_MANT_FP64+4)+4-:9];
    assign ResidualH2_i = Residual1_c_o[2*(C_MANT_FP64+4)+4-:9] + Residual1_s_o[2*(C_MANT_FP64+4)+4-:9];

    // S Select
    fcbrt_Ssel u_fcbrt_Ssel_stage0(
        .ResidualH_i 	( ResidualH0_i  ),
        .SH_i        	( SH0_i         ),
        .S_sel_o     	( s_sel0_i      )
    );

    fcbrt_Ssel u_fcbrt_Ssel_stage1(
        .ResidualH_i 	( ResidualH1_i  ),
        .SH_i        	( SH1_i         ),
        .S_sel_o     	( s_sel1_i      )
    );

    fcbrt_Ssel u_fcbrt_Ssel_stage2(
        .ResidualH_i 	( ResidualH2_i  ),
        .SH_i        	( SH2_i         ),
        .S_sel_o     	( s_sel2_i      )
    );

    fcbrt_S_SM_r64 u_fcbrt_S_SM_r64(
        .S0_i        	( S_Reg        ),
        .SM0_i       	( SM_Reg       ),
        .s_sel0_i    	( s_sel0_i     ),
        .s_sel1_i    	( s_sel1_i     ),
        .s_sel2_i    	( s_sel2_i     ),
        .cycle_cnt_i 	( cycle_cnt    ),
        .S1_mid_o    	( S1_mid_o     ),
       // .SM1_mid_o   	( SM1_mid_o    ),
        .S2_mid_o    	( S2_mid_o     ),
       //.SM2_mid_o   	( SM2_mid_o    ),
        .S_o         	( S_o          ),
        .SM_o        	( SM_o         )
    );

    fcbrt_Sq_r64 u_fcbrt_Sq_r64(
        .S0_i        	( S_Reg        ),
        .S1_i        	( S1_mid_o     ),
        .S2_i        	( S2_mid_o     ),
        .Sq0_c_i     	( S_Square_c_Reg      ),
        .Sq0_s_i     	( S_Square_s_Reg      ),
        .s_sel0_i    	( s_sel0_i     ),
        .s_sel1_i    	( s_sel1_i     ),
        .s_sel2_i    	( s_sel2_i     ),
        .cycle_cnt_i 	( cycle_cnt    ),
        .Sq0_c_o     	( Sq0_c_o      ),
        .Sq0_s_o     	( Sq0_s_o      ),
        .Sq1_c_o     	( Sq1_c_o      ),
        .Sq1_s_o     	( Sq1_s_o      ),
        .Sq2_c_o     	( Sq2_c_o      ),
        .Sq2_s_o     	( Sq2_s_o      )
    );

    fcbrt_Residual_r64 u_fcbrt_Residual_r64(
        .Residual0_c_i 	( Residual_c_Reg ),
        .Residual0_s_i 	( Residual_s_Reg ),
        .Sq0_c_i       	( S_Square_c_Reg ),
        .Sq0_s_i       	( S_Square_s_Reg ),
        .Sq1_c_i       	( Sq0_c_o        ),
        .Sq1_s_i       	( Sq0_s_o        ),
        .Sq2_c_i       	( Sq1_c_o        ),
        .Sq2_s_i       	( Sq1_s_o        ),
        .S0_i          	( S_Reg          ),
        .S1_i          	( S1_mid_o       ),
        .S2_i          	( S2_mid_o       ),
        .s_sel0_i      	( s_sel0_i       ),
        .s_sel1_i      	( s_sel1_i       ),
        .s_sel2_i      	( s_sel2_i       ),
        .cycle_cnt_i   	( cycle_cnt      ),
        .Residual0_c_o 	( Residual0_c_o  ),
        .Residual0_s_o 	( Residual0_s_o  ),
        .Residual1_c_o 	( Residual1_c_o  ),
        .Residual1_s_o 	( Residual1_s_o  ),
        .Residual2_c_o 	( Residual2_c_o  ),
        .Residual2_s_o 	( Residual2_s_o  )
    );

    // 寄存器维护
    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            S_Reg <= '0;
            SM_Reg <= '0;
            // S_Square_Reg <= '0;
            // Residual_Reg <= '0;
            S_Square_c_Reg <= '0;
            S_Square_s_Reg <= '0;
            Residual_c_Reg <= '0;
            Residual_s_Reg <= '0;
        end else if (core_start) begin
            S_Reg <= S_init_N;
            SM_Reg <= SM_init_N;
            // S_Square_Reg <= S_Square_init_N;
            // Residual_Reg <= Residual_init_N;
            S_Square_c_Reg <= '0;
            S_Square_s_Reg <= S_Square_init_N;
            Residual_c_Reg <= '0;
            Residual_s_Reg <= Residual_init_N;
        end else if (Fsm_enable) begin
            S_Reg <= S_o;
            SM_Reg <= SM_o;
            // S_Square_Reg <= S_Square_Reg;
            // Residual_Reg <= Residual_Reg;
            S_Square_c_Reg <= Sq2_c_o;
            S_Square_s_Reg <= Sq2_s_o;
            Residual_c_Reg <= Residual2_c_o;
            Residual_s_Reg <= Residual2_s_o;
        end else begin
            S_Reg <= S_Reg;
            SM_Reg <= SM_Reg;
            // S_Square_Reg <= S_Square_Reg;
            // Residual_Reg <= Residual_Reg;
            S_Square_c_Reg <= S_Square_c_Reg;
            S_Square_s_Reg <= S_Square_s_Reg;
            Residual_c_Reg <= Residual_c_Reg;
            Residual_s_Reg <= Residual_s_Reg;
        end
    end

    // 指数的旁路处理
    logic [C_EXP_FP64-1:0] x_udiv3_i;
    logic [C_EXP_FP64-1:0] q_udiv3_o;
    logic [C_EXP_FP64-1:0] exp_bias_nonc;
    logic [C_EXP_FP64-1:0] exp_bias_nonc_reg;   // 没有经过后处理，带有偏置

    logic [C_EXP_FP64-1:0] x_udiv3_i_Reg;
    
    assign x_udiv3_i = (core_start)?(is_subnormal_i?({{(C_EXP_FP64-C_LZCNT){1'b0}}, lzcnt_i}):exp_bias_i):x_udiv3_i_Reg;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            x_udiv3_i_Reg <= '0;
        end else begin
            x_udiv3_i_Reg <= x_udiv3_i;
        end
    end

    fcbrt_udiv3 #(
        .W 	( C_EXP_FP64  ))
    u_fcbrt_udiv3(
        .x_i 	( x_udiv3_i  ),
        .q_o 	( q_udiv3_o  )
    );

    always_comb begin
        if (is_subnormal_i) begin
            case(shift_num_i)
                2'd3: exp_bias_nonc = 11'd682 - q_udiv3_o;
                2'd1, 2'd2: exp_bias_nonc = 11'd681 - q_udiv3_o;
                default: exp_bias_nonc = '0;
            endcase
        end else begin
            exp_bias_nonc = 11'd682 + q_udiv3_o;
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            exp_bias_nonc_reg <= '0;
        end else if (cycle_cnt == Final_cycle) begin
            exp_bias_nonc_reg <= exp_bias_nonc;
        end else begin
            exp_bias_nonc_reg <= exp_bias_nonc_reg;
        end
    end

    // 后处理的开始信号
    logic start_N;
    logic start_P;

    assign start_N = ((cycle_cnt == Final_cycle)&&Fsm_enable)?1'b1:1'b0;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            start_P <= 1'b0;
        end else begin
            start_P <= start_N;
        end
    end

    // 输出信号
    assign start_o = start_P;
    assign special_case_o = special_case_i;
    assign sticky_o = ((Residual_c_Reg + Residual_s_Reg) != '0);
    assign mant_o = S_Reg;
    assign exp_bias_o = exp_bias_nonc_reg;

endmodule