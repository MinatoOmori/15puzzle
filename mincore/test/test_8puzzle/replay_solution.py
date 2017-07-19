# -*- coding: utf-8 -*-

import sys


def apply_move(n, board, move):
    move_dict = {
        'U': (-1, 0),
        'L': (0, -1),
        'R': (0, 1),
        'D': (1, 0)
    }

    dy, dx = move_dict[move]
    empty_pos = board.index(0)
    y = empty_pos // n
    x = empty_pos % n
    ny = y + dy
    nx = x + dx
    npos = ny * n + nx

    board[empty_pos], board[npos] = board[npos], board[empty_pos]


def main():
    n = int(input().strip())
    board = list(map(int, input().strip().split(' ')))
    moves = list(input().strip())

    for move in moves:
        apply_move(n, board, move)

    if board != list(range(n * n)):
        sys.exit(1)


if __name__ == '__main__':
    main()
