set term png size 3836,2021
set output out_file.'.png'
set title 'conflict on extents'
set ylabel 'number of conflicts'
set xlabel 'No. of sample point (1 point per 10 seconds)'
set yrang [0:]
plot log_file using 1 title 'ALLOC\_INFO' with line, \
log_file using 2 title 'COLL\_BLOCK' with line, \
log_file using 3 title 'LADDR\_INTERNAL' with line, \
log_file using 4 title 'LADDR\_LEAF' with line, \
log_file using 5 title 'OBJECT\_DATA\_BLOCK' with line, \
log_file using 6 title 'OMAP\_INNER' with line, \
log_file using 7 title 'OMAP\_LEAF' with line, \
log_file using 8 title 'ONODE\_BLOCK\_STAGED' with line, \
log_file using 9 title 'RETIRED\_PLACEHOLDER' with line, \
log_file using 10 title 'ROOT' with line, \
log_file using 11 title 'TEST\_BLOCK' with line, \
log_file using 12 title 'TEST\_BLOCK\_PHYSICAL' with line

set output out_file.'.per_sec.png'
set title 'conflict per second on extents'
set ylabel 'number of conflicts per second'
set xlabel 'No. of sample point (1 point per 10 seconds)'
set yrang [0:]
plot log_file2 using 1:2 title 'ALLOC\_INFO' with line, \
log_file2 using 1:3 title 'COLL\_BLOCK' with line, \
log_file2 using 1:4 title 'LADDR\_INTERNAL' with line, \
log_file2 using 1:5 title 'LADDR\_LEAF' with line, \
log_file2 using 1:6 title 'OBJECT\_DATA\_BLOCK' with line, \
log_file2 using 1:7 title 'OMAP\_INNER' with line, \
log_file2 using 1:8 title 'OMAP\_LEAF' with line, \
log_file2 using 1:9 title 'ONODE\_BLOCK\_STAGED' with line, \
log_file2 using 1:10 title 'RETIRED\_PLACEHOLDER' with line, \
log_file2 using 1:11 title 'ROOT' with line, \
log_file2 using 1:12 title 'TEST\_BLOCK' with line, \
log_file2 using 1:13 title 'TEST\_BLOCK\_PHYSICAL' with line

set output 'journal_trim_repeats_per_cycle.png'
set title 'avg num of repeats per journal trim trans'
set ylabel 'avg num of repreats per journal trim trans'
set xlabel 'time (secs)'
set yrange [0:]
plot 'journal_trim_repeats_per_cycle.with_time.plot' using 1:2 title 'avg num of repreats per journal trim trans' with line
