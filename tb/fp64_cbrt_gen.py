import struct
import random
import math
import gmpy2


# ============================================================
# bit conversions
# ============================================================
def u64_to_double(u: int) -> float:
    return struct.unpack('>d', u.to_bytes(8, 'big'))[0]


def double_to_u64(x: float) -> int:
    return int.from_bytes(struct.pack('>d', x), 'big')


def u64_hex(u: int) -> str:
    return f"{u:016x}"


# ============================================================
# raw fp64 field helpers
# ============================================================
def sign_bit(u: int) -> int:
    return (u >> 63) & 1


def exp_bits(u: int) -> int:
    return (u >> 52) & 0x7ff


def frac_bits(u: int) -> int:
    return u & ((1 << 52) - 1)


def is_nan_u64(u: int) -> bool:
    return exp_bits(u) == 0x7ff and frac_bits(u) != 0


def is_inf_u64(u: int) -> bool:
    return exp_bits(u) == 0x7ff and frac_bits(u) == 0


def is_zero_u64(u: int) -> bool:
    return exp_bits(u) == 0 and frac_bits(u) == 0


# ============================================================
# policy:
# qNaN in -> qNaN out
# canonical qNaN = 64'h7ff8000000000000
# ============================================================
QNaN_U64 = 0x7ff8000000000000
PINF_U64 = 0x7ff0000000000000
NINF_U64 = 0xfff0000000000000
PZERO_U64 = 0x0000000000000000
NZERO_U64 = 0x8000000000000000


# ============================================================
# exact binary64 -> exact rational mpq
# x = (-1)^s * m * 2^e
# normal:    m = 2^52 + frac, e = exp-1023-52
# subnormal: m = frac,        e = 1-1023-52
# ============================================================
def exact_fp64_to_mpq(u: int) -> gmpy2.mpq:
    s = sign_bit(u)
    e = exp_bits(u)
    f = frac_bits(u)

    assert not is_nan_u64(u)
    assert not is_inf_u64(u)

    if e == 0:
        # zero/subnormal
        if f == 0:
            return gmpy2.mpq(0)
        mant = f
        exp2 = 1 - 1023 - 52
    else:
        mant = (1 << 52) | f
        exp2 = e - 1023 - 52

    num = gmpy2.mpz(mant)
    den = gmpy2.mpz(1)

    if exp2 >= 0:
        num <<= exp2
    else:
        den <<= (-exp2)

    q = gmpy2.mpq(num, den)
    if s:
        q = -q
    return q


# ============================================================
# round an mpfr value to IEEE754 binary64 RNE, then export bits
#
# Important:
# here x_mp is already a real value we want to round to FP64.
# We explicitly create a 53-bit mpfr under RoundToNearest, then
# convert that exact binary64-valued result to Python float only
# for packing the final 64 bits.
# ============================================================
def round_mpfr_to_fp64_u64(x_mp: gmpy2.mpfr) -> int:
    with gmpy2.local_context(gmpy2.get_context()) as ctx:
        ctx.precision = 53
        ctx.round = gmpy2.RoundToNearest
        y53 = gmpy2.mpfr(x_mp)
        y = float(y53)
    return double_to_u64(y)


