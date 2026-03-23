package fcbrt_defs;

  // OPcode
  localparam C_RM                  = 3;
  localparam C_RM_NEAREST          = 3'h0;
  localparam C_FS_SP               = 1'b0;
  localparam C_FS_DP               = 1'b1;

  // ML_PLAC
  localparam C_INIT_IW             = 14;
  localparam C_INIT_OW             = 9;

  // FP64
  localparam C_OP_FP64             = 64;
  localparam C_MANT_FP64           = 52;
  localparam C_EXP_FP64            = 11;
  localparam C_BIAS_FP64           = 1023;

  localparam logic [C_OP_FP64-1:0] C_FP64_POS_ZERO = 64'h0000000000000000;
  localparam logic [C_OP_FP64-1:0] C_FP64_NEG_ZERO = 64'h8000000000000000;
  localparam logic [C_OP_FP64-1:0] C_FP64_POS_INF  = 64'h7ff0000000000000;
  localparam logic [C_OP_FP64-1:0] C_FP64_NEG_INF  = 64'hfff0000000000000;
  localparam logic [C_OP_FP64-1:0] C_FP64_POS_QNAN = 64'h7ff8000000000000;
  localparam logic [C_OP_FP64-1:0] C_FP64_NEG_QNAN = 64'hfff8000000000000;
  localparam logic [C_OP_FP64-1:0] C_FP64_POS_SNAN = 64'h7ff0000000000001;
  localparam logic [C_OP_FP64-1:0] C_FP64_NEG_SNAN = 64'hfff0000000000001;

  localparam C_LZCNT               = 6;

  // FP32
  localparam C_OP_FP32             = 32;
  localparam C_MANT_FP32           = 23;
  localparam C_EXP_FP32            = 8;
  localparam C_BIAS_FP32           = 127;

  localparam logic [C_OP_FP32-1:0] C_FP32_POS_ZERO = 32'h00000000;
  localparam logic [C_OP_FP32-1:0] C_FP32_NEG_ZERO = 32'h80000000;
  localparam logic [C_OP_FP32-1:0] C_FP32_POS_INF  = 32'h7f800000;
  localparam logic [C_OP_FP32-1:0] C_FP32_NEG_INF  = 32'hff800000;
  localparam logic [C_OP_FP32-1:0] C_FP32_POS_QNAN = 32'h7fc00000;
  localparam logic [C_OP_FP32-1:0] C_FP32_NEG_QNAN = 32'hffc00000;
  localparam logic [C_OP_FP32-1:0] C_FP32_POS_SNAN = 32'h7f800001;
  localparam logic [C_OP_FP32-1:0] C_FP32_NEG_SNAN = 32'hff800001;

endpackage: fcbrt_defs