module fcbrt_S_SM_r4 (
    input  logic [56:0] S_i,
    input  logic [56:0] SM_i,
    input  logic signed [2:0] s_sel_i,
    input  logic [4:0] cycle_cnt_i,

    output logic [56:0] S_o,
    output logic [56:0] SM_o
);

    logic [56:0] S_out;
    logic [56:0] SM_out;

    always_comb begin
        S_out  = S_i;
        SM_out = SM_i;

        case(cycle_cnt_i)
            5'd0: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:48], 2'b10, S_i [45:0]}; SM_out = {S_i [56:48], 2'b01, S_i [45:0]}; end
                    3'sd1:  begin S_out = {S_i [56:48], 2'b01, S_i [45:0]}; SM_out = {S_i [56:48], 2'b00, S_i [45:0]}; end
                    3'sd0:  begin S_out = {S_i [56:48], 2'b00, S_i [45:0]}; SM_out = {SM_i[56:48], 2'b11, SM_i[45:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:48], 2'b11, SM_i[45:0]}; SM_out = {SM_i[56:48], 2'b10, SM_i[45:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:48], 2'b10, SM_i[45:0]}; SM_out = {SM_i[56:48], 2'b01, SM_i[45:0]}; end
                    default: begin end
                endcase
            end

            5'd1: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:46], 2'b10, S_i [43:0]}; SM_out = {S_i [56:46], 2'b01, S_i [43:0]}; end
                    3'sd1:  begin S_out = {S_i [56:46], 2'b01, S_i [43:0]}; SM_out = {S_i [56:46], 2'b00, S_i [43:0]}; end
                    3'sd0:  begin S_out = {S_i [56:46], 2'b00, S_i [43:0]}; SM_out = {SM_i[56:46], 2'b11, SM_i[43:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:46], 2'b11, SM_i[43:0]}; SM_out = {SM_i[56:46], 2'b10, SM_i[43:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:46], 2'b10, SM_i[43:0]}; SM_out = {SM_i[56:46], 2'b01, SM_i[43:0]}; end
                    default: begin end
                endcase
            end

            5'd2: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:44], 2'b10, S_i [41:0]}; SM_out = {S_i [56:44], 2'b01, S_i [41:0]}; end
                    3'sd1:  begin S_out = {S_i [56:44], 2'b01, S_i [41:0]}; SM_out = {S_i [56:44], 2'b00, S_i [41:0]}; end
                    3'sd0:  begin S_out = {S_i [56:44], 2'b00, S_i [41:0]}; SM_out = {SM_i[56:44], 2'b11, SM_i[41:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:44], 2'b11, SM_i[41:0]}; SM_out = {SM_i[56:44], 2'b10, SM_i[41:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:44], 2'b10, SM_i[41:0]}; SM_out = {SM_i[56:44], 2'b01, SM_i[41:0]}; end
                    default: begin end
                endcase
            end

            5'd3: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:42], 2'b10, S_i [39:0]}; SM_out = {S_i [56:42], 2'b01, S_i [39:0]}; end
                    3'sd1:  begin S_out = {S_i [56:42], 2'b01, S_i [39:0]}; SM_out = {S_i [56:42], 2'b00, S_i [39:0]}; end
                    3'sd0:  begin S_out = {S_i [56:42], 2'b00, S_i [39:0]}; SM_out = {SM_i[56:42], 2'b11, SM_i[39:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:42], 2'b11, SM_i[39:0]}; SM_out = {SM_i[56:42], 2'b10, SM_i[39:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:42], 2'b10, SM_i[39:0]}; SM_out = {SM_i[56:42], 2'b01, SM_i[39:0]}; end
                    default: begin end
                endcase
            end

            5'd4: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:40], 2'b10, S_i [37:0]}; SM_out = {S_i [56:40], 2'b01, S_i [37:0]}; end
                    3'sd1:  begin S_out = {S_i [56:40], 2'b01, S_i [37:0]}; SM_out = {S_i [56:40], 2'b00, S_i [37:0]}; end
                    3'sd0:  begin S_out = {S_i [56:40], 2'b00, S_i [37:0]}; SM_out = {SM_i[56:40], 2'b11, SM_i[37:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:40], 2'b11, SM_i[37:0]}; SM_out = {SM_i[56:40], 2'b10, SM_i[37:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:40], 2'b10, SM_i[37:0]}; SM_out = {SM_i[56:40], 2'b01, SM_i[37:0]}; end
                    default: begin end
                endcase
            end

            5'd5: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:38], 2'b10, S_i [35:0]}; SM_out = {S_i [56:38], 2'b01, S_i [35:0]}; end
                    3'sd1:  begin S_out = {S_i [56:38], 2'b01, S_i [35:0]}; SM_out = {S_i [56:38], 2'b00, S_i [35:0]}; end
                    3'sd0:  begin S_out = {S_i [56:38], 2'b00, S_i [35:0]}; SM_out = {SM_i[56:38], 2'b11, SM_i[35:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:38], 2'b11, SM_i[35:0]}; SM_out = {SM_i[56:38], 2'b10, SM_i[35:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:38], 2'b10, SM_i[35:0]}; SM_out = {SM_i[56:38], 2'b01, SM_i[35:0]}; end
                    default: begin end
                endcase
            end

            5'd6: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:36], 2'b10, S_i [33:0]}; SM_out = {S_i [56:36], 2'b01, S_i [33:0]}; end
                    3'sd1:  begin S_out = {S_i [56:36], 2'b01, S_i [33:0]}; SM_out = {S_i [56:36], 2'b00, S_i [33:0]}; end
                    3'sd0:  begin S_out = {S_i [56:36], 2'b00, S_i [33:0]}; SM_out = {SM_i[56:36], 2'b11, SM_i[33:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:36], 2'b11, SM_i[33:0]}; SM_out = {SM_i[56:36], 2'b10, SM_i[33:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:36], 2'b10, SM_i[33:0]}; SM_out = {SM_i[56:36], 2'b01, SM_i[33:0]}; end
                    default: begin end
                endcase
            end

            5'd7: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:34], 2'b10, S_i [31:0]}; SM_out = {S_i [56:34], 2'b01, S_i [31:0]}; end
                    3'sd1:  begin S_out = {S_i [56:34], 2'b01, S_i [31:0]}; SM_out = {S_i [56:34], 2'b00, S_i [31:0]}; end
                    3'sd0:  begin S_out = {S_i [56:34], 2'b00, S_i [31:0]}; SM_out = {SM_i[56:34], 2'b11, SM_i[31:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:34], 2'b11, SM_i[31:0]}; SM_out = {SM_i[56:34], 2'b10, SM_i[31:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:34], 2'b10, SM_i[31:0]}; SM_out = {SM_i[56:34], 2'b01, SM_i[31:0]}; end
                    default: begin end
                endcase
            end

            5'd8: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:32], 2'b10, S_i [29:0]}; SM_out = {S_i [56:32], 2'b01, S_i [29:0]}; end
                    3'sd1:  begin S_out = {S_i [56:32], 2'b01, S_i [29:0]}; SM_out = {S_i [56:32], 2'b00, S_i [29:0]}; end
                    3'sd0:  begin S_out = {S_i [56:32], 2'b00, S_i [29:0]}; SM_out = {SM_i[56:32], 2'b11, SM_i[29:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:32], 2'b11, SM_i[29:0]}; SM_out = {SM_i[56:32], 2'b10, SM_i[29:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:32], 2'b10, SM_i[29:0]}; SM_out = {SM_i[56:32], 2'b01, SM_i[29:0]}; end
                    default: begin end
                endcase
            end

            5'd9: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:30], 2'b10, S_i [27:0]}; SM_out = {S_i [56:30], 2'b01, S_i [27:0]}; end
                    3'sd1:  begin S_out = {S_i [56:30], 2'b01, S_i [27:0]}; SM_out = {S_i [56:30], 2'b00, S_i [27:0]}; end
                    3'sd0:  begin S_out = {S_i [56:30], 2'b00, S_i [27:0]}; SM_out = {SM_i[56:30], 2'b11, SM_i[27:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:30], 2'b11, SM_i[27:0]}; SM_out = {SM_i[56:30], 2'b10, SM_i[27:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:30], 2'b10, SM_i[27:0]}; SM_out = {SM_i[56:30], 2'b01, SM_i[27:0]}; end
                    default: begin end
                endcase
            end

            5'd10: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:28], 2'b10, S_i [25:0]}; SM_out = {S_i [56:28], 2'b01, S_i [25:0]}; end
                    3'sd1:  begin S_out = {S_i [56:28], 2'b01, S_i [25:0]}; SM_out = {S_i [56:28], 2'b00, S_i [25:0]}; end
                    3'sd0:  begin S_out = {S_i [56:28], 2'b00, S_i [25:0]}; SM_out = {SM_i[56:28], 2'b11, SM_i[25:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:28], 2'b11, SM_i[25:0]}; SM_out = {SM_i[56:28], 2'b10, SM_i[25:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:28], 2'b10, SM_i[25:0]}; SM_out = {SM_i[56:28], 2'b01, SM_i[25:0]}; end
                    default: begin end
                endcase
            end

            5'd11: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:26], 2'b10, S_i [23:0]}; SM_out = {S_i [56:26], 2'b01, S_i [23:0]}; end
                    3'sd1:  begin S_out = {S_i [56:26], 2'b01, S_i [23:0]}; SM_out = {S_i [56:26], 2'b00, S_i [23:0]}; end
                    3'sd0:  begin S_out = {S_i [56:26], 2'b00, S_i [23:0]}; SM_out = {SM_i[56:26], 2'b11, SM_i[23:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:26], 2'b11, SM_i[23:0]}; SM_out = {SM_i[56:26], 2'b10, SM_i[23:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:26], 2'b10, SM_i[23:0]}; SM_out = {SM_i[56:26], 2'b01, SM_i[23:0]}; end
                    default: begin end
                endcase
            end

            5'd12: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:24], 2'b10, S_i [21:0]}; SM_out = {S_i [56:24], 2'b01, S_i [21:0]}; end
                    3'sd1:  begin S_out = {S_i [56:24], 2'b01, S_i [21:0]}; SM_out = {S_i [56:24], 2'b00, S_i [21:0]}; end
                    3'sd0:  begin S_out = {S_i [56:24], 2'b00, S_i [21:0]}; SM_out = {SM_i[56:24], 2'b11, SM_i[21:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:24], 2'b11, SM_i[21:0]}; SM_out = {SM_i[56:24], 2'b10, SM_i[21:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:24], 2'b10, SM_i[21:0]}; SM_out = {SM_i[56:24], 2'b01, SM_i[21:0]}; end
                    default: begin end
                endcase
            end

            5'd13: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:22], 2'b10, S_i [19:0]}; SM_out = {S_i [56:22], 2'b01, S_i [19:0]}; end
                    3'sd1:  begin S_out = {S_i [56:22], 2'b01, S_i [19:0]}; SM_out = {S_i [56:22], 2'b00, S_i [19:0]}; end
                    3'sd0:  begin S_out = {S_i [56:22], 2'b00, S_i [19:0]}; SM_out = {SM_i[56:22], 2'b11, SM_i[19:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:22], 2'b11, SM_i[19:0]}; SM_out = {SM_i[56:22], 2'b10, SM_i[19:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:22], 2'b10, SM_i[19:0]}; SM_out = {SM_i[56:22], 2'b01, SM_i[19:0]}; end
                    default: begin end
                endcase
            end

            5'd14: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:20], 2'b10, S_i [17:0]}; SM_out = {S_i [56:20], 2'b01, S_i [17:0]}; end
                    3'sd1:  begin S_out = {S_i [56:20], 2'b01, S_i [17:0]}; SM_out = {S_i [56:20], 2'b00, S_i [17:0]}; end
                    3'sd0:  begin S_out = {S_i [56:20], 2'b00, S_i [17:0]}; SM_out = {SM_i[56:20], 2'b11, SM_i[17:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:20], 2'b11, SM_i[17:0]}; SM_out = {SM_i[56:20], 2'b10, SM_i[17:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:20], 2'b10, SM_i[17:0]}; SM_out = {SM_i[56:20], 2'b01, SM_i[17:0]}; end
                    default: begin end
                endcase
            end

            5'd15: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:18], 2'b10, S_i [15:0]}; SM_out = {S_i [56:18], 2'b01, S_i [15:0]}; end
                    3'sd1:  begin S_out = {S_i [56:18], 2'b01, S_i [15:0]}; SM_out = {S_i [56:18], 2'b00, S_i [15:0]}; end
                    3'sd0:  begin S_out = {S_i [56:18], 2'b00, S_i [15:0]}; SM_out = {SM_i[56:18], 2'b11, SM_i[15:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:18], 2'b11, SM_i[15:0]}; SM_out = {SM_i[56:18], 2'b10, SM_i[15:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:18], 2'b10, SM_i[15:0]}; SM_out = {SM_i[56:18], 2'b01, SM_i[15:0]}; end
                    default: begin end
                endcase
            end

            5'd16: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:16], 2'b10, S_i [13:0]}; SM_out = {S_i [56:16], 2'b01, S_i [13:0]}; end
                    3'sd1:  begin S_out = {S_i [56:16], 2'b01, S_i [13:0]}; SM_out = {S_i [56:16], 2'b00, S_i [13:0]}; end
                    3'sd0:  begin S_out = {S_i [56:16], 2'b00, S_i [13:0]}; SM_out = {SM_i[56:16], 2'b11, SM_i[13:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:16], 2'b11, SM_i[13:0]}; SM_out = {SM_i[56:16], 2'b10, SM_i[13:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:16], 2'b10, SM_i[13:0]}; SM_out = {SM_i[56:16], 2'b01, SM_i[13:0]}; end
                    default: begin end
                endcase
            end

            5'd17: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:14], 2'b10, S_i [11:0]}; SM_out = {S_i [56:14], 2'b01, S_i [11:0]}; end
                    3'sd1:  begin S_out = {S_i [56:14], 2'b01, S_i [11:0]}; SM_out = {S_i [56:14], 2'b00, S_i [11:0]}; end
                    3'sd0:  begin S_out = {S_i [56:14], 2'b00, S_i [11:0]}; SM_out = {SM_i[56:14], 2'b11, SM_i[11:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:14], 2'b11, SM_i[11:0]}; SM_out = {SM_i[56:14], 2'b10, SM_i[11:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:14], 2'b10, SM_i[11:0]}; SM_out = {SM_i[56:14], 2'b01, SM_i[11:0]}; end
                    default: begin end
                endcase
            end

            5'd18: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:12], 2'b10, S_i [9:0]}; SM_out = {S_i [56:12], 2'b01, S_i [9:0]}; end
                    3'sd1:  begin S_out = {S_i [56:12], 2'b01, S_i [9:0]}; SM_out = {S_i [56:12], 2'b00, S_i [9:0]}; end
                    3'sd0:  begin S_out = {S_i [56:12], 2'b00, S_i [9:0]}; SM_out = {SM_i[56:12], 2'b11, SM_i[9:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:12], 2'b11, SM_i[9:0]}; SM_out = {SM_i[56:12], 2'b10, SM_i[9:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:12], 2'b10, SM_i[9:0]}; SM_out = {SM_i[56:12], 2'b01, SM_i[9:0]}; end
                    default: begin end
                endcase
            end

            5'd19: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:10], 2'b10, S_i [7:0]}; SM_out = {S_i [56:10], 2'b01, S_i [7:0]}; end
                    3'sd1:  begin S_out = {S_i [56:10], 2'b01, S_i [7:0]}; SM_out = {S_i [56:10], 2'b00, S_i [7:0]}; end
                    3'sd0:  begin S_out = {S_i [56:10], 2'b00, S_i [7:0]}; SM_out = {SM_i[56:10], 2'b11, SM_i[7:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:10], 2'b11, SM_i[7:0]}; SM_out = {SM_i[56:10], 2'b10, SM_i[7:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:10], 2'b10, SM_i[7:0]}; SM_out = {SM_i[56:10], 2'b01, SM_i[7:0]}; end
                    default: begin end
                endcase
            end

            5'd20: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:8], 2'b10, S_i [5:0]}; SM_out = {S_i [56:8], 2'b01, S_i [5:0]}; end
                    3'sd1:  begin S_out = {S_i [56:8], 2'b01, S_i [5:0]}; SM_out = {S_i [56:8], 2'b00, S_i [5:0]}; end
                    3'sd0:  begin S_out = {S_i [56:8], 2'b00, S_i [5:0]}; SM_out = {SM_i[56:8], 2'b11, SM_i[5:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:8], 2'b11, SM_i[5:0]}; SM_out = {SM_i[56:8], 2'b10, SM_i[5:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:8], 2'b10, SM_i[5:0]}; SM_out = {SM_i[56:8], 2'b01, SM_i[5:0]}; end
                    default: begin end
                endcase
            end

            5'd21: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:6], 2'b10, S_i [3:0]}; SM_out = {S_i [56:6], 2'b01, S_i [3:0]}; end
                    3'sd1:  begin S_out = {S_i [56:6], 2'b01, S_i [3:0]}; SM_out = {S_i [56:6], 2'b00, S_i [3:0]}; end
                    3'sd0:  begin S_out = {S_i [56:6], 2'b00, S_i [3:0]}; SM_out = {SM_i[56:6], 2'b11, SM_i[3:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:6], 2'b11, SM_i[3:0]}; SM_out = {SM_i[56:6], 2'b10, SM_i[3:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:6], 2'b10, SM_i[3:0]}; SM_out = {SM_i[56:6], 2'b01, SM_i[3:0]}; end
                    default: begin end
                endcase
            end

            5'd22: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:4], 2'b10, S_i [1:0]}; SM_out = {S_i [56:4], 2'b01, S_i [1:0]}; end
                    3'sd1:  begin S_out = {S_i [56:4], 2'b01, S_i [1:0]}; SM_out = {S_i [56:4], 2'b00, S_i [1:0]}; end
                    3'sd0:  begin S_out = {S_i [56:4], 2'b00, S_i [1:0]}; SM_out = {SM_i[56:4], 2'b11, SM_i[1:0]}; end
                   -3'sd1:  begin S_out = {SM_i[56:4], 2'b11, SM_i[1:0]}; SM_out = {SM_i[56:4], 2'b10, SM_i[1:0]}; end
                   -3'sd2:  begin S_out = {SM_i[56:4], 2'b10, SM_i[1:0]}; SM_out = {SM_i[56:4], 2'b01, SM_i[1:0]}; end
                    default: begin end
                endcase
            end

            5'd23: begin
                case(s_sel_i)
                    3'sd2:  begin S_out = {S_i [56:2], 2'b10}; SM_out = {S_i [56:2], 2'b01}; end
                    3'sd1:  begin S_out = {S_i [56:2], 2'b01}; SM_out = {S_i [56:2], 2'b00}; end
                    3'sd0:  begin S_out = {S_i [56:2], 2'b00}; SM_out = {SM_i[56:2], 2'b11}; end
                   -3'sd1:  begin S_out = {SM_i[56:2], 2'b11}; SM_out = {SM_i[56:2], 2'b10}; end
                   -3'sd2:  begin S_out = {SM_i[56:2], 2'b10}; SM_out = {SM_i[56:2], 2'b01}; end
                    default: begin end
                endcase
            end

            default: begin
                S_out  = S_i;
                SM_out = SM_i;
            end
        endcase
    end

    assign S_o  = S_out;
    assign SM_o = SM_out;

endmodule