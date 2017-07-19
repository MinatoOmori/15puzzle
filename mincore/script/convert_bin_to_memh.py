# -*- coding: utf-8 -*-

import argparse
import sys


def convert_bin_to_hex(bs, size):
    ret = []
    for i in range(size):
        if i < len(bs) // 4:
            w = bs[i*4: i*4+4]
            ret.append('%02x%02x%02x%02x' % (w[3], w[2], w[1], w[0]))
        else:
            ret.append('0')

    return ret


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--bin', type=str, default='a.out')
    ap.add_argument('--size', type=int, default=65536, help='memory size in words')
    args = ap.parse_args()

    with open(args.bin, 'rb') as f:
        bs = f.read()

    if not (len(bs) < 4 * args.size and len(bs) % 4 == 0):
        print('error: malformed binary', file=sys.stderr)
        sys.exit(1)

    print('\n'.join(convert_bin_to_hex(bs, args.size)))


if __name__ == '__main__':
    main()