# ============================================================
# strict FP64 -> FP64 cbrt golden
#
# We do NOT import input through Python float semantics.
# We decode exact binary64 -> exact mpq -> MPFR interval.
#
# Ziv-style loop:
#   compute lower/upper rounded bounds for cbrt(x)
#   round both bounds to FP64/RNE
#   if same bits -> guaranteed correctly rounded result
#   else increase precision and retry
# ============================================================
def fp64_cbrt_golden_u64_strict(u: int,
                                init_prec: int = 200,
                                step_prec: int = 100,
                                max_prec: int = 5000) -> int:
    if is_nan_u64(u):
        return QNaN_U64

    if is_inf_u64(u):
        return NINF_U64 if sign_bit(u) else PINF_U64

    if is_zero_u64(u):
        return NZERO_U64 if sign_bit(u) else PZERO_U64

    x_q = exact_fp64_to_mpq(u)

    p = init_prec
    while p <= max_prec:
        # lower bound: round toward -inf
        with gmpy2.local_context(gmpy2.get_context()) as ctx_lo:
            ctx_lo.precision = p
            ctx_lo.round = gmpy2.RoundDown
            x_lo = gmpy2.mpfr(x_q)
            y_lo = gmpy2.rootn(x_lo, 3)

        # upper bound: round toward +inf
        with gmpy2.local_context(gmpy2.get_context()) as ctx_hi:
            ctx_hi.precision = p
            ctx_hi.round = gmpy2.RoundUp
            x_hi = gmpy2.mpfr(x_q)
            y_hi = gmpy2.rootn(x_hi, 3)

        lo_u = round_mpfr_to_fp64_u64(y_lo)
        hi_u = round_mpfr_to_fp64_u64(y_hi)

        if lo_u == hi_u:
            return lo_u

        p += step_prec

    raise RuntimeError(f"Failed to uniquely round cbrt at input {u64_hex(u)} up to precision {max_prec}")


# ============================================================
# vector generation helpers
# ============================================================
def make_normal(sign: int, exp: int, frac: int) -> int:
    return ((sign & 1) << 63) | ((exp & 0x7ff) << 52) | (frac & ((1 << 52) - 1))


def make_subnormal(sign: int, frac: int) -> int:
    frac &= ((1 << 52) - 1)
    if frac == 0:
        frac = 1
    return ((sign & 1) << 63) | frac


