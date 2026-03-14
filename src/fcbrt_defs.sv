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

  localparam C_LZCNT               = 6;

  // FP32
  localparam C_OP_FP32             = 32;
  localparam C_MANT_FP32           = 23;
  localparam C_EXP_FP32            = 8;
  localparam C_BIAS_FP32           = 127;

endpackage: fcbrt_defs