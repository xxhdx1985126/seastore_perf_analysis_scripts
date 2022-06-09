set term png size 1980,1020
set output 'io_block_time.png'
set title 'time of io blocked in the last sampling interval'
set ylabel 'time of io blocked'
set xlabel 'No. of sample point (1 point per 10 seconds)'
set yrang [0:]
plot 'accumulated_io_block_time_per_sampling.plot' using 1 with line
