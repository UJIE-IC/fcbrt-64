module CLA_15bit(
    input logic [14:0] A,
    input logic [14:0] B,
    input logic C_in,
    output logic[14:0] S,
    output logic C_out
);

    logic [14:0] P;
    logic [14:0] G;
    logic [15:0] C;

    assign P = A ^ B;
    assign G = A & B;

    assign C[0] = C_in;

    genvar i;
    generate
        for (i = 0; i < 15; i = i + 1) begin : cla_logic
            assign C[i+1] = G[i] | (P[i] & C[i]);
            assign S[i] = P[i] ^ C[i];
        end
    endgenerate

    assign C_out = C[15];
    
endmodule