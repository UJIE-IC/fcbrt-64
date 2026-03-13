module CLA_15bit (
    input [14:0]A,
    input [14:0]B,
    input C_in,
    output [14:0] S,
    output C_out
);
    wire [14:0]P = A ^ B; 
    wire [14:0]G = A & B; 
    wire [15:0]C; 

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