module CSA4_2 #(
    parameter W = 113
)(
    input  logic [W-1:0] a_i,
    input  logic [W-1:0] b_i,
    input  logic [W-1:0] c_i,
    input  logic [W-1:0] d_i,
    output logic [W-1:0] s_o,
    output logic [W-1:0] c_o
);
    logic [W-1:0] s1, c1;
    logic [W-1:0] c1_raw, c2_raw;

    assign s1 = a_i ^ b_i ^ c_i;
    assign c1_raw = (a_i & b_i) | (a_i & c_i) | (b_i & c_i);
    assign c1 = {c1_raw[W-2:0], 1'b0};

    assign s_o = s1 ^ d_i ^ c1;
    assign c2_raw = (s1 & d_i) | (s1 & c1) | (d_i & c1);
    assign c_o = {c2_raw[W-2:0], 1'b0};

endmodule