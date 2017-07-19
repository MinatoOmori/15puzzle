#ifdef RISCV_SIM
#include "print.h"
#else
#include <stdio.h>
#endif

#define N 3
#define NN 9
#define INF 1000000
#define MAX_MOVES 32
#define N_SUCC 4

char g_board[NN];
int g_move_idx;
char g_moves[MAX_MOVES];

int k_initial_empty_y = 0;
int k_initial_empty_x = 2;
char k_initial_board[NN] = {4, 1, 0, 5, 2, 3, 8, 7, 6};
int k_dy[] = {-1, 0, 0, 1};
int k_dx[] = {0, -1, 1, 0};
char k_delta_name[] = {'U', 'L', 'R', 'D'};

int k_y_lut[] = {0, 0, 0, 1, 1, 1, 2, 2, 2};
int k_x_lut[] = {0, 1, 2, 0, 1, 2, 0, 1, 2};

int abs(int a) { return a >= 0 ? a : -a; }

int dist() {
  int ret = 0;
  for (int i = 0; i < NN; i++) {
    int e = g_board[i];
    if (e == 0) continue;

    int ey = k_y_lut[e];
    int ex = k_x_lut[e];
    int y = k_y_lut[i];
    int x = k_x_lut[i];

    ret += abs(ey - y) + abs(ex - x);
  }
  return ret;
}

int is_solved() {
  for (int i = 0; i < NN; i++)
    if (i != g_board[i]) return 0;
  return 1;
}

int is_inside_board(int y, int x) { return 0 <= y && y < N && 0 <= x && x < N; }

void swap(int pos, int npos) {
  char tmp = g_board[pos];
  g_board[pos] = g_board[npos];
  g_board[npos] = tmp;
}

int search(int empty_y, int empty_x, int current_cost, int upper_bound) {
  int d = dist();
  if (current_cost + d > upper_bound) return current_cost + d;

  if (is_solved()) return 0;

  int min_cost = INF;
  for (int i = 0; i < 4; i++) {
    int ny = empty_y + k_dy[i];
    int nx = empty_x + k_dx[i];
    if (!is_inside_board(ny, nx)) continue;

    int pos = empty_y * N + empty_x;
    int npos = ny * N + nx;
    swap(pos, npos);
    int cost = search(ny, nx, current_cost + 1, upper_bound);
    if (cost == 0) {
      g_moves[g_move_idx] = i;
      g_move_idx++;
      return 0;
    }
    if (cost < min_cost) min_cost = cost;
    swap(pos, npos);
  }

  return min_cost;
}

int ida_star(int empty_y, int empty_x) {
  int upper_bound = dist();
  for (int i = 0; ; i++) {
    int cost = search(empty_y, empty_x, 0, upper_bound);
    if (cost == 0) return upper_bound;
    if (cost == INF) return -1;
    upper_bound = cost;
  }
}

#ifdef RISCV_SIM
void print_moves() {
  for (int i = MAX_MOVES - 1; i >= 0; i--)
    if (g_moves[i] < N_SUCC) print_chr(k_delta_name[g_moves[i]]);
  print_chr('\n');
}
#else
void print_moves() {
  for (int i = MAX_MOVES - 1; i >= 0; i--)
    if (g_moves[i] < N_SUCC) printf("%c", k_delta_name[g_moves[i]]);
  printf("\n");
}
#endif

#ifdef RISCV_SIM
int main() {
  int empty_y = k_initial_empty_y;
  int empty_x = k_initial_empty_x;
  for (int i = 0; i < NN; ++i) g_board[i] = k_initial_board[i];

  g_move_idx = 0;
  for (int i = 0; i < MAX_MOVES; i++) g_moves[i] = N_SUCC;

  ida_star(empty_y, empty_x);
  print_moves();

  return 0;
}
#else
int main() {
  int empty_x, empty_y;
  for (int i = 0; i < N; ++i) {
    for (int j = 0; j < N; ++j) {
      int a;
      scanf("%d", &a);
      g_board[i * N + j] = (char)a;

      if (a == 0) {
        empty_y = i;
        empty_x = j;
      }
    }
  }

  g_move_idx = 0;
  for (int i = 0; i < sizeof g_moves; i++) g_moves[i] = N_SUCC;

  ida_star(empty_y, empty_x);
  print_moves();

  return 0;
}
#endif
