set term png size 1980,1020
set output 'io_blocked_count_reclaim.png'
set title 'number of io blocked by reclaim in the last sampling interval'
set ylabel 'number of io blocked'
set xlabel 'No. of sample point (1 point per 10 seconds)'
set yrang [0:]
plot 'io_blocked_count_reclaim_per_sampling.plot' using 1 with line
