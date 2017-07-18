#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 3
#define INF 1000000
#define MAX_MOVES 32
#define N_SUCC 4

char g_board[N][N];
int g_move_idx;
char g_moves[MAX_MOVES];

int k_dy[] = {-1, 0, 0, 1};
int k_dx[] = {0, -1, 1, 0};
char k_delta_name[] = {'U', 'L', 'R', 'D'};

int dist(char board[N][N]) {
  int ret = 0;
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      int y = board[i][j] / N;
      int x = board[i][j] % N;
      if (y == 0 && x == 0)
        continue;

      ret += abs(y - i) + abs(x - j);
    }
  }
  return ret;
}

int is_solved(char board[N][N]) {
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      int y = board[i][j] / N;
      int x = board[i][j] % N;
      if (y != i || x != j)
        return 0;
    }
  }
  return 1;
}

int is_inside_board(int y, int x) {
  return 0 <= y && y < N && 0 <= x && x < N;
}

void swap(char board[N][N], int ny, int nx, int y, int x) {
  char tmp = board[ny][nx];
  board[ny][nx] = board[y][x];
  board[y][x] = tmp;
}

void print_board(char board[N][N]) {
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++)
      printf("%d ", board[i][j]);
    printf("\n");
  }
  printf("---- dist: %d \n", dist(board));
}

int search(char board[N][N], int empty_y, int empty_x, int current_cost, int upper_bound)
{
  int d = dist(board);
  if (current_cost + d > upper_bound)
    return current_cost + d;

  if (is_solved(board))
    return 0;

  int min_cost = INF;
  for (int i = 0; i < 4; i++) {
    int ny = empty_y + k_dy[i];
    int nx = empty_x + k_dx[i];
    if (!is_inside_board(ny, nx))
      continue;

    swap(board, ny, nx, empty_y, empty_x);
    int cost = search(board, ny, nx, current_cost + 1, upper_bound);
    if (cost == 0) {
      g_moves[g_move_idx] = i;
      g_move_idx++;
      return 0;
    }
    if (cost < min_cost)
      min_cost = cost;
    swap(board, ny, nx, empty_y, empty_x);
  }

  return min_cost;
}

int ida_star(char board[N][N], int empty_y, int empty_x) {
  int upper_bound = dist(board);
  for (;;) {
    int cost = search(board, empty_y, empty_x, 0, upper_bound);
    if (cost == 0)
      return upper_bound;
    if (cost == INF)
      return -1;
    upper_bound = cost;
  }
}

int main()
{
  int empty_x, empty_y;
  for (int i = 0; i < N; ++i) {
    for (int j = 0; j < N; ++j) {
      int a;
      scanf("%d", &a);
      g_board[i][j] = (char)a;

      if (a == 0) {
        empty_y = i;
        empty_x = j;
      }
    }
  }

  g_move_idx = 0;
  memset(g_moves, N_SUCC, sizeof g_moves);
  ida_star(g_board, empty_y, empty_x);

  for (int i = MAX_MOVES - 1; i >= 0; i--)
    if (g_moves[i] < N_SUCC)
      printf("%c", k_delta_name[g_moves[i]]);
  printf("\n");

  return 0;
}
