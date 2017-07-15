#!/bin/bash

N=3
PYTHON=python3
SOLVER=./solver_ida

for i in `seq 0 100`;
do
  puzzle=`$PYTHON generate_puzzle.py -n $N`
  start=`date +%s%3N`
  answer=`echo $puzzle | $SOLVER`
  end=`date +%s%3N`
  `echo -e "$N\n$puzzle\n$answer" | $PYTHON replay_solution.py`

  if [ $? -eq 1 ];
  then
    echo "Failed to solve $puzzle. Solver answered $answer"
  else
    echo "Solved $puzzle in $((end-start)) msec. Solver answered $answer"
  fi
done
