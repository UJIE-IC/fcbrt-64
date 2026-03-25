module fcbrt_S_SM_r64(
    input  logic [56:0] S0_i,
    input  logic [56:0] SM0_i,
    input  logic signed [2:0] s_sel0_i,
    input  logic signed [2:0] s_sel1_i,
    input  logic signed [2:0] s_sel2_i,
    input  logic [2:0] cycle_cnt_i,

    output logic [56:0] S1_mid_o,
    output logic [56:0] S2_mid_o,
    output logic [56:0] S_o,
    output logic [56:0] SM_o
);

    logic [56:0] S0_out, SM0_out, S1_in, SM1_in, S1_out, SM1_out, S2_in, SM2_in, S2_out, SM2_out;

    // stage0 S/SM path
    always_comb begin
        case(cycle_cnt_i)
            4'd0: begin
                case(s_sel0_i)
                    3'sd2: begin
                        S0_out = {S0_i[56:48], 2'b10, S0_i[45:0]};
                        SM0_out = {S0_i[56:48], 2'b01, S0_i[45:0]};
                    end
                    3'sd1: begin
                        S0_out = {S0_i[56:48], 2'b01, S0_i[45:0]};
                        SM0_out = {S0_i[56:48], 2'b00, S0_i[45:0]};
                    end
                    3'sd0: begin
                        S0_out = {S0_i[56:48], 2'b00, S0_i[45:0]};
                        SM0_out = {SM0_i[56:48], 2'b11, SM0_i[45:0]};
                    end
                    -3'sd1: begin
                        S0_out = {SM0_i[56:48], 2'b11, SM0_i[45:0]};
                        SM0_out = {SM0_i[56:48], 2'b10, SM0_i[45:0]};
                    end
                    -3'sd2: begin
                        S0_out = {SM0_i[56:48], 2'b10, SM0_i[45:0]};
                        SM0_out = {SM0_i[56:48], 2'b01, SM0_i[45:0]};
                    end
                    default: begin
                        S0_out = S0_i;
                        SM0_out = SM0_i;
                    end
                endcase
            end
            4'd1: begin
                case(s_sel0_i)
                    3'sd2: begin
                        S0_out = {S0_i[56:42], 2'b10, S0_i[39:0]};
                        SM0_out = {S0_i[56:42], 2'b01, S0_i[39:0]};
                    end
                    3'sd1: begin
                        S0_out = {S0_i[56:42], 2'b01, S0_i[39:0]};
                        SM0_out = {S0_i[56:42], 2'b00, S0_i[39:0]};
                    end
                    3'sd0: begin
                        S0_out = {S0_i[56:42], 2'b00, S0_i[39:0]};
                        SM0_out = {SM0_i[56:42], 2'b11, SM0_i[39:0]};
                    end
                    -3'sd1: begin
                        S0_out = {SM0_i[56:42], 2'b11, SM0_i[39:0]};
                        SM0_out = {SM0_i[56:42], 2'b10, SM0_i[39:0]};
                    end
                    -3'sd2: begin
                        S0_out = {SM0_i[56:42], 2'b10, SM0_i[39:0]};
                        SM0_out = {SM0_i[56:42], 2'b01, SM0_i[39:0]};
                    end
                    default: begin
                        S0_out = S0_i;
                        SM0_out = SM0_i;
                    end
                endcase
            end
            4'd2: begin
                case(s_sel0_i)
                    3'sd2: begin
                        S0_out = {S0_i[56:36], 2'b10, S0_i[33:0]};
                        SM0_out = {S0_i[56:36], 2'b01, S0_i[33:0]};
                    end
                    3'sd1: begin
                        S0_out = {S0_i[56:36], 2'b01, S0_i[33:0]};
                        SM0_out = {S0_i[56:36], 2'b00, S0_i[33:0]};
                    end
                    3'sd0: begin
                        S0_out = {S0_i[56:36], 2'b00, S0_i[33:0]};
                        SM0_out = {SM0_i[56:36], 2'b11, SM0_i[33:0]};
                    end
                    -3'sd1: begin
                        S0_out = {SM0_i[56:36], 2'b11, SM0_i[33:0]};
                        SM0_out = {SM0_i[56:36], 2'b10, SM0_i[33:0]};
                    end
                    -3'sd2: begin
                        S0_out = {SM0_i[56:36], 2'b10, SM0_i[33:0]};
                        SM0_out = {SM0_i[56:36], 2'b01, SM0_i[33:0]};
                    end
                    default: begin
                        S0_out = S0_i;
                        SM0_out = SM0_i;
                    end
                endcase
            end
            4'd3: begin
                case(s_sel0_i)
                    3'sd2: begin
                        S0_out = {S0_i[56:30], 2'b10, S0_i[27:0]};
                        SM0_out = {S0_i[56:30], 2'b01, S0_i[27:0]};
                    end
                    3'sd1: begin
                        S0_out = {S0_i[56:30], 2'b01, S0_i[27:0]};
                        SM0_out = {S0_i[56:30], 2'b00, S0_i[27:0]};
                    end
                    3'sd0: begin
                        S0_out = {S0_i[56:30], 2'b00, S0_i[27:0]};
                        SM0_out = {SM0_i[56:30], 2'b11, SM0_i[27:0]};
                    end
                    -3'sd1: begin
                        S0_out = {SM0_i[56:30], 2'b11, SM0_i[27:0]};
                        SM0_out = {SM0_i[56:30], 2'b10, SM0_i[27:0]};
                    end
                    -3'sd2: begin
                        S0_out = {SM0_i[56:30], 2'b10, SM0_i[27:0]};
                        SM0_out = {SM0_i[56:30], 2'b01, SM0_i[27:0]};
                    end
                    default: begin
                        S0_out = S0_i;
                        SM0_out = SM0_i;
                    end
                endcase
            end
            4'd4: begin
                case(s_sel0_i)
                    3'sd2: begin
                        S0_out = {S0_i[56:24], 2'b10, S0_i[21:0]};
                        SM0_out = {S0_i[56:24], 2'b01, S0_i[21:0]};
                    end
                    3'sd1: begin
                        S0_out = {S0_i[56:24], 2'b01, S0_i[21:0]};
                        SM0_out = {S0_i[56:24], 2'b00, S0_i[21:0]};
                    end
                    3'sd0: begin
                        S0_out = {S0_i[56:24], 2'b00, S0_i[21:0]};
                        SM0_out = {SM0_i[56:24], 2'b11, SM0_i[21:0]};
                    end
                    -3'sd1: begin
                        S0_out = {SM0_i[56:24], 2'b11, SM0_i[21:0]};
                        SM0_out = {SM0_i[56:24], 2'b10, SM0_i[21:0]};
                    end
                    -3'sd2: begin
                        S0_out = {SM0_i[56:24], 2'b10, SM0_i[21:0]};
                        SM0_out = {SM0_i[56:24], 2'b01, SM0_i[21:0]};
                    end
                    default: begin
                        S0_out = S0_i;
                        SM0_out = SM0_i;
                    end
                endcase
            end
            4'd5: begin
                case(s_sel0_i)
                    3'sd2: begin
                        S0_out = {S0_i[56:18], 2'b10, S0_i[15:0]};
                        SM0_out = {S0_i[56:18], 2'b01, S0_i[15:0]};
                    end
                    3'sd1: begin
                        S0_out = {S0_i[56:18], 2'b01, S0_i[15:0]};
                        SM0_out = {S0_i[56:18], 2'b00, S0_i[15:0]};
                    end
                    3'sd0: begin
                        S0_out = {S0_i[56:18], 2'b00, S0_i[15:0]};
                        SM0_out = {SM0_i[56:18], 2'b11, SM0_i[15:0]};
                    end
                    -3'sd1: begin
                        S0_out = {SM0_i[56:18], 2'b11, SM0_i[15:0]};
                        SM0_out = {SM0_i[56:18], 2'b10, SM0_i[15:0]};
                    end
                    -3'sd2: begin
                        S0_out = {SM0_i[56:18], 2'b10, SM0_i[15:0]};
                        SM0_out = {SM0_i[56:18], 2'b01, SM0_i[15:0]};
                    end
                    default: begin
                        S0_out = S0_i;
                        SM0_out = SM0_i;
                    end
                endcase
            end
            4'd6: begin
                case(s_sel0_i)
                    3'sd2: begin
                        S0_out = {S0_i[56:12], 2'b10, S0_i[9:0]};
                        SM0_out = {S0_i[56:12], 2'b01, S0_i[9:0]};
                    end
                    3'sd1: begin
                        S0_out = {S0_i[56:12], 2'b01, S0_i[9:0]};
                        SM0_out = {S0_i[56:12], 2'b00, S0_i[9:0]};
                    end
                    3'sd0: begin
                        S0_out = {S0_i[56:12], 2'b00, S0_i[9:0]};
                        SM0_out = {SM0_i[56:12], 2'b11, SM0_i[9:0]};
                    end
                    -3'sd1: begin
                        S0_out = {SM0_i[56:12], 2'b11, SM0_i[9:0]};
                        SM0_out = {SM0_i[56:12], 2'b10, SM0_i[9:0]};
                    end
                    -3'sd2: begin
                        S0_out = {SM0_i[56:12], 2'b10, SM0_i[9:0]};
                        SM0_out = {SM0_i[56:12], 2'b01, SM0_i[9:0]};
                    end
                    default: begin
                        S0_out = S0_i;
                        SM0_out = SM0_i;
                    end
                endcase
            end
            4'd7: begin
                case(s_sel0_i)
                    3'sd2: begin
                        S0_out = {S0_i[56:6], 2'b10, S0_i[3:0]};
                        SM0_out = {S0_i[56:6], 2'b01, S0_i[3:0]};
                    end
                    3'sd1: begin
                        S0_out = {S0_i[56:6], 2'b01, S0_i[3:0]};
                        SM0_out = {S0_i[56:6], 2'b00, S0_i[3:0]};
                    end
                    3'sd0: begin
                        S0_out = {S0_i[56:6], 2'b00, S0_i[3:0]};
                        SM0_out = {SM0_i[56:6], 2'b11, SM0_i[3:0]};
                    end
                    -3'sd1: begin
                        S0_out = {SM0_i[56:6], 2'b11, SM0_i[3:0]};
                        SM0_out = {SM0_i[56:6], 2'b10, SM0_i[3:0]};
                    end
                    -3'sd2: begin
                        S0_out = {SM0_i[56:6], 2'b10, SM0_i[3:0]};
                        SM0_out = {SM0_i[56:6], 2'b01, SM0_i[3:0]};
                    end
                    default: begin
                        S0_out = S0_i;
                        SM0_out = SM0_i;
                    end
                endcase
            end
            default: begin
                S0_out = S0_i;
                SM0_out = SM0_i;
            end
        endcase
    end

    assign S1_in = S0_out;
    assign SM1_in = SM0_out;
    assign S1_mid_o = S0_out;

    // stage1 S/SM path
    always_comb begin
        case (cycle_cnt_i)
            4'd0: begin
                case (s_sel1_i)
                    3'sd2: begin
                        S1_out = {S1_in[56:46], 2'b10, S1_in[43:0]};
                        SM1_out = {S1_in[56:46], 2'b01, S1_in[43:0]};
                    end
                    3'sd1: begin
                        S1_out = {S1_in[56:46], 2'b01, S1_in[43:0]};
                        SM1_out = {S1_in[56:46], 2'b00, S1_in[43:0]};
                    end
                    3'sd0: begin
                        S1_out = {S1_in[56:46], 2'b00, S1_in[43:0]};
                        SM1_out = {SM1_in[56:46], 2'b11, SM1_in[43:0]};
                    end
                    -3'sd1: begin
                        S1_out = {SM1_in[56:46], 2'b11, SM1_in[43:0]};
                        SM1_out = {SM1_in[56:46], 2'b10, SM1_in[43:0]};
                    end
                    -3'sd2: begin
                        S1_out = {SM1_in[56:46], 2'b10, SM1_in[43:0]};
                        SM1_out = {SM1_in[56:46], 2'b01, SM1_in[43:0]};
                    end
                    default: begin
                        S1_out = S1_in;
                        SM1_out = SM1_in;
                    end
                endcase
            end
            4'd1: begin
                case (s_sel1_i)
                    3'sd2: begin
                        S1_out = {S1_in[56:40], 2'b10, S1_in[37:0]};
                        SM1_out = {S1_in[56:40], 2'b01, S1_in[37:0]};
                    end
                    3'sd1: begin
                        S1_out = {S1_in[56:40], 2'b01, S1_in[37:0]};
                        SM1_out = {S1_in[56:40], 2'b00, S1_in[37:0]};
                    end
                    3'sd0: begin
                        S1_out = {S1_in[56:40], 2'b00, S1_in[37:0]};
                        SM1_out = {SM1_in[56:40], 2'b11, SM1_in[37:0]};
                    end
                    -3'sd1: begin
                        S1_out = {SM1_in[56:40], 2'b11, SM1_in[37:0]};
                        SM1_out = {SM1_in[56:40], 2'b10, SM1_in[37:0]};
                    end
                    -3'sd2: begin
                        S1_out = {SM1_in[56:40], 2'b10, SM1_in[37:0]};
                        SM1_out = {SM1_in[56:40], 2'b01, SM1_in[37:0]};
                    end
                    default: begin
                        S1_out = S1_in;
                        SM1_out = SM1_in;
                    end
                endcase
            end
            4'd2: begin
                case (s_sel1_i)
                    3'sd2: begin
                        S1_out = {S1_in[56:34], 2'b10, S1_in[31:0]};
                        SM1_out = {S1_in[56:34], 2'b01, S1_in[31:0]};
                    end
                    3'sd1: begin
                        S1_out = {S1_in[56:34], 2'b01, S1_in[31:0]};
                        SM1_out = {S1_in[56:34], 2'b00, S1_in[31:0]};
                    end
                    3'sd0: begin
                        S1_out = {S1_in[56:34], 2'b00, S1_in[31:0]};
                        SM1_out = {SM1_in[56:34], 2'b11, SM1_in[31:0]};
                    end
                    -3'sd1: begin
                        S1_out = {SM1_in[56:34], 2'b11, SM1_in[31:0]};
                        SM1_out = {SM1_in[56:34], 2'b10, SM1_in[31:0]};
                    end
                    -3'sd2: begin
                        S1_out = {SM1_in[56:34], 2'b10, SM1_in[31:0]};
                        SM1_out = {SM1_in[56:34], 2'b01, SM1_in[31:0]};
                    end
                    default: begin
                        S1_out = S1_in;
                        SM1_out = SM1_in;
                    end
                endcase
            end
            4'd3: begin
                case (s_sel1_i)
                    3'sd2: begin
                        S1_out = {S1_in[56:28], 2'b10, S1_in[25:0]};
                        SM1_out = {S1_in[56:28], 2'b01, S1_in[25:0]};
                    end
                    3'sd1: begin
                        S1_out = {S1_in[56:28], 2'b01, S1_in[25:0]};
                        SM1_out = {S1_in[56:28], 2'b00, S1_in[25:0]};
                    end
                    3'sd0: begin
                        S1_out = {S1_in[56:28], 2'b00, S1_in[25:0]};
                        SM1_out = {SM1_in[56:28], 2'b11, SM1_in[25:0]};
                    end
                    -3'sd1: begin
                        S1_out = {SM1_in[56:28], 2'b11, SM1_in[25:0]};
                        SM1_out = {SM1_in[56:28], 2'b10, SM1_in[25:0]};
                    end
                    -3'sd2: begin
                        S1_out = {SM1_in[56:28], 2'b10, SM1_in[25:0]};
                        SM1_out = {SM1_in[56:28], 2'b01, SM1_in[25:0]};
                    end
                    default: begin
                        S1_out = S1_in;
                        SM1_out = SM1_in;
                    end
                endcase
            end
            4'd4: begin
                case (s_sel1_i)
                    3'sd2: begin
                        S1_out = {S1_in[56:22], 2'b10, S1_in[19:0]};
                        SM1_out = {S1_in[56:22], 2'b01, S1_in[19:0]};
                    end
                    3'sd1: begin
                        S1_out = {S1_in[56:22], 2'b01, S1_in[19:0]};
                        SM1_out = {S1_in[56:22], 2'b00, S1_in[19:0]};
                    end
                    3'sd0: begin
                        S1_out = {S1_in[56:22], 2'b00, S1_in[19:0]};
                        SM1_out = {SM1_in[56:22], 2'b11, SM1_in[19:0]};
                    end
                    -3'sd1: begin
                        S1_out = {SM1_in[56:22], 2'b11, SM1_in[19:0]};
                        SM1_out = {SM1_in[56:22], 2'b10, SM1_in[19:0]};
                    end
                    -3'sd2: begin
                        S1_out = {SM1_in[56:22], 2'b10, SM1_in[19:0]};
                        SM1_out = {SM1_in[56:22], 2'b01, SM1_in[19:0]};
                    end
                    default: begin
                        S1_out = S1_in;
                        SM1_out = SM1_in;
                    end
                endcase
            end
            4'd5: begin
                case (s_sel1_i)
                    3'sd2: begin
                        S1_out = {S1_in[56:16], 2'b10, S1_in[13:0]};
                        SM1_out = {S1_in[56:16], 2'b01, S1_in[13:0]};
                    end
                    3'sd1: begin
                        S1_out = {S1_in[56:16], 2'b01, S1_in[13:0]};
                        SM1_out = {S1_in[56:16], 2'b00, S1_in[13:0]};
                    end
                    3'sd0: begin
                        S1_out = {S1_in[56:16], 2'b00, S1_in[13:0]};
                        SM1_out = {SM1_in[56:16], 2'b11, SM1_in[13:0]};
                    end
                    -3'sd1: begin
                        S1_out = {SM1_in[56:16], 2'b11, SM1_in[13:0]};
                        SM1_out = {SM1_in[56:16], 2'b10, SM1_in[13:0]};
                    end
                    -3'sd2: begin
                        S1_out = {SM1_in[56:16], 2'b10, SM1_in[13:0]};
                        SM1_out = {SM1_in[56:16], 2'b01, SM1_in[13:0]};
                    end
                    default: begin
                        S1_out = S1_in;
                        SM1_out = SM1_in;
                    end
                endcase
            end
            4'd6: begin
                case (s_sel1_i)
                    3'sd2: begin
                        S1_out = {S1_in[56:10], 2'b10, S1_in[7:0]};
                        SM1_out = {S1_in[56:10], 2'b01, S1_in[7:0]};
                    end
                    3'sd1: begin
                        S1_out = {S1_in[56:10], 2'b01, S1_in[7:0]};
                        SM1_out = {S1_in[56:10], 2'b00, S1_in[7:0]};
                    end
                    3'sd0: begin
                        S1_out = {S1_in[56:10], 2'b00, S1_in[7:0]};
                        SM1_out = {SM1_in[56:10], 2'b11, SM1_in[7:0]};
                    end
                    -3'sd1: begin
                        S1_out = {SM1_in[56:10], 2'b11, SM1_in[7:0]};
                        SM1_out = {SM1_in[56:10], 2'b10, SM1_in[7:0]};
                    end
                    -3'sd2: begin
                        S1_out = {SM1_in[56:10], 2'b10, SM1_in[7:0]};
                        SM1_out = {SM1_in[56:10], 2'b01, SM1_in[7:0]};
                    end
                    default: begin
                        S1_out = S1_in;
                        SM1_out = SM1_in;
                    end
                endcase
            end
            4'd7: begin
                case (s_sel1_i)
                    3'sd2: begin
                        S1_out = {S1_in[56:4], 2'b10, S1_in[1:0]};
                        SM1_out = {S1_in[56:4], 2'b01, S1_in[1:0]};
                    end
                    3'sd1: begin
                        S1_out = {S1_in[56:4], 2'b01, S1_in[1:0]};
                        SM1_out = {S1_in[56:4], 2'b00, S1_in[1:0]};
                    end
                    3'sd0: begin
                        S1_out = {S1_in[56:4], 2'b00, S1_in[1:0]};
                        SM1_out = {SM1_in[56:4], 2'b11, SM1_in[1:0]};
                    end
                    -3'sd1: begin
                        S1_out = {SM1_in[56:4], 2'b11, SM1_in[1:0]};
                        SM1_out = {SM1_in[56:4], 2'b10, SM1_in[1:0]};
                    end
                    -3'sd2: begin
                        S1_out = {SM1_in[56:4], 2'b10, SM1_in[1:0]};
                        SM1_out = {SM1_in[56:4], 2'b01, SM1_in[1:0]};
                    end
                    default: begin
                        S1_out = S1_in;
                        SM1_out = SM1_in;
                    end
                endcase
            end
            default: begin
                S1_out = S1_in;
                SM1_out = SM1_in;
            end
        endcase
    end

    assign S2_in = S1_out;
    assign SM2_in = SM1_out;
    assign S2_mid_o = S1_out;

    // stage2 S/SM path
    always_comb begin
        case (cycle_cnt_i)
            4'd0: begin
                case (s_sel2_i)
                    3'sd2: begin
                        S2_out = {S2_in[56:44], 2'b10, S2_in[41:0]};
                        SM2_out = {S2_in[56:44], 2'b01, S2_in[41:0]};
                    end
                    3'sd1: begin
                        S2_out = {S2_in[56:44], 2'b01, S2_in[41:0]};
                        SM2_out = {S2_in[56:44], 2'b00, S2_in[41:0]};
                    end
                    3'sd0: begin
                        S2_out = {S2_in[56:44], 2'b00, S2_in[41:0]};
                        SM2_out = {SM2_in[56:44], 2'b11, SM2_in[41:0]};
                    end
                    -3'sd1: begin
                        S2_out = {SM2_in[56:44], 2'b11, SM2_in[41:0]};
                        SM2_out = {SM2_in[56:44], 2'b10, SM2_in[41:0]};
                    end
                    -3'sd2: begin
                        S2_out = {SM2_in[56:44], 2'b10, SM2_in[41:0]};
                        SM2_out = {SM2_in[56:44], 2'b01, SM2_in[41:0]};
                    end
                    default: begin
                        S2_out = S2_in;
                        SM2_out = SM2_in;
                    end
                endcase
            end
            4'd1: begin
                case (s_sel2_i)
                    3'sd2: begin
                        S2_out = {S2_in[56:38], 2'b10, S2_in[35:0]};
                        SM2_out = {S2_in[56:38], 2'b01, S2_in[35:0]};
                    end
                    3'sd1: begin
                        S2_out = {S2_in[56:38], 2'b01, S2_in[35:0]};
                        SM2_out = {S2_in[56:38], 2'b00, S2_in[35:0]};
                    end
                    3'sd0: begin
                        S2_out = {S2_in[56:38], 2'b00, S2_in[35:0]};
                        SM2_out = {SM2_in[56:38], 2'b11, SM2_in[35:0]};
                    end
                    -3'sd1: begin
                        S2_out = {SM2_in[56:38], 2'b11, SM2_in[35:0]};
                        SM2_out = {SM2_in[56:38], 2'b10, SM2_in[35:0]};
                    end
                    -3'sd2: begin
                        S2_out = {SM2_in[56:38], 2'b10, SM2_in[35:0]};
                        SM2_out = {SM2_in[56:38], 2'b01, SM2_in[35:0]};
                    end
                    default: begin
                        S2_out = S2_in;
                        SM2_out = SM2_in;
                    end
                endcase
            end
            4'd2: begin
                case (s_sel2_i)
                    3'sd2: begin
                        S2_out = {S2_in[56:32], 2'b10, S2_in[29:0]};
                        SM2_out = {S2_in[56:32], 2'b01, S2_in[29:0]};
                    end
                    3'sd1: begin
                        S2_out = {S2_in[56:32], 2'b01, S2_in[29:0]};
                        SM2_out = {S2_in[56:32], 2'b00, S2_in[29:0]};
                    end
                    3'sd0: begin
                        S2_out = {S2_in[56:32], 2'b00, S2_in[29:0]};
                        SM2_out = {SM2_in[56:32], 2'b11, SM2_in[29:0]};
                    end
                    -3'sd1: begin
                        S2_out = {SM2_in[56:32], 2'b11, SM2_in[29:0]};
                        SM2_out = {SM2_in[56:32], 2'b10, SM2_in[29:0]};
                    end
                    -3'sd2: begin
                        S2_out = {SM2_in[56:32], 2'b10, SM2_in[29:0]};
                        SM2_out = {SM2_in[56:32], 2'b01, SM2_in[29:0]};
                    end
                    default: begin
                        S2_out = S2_in;
                        SM2_out = SM2_in;
                    end
                endcase
            end
            4'd3: begin
                case (s_sel2_i)
                    3'sd2: begin
                        S2_out = {S2_in[56:26], 2'b10, S2_in[23:0]};
                        SM2_out = {S2_in[56:26], 2'b01, S2_in[23:0]};
                    end
                    3'sd1: begin
                        S2_out = {S2_in[56:26], 2'b01, S2_in[23:0]};
                        SM2_out = {S2_in[56:26], 2'b00, S2_in[23:0]};
                    end
                    3'sd0: begin
                        S2_out = {S2_in[56:26], 2'b00, S2_in[23:0]};
                        SM2_out = {SM2_in[56:26], 2'b11, SM2_in[23:0]};
                    end
                    -3'sd1: begin
                        S2_out = {SM2_in[56:26], 2'b11, SM2_in[23:0]};
                        SM2_out = {SM2_in[56:26], 2'b10, SM2_in[23:0]};
                    end
                    -3'sd2: begin
                        S2_out = {SM2_in[56:26], 2'b10, SM2_in[23:0]};
                        SM2_out = {SM2_in[56:26], 2'b01, SM2_in[23:0]};
                    end
                    default: begin
                        S2_out = S2_in;
                        SM2_out = SM2_in;
                    end
                endcase
            end
            4'd4: begin
                case (s_sel2_i)
                    3'sd2: begin
                        S2_out = {S2_in[56:20], 2'b10, S2_in[17:0]};
                        SM2_out = {S2_in[56:20], 2'b01, S2_in[17:0]};
                    end
                    3'sd1: begin
                        S2_out = {S2_in[56:20], 2'b01, S2_in[17:0]};
                        SM2_out = {S2_in[56:20], 2'b00, S2_in[17:0]};
                    end
                    3'sd0: begin
                        S2_out = {S2_in[56:20], 2'b00, S2_in[17:0]};
                        SM2_out = {SM2_in[56:20], 2'b11, SM2_in[17:0]};
                    end
                    -3'sd1: begin
                        S2_out = {SM2_in[56:20], 2'b11, SM2_in[17:0]};
                        SM2_out = {SM2_in[56:20], 2'b10, SM2_in[17:0]};
                    end
                    -3'sd2: begin
                        S2_out = {SM2_in[56:20], 2'b10, SM2_in[17:0]};
                        SM2_out = {SM2_in[56:20], 2'b01, SM2_in[17:0]};
                    end
                    default: begin
                        S2_out = S2_in;
                        SM2_out = SM2_in;
                    end
                endcase
            end
            4'd5: begin
                case (s_sel2_i)
                    3'sd2: begin
                        S2_out = {S2_in[56:14], 2'b10, S2_in[11:0]};
                        SM2_out = {S2_in[56:14], 2'b01, S2_in[11:0]};
                    end
                    3'sd1: begin
                        S2_out = {S2_in[56:14], 2'b01, S2_in[11:0]};
                        SM2_out = {S2_in[56:14], 2'b00, S2_in[11:0]};
                    end
                    3'sd0: begin
                        S2_out = {S2_in[56:14], 2'b00, S2_in[11:0]};
                        SM2_out = {SM2_in[56:14], 2'b11, SM2_in[11:0]};
                    end
                    -3'sd1: begin
                        S2_out = {SM2_in[56:14], 2'b11, SM2_in[11:0]};
                        SM2_out = {SM2_in[56:14], 2'b10, SM2_in[11:0]};
                    end
                    -3'sd2: begin
                        S2_out = {SM2_in[56:14], 2'b10, SM2_in[11:0]};
                        SM2_out = {SM2_in[56:14], 2'b01, SM2_in[11:0]};
                    end
                    default: begin
                        S2_out = S2_in;
                        SM2_out = SM2_in;
                    end
                endcase
            end
            4'd6: begin
                case (s_sel2_i)
                    3'sd2: begin
                        S2_out = {S2_in[56:8], 2'b10, S2_in[5:0]};
                        SM2_out = {S2_in[56:8], 2'b01, S2_in[5:0]};
                    end
                    3'sd1: begin
                        S2_out = {S2_in[56:8], 2'b01, S2_in[5:0]};
                        SM2_out = {S2_in[56:8], 2'b00, S2_in[5:0]};
                    end
                    3'sd0: begin
                        S2_out = {S2_in[56:8], 2'b00, S2_in[5:0]};
                        SM2_out = {SM2_in[56:8], 2'b11, SM2_in[5:0]};
                    end
                    -3'sd1: begin
                        S2_out = {SM2_in[56:8], 2'b11, SM2_in[5:0]};
                        SM2_out = {SM2_in[56:8], 2'b10, SM2_in[5:0]};
                    end
                    -3'sd2: begin
                        S2_out = {SM2_in[56:8], 2'b10, SM2_in[5:0]};
                        SM2_out = {SM2_in[56:8], 2'b01, SM2_in[5:0]};
                    end
                    default: begin
                        S2_out = S2_in;
                        SM2_out = SM2_in;
                    end
                endcase
            end
            4'd7: begin
                case (s_sel2_i)
                    3'sd2: begin
                        S2_out = {S2_in[56:2], 2'b10};
                        SM2_out = {S2_in[56:2], 2'b01};
                    end
                    3'sd1: begin
                        S2_out = {S2_in[56:2], 2'b01};
                        SM2_out = {S2_in[56:2], 2'b00};
                    end
                    3'sd0: begin
                        S2_out = {S2_in[56:2], 2'b00};
                        SM2_out = {SM2_in[56:2], 2'b11};
                    end
                    -3'sd1: begin
                        S2_out = {SM2_in[56:2], 2'b11};
                        SM2_out = {SM2_in[56:2], 2'b10};
                    end
                    -3'sd2: begin
                        S2_out = {SM2_in[56:2], 2'b10};
                        SM2_out = {SM2_in[56:2], 2'b01};
                    end
                    default: begin
                        S2_out = S2_in;
                        SM2_out = SM2_in;
                    end
                endcase
            end
            default: begin
                S2_out = S2_in;
                SM2_out = SM2_in;
            end
        endcase
    end

    assign S_o = S2_out;
    assign SM_o = SM2_out;

    endmodule