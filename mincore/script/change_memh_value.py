# -*- coding: utf-8 -*-

import argparse
import itertools
import re
import sys
import traceback


WHITESPACES_RE = re.compile('\s+')


def get_sym_addrs(map_lines):
    sym_addrs = {}
    for line in map_lines:
        elms = WHITESPACES_RE.split(line)
        if len(elms) < 2:
            continue

        sym_addrs[elms[-1]] = elms[-2]

    return sym_addrs


def get_updated_memh(memh_lines, kvs, sym_addrs):
    for kv in itertools.chain(*kvs):
        k, v = kv.split('=')
        if k not in sym_addrs:
            raise RuntimeError('Undefined symbol %s' % k)

        vlen_words = len(v) // 8
        if len(v) == 0 or len(v) % 8 != 0:
            raise RuntimeError('Malformed value %s' % v)

        addr = int(sym_addrs[k], base=16) // 4
        for i in range(vlen_words):
            memh_lines[addr + i] = v[i*8:i*8+8]

    return memh_lines


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--memh', type=str, help='path to memh file', required=True)
    ap.add_argument('--map', type=str, help='path to map file', required=True)
    ap.add_argument('--kvs', type=str, action='append', nargs='+', required=True,
        help='<variable name>=<32 bit aligned value in hex>')
    args = ap.parse_args()

    with open(args.map, 'r') as f:
        lines = [e.strip() for e in f.readlines()]
    sym_addrs = get_sym_addrs(lines)

    with open(args.memh, 'r') as f:
        lines = [e.strip() for e in f.readlines()]

    try:
        updated_memh = get_updated_memh(lines, args.kvs, sym_addrs)
    except Exception as e:
        traceback.print_exc()
        sys.exit(1)

    print('\n'.join(updated_memh), sep='')


if __name__ == '__main__':
    main()
