import fcbrt_defs::*;
module fcbrt_init_pow_lut(
    input  logic [C_INIT_OW-1:0] mant_init_i,
    output logic [16:0]          init_sq_o,
    output logic [24:0]          init_cb_o
);

    logic [7:0] lut_idx;

    always_comb begin
        init_sq_o = '0;
        init_cb_o = '0;
        lut_idx   = 8'd0;

        if (mant_init_i < 9'h080) begin
            init_sq_o = '0;
            init_cb_o = '0;
        end else if (mant_init_i > 9'h100) begin
            init_sq_o = 17'h10000;
            init_cb_o = 25'h1000000;
        end else begin
            lut_idx = mant_init_i - 9'h080;
            case (lut_idx)
                8'd  0: begin init_sq_o = 17'h04000; init_cb_o = 25'h0200000; end // x0 = 0.50000000
                8'd  1: begin init_sq_o = 17'h04101; init_cb_o = 25'h020c181; end // x0 = 0.50390625
                8'd  2: begin init_sq_o = 17'h04204; init_cb_o = 25'h0218608; end // x0 = 0.50781250
                8'd  3: begin init_sq_o = 17'h04309; init_cb_o = 25'h0224d9b; end // x0 = 0.51171875
                8'd  4: begin init_sq_o = 17'h04410; init_cb_o = 25'h0231840; end // x0 = 0.51562500
                8'd  5: begin init_sq_o = 17'h04519; init_cb_o = 25'h023e5fd; end // x0 = 0.51953125
                8'd  6: begin init_sq_o = 17'h04624; init_cb_o = 25'h024b6d8; end // x0 = 0.52343750
                8'd  7: begin init_sq_o = 17'h04731; init_cb_o = 25'h0258ad7; end // x0 = 0.52734375
                8'd  8: begin init_sq_o = 17'h04840; init_cb_o = 25'h0266200; end // x0 = 0.53125000
                8'd  9: begin init_sq_o = 17'h04951; init_cb_o = 25'h0273c59; end // x0 = 0.53515625
                8'd 10: begin init_sq_o = 17'h04a64; init_cb_o = 25'h02819e8; end // x0 = 0.53906250
                8'd 11: begin init_sq_o = 17'h04b79; init_cb_o = 25'h028fab3; end // x0 = 0.54296875
                8'd 12: begin init_sq_o = 17'h04c90; init_cb_o = 25'h029dec0; end // x0 = 0.54687500
                8'd 13: begin init_sq_o = 17'h04da9; init_cb_o = 25'h02ac615; end // x0 = 0.55078125
                8'd 14: begin init_sq_o = 17'h04ec4; init_cb_o = 25'h02bb0b8; end // x0 = 0.55468750
                8'd 15: begin init_sq_o = 17'h04fe1; init_cb_o = 25'h02c9eaf; end // x0 = 0.55859375
                8'd 16: begin init_sq_o = 17'h05100; init_cb_o = 25'h02d9000; end // x0 = 0.56250000
                8'd 17: begin init_sq_o = 17'h05221; init_cb_o = 25'h02e84b1; end // x0 = 0.56640625
                8'd 18: begin init_sq_o = 17'h05344; init_cb_o = 25'h02f7cc8; end // x0 = 0.57031250
                8'd 19: begin init_sq_o = 17'h05469; init_cb_o = 25'h030784b; end // x0 = 0.57421875
                8'd 20: begin init_sq_o = 17'h05590; init_cb_o = 25'h0317740; end // x0 = 0.57812500
                8'd 21: begin init_sq_o = 17'h056b9; init_cb_o = 25'h03279ad; end // x0 = 0.58203125
                8'd 22: begin init_sq_o = 17'h057e4; init_cb_o = 25'h0337f98; end // x0 = 0.58593750
                8'd 23: begin init_sq_o = 17'h05911; init_cb_o = 25'h0348907; end // x0 = 0.58984375
                8'd 24: begin init_sq_o = 17'h05a40; init_cb_o = 25'h0359600; end // x0 = 0.59375000
                8'd 25: begin init_sq_o = 17'h05b71; init_cb_o = 25'h036a689; end // x0 = 0.59765625
                8'd 26: begin init_sq_o = 17'h05ca4; init_cb_o = 25'h037baa8; end // x0 = 0.60156250
                8'd 27: begin init_sq_o = 17'h05dd9; init_cb_o = 25'h038d263; end // x0 = 0.60546875
                8'd 28: begin init_sq_o = 17'h05f10; init_cb_o = 25'h039edc0; end // x0 = 0.60937500
                8'd 29: begin init_sq_o = 17'h06049; init_cb_o = 25'h03b0cc5; end // x0 = 0.61328125
                8'd 30: begin init_sq_o = 17'h06184; init_cb_o = 25'h03c2f78; end // x0 = 0.61718750
                8'd 31: begin init_sq_o = 17'h062c1; init_cb_o = 25'h03d55df; end // x0 = 0.62109375
                8'd 32: begin init_sq_o = 17'h06400; init_cb_o = 25'h03e8000; end // x0 = 0.62500000
                8'd 33: begin init_sq_o = 17'h06541; init_cb_o = 25'h03fade1; end // x0 = 0.62890625
                8'd 34: begin init_sq_o = 17'h06684; init_cb_o = 25'h040df88; end // x0 = 0.63281250
                8'd 35: begin init_sq_o = 17'h067c9; init_cb_o = 25'h04214fb; end // x0 = 0.63671875
                8'd 36: begin init_sq_o = 17'h06910; init_cb_o = 25'h0434e40; end // x0 = 0.64062500
                8'd 37: begin init_sq_o = 17'h06a59; init_cb_o = 25'h0448b5d; end // x0 = 0.64453125
                8'd 38: begin init_sq_o = 17'h06ba4; init_cb_o = 25'h045cc58; end // x0 = 0.64843750
                8'd 39: begin init_sq_o = 17'h06cf1; init_cb_o = 25'h0471137; end // x0 = 0.65234375
                8'd 40: begin init_sq_o = 17'h06e40; init_cb_o = 25'h0485a00; end // x0 = 0.65625000
                8'd 41: begin init_sq_o = 17'h06f91; init_cb_o = 25'h049a6b9; end // x0 = 0.66015625
                8'd 42: begin init_sq_o = 17'h070e4; init_cb_o = 25'h04af768; end // x0 = 0.66406250
                8'd 43: begin init_sq_o = 17'h07239; init_cb_o = 25'h04c4c13; end // x0 = 0.66796875
                8'd 44: begin init_sq_o = 17'h07390; init_cb_o = 25'h04da4c0; end // x0 = 0.67187500
                8'd 45: begin init_sq_o = 17'h074e9; init_cb_o = 25'h04f0175; end // x0 = 0.67578125
                8'd 46: begin init_sq_o = 17'h07644; init_cb_o = 25'h0506238; end // x0 = 0.67968750
                8'd 47: begin init_sq_o = 17'h077a1; init_cb_o = 25'h051c70f; end // x0 = 0.68359375
                8'd 48: begin init_sq_o = 17'h07900; init_cb_o = 25'h0533000; end // x0 = 0.68750000
                8'd 49: begin init_sq_o = 17'h07a61; init_cb_o = 25'h0549d11; end // x0 = 0.69140625
                8'd 50: begin init_sq_o = 17'h07bc4; init_cb_o = 25'h0560e48; end // x0 = 0.69531250
                8'd 51: begin init_sq_o = 17'h07d29; init_cb_o = 25'h05783ab; end // x0 = 0.69921875
                8'd 52: begin init_sq_o = 17'h07e90; init_cb_o = 25'h058fd40; end // x0 = 0.70312500
                8'd 53: begin init_sq_o = 17'h07ff9; init_cb_o = 25'h05a7b0d; end // x0 = 0.70703125
                8'd 54: begin init_sq_o = 17'h08164; init_cb_o = 25'h05bfd18; end // x0 = 0.71093750
                8'd 55: begin init_sq_o = 17'h082d1; init_cb_o = 25'h05d8367; end // x0 = 0.71484375
                8'd 56: begin init_sq_o = 17'h08440; init_cb_o = 25'h05f0e00; end // x0 = 0.71875000
                8'd 57: begin init_sq_o = 17'h085b1; init_cb_o = 25'h0609ce9; end // x0 = 0.72265625
                8'd 58: begin init_sq_o = 17'h08724; init_cb_o = 25'h0623028; end // x0 = 0.72656250
                8'd 59: begin init_sq_o = 17'h08899; init_cb_o = 25'h063c7c3; end // x0 = 0.73046875
                8'd 60: begin init_sq_o = 17'h08a10; init_cb_o = 25'h06563c0; end // x0 = 0.73437500
                8'd 61: begin init_sq_o = 17'h08b89; init_cb_o = 25'h0670425; end // x0 = 0.73828125
                8'd 62: begin init_sq_o = 17'h08d04; init_cb_o = 25'h068a8f8; end // x0 = 0.74218750
                8'd 63: begin init_sq_o = 17'h08e81; init_cb_o = 25'h06a523f; end // x0 = 0.74609375
                8'd 64: begin init_sq_o = 17'h09000; init_cb_o = 25'h06c0000; end // x0 = 0.75000000
                8'd 65: begin init_sq_o = 17'h09181; init_cb_o = 25'h06db241; end // x0 = 0.75390625
                8'd 66: begin init_sq_o = 17'h09304; init_cb_o = 25'h06f6908; end // x0 = 0.75781250
                8'd 67: begin init_sq_o = 17'h09489; init_cb_o = 25'h071245b; end // x0 = 0.76171875
                8'd 68: begin init_sq_o = 17'h09610; init_cb_o = 25'h072e440; end // x0 = 0.76562500
                8'd 69: begin init_sq_o = 17'h09799; init_cb_o = 25'h074a8bd; end // x0 = 0.76953125
                8'd 70: begin init_sq_o = 17'h09924; init_cb_o = 25'h07671d8; end // x0 = 0.77343750
                8'd 71: begin init_sq_o = 17'h09ab1; init_cb_o = 25'h0783f97; end // x0 = 0.77734375
                8'd 72: begin init_sq_o = 17'h09c40; init_cb_o = 25'h07a1200; end // x0 = 0.78125000
                8'd 73: begin init_sq_o = 17'h09dd1; init_cb_o = 25'h07be919; end // x0 = 0.78515625
                8'd 74: begin init_sq_o = 17'h09f64; init_cb_o = 25'h07dc4e8; end // x0 = 0.78906250
                8'd 75: begin init_sq_o = 17'h0a0f9; init_cb_o = 25'h07fa573; end // x0 = 0.79296875
                8'd 76: begin init_sq_o = 17'h0a290; init_cb_o = 25'h0818ac0; end // x0 = 0.79687500
                8'd 77: begin init_sq_o = 17'h0a429; init_cb_o = 25'h08374d5; end // x0 = 0.80078125
                8'd 78: begin init_sq_o = 17'h0a5c4; init_cb_o = 25'h08563b8; end // x0 = 0.80468750
                8'd 79: begin init_sq_o = 17'h0a761; init_cb_o = 25'h087576f; end // x0 = 0.80859375
                8'd 80: begin init_sq_o = 17'h0a900; init_cb_o = 25'h0895000; end // x0 = 0.81250000
                8'd 81: begin init_sq_o = 17'h0aaa1; init_cb_o = 25'h08b4d71; end // x0 = 0.81640625
                8'd 82: begin init_sq_o = 17'h0ac44; init_cb_o = 25'h08d4fc8; end // x0 = 0.82031250
                8'd 83: begin init_sq_o = 17'h0ade9; init_cb_o = 25'h08f570b; end // x0 = 0.82421875
                8'd 84: begin init_sq_o = 17'h0af90; init_cb_o = 25'h0916340; end // x0 = 0.82812500
                8'd 85: begin init_sq_o = 17'h0b139; init_cb_o = 25'h093746d; end // x0 = 0.83203125
                8'd 86: begin init_sq_o = 17'h0b2e4; init_cb_o = 25'h0958a98; end // x0 = 0.83593750
                8'd 87: begin init_sq_o = 17'h0b491; init_cb_o = 25'h097a5c7; end // x0 = 0.83984375
                8'd 88: begin init_sq_o = 17'h0b640; init_cb_o = 25'h099c600; end // x0 = 0.84375000
                8'd 89: begin init_sq_o = 17'h0b7f1; init_cb_o = 25'h09beb49; end // x0 = 0.84765625
                8'd 90: begin init_sq_o = 17'h0b9a4; init_cb_o = 25'h09e15a8; end // x0 = 0.85156250
                8'd 91: begin init_sq_o = 17'h0bb59; init_cb_o = 25'h0a04523; end // x0 = 0.85546875
                8'd 92: begin init_sq_o = 17'h0bd10; init_cb_o = 25'h0a279c0; end // x0 = 0.85937500
                8'd 93: begin init_sq_o = 17'h0bec9; init_cb_o = 25'h0a4b385; end // x0 = 0.86328125
                8'd 94: begin init_sq_o = 17'h0c084; init_cb_o = 25'h0a6f278; end // x0 = 0.86718750
                8'd 95: begin init_sq_o = 17'h0c241; init_cb_o = 25'h0a9369f; end // x0 = 0.87109375
                8'd 96: begin init_sq_o = 17'h0c400; init_cb_o = 25'h0ab8000; end // x0 = 0.87500000
                8'd 97: begin init_sq_o = 17'h0c5c1; init_cb_o = 25'h0adcea1; end // x0 = 0.87890625
                8'd 98: begin init_sq_o = 17'h0c784; init_cb_o = 25'h0b02288; end // x0 = 0.88281250
                8'd 99: begin init_sq_o = 17'h0c949; init_cb_o = 25'h0b27bbb; end // x0 = 0.88671875
                8'd100: begin init_sq_o = 17'h0cb10; init_cb_o = 25'h0b4da40; end // x0 = 0.89062500
                8'd101: begin init_sq_o = 17'h0ccd9; init_cb_o = 25'h0b73e1d; end // x0 = 0.89453125
                8'd102: begin init_sq_o = 17'h0cea4; init_cb_o = 25'h0b9a758; end // x0 = 0.89843750
                8'd103: begin init_sq_o = 17'h0d071; init_cb_o = 25'h0bc15f7; end // x0 = 0.90234375
                8'd104: begin init_sq_o = 17'h0d240; init_cb_o = 25'h0be8a00; end // x0 = 0.90625000
                8'd105: begin init_sq_o = 17'h0d411; init_cb_o = 25'h0c10379; end // x0 = 0.91015625
                8'd106: begin init_sq_o = 17'h0d5e4; init_cb_o = 25'h0c38268; end // x0 = 0.91406250
                8'd107: begin init_sq_o = 17'h0d7b9; init_cb_o = 25'h0c606d3; end // x0 = 0.91796875
                8'd108: begin init_sq_o = 17'h0d990; init_cb_o = 25'h0c890c0; end // x0 = 0.92187500
                8'd109: begin init_sq_o = 17'h0db69; init_cb_o = 25'h0cb2035; end // x0 = 0.92578125
                8'd110: begin init_sq_o = 17'h0dd44; init_cb_o = 25'h0cdb538; end // x0 = 0.92968750
                8'd111: begin init_sq_o = 17'h0df21; init_cb_o = 25'h0d04fcf; end // x0 = 0.93359375
                8'd112: begin init_sq_o = 17'h0e100; init_cb_o = 25'h0d2f000; end // x0 = 0.93750000
                8'd113: begin init_sq_o = 17'h0e2e1; init_cb_o = 25'h0d595d1; end // x0 = 0.94140625
                8'd114: begin init_sq_o = 17'h0e4c4; init_cb_o = 25'h0d84148; end // x0 = 0.94531250
                8'd115: begin init_sq_o = 17'h0e6a9; init_cb_o = 25'h0daf26b; end // x0 = 0.94921875
                8'd116: begin init_sq_o = 17'h0e890; init_cb_o = 25'h0dda940; end // x0 = 0.95312500
                8'd117: begin init_sq_o = 17'h0ea79; init_cb_o = 25'h0e065cd; end // x0 = 0.95703125
                8'd118: begin init_sq_o = 17'h0ec64; init_cb_o = 25'h0e32818; end // x0 = 0.96093750
                8'd119: begin init_sq_o = 17'h0ee51; init_cb_o = 25'h0e5f027; end // x0 = 0.96484375
                8'd120: begin init_sq_o = 17'h0f040; init_cb_o = 25'h0e8be00; end // x0 = 0.96875000
                8'd121: begin init_sq_o = 17'h0f231; init_cb_o = 25'h0eb91a9; end // x0 = 0.97265625
                8'd122: begin init_sq_o = 17'h0f424; init_cb_o = 25'h0ee6b28; end // x0 = 0.97656250
                8'd123: begin init_sq_o = 17'h0f619; init_cb_o = 25'h0f14a83; end // x0 = 0.98046875
                8'd124: begin init_sq_o = 17'h0f810; init_cb_o = 25'h0f42fc0; end // x0 = 0.98437500
                8'd125: begin init_sq_o = 17'h0fa09; init_cb_o = 25'h0f71ae5; end // x0 = 0.98828125
                8'd126: begin init_sq_o = 17'h0fc04; init_cb_o = 25'h0fa0bf8; end // x0 = 0.99218750
                8'd127: begin init_sq_o = 17'h0fe01; init_cb_o = 25'h0fd02ff; end // x0 = 0.99609375
                8'd128: begin init_sq_o = 17'h10000; init_cb_o = 25'h1000000; end // x0 = 1.00000000
                default: begin init_sq_o = '0; init_cb_o = '0; end
            endcase
        end
    end

endmodule
