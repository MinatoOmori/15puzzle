#!/bin/bash

N=3
puzzle_data=`python3 generate_puzzle.py --print_empty_yx`
empty_y=${puzzle_data[@]::1}
empty_x=${puzzle_data[@]:2:1}
board=${puzzle_data[@]:3}
p0=${board[@]:0:1}
p1=${board[@]:2:1}
p2=${board[@]:4:1}
p3=${board[@]:6:1}
p4=${board[@]:8:1}
p5=${board[@]:10:1}
p6=${board[@]:12:1}
p7=${board[@]:14:1}
p8=${board[@]:16:1}

empty_y_on_mem="0000000${empty_y}"
empty_x_on_mem="0000000${empty_x}"
board_on_mem="0${p3}0${p2}0${p1}0${p0}0${p7}0${p6}0${p5}0${p4}0000000${p8}"

python3 ../../script/change_memh_value.py \
  --memh ./build/solver_ida.memh \
  --map ./build/solver_ida.map \
  --kv k_initial_empty_y=$empty_y_on_mem \
  k_initial_empty_x=$empty_x_on_mem \
  k_initial_board=$board_on_mem \
  > ./build/memory.memh

echo "Start solving $board"

cd build
start=`date +%s`
output=`../../../build/Vtest_top`
end=`date +%s`
answer=`echo $output | cut -d' ' -f1`
cd ..

`echo -e "$N\n$board\n$answer" | python3 replay_solution.py`
if [ $? -eq 0 ];
then
  echo "Solved $board in $((end-start)) sec. Solver answered $answer"
else
  echo "Failed to solve $board. Solver answered $answer"
fi
