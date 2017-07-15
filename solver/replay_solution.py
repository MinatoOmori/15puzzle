# -*- coding: utf-8 -*-

import sys


def is_inside_board(n, y, x):
    return 0 <= y < n and 0 <= x < n


def apply_move(n, board, move):
    move_dict = {
        'U': (-1, 0),
        'L': (0, -1),
        'R': (0, 1),
        'D': (1, 0)
    }

    if move not in move_dict:
        return False

    dy, dx = move_dict[move]
    empty_pos = board.index(0)
    y = empty_pos // n
    x = empty_pos % n
    ny = y + dy
    nx = x + dx

    if not is_inside_board(n, ny, nx):
        return False

    npos = ny * n + nx
    board[empty_pos], board[npos] = board[npos], board[empty_pos]

    return True


def main():
    n = int(input().strip())
    board = list(map(int, input().strip().split(' ')))
    moves = list(input().strip())

    for move in moves:
        ok = apply_move(n, board, move)
        if not ok:
            sys.exit(1)

    if board != list(range(n * n)):
        sys.exit(1)


if __name__ == '__main__':
    main()
