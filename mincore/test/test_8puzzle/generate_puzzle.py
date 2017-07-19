# -*- coding: utf-8 -*-

import argparse
import random


def inversion_count(puzzle, n):
    ret = 0
    for i in range(n * n - 1):
        for j in range(i + 1, n * n):
            if puzzle[i] == 0 or puzzle[j] == 0:
                continue

            if puzzle[i] > puzzle[j]:
                ret += 1

    return ret


def is_solvable(puzzle, n):
    icnt = inversion_count(puzzle, n)
    if n % 2 == 0:
        return (puzzle.index(0) // 4 % 2) != (icnt % 2)

    return icnt % 2 == 0


def generate_puzzle(n):
    while True:
        puzzle = list(range(n * n))
        random.shuffle(puzzle)

        if is_solvable(puzzle, n):
            return puzzle


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('-n', type=int, default=3) # Assume n >= 3
    ap.add_argument('--print_empty_yx', action='store_true', default=False)
    args = ap.parse_args()

    puzzle = generate_puzzle(args.n)
    if args.print_empty_yx:
        empty_idx = puzzle.index(0)
        print(empty_idx // args.n)
        print(empty_idx % args.n)

    print(' '.join(map(str, puzzle)))


if __name__ == '__main__':
    main()
