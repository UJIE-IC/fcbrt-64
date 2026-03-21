module fcbrt_Ssel(
    input  logic signed [8:0] ResidualH_i, // Q5.4 signed
    input  logic [6:0] SH_i,               // U1.6 unsigned
    output logic signed [2:0] S_sel_o      // {-2,-1,0,1,2}
);

    logic [6:0] m1_pos;
    logic [6:0] m2_pos;

    logic SH_is_one;
    logic ResH_nonneg;

    assign SH_is_one  = (SH_i == 7'd64);    // 1.000000
    assign ResH_nonneg = ~ResidualH_i[8];   // signed Q5.4

    always_comb begin
        if (SH_i >= 7'd48) begin
            m1_pos = 7'd17;
        end else if (SH_i >= 7'd39) begin
            m1_pos = 7'd10;
        end else begin
            m1_pos = 7'd7;
        end

        if (SH_i >= 7'd62) begin
            m2_pos = 7'd65;
        end else if (SH_i >= 7'd57) begin
            m2_pos = 7'd62;
        end else if (SH_i >= 7'd53) begin
            m2_pos = 7'd52;
        end else if (SH_i >= 7'd49) begin
            m2_pos = 7'd45;
        end else if (SH_i >= 7'd46) begin
            m2_pos = 7'd39;
        end else if (SH_i >= 7'd43) begin
            m2_pos = 7'd35;
        end else if (SH_i >= 7'd40) begin
            m2_pos = 7'd30;
        end else if (SH_i >= 7'd38) begin
            m2_pos = 7'd26;
        end else if (SH_i >= 7'd36) begin
            m2_pos = 7'd24;
        end else if (SH_i == 7'd35) begin
            m2_pos = 7'd22;
        end else if (SH_i == 7'd34) begin
            m2_pos = 7'd21;
        end else if (SH_i == 7'd33) begin
            m2_pos = 7'd20;
        end else if (SH_i == 7'd32) begin
            m2_pos = 7'd19;
        end else begin
            m2_pos = '0;
        end
    end

    //   y =  2 : residual >= +m2
    //   y =  1 : residual >= +m1 && residual < +m2
    //   y =  0 : residual >= -m1 && residual < +m1
    //   y = -1 : residual >= -m2 && residual < -m1
    //   y = -2 : residual <  -m2
    always_comb begin
        if (SH_is_one) begin
            // At S=1, only s_i in {-2,-1,0} is required.
            if (ResidualH_i >= -9'sd17) begin
                S_sel_o = 3'sd0;
            end else if (ResidualH_i >= -9'sd65) begin
                S_sel_o = -3'sd1;
            end else begin
                S_sel_o = -3'sd2;
            end
        end else if (ResH_nonneg) begin
            if (ResidualH_i >= $signed({2'b00, m2_pos}))
                S_sel_o = 3'sd2;
            else if (ResidualH_i >= $signed({2'b00, m1_pos}))
                S_sel_o = 3'sd1;
            else
                S_sel_o = 3'sd0;
        end else begin
            if (ResidualH_i >= -$signed({2'b00, m1_pos}))
                S_sel_o = 3'sd0;
            else if (ResidualH_i >= -$signed({2'b00, m2_pos}))
                S_sel_o = -3'sd1;
            else
                S_sel_o = -3'sd2;
        end
    end

endmodule
