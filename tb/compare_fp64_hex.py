import sys


def load_lines(path):
    with open(path, 'r', encoding='utf-8') as f:
        return [line.strip().lower() for line in f if line.strip()]


def main():
    golden = sys.argv[1] if len(sys.argv) > 1 else 'output_hex.txt'
    dut = sys.argv[2] if len(sys.argv) > 2 else 'dut_output_hex.txt'
    inputs = sys.argv[3] if len(sys.argv) > 3 else 'input_hex.txt'

    golden_lines = load_lines(golden)
    dut_lines = load_lines(dut)
    input_lines = load_lines(inputs)

    n = min(len(golden_lines), len(dut_lines), len(input_lines))
    print(f'inputs={len(input_lines)} golden={len(golden_lines)} dut={len(dut_lines)} compare={n}')

    mismatches = 0
    for i in range(n):
        if golden_lines[i] != dut_lines[i]:
            mismatches += 1
            print(f'MISMATCH idx={i} in={input_lines[i]} golden={golden_lines[i]} dut={dut_lines[i]}')
            if mismatches >= 50:
                print('Too many mismatches, stop printing.')
                break

    if len(golden_lines) != len(dut_lines):
        print('LENGTH MISMATCH:')
        print(f'  golden={len(golden_lines)}')
        print(f'  dut   ={len(dut_lines)}')

    if mismatches == 0 and len(golden_lines) == len(dut_lines):
        print('PASS: all outputs match.')
    else:
        print(f'FAIL: mismatches={mismatches}')
        sys.exit(1)


if __name__ == '__main__':
    main()
