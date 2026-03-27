module fcbrt_Ssquare_r4(
    input  logic [56:0] S_i,
    input  logic [112:0] Sq_c_i,
    input  logic [112:0] Sq_s_i,
    input  logic signed [2:0] s_sel_i,
    input  logic [4:0] cycle_cnt_i,

    output logic [112:0] Sq_c_o,
    output logic [112:0] Sq_s_o
);

    // Sq_next = Sq_prev + X + Y
    // X = 2*S*q*4^{-j}
    // Y = q^2*4^{-2j}

    logic [112:0] Sqx0_base;
    logic [112:0] Sqx0;
    logic [112:0] Sqy0_base;
    logic [112:0] Sqy0;
    logic Sqx0_neg;

    always_comb begin
        case(cycle_cnt_i)
            5'd0: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {8'b0, S_i, 48'b0};
                        Sqy0_base = {18'b0, 1'b1, 94'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {9'b0, S_i, 47'b0};
                        Sqy0_base = {20'b0, 1'b1, 92'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {9'b0, S_i, 47'b0};
                        Sqy0_base = {20'b0, 1'b1, 92'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {8'b0, S_i, 48'b0};
                        Sqy0_base = {18'b0, 1'b1, 94'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd1: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {10'b0, S_i, 46'b0};
                        Sqy0_base = {22'b0, 1'b1, 90'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {11'b0, S_i, 45'b0};
                        Sqy0_base = {24'b0, 1'b1, 88'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {11'b0, S_i, 45'b0};
                        Sqy0_base = {24'b0, 1'b1, 88'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {10'b0, S_i, 46'b0};
                        Sqy0_base = {22'b0, 1'b1, 90'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd2: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {12'b0, S_i, 44'b0};
                        Sqy0_base = {26'b0, 1'b1, 86'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {13'b0, S_i, 43'b0};
                        Sqy0_base = {28'b0, 1'b1, 84'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {13'b0, S_i, 43'b0};
                        Sqy0_base = {28'b0, 1'b1, 84'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {12'b0, S_i, 44'b0};
                        Sqy0_base = {26'b0, 1'b1, 86'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd3: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {14'b0, S_i, 42'b0};
                        Sqy0_base = {30'b0, 1'b1, 82'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {15'b0, S_i, 41'b0};
                        Sqy0_base = {32'b0, 1'b1, 80'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {15'b0, S_i, 41'b0};
                        Sqy0_base = {32'b0, 1'b1, 80'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {14'b0, S_i, 42'b0};
                        Sqy0_base = {30'b0, 1'b1, 82'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd4: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {16'b0, S_i, 40'b0};
                        Sqy0_base = {34'b0, 1'b1, 78'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {17'b0, S_i, 39'b0};
                        Sqy0_base = {36'b0, 1'b1, 76'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {17'b0, S_i, 39'b0};
                        Sqy0_base = {36'b0, 1'b1, 76'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {16'b0, S_i, 40'b0};
                        Sqy0_base = {34'b0, 1'b1, 78'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd5: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {18'b0, S_i, 38'b0};
                        Sqy0_base = {38'b0, 1'b1, 74'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {19'b0, S_i, 37'b0};
                        Sqy0_base = {40'b0, 1'b1, 72'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {19'b0, S_i, 37'b0};
                        Sqy0_base = {40'b0, 1'b1, 72'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {18'b0, S_i, 38'b0};
                        Sqy0_base = {38'b0, 1'b1, 74'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd6: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {20'b0, S_i, 36'b0};
                        Sqy0_base = {42'b0, 1'b1, 70'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {21'b0, S_i, 35'b0};
                        Sqy0_base = {44'b0, 1'b1, 68'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {21'b0, S_i, 35'b0};
                        Sqy0_base = {44'b0, 1'b1, 68'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {20'b0, S_i, 36'b0};
                        Sqy0_base = {42'b0, 1'b1, 70'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd7: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {22'b0, S_i, 34'b0};
                        Sqy0_base = {46'b0, 1'b1, 66'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {23'b0, S_i, 33'b0};
                        Sqy0_base = {48'b0, 1'b1, 64'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {23'b0, S_i, 33'b0};
                        Sqy0_base = {48'b0, 1'b1, 64'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {22'b0, S_i, 34'b0};
                        Sqy0_base = {46'b0, 1'b1, 66'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd8: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {24'b0, S_i, 32'b0};
                        Sqy0_base = {50'b0, 1'b1, 62'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {25'b0, S_i, 31'b0};
                        Sqy0_base = {52'b0, 1'b1, 60'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {25'b0, S_i, 31'b0};
                        Sqy0_base = {52'b0, 1'b1, 60'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {24'b0, S_i, 32'b0};
                        Sqy0_base = {50'b0, 1'b1, 62'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd9: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {26'b0, S_i, 30'b0};
                        Sqy0_base = {54'b0, 1'b1, 58'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {27'b0, S_i, 29'b0};
                        Sqy0_base = {56'b0, 1'b1, 56'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {27'b0, S_i, 29'b0};
                        Sqy0_base = {56'b0, 1'b1, 56'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {26'b0, S_i, 30'b0};
                        Sqy0_base = {54'b0, 1'b1, 58'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd10: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {28'b0, S_i, 28'b0};
                        Sqy0_base = {58'b0, 1'b1, 54'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {29'b0, S_i, 27'b0};
                        Sqy0_base = {60'b0, 1'b1, 52'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {29'b0, S_i, 27'b0};
                        Sqy0_base = {60'b0, 1'b1, 52'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {28'b0, S_i, 28'b0};
                        Sqy0_base = {58'b0, 1'b1, 54'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd11: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {30'b0, S_i, 26'b0};
                        Sqy0_base = {62'b0, 1'b1, 50'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {31'b0, S_i, 25'b0};
                        Sqy0_base = {64'b0, 1'b1, 48'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {31'b0, S_i, 25'b0};
                        Sqy0_base = {64'b0, 1'b1, 48'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {30'b0, S_i, 26'b0};
                        Sqy0_base = {62'b0, 1'b1, 50'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd12: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {32'b0, S_i, 24'b0};
                        Sqy0_base = {66'b0, 1'b1, 46'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {33'b0, S_i, 23'b0};
                        Sqy0_base = {68'b0, 1'b1, 44'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {33'b0, S_i, 23'b0};
                        Sqy0_base = {68'b0, 1'b1, 44'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {32'b0, S_i, 24'b0};
                        Sqy0_base = {66'b0, 1'b1, 46'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd13: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {34'b0, S_i, 22'b0};
                        Sqy0_base = {70'b0, 1'b1, 42'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {35'b0, S_i, 21'b0};
                        Sqy0_base = {72'b0, 1'b1, 40'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {35'b0, S_i, 21'b0};
                        Sqy0_base = {72'b0, 1'b1, 40'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {34'b0, S_i, 22'b0};
                        Sqy0_base = {70'b0, 1'b1, 42'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd14: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {36'b0, S_i, 20'b0};
                        Sqy0_base = {74'b0, 1'b1, 38'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {37'b0, S_i, 19'b0};
                        Sqy0_base = {76'b0, 1'b1, 36'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {37'b0, S_i, 19'b0};
                        Sqy0_base = {76'b0, 1'b1, 36'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {36'b0, S_i, 20'b0};
                        Sqy0_base = {74'b0, 1'b1, 38'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd15: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {38'b0, S_i, 18'b0};
                        Sqy0_base = {78'b0, 1'b1, 34'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {39'b0, S_i, 17'b0};
                        Sqy0_base = {80'b0, 1'b1, 32'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {39'b0, S_i, 17'b0};
                        Sqy0_base = {80'b0, 1'b1, 32'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {38'b0, S_i, 18'b0};
                        Sqy0_base = {78'b0, 1'b1, 34'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd16: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {40'b0, S_i, 16'b0};
                        Sqy0_base = {82'b0, 1'b1, 30'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {41'b0, S_i, 15'b0};
                        Sqy0_base = {84'b0, 1'b1, 28'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {41'b0, S_i, 15'b0};
                        Sqy0_base = {84'b0, 1'b1, 28'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {40'b0, S_i, 16'b0};
                        Sqy0_base = {82'b0, 1'b1, 30'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd17: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {42'b0, S_i, 14'b0};
                        Sqy0_base = {86'b0, 1'b1, 26'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {43'b0, S_i, 13'b0};
                        Sqy0_base = {88'b0, 1'b1, 24'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {43'b0, S_i, 13'b0};
                        Sqy0_base = {88'b0, 1'b1, 24'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {42'b0, S_i, 14'b0};
                        Sqy0_base = {86'b0, 1'b1, 26'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd18: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {44'b0, S_i, 12'b0};
                        Sqy0_base = {90'b0, 1'b1, 22'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {45'b0, S_i, 11'b0};
                        Sqy0_base = {92'b0, 1'b1, 20'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {45'b0, S_i, 11'b0};
                        Sqy0_base = {92'b0, 1'b1, 20'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {44'b0, S_i, 12'b0};
                        Sqy0_base = {90'b0, 1'b1, 22'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd19: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {46'b0, S_i, 10'b0};
                        Sqy0_base = {94'b0, 1'b1, 18'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {47'b0, S_i, 9'b0};
                        Sqy0_base = {96'b0, 1'b1, 16'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {47'b0, S_i, 9'b0};
                        Sqy0_base = {96'b0, 1'b1, 16'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {46'b0, S_i, 10'b0};
                        Sqy0_base = {94'b0, 1'b1, 18'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd20: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {48'b0, S_i, 8'b0};
                        Sqy0_base = {98'b0, 1'b1, 14'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {49'b0, S_i, 7'b0};
                        Sqy0_base = {100'b0, 1'b1, 12'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {49'b0, S_i, 7'b0};
                        Sqy0_base = {100'b0, 1'b1, 12'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {48'b0, S_i, 8'b0};
                        Sqy0_base = {98'b0, 1'b1, 14'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd21: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {50'b0, S_i, 6'b0};
                        Sqy0_base = {102'b0, 1'b1, 10'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {51'b0, S_i, 5'b0};
                        Sqy0_base = {104'b0, 1'b1, 8'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {51'b0, S_i, 5'b0};
                        Sqy0_base = {104'b0, 1'b1, 8'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {50'b0, S_i, 6'b0};
                        Sqy0_base = {102'b0, 1'b1, 10'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd22: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {52'b0, S_i, 4'b0};
                        Sqy0_base = {106'b0, 1'b1, 6'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {53'b0, S_i, 3'b0};
                        Sqy0_base = {108'b0, 1'b1, 4'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {53'b0, S_i, 3'b0};
                        Sqy0_base = {108'b0, 1'b1, 4'b0};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {52'b0, S_i, 4'b0};
                        Sqy0_base = {106'b0, 1'b1, 6'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            5'd23: begin
                case(s_sel_i)
                    3'sd2: begin
                        Sqx0_base = {54'b0, S_i, 2'b0};
                        Sqy0_base = {110'b0, 1'b1, 2'b0};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd1: begin
                        Sqx0_base = {55'b0, S_i, 1'b0};
                        Sqy0_base = {112'b0, 1'b1};
                        Sqx0_neg = 1'b0;
                    end
                    3'sd0: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                    -3'sd1: begin
                        Sqx0_base = {55'b0, S_i, 1'b0};
                        Sqy0_base = {112'b0, 1'b1};
                        Sqx0_neg = 1'b1;
                    end
                    -3'sd2: begin
                        Sqx0_base = {54'b0, S_i, 2'b0};
                        Sqy0_base = {110'b0, 1'b1, 2'b0};
                        Sqx0_neg = 1'b1;
                    end
                    default: begin
                        Sqx0_base = '0;
                        Sqy0_base = '0;
                        Sqx0_neg = 1'b0;
                    end
                endcase
            end

            default: begin
                Sqx0_base = '0;
                Sqy0_base = '0;
                Sqx0_neg = 1'b0;
            end
        endcase

        Sqx0 = Sqx0_neg ? (~Sqx0_base)        : Sqx0_base;
        Sqy0 = Sqx0_neg ? (Sqy0_base + 113'd1): Sqy0_base;
    end

    CSA4_2 #(.W(113)) u_Sq0_CSA4_2(
        .a_i(Sq_c_i),
        .b_i(Sq_s_i),
        .c_i(Sqx0),
        .d_i(Sqy0),
        .s_o(Sq_s_o),
        .c_o(Sq_c_o)
    );

endmodule