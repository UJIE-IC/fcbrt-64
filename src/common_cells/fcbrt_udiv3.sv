module fcbrt_udiv3 #(
    parameter int W = 11
)(
    input logic [W-1:0] x_i,
    output logic [W-1:0] q_o
);

    // floor(x_i / 3) = (x_i * 683) >> 11
    // 其中：683 = 2^9 + 2^7 + 2^5 + 2^3 + 2^1 + 2^0

    localparam  MW = W + 10;

    logic [MW-1:0] x_ext;
    logic [MW-1:0] mul_683_d;
    logic [W:0] times3_d;
    logic [W:0] rem_d;

    assign x_ext = {{(MW-W){1'b0}}, x_i};
    assign mul_683_d = (x_ext << 9) + (x_ext << 7) + (x_ext << 5) + (x_ext << 3) + (x_ext << 1) + x_ext;
    assign q_o = mul_683_d[MW-1:11];

endmodule


