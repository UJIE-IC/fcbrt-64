package defs_cbrt;

  localparam C_RM                  = 3;
  localparam C_RM_NEAREST          = 3'h0;

  localparam C_FS                  = 1;    // only FP32 / FP64
  localparam C_FMT_FP32            = 1'b0;
  localparam C_FMT_FP64            = 1'b1;

  // FP64
  localparam C_OP_FP64             = 64;
  localparam C_MANT_FP64           = 52;
  localparam C_EXP_FP64            = 11;
  localparam C_BIAS_FP64           = 1023;
  localparam C_EXP_ZERO_FP64       = 11'h000;
  localparam C_EXP_INF_FP64        = 11'h7FF;
  localparam C_MANT_ZERO_FP64      = 52'h0;
  localparam C_MANT_NAN_FP64       = 52'h8_0000_0000_0000;
  localparam C_PZERO_FP64          = 64'h0000_0000_0000_0000;
  localparam C_MZERO_FP64          = 64'h8000_0000_0000_0000;
  localparam C_QNAN_FP64           = 64'h7FF8_0000_0000_0000;

  // FP32
  localparam C_OP_FP32             = 32;
  localparam C_MANT_FP32           = 23;
  localparam C_EXP_FP32            = 8;
  localparam C_BIAS_FP32           = 127;
  localparam C_EXP_ZERO_FP32       = 8'h00;
  localparam C_EXP_INF_FP32        = 8'hFF;
  localparam C_MANT_ZERO_FP32      = 23'h0;
  localparam C_MANT_NAN_FP32       = 23'h40_0000;
  localparam C_PZERO_FP32          = 32'h0000_0000;
  localparam C_MZERO_FP32          = 32'h8000_0000;
  localparam C_QNAN_FP32           = 32'h7FC0_0000;

endpackage : defs_cbrt