# ============================================================
# broad coverage input set
# ============================================================
def generate_input_set(
    n_rand_normal: int = 1000,
    n_rand_subnormal: int = 200,
    n_cube_neighbors: int = 500,
    seed: int = 1
):
    random.seed(seed)
    inputs = []

    # --------------------------------------------------------
    # 1) special values
    # --------------------------------------------------------
    inputs.extend([
        PZERO_U64,
        NZERO_U64,
        PINF_U64,
        NINF_U64,
        QNaN_U64,
    ])

    # --------------------------------------------------------
    # 2) fixed important boundary values
    # --------------------------------------------------------
    inputs.extend([
        0x3ff0000000000000,  # 1.0
        0xbff0000000000000,  # -1.0
        0x4000000000000000,  # 2.0
        0xc000000000000000,  # -2.0
        0x4020000000000000,  # 8.0
        0xc020000000000000,  # -8.0
        0x3fc0000000000000,  # 0.125
        0xbfc0000000000000,  # -0.125
        0x3fe0000000000000,  # 0.5
        0xbfe0000000000000,  # -0.5
        0x0010000000000000,  # min normal
        0x8010000000000000,  # -min normal
        0x000fffffffffffff,  # max subnormal
        0x800fffffffffffff,  # -max subnormal
        0x0000000000000001,  # min subnormal
        0x8000000000000001,  # -min subnormal
        0x7fefffffffffffff,  # max finite
        0xffefffffffffffff,  # min finite
    ])

    # --------------------------------------------------------
    # 3) exponent sweep + representative fractions
    # --------------------------------------------------------
    frac_samples = [
        0x0000000000000,
        0x0000000000001,
        0x0000000000002,
        0x0000000000003,
        0x4000000000000,
        0x7ffffffffffff,
        0x8000000000000,
        0xfffffffffffff,
    ]
    exp_samples = [
        1, 2, 3, 4, 5, 10, 20, 50, 100, 200, 400,
        700, 900, 1022, 1023, 1024, 1200, 1500, 1800, 2000, 2045, 2046
    ]
    for s in [0, 1]:
        for e in exp_samples:
            for f in frac_samples:
                inputs.append(make_normal(s, e, f))

    # --------------------------------------------------------
    # 4) structured random normals
    # --------------------------------------------------------
    for _ in range(n_rand_normal):
        s = random.getrandbits(1)
        e = random.randint(1, 2046)
        f = random.getrandbits(52)
        inputs.append(make_normal(s, e, f))

    # --------------------------------------------------------
    # 5) structured random subnormals
    # --------------------------------------------------------
    for _ in range(n_rand_subnormal):
        s = random.getrandbits(1)
        f = random.randint(1, (1 << 52) - 1)
        inputs.append(make_subnormal(s, f))

    # --------------------------------------------------------
    # 6) exact cubes and near-neighbors
    # --------------------------------------------------------
    ys = []

    for k in range(-512, 513):
        ys.append(float(k) / 64.0)

    for e in range(-200, 201, 8):
        y = math.ldexp(1.0, e)
        ys.append(y)
        ys.append(-y)
        ys.append(y * 1.5)
        ys.append(-y * 1.5)
        ys.append(y * (1.0 + 2.0**-20))
        ys.append(-y * (1.0 + 2.0**-20))

    for _ in range(max(200, n_cube_neighbors // 10)):
        sign = -1.0 if random.getrandbits(1) else 1.0
        exp2 = random.randint(-200, 200)
        mant = 1.0 + random.random()
        ys.append(sign * math.ldexp(mant, exp2))

    cube_neighbors_added = 0
    for y in ys:
        x = y * y * y
        if not math.isfinite(x):
            continue

        u = double_to_u64(float(x))
        inputs.append(u)

        for d in [-2, -1, 1, 2]:
            v = u + d
            if 0 <= v <= 0xffffffffffffffff:
                inputs.append(v)

        cube_neighbors_added += 1
        if cube_neighbors_added >= n_cube_neighbors:
            break

    # --------------------------------------------------------
    # 7) values around normal/subnormal boundary
    # --------------------------------------------------------
    boundary_vals = [
        0x000ffffffffffffd,
        0x000ffffffffffffe,
        0x000fffffffffffff,
        0x0010000000000000,
        0x0010000000000001,
        0x0010000000000002,
        0x800ffffffffffffd,
        0x800ffffffffffffe,
        0x800fffffffffffff,
        0x8010000000000000,
        0x8010000000000001,
        0x8010000000000002,
    ]
    inputs.extend(boundary_vals)

    # --------------------------------------------------------
    # 8) values around easy roots
    # --------------------------------------------------------
    centers = [
        0x3ff0000000000000,  # 1
        0x4000000000000000,  # 2
        0x4020000000000000,  # 8
        0x3fc0000000000000,  # 0.125
        0xbff0000000000000,  # -1
        0xc020000000000000,  # -8
    ]
    for c in centers:
        for d in range(-16, 17):
            v = c + d
            if 0 <= v <= 0xffffffffffffffff:
                inputs.append(v)

    # unique, stable
    seen = set()
    uniq = []
    for u in inputs:
        if u not in seen:
            seen.add(u)
            uniq.append(u)

    return uniq


# ============================================================
# main generation entry
# ============================================================
def generate_vector_files(
    input_txt: str = "../result/input_hex.txt",
    output_txt: str = "../result/output_hex.txt",
    n_rand_normal: int = 10000,
    n_rand_subnormal: int = 2000,
    n_cube_neighbors: int = 5000,
    seed: int = 2
):
    inputs = generate_input_set(
        n_rand_normal=n_rand_normal,
        n_rand_subnormal=n_rand_subnormal,
        n_cube_neighbors=n_cube_neighbors,
        seed=seed
    )

    with open(input_txt, "w", encoding="utf-8") as fi, \
         open(output_txt, "w", encoding="utf-8") as fo:
        for idx, u in enumerate(inputs):
            y = fp64_cbrt_golden_u64_strict(u)
            fi.write(u64_hex(u) + "\n")
            fo.write(u64_hex(y) + "\n")
            if (idx + 1) % 200 == 0:
                print(f"done {idx + 1}/{len(inputs)}")

    print(f"Generated {len(inputs)} cases")
    print(f"Input : {input_txt}")
    print(f"Output: {output_txt}")


if __name__ == "__main__":
    generate_vector_files(
        input_txt="../result/input_hex.txt",
        output_txt="../result/output_hex.txt",
        n_rand_normal=10000,
        n_rand_subnormal=2000,
        n_cube_neighbors=5000,
        seed=2
    )