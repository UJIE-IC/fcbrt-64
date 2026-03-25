module fcbrt_Residual_r64 (
    input  logic [116:0] Residual0_c_i,
    input  logic [116:0] Residual0_s_i,
    input  logic [112:0] Sq0_c_i,
    input  logic [112:0] Sq0_s_i,
    input  logic [112:0] Sq1_c_i,
    input  logic [112:0] Sq1_s_i,
    input  logic [112:0] Sq2_c_i,
    input  logic [112:0] Sq2_s_i,
    input  logic [56:0] S0_i,
    input  logic [56:0] S1_i,
    input  logic [56:0] S2_i,
    input  logic signed [2:0] s_sel0_i,
    input  logic signed [2:0] s_sel1_i,
    input  logic signed [2:0] s_sel2_i,
    input  logic [2:0] cycle_cnt_i,
    output logic [116:0] Residual0_c_o,
    output logic [116:0] Residual0_s_o,
    output logic [116:0] Residual1_c_o,
    output logic [116:0] Residual1_s_o,
    output logic [116:0] Residual2_c_o,
    output logic [116:0] Residual2_s_o
);

    // Residual_next = (Residual_prev + A + B + C) << 2
    // A = -3*Sq*q
    // B = -3*S*q^2*4^{-j}
    // C = -q^3*4^{-2j}
    
    // stage0 Residual path

    logic [116:0] Residual0_A0_sel, Residual0_A1_sel, Residual0_A2_sel, Residual0_A3_sel;
    logic [116:0] Residual0_B0_sel, Residual0_B1_sel, Residual0_C_sel, Residual0_Corr_sel;

    // CSA压缩树中间输出
    logic [116:0] Residual0_mid1_s0, Residual0_mid1_c0, Residual0_mid1_s1, Residual0_mid1_c1;
    logic [116:0] Residual0_mid2_s0, Residual0_mid2_c0, Residual0_mid3_s0, Residual0_mid3_c0;

    always_comb begin
        case(s_sel0_i)
            3'sd2: begin
                Residual0_A0_sel = ~{2'b00, Sq0_c_i, 2'b00};
                Residual0_A1_sel = ~{3'b000, Sq0_c_i, 1'b0};
                Residual0_A2_sel = ~{2'b00, Sq0_s_i, 2'b00};
                Residual0_A3_sel = ~{3'b000, Sq0_s_i, 1'b0};
            end
            3'sd1: begin
                Residual0_A0_sel = ~{3'b000, Sq0_c_i, 1'b0};
                Residual0_A1_sel = ~{4'b0000, Sq0_c_i};
                Residual0_A2_sel = ~{3'b000, Sq0_s_i, 1'b0};
                Residual0_A3_sel = ~{4'b0000, Sq0_s_i};
            end
            3'sd0: begin
                Residual0_A0_sel = '0;
                Residual0_A1_sel = '0;
                Residual0_A2_sel = '0;
                Residual0_A3_sel = '0;
            end
            -3'sd1: begin
                Residual0_A0_sel = {3'b000, Sq0_c_i, 1'b0};
                Residual0_A1_sel = {4'b0000, Sq0_c_i};
                Residual0_A2_sel = {3'b000, Sq0_s_i, 1'b0};
                Residual0_A3_sel = {4'b0000, Sq0_s_i};
            end
            -3'sd2: begin
                Residual0_A0_sel = {2'b00, Sq0_c_i, 2'b00};
                Residual0_A1_sel = {3'b000, Sq0_c_i, 1'b0};
                Residual0_A2_sel = {2'b00, Sq0_s_i, 2'b00};
                Residual0_A3_sel = {3'b000, Sq0_s_i, 1'b0};
            end
            default: begin
                Residual0_A0_sel = '0;
                Residual0_A1_sel = '0;
                Residual0_A2_sel = '0;
                Residual0_A3_sel = '0;
            end
        endcase
    end

    always_comb begin
        case(cycle_cnt_i)
            4'd0: begin
                case(s_sel0_i)
                    3'sd2: begin
                        Residual0_B0_sel = ~{11'b0, S0_i, 49'b0};
                        Residual0_B1_sel = ~{12'b0, S0_i, 48'b0};
                        Residual0_C_sel = ~{21'b0, 1'b1, 95'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual0_B0_sel = ~{13'b0, S0_i, 47'b0};
                        Residual0_B1_sel = ~{14'b0, S0_i, 46'b0};
                        Residual0_C_sel = ~{24'b0, 1'b1, 92'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual0_B0_sel = ~{13'b0, S0_i, 47'b0};
                        Residual0_B1_sel = ~{14'b0, S0_i, 46'b0};
                        Residual0_C_sel = {24'b0, 1'b1, 92'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual0_B0_sel = ~{11'b0, S0_i, 49'b0};
                        Residual0_B1_sel = ~{12'b0, S0_i, 48'b0};
                        Residual0_C_sel = {21'b0, 1'b1, 95'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                endcase
            end
            4'd1: begin
                case(s_sel0_i)
                    3'sd2: begin
                        Residual0_B0_sel = ~{17'b0, S0_i, 43'b0};
                        Residual0_B1_sel = ~{18'b0, S0_i, 42'b0};
                        Residual0_C_sel = ~{33'b0, 1'b1, 83'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual0_B0_sel = ~{19'b0, S0_i, 41'b0};
                        Residual0_B1_sel = ~{20'b0, S0_i, 40'b0};
                        Residual0_C_sel = ~{36'b0, 1'b1, 80'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual0_B0_sel = ~{19'b0, S0_i, 41'b0};
                        Residual0_B1_sel = ~{20'b0, S0_i, 40'b0};
                        Residual0_C_sel = {36'b0, 1'b1, 80'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual0_B0_sel = ~{17'b0, S0_i, 43'b0};
                        Residual0_B1_sel = ~{18'b0, S0_i, 42'b0};
                        Residual0_C_sel = {33'b0, 1'b1, 83'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                endcase
            end
            4'd2: begin
                case(s_sel0_i)
                    3'sd2: begin
                        Residual0_B0_sel = ~{23'b0, S0_i, 37'b0};
                        Residual0_B1_sel = ~{24'b0, S0_i, 36'b0};
                        Residual0_C_sel = ~{45'b0, 1'b1, 71'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual0_B0_sel = ~{25'b0, S0_i, 35'b0};
                        Residual0_B1_sel = ~{26'b0, S0_i, 34'b0};
                        Residual0_C_sel = ~{48'b0, 1'b1, 68'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual0_B0_sel = ~{25'b0, S0_i, 35'b0};
                        Residual0_B1_sel = ~{26'b0, S0_i, 34'b0};
                        Residual0_C_sel = {48'b0, 1'b1, 68'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual0_B0_sel = ~{23'b0, S0_i, 37'b0};
                        Residual0_B1_sel = ~{24'b0, S0_i, 36'b0};
                        Residual0_C_sel = {45'b0, 1'b1, 71'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                endcase
            end
            4'd3: begin
                case(s_sel0_i)
                    3'sd2: begin
                        Residual0_B0_sel = ~{29'b0, S0_i, 31'b0};
                        Residual0_B1_sel = ~{30'b0, S0_i, 30'b0};
                        Residual0_C_sel = ~{57'b0, 1'b1, 59'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual0_B0_sel = ~{31'b0, S0_i, 29'b0};
                        Residual0_B1_sel = ~{32'b0, S0_i, 28'b0};
                        Residual0_C_sel = ~{60'b0, 1'b1, 56'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual0_B0_sel = ~{31'b0, S0_i, 29'b0};
                        Residual0_B1_sel = ~{32'b0, S0_i, 28'b0};
                        Residual0_C_sel = {60'b0, 1'b1, 56'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual0_B0_sel = ~{29'b0, S0_i, 31'b0};
                        Residual0_B1_sel = ~{30'b0, S0_i, 30'b0};
                        Residual0_C_sel = {57'b0, 1'b1, 59'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                endcase
            end
            4'd4: begin
                case(s_sel0_i)
                    3'sd2: begin
                        Residual0_B0_sel = ~{35'b0, S0_i, 25'b0};
                        Residual0_B1_sel = ~{36'b0, S0_i, 24'b0};
                        Residual0_C_sel = ~{69'b0, 1'b1, 47'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual0_B0_sel = ~{37'b0, S0_i, 23'b0};
                        Residual0_B1_sel = ~{38'b0, S0_i, 22'b0};
                        Residual0_C_sel = ~{72'b0, 1'b1, 44'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual0_B0_sel = ~{37'b0, S0_i, 23'b0};
                        Residual0_B1_sel = ~{38'b0, S0_i, 22'b0};
                        Residual0_C_sel = {72'b0, 1'b1, 44'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual0_B0_sel = ~{35'b0, S0_i, 25'b0};
                        Residual0_B1_sel = ~{36'b0, S0_i, 24'b0};
                        Residual0_C_sel = {69'b0, 1'b1, 47'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                endcase
            end
            4'd5: begin
                case(s_sel0_i)
                    3'sd2: begin
                        Residual0_B0_sel = ~{41'b0, S0_i, 19'b0};
                        Residual0_B1_sel = ~{42'b0, S0_i, 18'b0};
                        Residual0_C_sel = ~{81'b0, 1'b1, 35'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual0_B0_sel = ~{43'b0, S0_i, 17'b0};
                        Residual0_B1_sel = ~{44'b0, S0_i, 16'b0};
                        Residual0_C_sel = ~{84'b0, 1'b1, 32'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual0_B0_sel = ~{43'b0, S0_i, 17'b0};
                        Residual0_B1_sel = ~{44'b0, S0_i, 16'b0};
                        Residual0_C_sel = {84'b0, 1'b1, 32'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual0_B0_sel = ~{41'b0, S0_i, 19'b0};
                        Residual0_B1_sel = ~{42'b0, S0_i, 18'b0};
                        Residual0_C_sel = {81'b0, 1'b1, 35'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                endcase
            end
            4'd6: begin
                case(s_sel0_i)
                    3'sd2: begin
                        Residual0_B0_sel = ~{47'b0, S0_i, 13'b0};
                        Residual0_B1_sel = ~{48'b0, S0_i, 12'b0};
                        Residual0_C_sel = ~{93'b0, 1'b1, 23'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual0_B0_sel = ~{49'b0, S0_i, 11'b0};
                        Residual0_B1_sel = ~{50'b0, S0_i, 10'b0};
                        Residual0_C_sel = ~{96'b0, 1'b1, 20'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual0_B0_sel = ~{49'b0, S0_i, 11'b0};
                        Residual0_B1_sel = ~{50'b0, S0_i, 10'b0};
                        Residual0_C_sel = {96'b0, 1'b1, 20'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual0_B0_sel = ~{47'b0, S0_i, 13'b0};
                        Residual0_B1_sel = ~{48'b0, S0_i, 12'b0};
                        Residual0_C_sel = {93'b0, 1'b1, 23'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                endcase
            end
            4'd7: begin
                case(s_sel0_i)
                    3'sd2: begin
                        Residual0_B0_sel = ~{53'b0, S0_i, 7'b0};
                        Residual0_B1_sel = ~{54'b0, S0_i, 6'b0};
                        Residual0_C_sel = ~{105'b0, 1'b1, 11'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual0_B0_sel = ~{55'b0, S0_i, 5'b0};
                        Residual0_B1_sel = ~{56'b0, S0_i, 4'b0};
                        Residual0_C_sel = ~{108'b0, 1'b1, 8'b0};
                        Residual0_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual0_B0_sel = ~{55'b0, S0_i, 5'b0};
                        Residual0_B1_sel = ~{56'b0, S0_i, 4'b0};
                        Residual0_C_sel = {108'b0, 1'b1, 8'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual0_B0_sel = ~{53'b0, S0_i, 7'b0};
                        Residual0_B1_sel = ~{54'b0, S0_i, 6'b0};
                        Residual0_C_sel = {105'b0, 1'b1, 11'b0};
                        Residual0_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual0_B0_sel = '0;
                        Residual0_B1_sel = '0;
                        Residual0_C_sel = '0;
                        Residual0_Corr_sel = '0;
                    end
                endcase
            end
            default: begin
                Residual0_B0_sel = '0;
                Residual0_B1_sel = '0;
                Residual0_C_sel = '0;
                Residual0_Corr_sel = '0;
            end
        endcase
    end

    CSA4_2 #(.W(117)) u_Residual0_mid1_0 (
        .a_i(Residual0_c_i),
        .b_i(Residual0_s_i),
        .c_i(Residual0_A0_sel),
        .d_i(Residual0_A1_sel),
        .s_o(Residual0_mid1_s0),
        .c_o(Residual0_mid1_c0)
    );

    CSA4_2 #(.W(117)) u_Residual0_mid1_1 (
        .a_i(Residual0_A2_sel),
        .b_i(Residual0_A3_sel),
        .c_i(Residual0_B0_sel),
        .d_i(Residual0_B1_sel),
        .s_o(Residual0_mid1_s1),
        .c_o(Residual0_mid1_c1)
    );

    CSA4_2 #(.W(117)) u_Residual0_mid2_0 (
        .a_i(Residual0_mid1_s0),
        .b_i(Residual0_mid1_c0),
        .c_i(Residual0_mid1_s1),
        .d_i(Residual0_mid1_c1),
        .s_o(Residual0_mid2_s0),
        .c_o(Residual0_mid2_c0)
    );

    CSA4_2 #(.W(117)) u_Residual0_mid3_0 (
        .a_i(Residual0_mid2_s0),
        .b_i(Residual0_mid2_c0),
        .c_i(Residual0_C_sel),
        .d_i(Residual0_Corr_sel),
        .s_o(Residual0_mid3_s0),
        .c_o(Residual0_mid3_c0)
    );

    assign Residual0_s_o = {Residual0_mid3_s0[114:0], 2'b00};
    assign Residual0_c_o = {Residual0_mid3_c0[114:0], 2'b00};

    // stage1 Residual path
    logic [116:0] Residual1_A0_sel, Residual1_A1_sel, Residual1_A2_sel, Residual1_A3_sel;
    logic [116:0] Residual1_B0_sel, Residual1_B1_sel, Residual1_C_sel, Residual1_Corr_sel;
    logic [116:0] Residual1_mid1_s0, Residual1_mid1_c0, Residual1_mid1_s1, Residual1_mid1_c1;
    logic [116:0] Residual1_mid2_s0, Residual1_mid2_c0, Residual1_mid3_s0, Residual1_mid3_c0;

    always_comb begin
        case(s_sel1_i)
            3'sd2: begin
                Residual1_A0_sel = ~{2'b00, Sq1_c_i, 2'b00};
                Residual1_A1_sel = ~{3'b000, Sq1_c_i, 1'b0};
                Residual1_A2_sel = ~{2'b00, Sq1_s_i, 2'b00};
                Residual1_A3_sel = ~{3'b000, Sq1_s_i, 1'b0};
            end
            3'sd1: begin
                Residual1_A0_sel = ~{3'b000, Sq1_c_i, 1'b0};
                Residual1_A1_sel = ~{4'b0000, Sq1_c_i};
                Residual1_A2_sel = ~{3'b000, Sq1_s_i, 1'b0};
                Residual1_A3_sel = ~{4'b0000, Sq1_s_i};
            end
            3'sd0: begin
                Residual1_A0_sel = '0;
                Residual1_A1_sel = '0;
                Residual1_A2_sel = '0;
                Residual1_A3_sel = '0;
            end
            -3'sd1: begin
                Residual1_A0_sel = {3'b000, Sq1_c_i, 1'b0};
                Residual1_A1_sel = {4'b0000, Sq1_c_i};
                Residual1_A2_sel = {3'b000, Sq1_s_i, 1'b0};
                Residual1_A3_sel = {4'b0000, Sq1_s_i};
            end
            -3'sd2: begin
                Residual1_A0_sel = {2'b00, Sq1_c_i, 2'b00};
                Residual1_A1_sel = {3'b000, Sq1_c_i, 1'b0};
                Residual1_A2_sel = {2'b00, Sq1_s_i, 2'b00};
                Residual1_A3_sel = {3'b000, Sq1_s_i, 1'b0};
            end
            default: begin
                Residual1_A0_sel = '0;
                Residual1_A1_sel = '0;
                Residual1_A2_sel = '0;
                Residual1_A3_sel = '0;
            end
        endcase
    end

    always_comb begin
        case(cycle_cnt_i)
            4'd0: begin
                case(s_sel1_i)
                    3'sd2: begin
                        Residual1_B0_sel = ~{13'b0, S1_i, 47'b0};
                        Residual1_B1_sel = ~{14'b0, S1_i, 46'b0};
                        Residual1_C_sel = ~{25'b0, 1'b1, 91'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual1_B0_sel = ~{15'b0, S1_i, 45'b0};
                        Residual1_B1_sel = ~{16'b0, S1_i, 44'b0};
                        Residual1_C_sel = ~{28'b0, 1'b1, 88'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual1_B0_sel = ~{15'b0, S1_i, 45'b0};
                        Residual1_B1_sel = ~{16'b0, S1_i, 44'b0};
                        Residual1_C_sel = {28'b0, 1'b1, 88'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual1_B0_sel = ~{13'b0, S1_i, 47'b0};
                        Residual1_B1_sel = ~{14'b0, S1_i, 46'b0};
                        Residual1_C_sel = {25'b0, 1'b1, 91'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                endcase
            end
            4'd1: begin
                case(s_sel1_i)
                    3'sd2: begin
                        Residual1_B0_sel = ~{19'b0, S1_i, 41'b0};
                        Residual1_B1_sel = ~{20'b0, S1_i, 40'b0};
                        Residual1_C_sel = ~{37'b0, 1'b1, 79'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual1_B0_sel = ~{21'b0, S1_i, 39'b0};
                        Residual1_B1_sel = ~{22'b0, S1_i, 38'b0};
                        Residual1_C_sel = ~{40'b0, 1'b1, 76'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual1_B0_sel = ~{21'b0, S1_i, 39'b0};
                        Residual1_B1_sel = ~{22'b0, S1_i, 38'b0};
                        Residual1_C_sel = {40'b0, 1'b1, 76'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual1_B0_sel = ~{19'b0, S1_i, 41'b0};
                        Residual1_B1_sel = ~{20'b0, S1_i, 40'b0};
                        Residual1_C_sel = {37'b0, 1'b1, 79'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                endcase
            end
            4'd2: begin
                case(s_sel1_i)
                    3'sd2: begin
                        Residual1_B0_sel = ~{25'b0, S1_i, 35'b0};
                        Residual1_B1_sel = ~{26'b0, S1_i, 34'b0};
                        Residual1_C_sel = ~{49'b0, 1'b1, 67'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual1_B0_sel = ~{27'b0, S1_i, 33'b0};
                        Residual1_B1_sel = ~{28'b0, S1_i, 32'b0};
                        Residual1_C_sel = ~{52'b0, 1'b1, 64'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual1_B0_sel = ~{27'b0, S1_i, 33'b0};
                        Residual1_B1_sel = ~{28'b0, S1_i, 32'b0};
                        Residual1_C_sel = {52'b0, 1'b1, 64'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual1_B0_sel = ~{25'b0, S1_i, 35'b0};
                        Residual1_B1_sel = ~{26'b0, S1_i, 34'b0};
                        Residual1_C_sel = {49'b0, 1'b1, 67'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                endcase
            end
            4'd3: begin
                case(s_sel1_i)
                    3'sd2: begin
                        Residual1_B0_sel = ~{31'b0, S1_i, 29'b0};
                        Residual1_B1_sel = ~{32'b0, S1_i, 28'b0};
                        Residual1_C_sel = ~{61'b0, 1'b1, 55'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual1_B0_sel = ~{33'b0, S1_i, 27'b0};
                        Residual1_B1_sel = ~{34'b0, S1_i, 26'b0};
                        Residual1_C_sel = ~{64'b0, 1'b1, 52'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual1_B0_sel = ~{33'b0, S1_i, 27'b0};
                        Residual1_B1_sel = ~{34'b0, S1_i, 26'b0};
                        Residual1_C_sel = {64'b0, 1'b1, 52'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual1_B0_sel = ~{31'b0, S1_i, 29'b0};
                        Residual1_B1_sel = ~{32'b0, S1_i, 28'b0};
                        Residual1_C_sel = {61'b0, 1'b1, 55'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                endcase
            end
            4'd4: begin
                case(s_sel1_i)
                    3'sd2: begin
                        Residual1_B0_sel = ~{37'b0, S1_i, 23'b0};
                        Residual1_B1_sel = ~{38'b0, S1_i, 22'b0};
                        Residual1_C_sel = ~{73'b0, 1'b1, 43'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual1_B0_sel = ~{39'b0, S1_i, 21'b0};
                        Residual1_B1_sel = ~{40'b0, S1_i, 20'b0};
                        Residual1_C_sel = ~{76'b0, 1'b1, 40'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual1_B0_sel = ~{39'b0, S1_i, 21'b0};
                        Residual1_B1_sel = ~{40'b0, S1_i, 20'b0};
                        Residual1_C_sel = {76'b0, 1'b1, 40'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual1_B0_sel = ~{37'b0, S1_i, 23'b0};
                        Residual1_B1_sel = ~{38'b0, S1_i, 22'b0};
                        Residual1_C_sel = {73'b0, 1'b1, 43'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                endcase
            end
            4'd5: begin
                case(s_sel1_i)
                    3'sd2: begin
                        Residual1_B0_sel = ~{43'b0, S1_i, 17'b0};
                        Residual1_B1_sel = ~{44'b0, S1_i, 16'b0};
                        Residual1_C_sel = ~{85'b0, 1'b1, 31'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual1_B0_sel = ~{45'b0, S1_i, 15'b0};
                        Residual1_B1_sel = ~{46'b0, S1_i, 14'b0};
                        Residual1_C_sel = ~{88'b0, 1'b1, 28'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual1_B0_sel = ~{45'b0, S1_i, 15'b0};
                        Residual1_B1_sel = ~{46'b0, S1_i, 14'b0};
                        Residual1_C_sel = {88'b0, 1'b1, 28'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual1_B0_sel = ~{43'b0, S1_i, 17'b0};
                        Residual1_B1_sel = ~{44'b0, S1_i, 16'b0};
                        Residual1_C_sel = {85'b0, 1'b1, 31'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                endcase
            end
            4'd6: begin
                case(s_sel1_i)
                    3'sd2: begin
                        Residual1_B0_sel = ~{49'b0, S1_i, 11'b0};
                        Residual1_B1_sel = ~{50'b0, S1_i, 10'b0};
                        Residual1_C_sel = ~{97'b0, 1'b1, 19'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual1_B0_sel = ~{51'b0, S1_i, 9'b0};
                        Residual1_B1_sel = ~{52'b0, S1_i, 8'b0};
                        Residual1_C_sel = ~{100'b0, 1'b1, 16'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual1_B0_sel = ~{51'b0, S1_i, 9'b0};
                        Residual1_B1_sel = ~{52'b0, S1_i, 8'b0};
                        Residual1_C_sel = {100'b0, 1'b1, 16'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual1_B0_sel = ~{49'b0, S1_i, 11'b0};
                        Residual1_B1_sel = ~{50'b0, S1_i, 10'b0};
                        Residual1_C_sel = {97'b0, 1'b1, 19'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                endcase
            end
            4'd7: begin
                case(s_sel1_i)
                    3'sd2: begin
                        Residual1_B0_sel = ~{55'b0, S1_i, 5'b0};
                        Residual1_B1_sel = ~{56'b0, S1_i, 4'b0};
                        Residual1_C_sel = ~{109'b0, 1'b1, 7'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual1_B0_sel = ~{57'b0, S1_i, 3'b0};
                        Residual1_B1_sel = ~{58'b0, S1_i, 2'b0};
                        Residual1_C_sel = ~{112'b0, 1'b1, 4'b0};
                        Residual1_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual1_B0_sel = ~{57'b0, S1_i, 3'b0};
                        Residual1_B1_sel = ~{58'b0, S1_i, 2'b0};
                        Residual1_C_sel = {112'b0, 1'b1, 4'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual1_B0_sel = ~{55'b0, S1_i, 5'b0};
                        Residual1_B1_sel = ~{56'b0, S1_i, 4'b0};
                        Residual1_C_sel = {109'b0, 1'b1, 7'b0};
                        Residual1_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual1_B0_sel = '0;
                        Residual1_B1_sel = '0;
                        Residual1_C_sel = '0;
                        Residual1_Corr_sel = '0;
                    end
                endcase
            end
            default: begin
                Residual1_B0_sel = '0;
                Residual1_B1_sel = '0;
                Residual1_C_sel = '0;
                Residual1_Corr_sel = '0;
            end
        endcase
    end

    // CSA压缩树
    CSA4_2 #(.W(117)) u_Residual1_mid1_0 (
        .a_i(Residual0_c_o),
        .b_i(Residual0_s_o),
        .c_i(Residual1_A0_sel),
        .d_i(Residual1_A1_sel),
        .s_o(Residual1_mid1_s0),
        .c_o(Residual1_mid1_c0)
    );

    CSA4_2 #(.W(117)) u_Residual1_mid1_1 (
        .a_i(Residual1_A2_sel),
        .b_i(Residual1_A3_sel),
        .c_i(Residual1_B0_sel),
        .d_i(Residual1_B1_sel),
        .s_o(Residual1_mid1_s1),
        .c_o(Residual1_mid1_c1)
    );

    CSA4_2 #(.W(117)) u_Residual1_mid2_0 (
        .a_i(Residual1_mid1_s0),
        .b_i(Residual1_mid1_c0),
        .c_i(Residual1_mid1_s1),
        .d_i(Residual1_mid1_c1),
        .s_o(Residual1_mid2_s0),
        .c_o(Residual1_mid2_c0)
    );

    CSA4_2 #(.W(117)) u_Residual1_mid3_0 (
        .a_i(Residual1_mid2_s0),
        .b_i(Residual1_mid2_c0),
        .c_i(Residual1_C_sel),
        .d_i(Residual1_Corr_sel),
        .s_o(Residual1_mid3_s0),
        .c_o(Residual1_mid3_c0)
    );

    assign Residual1_s_o = {Residual1_mid3_s0[114:0], 2'b00};
    assign Residual1_c_o = {Residual1_mid3_c0[114:0], 2'b00};

    // stage2 Residual path
    logic [116:0] Residual2_A0_sel, Residual2_A1_sel, Residual2_A2_sel, Residual2_A3_sel;
    logic [116:0] Residual2_B0_sel, Residual2_B1_sel, Residual2_C_sel, Residual2_Corr_sel;
    logic [116:0] Residual2_mid1_s0, Residual2_mid1_c0, Residual2_mid1_s1, Residual2_mid1_c1;
    logic [116:0] Residual2_mid2_s0, Residual2_mid2_c0, Residual2_mid3_s0, Residual2_mid3_c0;

    always_comb begin
        case(s_sel2_i)
            3'sd2: begin
                Residual2_A0_sel = ~{2'b00, Sq2_c_i, 2'b00};
                Residual2_A1_sel = ~{3'b000, Sq2_c_i, 1'b0};
                Residual2_A2_sel = ~{2'b00, Sq2_s_i, 2'b00};
                Residual2_A3_sel = ~{3'b000, Sq2_s_i, 1'b0};
            end
            3'sd1: begin
                Residual2_A0_sel = ~{3'b000, Sq2_c_i, 1'b0};
                Residual2_A1_sel = ~{4'b0000, Sq2_c_i};
                Residual2_A2_sel = ~{3'b000, Sq2_s_i, 1'b0};
                Residual2_A3_sel = ~{4'b0000, Sq2_s_i};
            end
            3'sd0: begin
                Residual2_A0_sel = '0;
                Residual2_A1_sel = '0;
                Residual2_A2_sel = '0;
                Residual2_A3_sel = '0;
            end
            -3'sd1: begin
                Residual2_A0_sel = {3'b000, Sq2_c_i, 1'b0};
                Residual2_A1_sel = {4'b0000, Sq2_c_i};
                Residual2_A2_sel = {3'b000, Sq2_s_i, 1'b0};
                Residual2_A3_sel = {4'b0000, Sq2_s_i};
            end
            -3'sd2: begin
                Residual2_A0_sel = {2'b00, Sq2_c_i, 2'b00};
                Residual2_A1_sel = {3'b000, Sq2_c_i, 1'b0};
                Residual2_A2_sel = {2'b00, Sq2_s_i, 2'b00};
                Residual2_A3_sel = {3'b000, Sq2_s_i, 1'b0};
            end
            default: begin
                Residual2_A0_sel = '0;
                Residual2_A1_sel = '0;
                Residual2_A2_sel = '0;
                Residual2_A3_sel = '0;
            end
        endcase
    end

    always_comb begin
        case(cycle_cnt_i)
            4'd0: begin
                case(s_sel2_i)
                    3'sd2: begin
                        Residual2_B0_sel = ~{15'b0, S2_i, 45'b0};
                        Residual2_B1_sel = ~{16'b0, S2_i, 44'b0};
                        Residual2_C_sel = ~{29'b0, 1'b1, 87'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual2_B0_sel = ~{17'b0, S2_i, 43'b0};
                        Residual2_B1_sel = ~{18'b0, S2_i, 42'b0};
                        Residual2_C_sel = ~{32'b0, 1'b1, 84'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual2_B0_sel = ~{17'b0, S2_i, 43'b0};
                        Residual2_B1_sel = ~{18'b0, S2_i, 42'b0};
                        Residual2_C_sel = {32'b0, 1'b1, 84'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual2_B0_sel = ~{15'b0, S2_i, 45'b0};
                        Residual2_B1_sel = ~{16'b0, S2_i, 44'b0};
                        Residual2_C_sel = {29'b0, 1'b1, 87'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                endcase
            end
            4'd1: begin
                case(s_sel2_i)
                    3'sd2: begin
                        Residual2_B0_sel = ~{21'b0, S2_i, 39'b0};
                        Residual2_B1_sel = ~{22'b0, S2_i, 38'b0};
                        Residual2_C_sel = ~{41'b0, 1'b1, 75'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual2_B0_sel = ~{23'b0, S2_i, 37'b0};
                        Residual2_B1_sel = ~{24'b0, S2_i, 36'b0};
                        Residual2_C_sel = ~{44'b0, 1'b1, 72'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual2_B0_sel = ~{23'b0, S2_i, 37'b0};
                        Residual2_B1_sel = ~{24'b0, S2_i, 36'b0};
                        Residual2_C_sel = {44'b0, 1'b1, 72'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual2_B0_sel = ~{21'b0, S2_i, 39'b0};
                        Residual2_B1_sel = ~{22'b0, S2_i, 38'b0};
                        Residual2_C_sel = {41'b0, 1'b1, 75'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                endcase
            end
            4'd2: begin
                case(s_sel2_i)
                    3'sd2: begin
                        Residual2_B0_sel = ~{27'b0, S2_i, 33'b0};
                        Residual2_B1_sel = ~{28'b0, S2_i, 32'b0};
                        Residual2_C_sel = ~{53'b0, 1'b1, 63'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual2_B0_sel = ~{29'b0, S2_i, 31'b0};
                        Residual2_B1_sel = ~{30'b0, S2_i, 30'b0};
                        Residual2_C_sel = ~{56'b0, 1'b1, 60'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual2_B0_sel = ~{29'b0, S2_i, 31'b0};
                        Residual2_B1_sel = ~{30'b0, S2_i, 30'b0};
                        Residual2_C_sel = {56'b0, 1'b1, 60'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual2_B0_sel = ~{27'b0, S2_i, 33'b0};
                        Residual2_B1_sel = ~{28'b0, S2_i, 32'b0};
                        Residual2_C_sel = {53'b0, 1'b1, 63'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                endcase
            end
            4'd3: begin
                case(s_sel2_i)
                    3'sd2: begin
                        Residual2_B0_sel = ~{33'b0, S2_i, 27'b0};
                        Residual2_B1_sel = ~{34'b0, S2_i, 26'b0};
                        Residual2_C_sel = ~{65'b0, 1'b1, 51'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual2_B0_sel = ~{35'b0, S2_i, 25'b0};
                        Residual2_B1_sel = ~{36'b0, S2_i, 24'b0};
                        Residual2_C_sel = ~{68'b0, 1'b1, 48'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual2_B0_sel = ~{35'b0, S2_i, 25'b0};
                        Residual2_B1_sel = ~{36'b0, S2_i, 24'b0};
                        Residual2_C_sel = {68'b0, 1'b1, 48'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual2_B0_sel = ~{33'b0, S2_i, 27'b0};
                        Residual2_B1_sel = ~{34'b0, S2_i, 26'b0};
                        Residual2_C_sel = {65'b0, 1'b1, 51'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                endcase
            end
            4'd4: begin
                case(s_sel2_i)
                    3'sd2: begin
                        Residual2_B0_sel = ~{39'b0, S2_i, 21'b0};
                        Residual2_B1_sel = ~{40'b0, S2_i, 20'b0};
                        Residual2_C_sel = ~{77'b0, 1'b1, 39'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual2_B0_sel = ~{41'b0, S2_i, 19'b0};
                        Residual2_B1_sel = ~{42'b0, S2_i, 18'b0};
                        Residual2_C_sel = ~{80'b0, 1'b1, 36'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual2_B0_sel = ~{41'b0, S2_i, 19'b0};
                        Residual2_B1_sel = ~{42'b0, S2_i, 18'b0};
                        Residual2_C_sel = {80'b0, 1'b1, 36'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual2_B0_sel = ~{39'b0, S2_i, 21'b0};
                        Residual2_B1_sel = ~{40'b0, S2_i, 20'b0};
                        Residual2_C_sel = {77'b0, 1'b1, 39'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                endcase
            end
            4'd5: begin
                case(s_sel2_i)
                    3'sd2: begin
                        Residual2_B0_sel = ~{45'b0, S2_i, 15'b0};
                        Residual2_B1_sel = ~{46'b0, S2_i, 14'b0};
                        Residual2_C_sel = ~{89'b0, 1'b1, 27'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual2_B0_sel = ~{47'b0, S2_i, 13'b0};
                        Residual2_B1_sel = ~{48'b0, S2_i, 12'b0};
                        Residual2_C_sel = ~{92'b0, 1'b1, 24'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual2_B0_sel = ~{47'b0, S2_i, 13'b0};
                        Residual2_B1_sel = ~{48'b0, S2_i, 12'b0};
                        Residual2_C_sel = {92'b0, 1'b1, 24'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual2_B0_sel = ~{45'b0, S2_i, 15'b0};
                        Residual2_B1_sel = ~{46'b0, S2_i, 14'b0};
                        Residual2_C_sel = {89'b0, 1'b1, 27'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                endcase
            end
            4'd6: begin
                case(s_sel2_i)
                    3'sd2: begin
                        Residual2_B0_sel = ~{51'b0, S2_i, 9'b0};
                        Residual2_B1_sel = ~{52'b0, S2_i, 8'b0};
                        Residual2_C_sel = ~{101'b0, 1'b1, 15'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual2_B0_sel = ~{53'b0, S2_i, 7'b0};
                        Residual2_B1_sel = ~{54'b0, S2_i, 6'b0};
                        Residual2_C_sel = ~{104'b0, 1'b1, 12'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual2_B0_sel = ~{53'b0, S2_i, 7'b0};
                        Residual2_B1_sel = ~{54'b0, S2_i, 6'b0};
                        Residual2_C_sel = {104'b0, 1'b1, 12'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual2_B0_sel = ~{51'b0, S2_i, 9'b0};
                        Residual2_B1_sel = ~{52'b0, S2_i, 8'b0};
                        Residual2_C_sel = {101'b0, 1'b1, 15'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                endcase
            end
            4'd7: begin
                case(s_sel2_i)
                    3'sd2: begin
                        Residual2_B0_sel = ~{57'b0, S2_i, 3'b0};
                        Residual2_B1_sel = ~{58'b0, S2_i, 2'b0};
                        Residual2_C_sel = ~{113'b0, 1'b1, 3'b0};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd1: begin
                        Residual2_B0_sel = ~{59'b0, S2_i, 1'b0};
                        Residual2_B1_sel = ~{60'b0, S2_i};
                        Residual2_C_sel = ~{116'b0, 1'b1};
                        Residual2_Corr_sel = 117'd7;
                    end
                    3'sd0: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                    -3'sd1: begin
                        Residual2_B0_sel = ~{59'b0, S2_i, 1'b0};
                        Residual2_B1_sel = ~{60'b0, S2_i};
                        Residual2_C_sel = {116'b0, 1'b1};
                        Residual2_Corr_sel = 117'd2;
                    end
                    -3'sd2: begin
                        Residual2_B0_sel = ~{57'b0, S2_i, 3'b0};
                        Residual2_B1_sel = ~{58'b0, S2_i, 2'b0};
                        Residual2_C_sel = {113'b0, 1'b1, 3'b0};
                        Residual2_Corr_sel = 117'd2;
                    end
                    default: begin
                        Residual2_B0_sel = '0;
                        Residual2_B1_sel = '0;
                        Residual2_C_sel = '0;
                        Residual2_Corr_sel = '0;
                    end
                endcase
            end
            default: begin
                Residual2_B0_sel = '0;
                Residual2_B1_sel = '0;
                Residual2_C_sel = '0;
                Residual2_Corr_sel = '0;
            end
        endcase
    end

    CSA4_2 #(.W(117)) u_Residual2_mid1_0 (
        .a_i(Residual1_c_o),
        .b_i(Residual1_s_o),
        .c_i(Residual2_A0_sel),
        .d_i(Residual2_A1_sel),
        .s_o(Residual2_mid1_s0),
        .c_o(Residual2_mid1_c0)
    );

    CSA4_2 #(.W(117)) u_Residual2_mid1_1 (
        .a_i(Residual2_A2_sel),
        .b_i(Residual2_A3_sel),
        .c_i(Residual2_B0_sel),
        .d_i(Residual2_B1_sel),
        .s_o(Residual2_mid1_s1),
        .c_o(Residual2_mid1_c1)
    );

    CSA4_2 #(.W(117)) u_Residual2_mid2_0 (
        .a_i(Residual2_mid1_s0),
        .b_i(Residual2_mid1_c0),
        .c_i(Residual2_mid1_s1),
        .d_i(Residual2_mid1_c1),
        .s_o(Residual2_mid2_s0),
        .c_o(Residual2_mid2_c0)
    );

    CSA4_2 #(.W(117)) u_Residual2_mid3_0 (
        .a_i(Residual2_mid2_s0),
        .b_i(Residual2_mid2_c0),
        .c_i(Residual2_C_sel),
        .d_i(Residual2_Corr_sel),
        .s_o(Residual2_mid3_s0),
        .c_o(Residual2_mid3_c0)
    );

    assign Residual2_s_o = {Residual2_mid3_s0[114:0], 2'b00};
    assign Residual2_c_o = {Residual2_mid3_c0[114:0], 2'b00};

endmodule